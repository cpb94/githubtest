$PBExportHeader$w_lis_venfacturas.srw
forward
global type w_lis_venfacturas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_venfacturas
end type
type st_2 from statictext within w_lis_venfacturas
end type
type em_anyo from u_em_campo within w_lis_venfacturas
end type
type em_factura from u_em_campo within w_lis_venfacturas
end type
type st_3 from statictext within w_lis_venfacturas
end type
type dw_proceso from datawindow within w_lis_venfacturas
end type
type em_copias1 from editmask within w_lis_venfacturas
end type
type st_13 from statictext within w_lis_venfacturas
end type
type cabecera from dropdownlistbox within w_lis_venfacturas
end type
type st_7 from statictext within w_lis_venfacturas
end type
type st_cliente from statictext within w_lis_venfacturas
end type
type st_codcli from statictext within w_lis_venfacturas
end type
type st_pagina from statictext within w_lis_venfacturas
end type
type em_copias2 from editmask within w_lis_venfacturas
end type
type em_copias3 from editmask within w_lis_venfacturas
end type
type gb_3 from groupbox within w_lis_venfacturas
end type
type st_1 from statictext within w_lis_venfacturas
end type
type st_33 from statictext within w_lis_venfacturas
end type
type st_44 from statictext within w_lis_venfacturas
end type
type cb_3 from u_boton within w_lis_venfacturas
end type
type listado_partidas from datawindow within w_lis_venfacturas
end type
type gb_1 from groupbox within w_lis_venfacturas
end type
type cb_1 from u_boton within w_lis_venfacturas
end type
type cb_2 from u_boton within w_lis_venfacturas
end type
type cbx_matric from checkbox within w_lis_venfacturas
end type
type cbx_nom_agente from checkbox within w_lis_venfacturas
end type
type pb_imprimir_preli from picturebutton within w_lis_venfacturas
end type
type gb_2 from groupbox within w_lis_venfacturas
end type
type cbx_2 from checkbox within w_lis_venfacturas
end type
type cbx_1 from checkbox within w_lis_venfacturas
end type
type uo_manejo from u_manejo_datawindow within w_lis_venfacturas
end type
type uo_1 from u_selec_impresoras within w_lis_venfacturas
end type
type dw_facturas from datawindow within w_lis_venfacturas
end type
type dw_preliminar from datawindow within w_lis_venfacturas
end type
type dw_declaracion_adquiriente from datawindow within w_lis_venfacturas
end type
type cbx_declaracion_entrada_entrega_intracom from checkbox within w_lis_venfacturas
end type
type cbx_agrupar_ref from checkbox within w_lis_venfacturas
end type
type cb_4 from u_boton within w_lis_venfacturas
end type
end forward

global type w_lis_venfacturas from w_int_con_empresa
integer x = 14
integer y = 16
integer width = 4123
integer height = 3224
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_factura em_factura
st_3 st_3
dw_proceso dw_proceso
em_copias1 em_copias1
st_13 st_13
cabecera cabecera
st_7 st_7
st_cliente st_cliente
st_codcli st_codcli
st_pagina st_pagina
em_copias2 em_copias2
em_copias3 em_copias3
gb_3 gb_3
st_1 st_1
st_33 st_33
st_44 st_44
cb_3 cb_3
listado_partidas listado_partidas
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
cbx_matric cbx_matric
cbx_nom_agente cbx_nom_agente
pb_imprimir_preli pb_imprimir_preli
gb_2 gb_2
cbx_2 cbx_2
cbx_1 cbx_1
uo_manejo uo_manejo
uo_1 uo_1
dw_facturas dw_facturas
dw_preliminar dw_preliminar
dw_declaracion_adquiriente dw_declaracion_adquiriente
cbx_declaracion_entrada_entrega_intracom cbx_declaracion_entrada_entrega_intracom
cbx_agrupar_ref cbx_agrupar_ref
cb_4 cb_4
end type
global w_lis_venfacturas w_lis_venfacturas

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli,var_obs_lin
Dec{4}  var_total
Real var_cambio
dec cambio_euros 
integer lineas =20, bultos_totales = 0
integer lnpie,contador,var_tipo
long reg,reg1,ante_anyo_albaran,v_anyo_albaran,v_albaran,pallets_totales
Dec ante_albaran,var_paginas_a_imprimir
DateTime var_ffactura,v_falbaran
String cartera,precartera,destino,susref=""
string calculo_dtoesp

end variables

forward prototypes
public subroutine f_pagina ()
public subroutine f_inicio ()
public subroutine f_valores (integer registro, integer tipo)
public subroutine f_dat ()
public function decimal f_convertir (string que, string emp, string art, decimal cant, decimal importe)
public function decimal f_convertir_metrosl (string que, string emp, string art, decimal cant, decimal importe)
public subroutine f_proceso_matric (integer tipo)
protected subroutine f_proceso (integer tipo)
public subroutine f_textos_pie_pais (string arg_pais, ref string arg_textos_pie)
public function integer f_convierte_texto_en_array (string arg_pie, ref string arg_array[])
end prototypes

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")+ &
					  string(dw_preliminar.getItemNumber(dw_preliminar.GetRow(),"total_paginas"),"###")
end subroutine

public subroutine f_inicio ();SetNull(filtro)
SetNull(var_idioma)
SetNull(var_tipocli)
SetNull(var_codcli)
SetNull(var_total)
SetNull(lnpie)
SetNUll(contador)
SetNUll(var_tipo)
SetNull(reg)
SetNull(reg1)
SetNUll(ante_anyo_albaran)
SetNUll(v_anyo_albaran)
SetNUll(v_albaran)
ante_albaran = 0
SetNUll(var_ffactura)
SetNUll(v_falbaran)
SetNUll(cartera)
SetNull(precartera)


end subroutine

public subroutine f_valores (integer registro, integer tipo);Dec{0} var_anyo,var_factura
String var_tipo_cliente,var_cliente,texto,var_serie,var_envio
String var_agente1,banco_de_cobro,var_contenedor,var_precinto,var_transportista,var_tipo_pallet
Dec{2} var_valorfron,peso,peso_neto
var_anyo     = Dec(em_anyo.text)
var_factura  = Dec(em_factura.text)
string var_correspondencia
string textcomercial1, textcomercial2,ls_contenedor,ls_precinto

//if Trim(var_idioma) = "1" Then var_idioma="3"

//IMPORTANTE - SOLO USAMOS EL TEXTO COMERCIAL

SELECT venfac.ffactura,venfac.cliente,
		venfac.textcomercial1, venfac.textcomercial2,
		venfac.serie,venfac.envio,venfac.cartera,venfac.precartera,
		venfac.divisa,venfac.correspondencia,venfac.agente1,
		venfac.valor_frontera,peso,peso_neto,banco_de_cobro,contenedor,precinto,transportista
INTO  :var_ffactura,:var_cliente,
		:textcomercial1, :textcomercial2, 
	   :var_serie,:var_envio,:cartera,:precartera,:var_moneda,:var_correspondencia,
      :var_agente1,:var_valorfron,:peso,:peso_neto,:banco_de_cobro,:var_contenedor,:var_precinto,:var_transportista
FROM   venfac  
Where  venfac.empresa = :codigo_empresa
And    venfac.anyo    = :var_anyo
And    venfac.factura = :var_factura;


if isnull(var_correspondencia) then var_correspondencia = ""
//******************************************************************************************************
//IMPORTANTE - SOLO USAMOS EL TEXTO COMERCIAL

//if isnull(var_correspondencia) then var_correspondencia = ""
//CHOOSE CASE tipo
//	CASE 1
//		texto = texto1
//	CASE 2
//		texto = texto2
//	CASE 3
//		texto = texto3
//END CHOOSE

// Santiago.27/09/00. Todas las series deben tener los datos del albarán
//IF var_serie = "1" Then		
		// Control  cambio albaranes
		IF v_albaran <> ante_albaran Then
			
			//and reg <> reg1 Then
				dw_preliminar.InsertRow(registro)
				IF cabecera.text = "Si" Then
					f_asignar_columna(dw_preliminar,registro,"ver_cabecera","S")
				ELSE
					f_asignar_columna(dw_preliminar,registro,"ver_cabecera","N")
				END IF
				String aux
				susref = f_susref_venalb (codigo_empresa,var_anyo,v_albaran)
				
				if isnull(susref) then susref = ''
				
				if not(IsNull(susref) or trim(susref)="")  then
					//f_asignar_columna(dw_preliminar,registro,"sus_ref"," Ref: "+susref)
				end if
				
				bultos_totales = bultos_totales + f_bultos_venalb_venlifac(codigo_empresa,var_anyo,v_albaran)
				
//				aux="Alb nº   "+ STring(v_albaran,f_mascara_decimales(0)) + " del "+ string(v_falbaran,"dd-mm-yy")
				if v_albaran <> 0 then
					aux = f_diccionario("Alb nº",var_idioma)+" "+ STring(v_albaran,f_mascara_decimales(0)) + " ( "+ string(v_falbaran,"dd-mm-yy")+ " )"
					
					ls_contenedor = ''
					ls_precinto   = ''
					
					select max(isnull(venlifac.contenedor,'')),
							 max(isnull(venlifac.precinto,''))
					into   :ls_contenedor,
							 :ls_precinto
					from   venlifac
					where  venlifac.empresa      = :codigo_empresa
					and    venlifac.anyo_albaran = :v_anyo_albaran
					and    venlifac.albaran      = :v_albaran;
					
					if trim(ls_contenedor) <> '' then
						aux += ' '+f_diccionario("Contenedor",var_idioma)+' : '+ls_contenedor
					end if
					
					if trim(ls_precinto) <> '' then
						aux += ' '+f_diccionario("Precinto",var_idioma)+' : '+ls_precinto
					end if					
				else 
					aux = ''
				end if
				
				if not(IsNull(susref)) and trim(susref)<>""  then
					//f_asignar_columna(dw_preliminar,registro,"sus_ref"," Ref: "+susref)
					aux += ' ['+susref+']'
				end if				
				
				//f_asignar_columna(dw_preliminar,registro,"articulo",aux)
				f_asignar_columna(dw_preliminar,registro,"articulo",'')
				f_asignar_columna(dw_preliminar,registro,"sus_ref",aux)
				f_asignar_columna(dw_preliminar,registro,"texto_cabecera",texto)
				f_asignar_columna(dw_preliminar,registro,"tipo",String(tipo))
				f_asignar_columna(dw_preliminar,registro,"empresa",String(codigo_empresa))
				//dw_preliminar.SetItem(registro,"empresa",String(codigo_empresa))				
				f_asignar_columna(dw_preliminar,registro,"anyo",String(var_anyo))
				f_asignar_columna(dw_preliminar,registro,"factura",String(var_factura))
				f_asignar_columna(dw_preliminar,registro,"cod_correspondencia",var_correspondencia)
				dw_preliminar.SetItem(registro,"ffactura",var_ffactura)
				f_asignar_columna(dw_preliminar,registro,"idioma",var_idioma)
				f_asignar_columna(dw_preliminar,registro,"serie",var_serie)
				f_asignar_columna(dw_preliminar,registro,"moneda",var_moneda)
				f_asignar_columna(dw_preliminar,registro,"cliente",var_cliente)
				f_asignar_columna(dw_preliminar,registro,"envio",var_envio)
				f_asignar_columna(dw_preliminar,registro,"destino",destino)
				f_asignar_columna(dw_preliminar,registro,"total",String(var_total))
				f_asignar_columna(dw_preliminar,registro,"agente1",var_agente1)
				f_asignar_columna(dw_preliminar,registro,"contenedor",var_contenedor)
				f_asignar_columna(dw_preliminar,registro,"precinto",var_precinto)
				f_asignar_columna(dw_preliminar,registro,"transportista",var_transportista)
				dw_preliminar.SetItem(registro,"bultos",bultos_totales)
				dw_preliminar.SetItem(registro,"valor_frontera",var_valorfron)				
				dw_preliminar.SetItem(registro,"total_ptas",String(f_conversion_pesetas(var_total,cambio_euros),f_mascara_moneda("1")))//String(var_total*var_cambio,f_mascara_moneda("1")))
				
				if cbx_nom_agente.checked then
					f_asignar_columna(dw_preliminar,registro,"nom_agente",'S')
				else
					f_asignar_columna(dw_preliminar,registro,"nom_agente",'N')					
				end if
				IF Int(registro/lineas)  * lineas = registro Then 
					f_asignar_columna(dw_preliminar,registro,"fin","1")
				ELSE
					f_asignar_columna(dw_preliminar,registro,"fin","2")
				END IF
				registro = registro + 1
				if (registro = 20) or (registro = 39) or (registro = 58) or (registro = 77) or (registro = 96) or (registro = 115) or (registro = 134) or (registro = 153) or (registro = 172) or (registro = 191) then
					IF cabecera.text = "Si" Then
						f_asignar_columna(dw_preliminar,registro,"ver_cabecera","S")
					ELSE
						f_asignar_columna(dw_preliminar,registro,"ver_cabecera","N")
					END IF
					
					dw_preliminar.SetItem(registro,"ffactura",var_ffactura)
					f_asignar_columna(dw_preliminar,registro,"texto_cabecera",texto)
					f_asignar_columna(dw_preliminar,registro,"cod_correspondencia",var_correspondencia) // David 01-12-05
					f_asignar_columna(dw_preliminar,registro,"tipo",String(tipo))
					f_asignar_columna(dw_preliminar,registro,"empresa",codigo_empresa)
					f_asignar_columna(dw_preliminar,registro,"anyo",String(var_anyo))
					f_asignar_columna(dw_preliminar,registro,"factura",String(var_factura))
					f_asignar_columna(dw_preliminar,registro,"idioma",var_idioma)
					f_asignar_columna(dw_preliminar,registro,"serie",var_serie)
					f_asignar_columna(dw_preliminar,registro,"moneda",var_moneda)
					f_asignar_columna(dw_preliminar,registro,"destino",destino)
					f_asignar_columna(dw_preliminar,registro,"cliente",var_cliente)
					f_asignar_columna(dw_preliminar,registro,"envio",var_envio)
					f_asignar_columna(dw_preliminar,registro,"cartera",cartera)
					f_asignar_columna(dw_preliminar,registro,"precartera",precartera)
					f_asignar_columna(dw_preliminar,registro - 1,"total",String(var_total))
					f_asignar_columna(dw_preliminar,registro,"agente1",var_agente1)
					f_asignar_columna(dw_preliminar,registro,"contenedor",var_contenedor)
					f_asignar_columna(dw_preliminar,registro,"precinto",var_precinto)
					f_asignar_columna(dw_preliminar,registro,"transportista",var_transportista)
					f_asignar_columna(dw_preliminar,registro,"banco_de_cobro",banco_de_cobro)		
					dw_preliminar.SetItem(registro,"valor_frontera",var_valorfron)	
					dw_preliminar.SetItem(registro,"bultos",bultos_totales)
					dw_preliminar.SetItem(registro,"total_ptas",String(var_total*var_cambio,f_mascara_moneda("1")))
					
					if cbx_nom_agente.checked then
						f_asignar_columna(dw_preliminar,registro,"nom_agente",'S')
					else
						f_asignar_columna(dw_preliminar,registro,"nom_agente",'N')					
					end if		
// David 31-03-2010
//					if not(cbx_matric.checked) then
//						dw_preliminar.SetItem(registro,"peso_bruto",peso)				
//						dw_preliminar.SetItem(registro,"peso_neto",peso_neto)				
//					end if
					IF Int(registro/lineas)  * lineas = registro  Then 
						f_asignar_columna(dw_preliminar,registro,"fin","1")
					ELSE
						f_asignar_columna(dw_preliminar,registro,"fin","2")
					END IF
				end if
		ELSE
				IF cabecera.text = "Si" Then
					f_asignar_columna(dw_preliminar,registro,"ver_cabecera","S")
				ELSE
					f_asignar_columna(dw_preliminar,registro,"ver_cabecera","N")
				END IF
				
				dw_preliminar.SetItem(registro,"ffactura",var_ffactura)
				f_asignar_columna(dw_preliminar,registro,"texto_cabecera",texto)
				f_asignar_columna(dw_preliminar,registro,"cod_correspondencia",var_correspondencia) // David 01-12-05
				f_asignar_columna(dw_preliminar,registro,"tipo",String(tipo))
				f_asignar_columna(dw_preliminar,registro,"empresa",codigo_empresa)
				f_asignar_columna(dw_preliminar,registro,"anyo",String(var_anyo))
				f_asignar_columna(dw_preliminar,registro,"factura",String(var_factura))
				f_asignar_columna(dw_preliminar,registro,"idioma",var_idioma)
				f_asignar_columna(dw_preliminar,registro,"serie",var_serie)
				f_asignar_columna(dw_preliminar,registro,"moneda",var_moneda)
				f_asignar_columna(dw_preliminar,registro,"destino",destino)
				f_asignar_columna(dw_preliminar,registro,"cliente",var_cliente)
				f_asignar_columna(dw_preliminar,registro,"envio",var_envio)
				f_asignar_columna(dw_preliminar,registro,"cartera",cartera)
				f_asignar_columna(dw_preliminar,registro,"precartera",precartera)
				f_asignar_columna(dw_preliminar,registro - 1,"total",String(var_total))
				f_asignar_columna(dw_preliminar,registro,"agente1",var_agente1)
				f_asignar_columna(dw_preliminar,registro,"contenedor",var_contenedor)
				f_asignar_columna(dw_preliminar,registro,"precinto",var_precinto)
				f_asignar_columna(dw_preliminar,registro,"transportista",var_transportista)
				f_asignar_columna(dw_preliminar,registro,"banco_de_cobro",banco_de_cobro)		
				dw_preliminar.SetItem(registro,"valor_frontera",var_valorfron)	
				dw_preliminar.SetItem(registro,"bultos",bultos_totales)
				dw_preliminar.SetItem(registro,"total_ptas",String(var_total*var_cambio,f_mascara_moneda("1")))
	
				if cbx_nom_agente.checked then
					f_asignar_columna(dw_preliminar,registro,"nom_agente",'S')
				else
					f_asignar_columna(dw_preliminar,registro,"nom_agente",'N')					
				end if	
// David 31-03-2010
//				if not(cbx_matric.checked) then
//					dw_preliminar.SetItem(registro,"peso_bruto",peso)				
//					dw_preliminar.SetItem(registro,"peso_neto",peso_neto)				
//				end if
				IF Int(registro/lineas)  * lineas = registro  Then 
					f_asignar_columna(dw_preliminar,registro,"fin","1")
				ELSE
					f_asignar_columna(dw_preliminar,registro,"fin","2")
				END IF
		END IF

		ante_anyo_albaran = v_anyo_albaran
		ante_albaran = v_albaran
//	END IF		
// Santiago.27/09/00. Todas las series deben tener los datos del albarán
		contador = registro
		
// David 31-03-2010
dw_preliminar.SetItem(1,"peso_bruto",peso)				
dw_preliminar.SetItem(1,"peso_neto",peso_neto)				

dw_preliminar.SetItem(registro, "textcomercial1", string(textcomercial1))
dw_preliminar.SetItem(registro, "textcomercial2", string(textcomercial2))


end subroutine

public subroutine f_dat ();var_idioma      = f_idioma_venfac(codigo_empresa,Dec(em_anyo.text),Dec(em_factura.text))
var_moneda      = f_divisa_venfac(codigo_empresa,Dec(em_anyo.text),Dec(em_factura.text))
var_codcli      = f_cliente_venfac(codigo_empresa,Dec(em_anyo.text),Dec(em_factura.text))
st_codcli.text  = var_codcli
st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)

end subroutine

public function decimal f_convertir (string que, string emp, string art, decimal cant, decimal importe);dec{2} m2,precio

m2=f_convertir_piezas_metros(emp,art,cant)
precio=importe/m2
precio=dec(string(precio,f_mascara_moneda(var_moneda)))
m2=dec(string((importe/precio),'###,###,###.##'))

IF dec(string((m2*precio),f_mascara_moneda(var_moneda))) <> importe then
	m2=f_convertir_piezas_metros(emp,art,cant)
	precio=importe/m2
	precio=dec(string(precio,'###,###,###.##'))
	m2=dec(string((importe/precio),'###,###,###.##'))
end if

if que="M" then
	   return m2
  else
    	return precio
end if
end function

public function decimal f_convertir_metrosl (string que, string emp, string art, decimal cant, decimal importe);dec ml,precio

ml=f_convertir_piezas_metrosl(emp,art,cant)
precio=importe/ml
precio=dec(string(precio,f_mascara_moneda(var_moneda)))
//ml=dec(string((importe/precio),'###,###,###.##'))

//IF dec(string((m2*precio),f_mascara_moneda(var_moneda))) <> importe then
//	m2=f_convertir_piezas_metros(emp,art,cant)
//	precio=importe/m2
//	precio=dec(string(precio,'###,###,###.##'))
//	m2=dec(string((importe/precio),'###,###,###.##'))
//end if
//
if que="M" then
		//f_mensaje("desde la ventana",String(ml))
	   return ml
  else
    	return precio
end if
end function

public subroutine f_proceso_matric (integer tipo);Dec{0} var_anyo,var_factura,resto,re,var_paginas,var_ejercicio
long va,va2,indice
String  var_tono,textpie[50],pie,pie1,pie2,pie3,letra,var_articulo,tipo_iva,&
	tipo_recargo,puntos,destino1,destino2,destino3,var_clase,c,des,&
	mascara,mascara2
String textopie2,cadena,texto_iva,texto_recargo,var_tipo_pallet
Dec{4}  var_calibre,var_cantidad,acumulado,dto1,impdto1,dto2,impdto2,dto3,impdto3,&
		  dto4,impdto4,dtopp,impdtopp,aculumado,dtoesp,precio,cantidad,bruto,importe,iva,&
		  recargo,importeiva,importerecargo

String   var_tipo_unidad,textdto1,textdto2,textdto3,textdto4,tipodto1,&
         tipodto2,tipodto3,tipodto4,tipo_cliente,linea,unimetro,var_caja,&
			unimetrosl			
			
Dec{4}   importedto1,importedto2,importedto3,importedto4,importedtopp
string n_partida="N",var_pais,cod_partida,nom_partida
string texto_euro,mascara_euros,var_serie

unimetro ="N"
unimetrosl ="N"
if cbx_1.checked = true then unimetro   = "S"
// unidades a metros lineales
if cbx_2.checked = true then unimetrosl = "S"

var_total = 0
puntos= "............................................."
contador    = 0
acumulado   = 0
importedto1 = 0
importedto2 = 0
importedto3 = 0
importedto4 = 0
importedtopp= 0 
var_anyo     = Dec(em_anyo.text)
var_factura  = Dec(em_factura.text)
Select dtoesp1,tipodto1,explicaciondto1, dtoesp2,tipodto2,explicaciondto2,
		 dtoesp3,tipodto3,explicaciondto3, dtoesp4,tipodto4,explicaciondto4,
		 dtopp,textcomercial2,textaduanaesp2,textaduanaext2,tipoiva,cartera,precartera,
		 destino1,destino2,destino3,pais,cambio,cambio_euros,serie
Into   :dto1,:tipodto1,:textdto1, :dto2,:tipodto2,:textdto2,
       :dto3,:tipodto3,:textdto3, :dto4,:tipodto4,:textdto4,
		 :dtopp,:pie1,:pie2,:pie3,  :tipo_iva,:cartera,:precartera,
		 :destino1,:destino2,:destino3,:var_pais,:var_cambio,:cambio_euros,:var_serie
From   venfac
Where  venfac.empresa = :codigo_empresa
And    venfac.anyo    = :var_anyo
And    venfac.factura= :var_factura;

IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",SQLCA.sqlerrtext)
mascara = f_mascara_moneda(var_moneda)
mascara2 = "###,###,###,###.00"
//-----------------------
// texto pie factura
//-----------------------
CHOOSE CASE tipo
	CASE 1
		pie      = pie1
		destino  = destino1
	CASE 2		
		pie      = pie2
		destino  = destino2
	CASE 3
		pie      = pie3
		destino  = destino3
		// comprueba si tiene que poner texto de las partidas en el articulo
		n_partida = f_partida_sn_pais(var_pais)
END CHOOSE


lnpie = 0
va2= len(pie)
cadena = ""

For va = 1 To va2
	letra= Mid(pie,va,1)
	cadena = cadena + letra
	IF Asc(Mid(pie,va,2))= 13 Then
			lnpie = lnpie +1
  			textpie[lnpie] = Mid(cadena,1,len(cadena) - 1)
 		   cadena = ""
			va= va +1
	END IF
Next
IF Trim(cadena)<> "" Then
		lnpie = lnpie +1
		textpie[lnpie] = cadena
END IF

//-------------------------------------------------



var_ejercicio = f_ejercicio_activo(codigo_empresa)

  SELECT contaiva.iva,contaiva.recargo,contaiva.descripcion  
    INTO :iva,:tipo_recargo,:texto_iva  
    FROM contaiva  
   WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
         ( contaiva.empresa = :codigo_empresa ) AND  
         ( contaiva.tipoiva = :tipo_iva )   ;
  IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en contaiva",SQLCA.sqlerrtext)
  
  IF Not IsNull(tipo_recargo) and Trim(tipo_recargo) <> "" Then
  		SELECT  contaiva.iva,contaiva.descripcion INTO :recargo,:texto_recargo
   	 FROM   contaiva  
   	WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
      	   ( contaiva.empresa = :codigo_empresa ) AND  
         	( contaiva.tipoiva = :tipo_recargo )   ;
	   IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en recargo",SQLCA.sqlerrtext)
  END IF


//---------------------------------------------------------------------

//if unimetro="S" then
	  f_mascara_columna(dw_preliminar,"precio",f_mascara_decimales(2))
//  else
//     f_mascara_columna(dw_preliminar,"precio",mascara)	
//End if	

dw_preliminar.SetItem(contador,"total_ptas",String(var_total*var_cambio,f_mascara_moneda("1")))
f_mascara_columna(dw_preliminar,"total",mascara)

 dw_proceso.retrieve(codigo_empresa,var_anyo,var_factura,"S")
IF tipo <> 1 Then
	dw_proceso.SetFilter("listar_aduana = 'S'")
	dw_proceso.Filter()
END IF
reg = dw_proceso.RowCount()
IF reg <> 0 Then
	For reg1 = 1 to reg
		acumulado    = 0
		contador     = contador + 1
		var_clase    = dw_proceso.GetItemString(reg1,"clase")
		v_anyo_albaran = dw_proceso.GetItemNumber(reg1,"anyo_albaran")
		v_albaran    = dw_proceso.GetItemNumber(reg1,"albaran")
		v_falbaran   = dw_proceso.GetItemDateTime(reg1,"falbaran")
		dtoesp       = dw_proceso.GetItemNumber(reg1,"dtoesp")
		cantidad     = dw_proceso.GetItemNumber(reg1,"cantidad")
		var_tono     = dw_proceso.GetItemString(reg1,"tonochar")
		var_calibre  = dw_proceso.GetItemNumber(reg1,"calibre")
		var_tipo_pallet = dw_proceso.GetItemString(reg1,"tipo_pallet")
		var_caja     = dw_proceso.GetItemString(reg1,"caja")
		CHOOSE CASE tipo
		 CASE  3
			precio     = dw_proceso.GetItemNumber(reg1,"precio_aduana_neto")
			bruto      = dw_proceso.GetItemNumber(reg1,"importe_aduana")
			impdtopp   = dw_proceso.GetItemNumber(reg1,"impdtopp_aduana")
			impdto1    = dw_proceso.GetItemNumber(reg1,"impdtoesp1_aduana")
			impdto2    = dw_proceso.GetItemNumber(reg1,"impdtoesp2_aduana")			
			impdto3    = dw_proceso.GetItemNumber(reg1,"impdtoesp3_aduana")			
			impdto4    = dw_proceso.GetItemNumber(reg1,"impdtoesp4_aduana")			
		 CASE ELSE
			precio       = dw_proceso.GetItemNumber(reg1,"precio_neto")
			bruto       = dw_proceso.GetItemNumber(reg1,"importe")
			impdtopp       = dw_proceso.GetItemNumber(reg1,"impdtopp")
			impdto1       = dw_proceso.GetItemNumber(reg1,"impdtoesp1")
			impdto2       = dw_proceso.GetItemNumber(reg1,"impdtoesp2")			
			impdto3       = dw_proceso.GetItemNumber(reg1,"impdtoesp3")
			impdto4       = dw_proceso.GetItemNumber(reg1,"impdtoesp4")
		END CHOOSE

		   acumulado = bruto - impdtopp
         importedto1  = importedto1  + impdto1			 
	      importedto2  = importedto2  + impdto2			 
	      importedto3  = importedto3  + impdto3			 
	      importedto4  = importedto4  + impdto4			 
	      importedtopp = importedtopp + impdtopp			 
	      contador = dw_preliminar.RowCount() +1
		   dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		
		var_articulo = dw_proceso.GetItemString(reg1,"articulo")
		var_tipo_unidad=dw_proceso.GetItemSTring(reg1,"tipo_unidad")
		
		dw_preliminar.SetItem(contador,"tipo_unidad",var_tipo_unidad)
		dw_preliminar.SetItem(contador,"unimetro",unimetro)
		dw_preliminar.SetItem(contador,"unimetrosl",unimetrosl)		
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemNumber(reg1,"pallets"))
		dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemNumber(reg1,"cajas"))
		dw_preliminar.SetItem(contador,"total_cajas",dw_proceso.GetItemNumber(reg1,"total_cajas"))
		if tipo=3 and f_partida_sn_pais(var_pais)="S" then
			 cod_partida = f_partida_segun_familia(codigo_empresa,f_familia_articulo(codigo_empresa,var_articulo))
			 nom_partida = f_nombre_partida(codigo_empresa,cod_partida)
			 dw_preliminar.SetItem(contador,"articulo",trim(nom_partida)+" "+dw_proceso.GetItemString(reg1,"descripcion"))
    	else
		    dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))	
		end if
	
		dw_preliminar.SetItem(contador,"tono",dw_proceso.GetItemString(reg1,"tonochar"))
		dw_preliminar.SetItem(contador,"calibre",dw_proceso.GetItemNumber(reg1,"calibre"))
   	dw_preliminar.SetItem(contador,"tipo_pallet",dw_proceso.GetItemString(reg1,"tipo_pallet"))
   	dw_preliminar.SetItem(contador,"caja",dw_proceso.GetItemString(reg1,"caja"))		
		IF tipo <>3 Then
			dw_preliminar.SetItem(contador,"importe",String(Dec(dw_proceso.GetItemNumber(reg1,"importe")),mascara))
			IF var_tipo_unidad= "0" Then
				// *---* precio
					if cbx_1.checked and (unimetrosl<>"S") then
						dw_preliminar.SetItem(contador,"precio",dec(string(f_convertir("P",codigo_empresa,var_articulo,cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))),f_mascara_decimales(2))))
					 else
						if unimetrosl = "S" then
							dw_preliminar.SetItem(contador,"precio",dec(string(f_convertir_metrosl("P",codigo_empresa,var_articulo,cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))),f_mascara_decimales(2))))
						else
							dw_preliminar.SetItem(contador,"precio",Dec(String(dw_proceso.GetItemNumber(reg1,"precio_neto"),mascara2)))
						end if
					end if
         else			
               dw_preliminar.SetItem(contador,"precio",Dec(String(dw_proceso.GetItemNumber(reg1,"precio_neto"),mascara2)))
			End if
			
			dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento"))
		ELSE
			dw_preliminar.SetItem(contador,"importe",String(Dec(dw_proceso.GetItemNumber(reg1,"importe_aduana")),mascara))
			// *---* precio
			if cbx_1.checked and (unimetrosl<>"S") then
				dw_preliminar.SetItem(contador,"precio",dec(string(f_convertir("P",codigo_empresa,var_articulo,cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))),f_mascara_decimales(2))))
			 else
				if unimetrosl = "S" then
					dw_preliminar.SetItem(contador,"precio",dec(string(f_convertir_metrosl("P",codigo_empresa,var_articulo,cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))),f_mascara_decimales(2))))
				else
					dw_preliminar.SetItem(contador,"precio",Dec(String(dw_proceso.GetItemNumber(reg1,"precio_neto"),mascara2)))
				end if
			end if
			dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento_aduana"))
		END IF
		dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"formato")))
		dw_preliminar.SetItem(contador,"familia",f_nombre_familia(codigo_empresa,dw_proceso.GetItemString(reg1,"familia")))		
		dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"calidad")))
		var_tipo_unidad=dw_proceso.GetItemSTring(reg1,"tipo_unidad")
		var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad")

		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad= "0" Then
				if cbx_1.checked and (unimetrosl<>"S")then
					dw_preliminar.SetItem(contador,"piezas",0)
					dw_preliminar.SetItem(contador,"metros",f_convertir("M",codigo_empresa,var_articulo,var_cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))))
				else 
					if unimetrosl ="S" then
						// en la casilla piezas ponemos los ml
						//f_mascara_columna(dw_preliminar,"piezas",f_mascara_decimales(2))
						//***
						//f_mensaje("",String(f_convertir_metrosl("M",codigo_empresa,var_articulo,var_cantidad,dec(dw_preliminar.getitemstring(contador,"importe")))))
						dw_preliminar.SetItem(contador,"piezas",f_convertir_metrosl("M",codigo_empresa,var_articulo,var_cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))))
						// Calcula los metros de las piezas
						dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_piezas(codigo_empresa,var_articulo,var_caja,var_cantidad))
						
				   else 
						dw_preliminar.SetItem(contador,"piezas",var_cantidad)
						// Calcula los metros de las piezas
						dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_piezas(codigo_empresa,var_articulo,var_caja,var_cantidad))
					end if
				end if
			ELSE
				dw_preliminar.SetItem(contador,"piezas","0")
				dw_preliminar.SetItem(contador,"metros",var_cantidad)
			END IF
		ELSE
			dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####.##")+ " " + dw_proceso.GetItemString(reg1,"descripcion"))
		END IF
		
		IF tipo <>3 then
			var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))
		ELSE
			var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe_aduana"))
		END IF
		C = ""
		//IF var_clase = "M" Then C = "(MUESTRAS)"
		//IF var_clase = "S" Then C = "(SIN CARGO)"
		IF var_clase = "M" Then C = "("+f_diccionario("MUESTRAS",f_idioma_venfac(codigo_empresa,var_anyo,var_factura))+")"
		IF var_clase = "S" Then C = "("+f_diccionario("SIN CARGO",f_idioma_venfac(codigo_empresa,var_anyo,var_factura))+")"
		
		des = dw_preliminar.GetItemString(contador,"articulo")
		IF Trim(des) <> "" Then 
			dw_preliminar.SetItem(contador,"articulo",des + " " +c)
		END IF
	Next
	reg1 = 0
	IF contador <>0 then
      contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
      f_valores(contador,tipo)
		dw_preliminar.SetItem(contador - 1,"raya",1)
		dw_preliminar.SetItem(contador,"texto",f_diccionario("TOTAL BRUTO",f_idioma_venfac(codigo_empresa,var_anyo,var_factura)) + puntos)
		dw_preliminar.SetItem(contador,"importe",String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
	END IF
END IF

IF importedto1 <>0 then
		contador = contador + 1
      contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(dto1,"#0.00") + "% " +textdto1+puntos )
		dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto1),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total - importedto1
		contador  = contador + 1
      contador  = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF
IF importedto2 <>0 then
		contador = contador + 1
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(dto2,"#0.00") + "% " +textdto2+puntos)
		dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto2),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total - importedto2
		contador = contador + 1
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF

IF importedto3 <>0 then
		contador = contador + 1
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(dto3,"#0.00") + "% " +textdto3+puntos)
		dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto3),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total - importedto3
	   contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF

IF importedto4 <>0 then
	   contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(dto4,"#0.00") + "% " +textdto4+puntos)
		dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto4),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total - importedto4
		contador = contador + 1
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF



dw_proceso.retrieve(codigo_empresa,var_anyo,var_factura,"N")
IF tipo <> 1 Then
	dw_proceso.SetFilter("listar_aduana = 'S'")
	dw_proceso.Filter()
END IF
reg = dw_proceso.RowCOunt()
IF reg <> 0 Then
	
	For reg1 = 1 to reg
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		var_clase    = dw_proceso.GetItemString(reg1,"clase")
		var_articulo = dw_proceso.GetItemString(reg1,"articulo")
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemNumber(reg1,"pallets"))
		dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemNumber(reg1,"cajas"))
		dw_preliminar.SetItem(contador,"total_cajas",dw_proceso.GetItemNumber(reg1,"total_cajas"))
      if tipo=3 and f_partida_sn_pais(var_pais)="S" then
 		    cod_partida = f_partida_segun_familia(codigo_empresa,f_familia_articulo(codigo_empresa,var_articulo))
			 nom_partida = f_nombre_partida(codigo_empresa,cod_partida)
			 dw_preliminar.SetItem(contador,"articulo",trim(nom_partida)+" "+dw_proceso.GetItemString(reg1,"descripcion"))
		 else
	      dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))	
		end if
		dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemNumber(reg1,"precio"))
		dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento"))
		dw_preliminar.SetItem(contador,"importe",String(Dec(dw_proceso.GetItemNumber(reg1,"importe")),mascara))
		dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"formato")))
		dw_preliminar.SetItem(contador,"familia",f_nombre_familia(codigo_empresa,dw_proceso.GetItemString(reg1,"familia")))		
		dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"calidad")))
		var_tipo_unidad=dw_proceso.GetItemString(reg1,"tipo_unidad")
		var_cantidad=Dec(dw_proceso.GetItemNumber(reg1,"cantidad"))
		 
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad= "0" Then
				dw_preliminar.SetItem(contador,"piezas",String(var_cantidad))
				dw_preliminar.SetItem(contador,"metros","0")
			ELSE
				dw_preliminar.SetItem(contador,"piezas","0")
				dw_preliminar.SetItem(contador,"metros",String(var_cantidad))
			END IF
		ELSE
			// Modificacion según Carlos
			//dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####")+ " " + dw_proceso.GetItemNumber(reg1,"descripcion"))
	   	dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemSTring(reg1,"descripcion"))
	   
						
		END IF
		
	var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))		
	impdtopp =  Dec(STring(Dec(dw_proceso.GetItemNumber(reg1,"importe")) * dtopp / 100,mascara))
   importedtopp = importedtopp + impdtopp
	C = ""
		IF var_clase = "M" Then C = "(MUESTRAS)"
		IF var_clase = "S" Then C = "(SIN CARGO)"
		des = dw_preliminar.GetItemString(contador,"articulo")
		IF Trim(des) <> "" Then 
			dw_preliminar.SetItem(contador,"articulo",des + " " +c)
		END IF
	Next
	END IF
	var_total = var_total - Dec(String(importedtopp,mascara))
	
//	IF importedtopp <>0 then
//		contador = contador + 1
//		contador = dw_preliminar.RowCount() +1
//		dw_preliminar.InsertRow(contador)
//		f_valores(contador,tipo)
//		dw_preliminar.SetItem(contador,"texto",String(dtopp,"##,##") + "% " +f_diccionario("PRONTO PAGO",var_idioma)+puntos)
//		IF importedtopp <0 Then
//			dw_preliminar.SetItem(contador,"importe", + String(Dec(importedtopp * (-1)),mascara))
//		ELSE
//			dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedtopp),mascara))
//		END IF
//		dw_preliminar.SetItem(contador,"orden","2")
//		dw_preliminar.SetItem(contador,"raya",1)
//		
//		contador = contador + 1
//		contador = dw_preliminar.RowCount() +1
//		dw_preliminar.InsertRow(contador)
//		f_valores(contador,tipo)
//		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
//		dw_preliminar.SetItem(contador,"orden","2")
//
//
//END IF

IF IsNull(iva)     Then iva = 0
IF IsNull(recargo) Then recargo = 0
importeiva      = Dec(STring(var_total * iva / 100,mascara))
importerecargo  = Dec(String(var_total * recargo / 100,mascara))

//IF importeiva <>0 then
//      contador = dw_preliminar.RowCount() +1
//		dw_preliminar.InsertRow(contador)
//		f_valores(contador,tipo)
//		dw_preliminar.SetItem(contador,"texto","IVA "+String(iva,"##") + "% " +puntos)
//		dw_preliminar.SetItem(contador,"importe"," " + String(Dec(importeiva),mascara))
//		dw_preliminar.SetItem(contador,"orden","2")
//		dw_preliminar.SetItem(contador,"raya",1)
//		var_total = var_total + importeiva
//		contador = dw_preliminar.RowCount() +1
//		dw_preliminar.InsertRow(contador)
//		f_valores(contador,tipo)
//		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
//		dw_preliminar.SetItem(contador,"orden","2")
//END IF

IF importerecargo <>0 then
		contador = contador + 1
      contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(recargo,"##") + "% " +texto_recargo+puntos)
		dw_preliminar.SetItem(contador,"importe"," " + String(Dec(importerecargo),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total + importerecargo
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF



// calculo resto de lineas para completar la hoja
	var_paginas = Int(contador / lineas)
	resto = lineas - (contador - (var_paginas * lineas))

IF resto >= lnpie Then	// Hay espacio para los textos
	// calculo final de hoja
	For  re = 1 To resto - lnpie
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	For reg1 = 1 To lnpie
		contador = contador + 1
		      contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
	   f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"textopie",textpie[reg1])
		dw_preliminar.SetItem(contador,"orden","2")

	NEXT
ELSE
	For  re = 1 To resto
		contador = contador + 1 
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	// calculo resto de lineas para completar la hoja
	var_paginas = Int(contador / lineas)
	resto = lineas - (contador - (var_paginas * lineas))
	
	
	// calculo final de hoja
	For  re = 1 To resto - lnpie
		contador = contador + 1 
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	
	
	
	For reg1 = 1 To lnpie
		contador = contador + 1
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
	   f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"textopie",textpie[reg1])
		dw_preliminar.SetItem(contador,"orden","2")
	NEXT
	
END IF

//if var_serie = "1" then
//	mascara_euros = f_mascara_moneda (f_codigo_euro())
//	texto_euro = "Euros :#"+String(f_conversion_euros(var_total,cambio_euros),mascara_euros)+"#  "
//else
//	texto_euro = ""
//end if
dw_preliminar.SetItem(contador,"texto_total",&
          			texto_euro+&
			 			f_textopie2_venfac(codigo_empresa,var_anyo,var_factura) +"  "+f_nombre_moneda_abr(var_moneda) + "  #" +&
						String(var_total,mascara)+"#")

dw_preliminar.SetItem(contador,"total_ptas",String(f_conversion_pesetas(var_total,cambio_euros),f_mascara_moneda("1")))
//carga los valores de los totales//

for indice = 1 to dw_preliminar.rowcount() 
	dw_preliminar.SetItem(indice,"total_neto", + String(Dec(var_total + importedtopp),mascara))	
	dw_preliminar.SetItem(indice,"base_imponible",String(var_total,mascara))	
	dw_preliminar.SetItem(indice,"porc_iva",String(iva,"##"))
	IF importeiva <> 0 then
		dw_preliminar.SetItem(indice,"importe_iva"," " + String(Dec(importeiva),mascara))
	END IF
	IF importedtopp <> 0 then
		dw_preliminar.SetItem(indice,"porc_pp",String(dtopp,"##,##")+" %")
		IF importedtopp <0 Then
			dw_preliminar.SetItem(indice,"importe_pp", + String(Dec(importedtopp * (-1)),mascara))
		ELSE
			dw_preliminar.SetItem(indice,"importe_pp","-" + String(Dec(importedtopp),mascara))
		END IF
	else
		dw_preliminar.SetItem(indice,"importe_pp","")
	end if	
	dw_preliminar.SetItem(indice,"total_factura", + String(Dec(var_total+importeiva),mascara)+" "+f_nombre_moneda_abr(var_moneda))
next

///////////////////
dw_preliminar.SetItem(contador,"ultima","S")



end subroutine

protected subroutine f_proceso (integer tipo);Dec{0} var_anyo,var_factura,resto,re,var_ejercicio,var_numpalet,var_paginas
long va,va2,longi,pos_blanco
String  var_tono,textpie[],pie,pie1,pie2,pie3,letra,var_articulo,tipo_iva,&
	tipo_recargo,puntos,destino1,destino2,destino3,var_clase,c,des,&
	mascara,mascara2, var_familia
String textopie2,cadena,texto_iva,texto_recargo,var_tipo_pallet,var_descripcion,var_formato,parte1,parte2
Dec{4}  var_calibre,var_cantidad,acumulado,dto1,impdto1,dto2,impdto2,dto3,impdto3,&
		  dto4,impdto4,dtopp,impdtopp,aculumado,dtoesp,cantidad,bruto,importe,iva,&
		  recargo,importeiva,importerecargo,var_metros
dec{6}  precio
String   var_tipo_unidad,textdto1,textdto2,textdto3,textdto4,tipodto1,&
         tipodto2,tipodto3,tipodto4,tipo_cliente,linea,unimetro,var_caja,&
			unimetrosl,var_tipo_linea,ls_paises_texto_factura1,ls_paises_texto_factura2,ls_paises_texto_factura3
			
Dec{4}   importedto1,importedto2,importedto3,importedto4,importedtopp
string n_partida="N",var_pais,cod_partida,nom_partida
string texto_euro,mascara_euros,var_serie
Long v_piezascaja, piezas_calculadas
Dec cajas_parciales
Dec v_metroscaja
Int decimales_unidad
string agrupa_referencias ,ls_tarifa
string var_tono_imprimir,var_calibre_imprimir,ls_venseries_texto_factura,ls_cliente,ls_listar_textos_pais1,ls_listar_textos_pais2,ls_listar_textos_pais3

if cbx_agrupar_ref.checked then
	agrupa_referencias = 'S'
else
	agrupa_referencias = 'N'
end if

unimetro ="N"
unimetrosl ="N"
if cbx_1.checked = true then unimetro   = "S"
// unidades a metros lineales
if cbx_2.checked = true then unimetrosl = "S"

var_total = 0
puntos= "............................................."
contador    = 1
acumulado   = 0
importedto1 = 0
importedto2 = 0
importedto3 = 0
importedto4 = 0
importedtopp= 0 
var_anyo     = Dec(em_anyo.text)
var_factura  = Dec(em_factura.text)

Select dtoesp1,tipodto1,explicaciondto1, dtoesp2,tipodto2,explicaciondto2,
		 dtoesp3,tipodto3,explicaciondto3, dtoesp4,tipodto4,explicaciondto4,
		 dtopp,ltrim(rtrim(isnull(textcomercial2,''))),ltrim(rtrim(isnull(textaduanaesp2,''))),ltrim(rtrim(isnull(textaduanaext2,''))),tipoiva,cartera,precartera,
		 ltrim(rtrim(isnull(destino1,''))),ltrim(rtrim(isnull(destino2,''))),ltrim(rtrim(isnull(destino3,''))),pais,cambio,cambio_euros, serie,  calculo_dtoesp,tarifa,cliente
Into   :dto1,:tipodto1,:textdto1, :dto2,:tipodto2,:textdto2,
       :dto3,:tipodto3,:textdto3, :dto4,:tipodto4,:textdto4,
		 :dtopp,:pie1,:pie2,:pie3,  :tipo_iva,:cartera,:precartera,
		 :destino1,:destino2,:destino3,:var_pais,:var_cambio,:cambio_euros,:var_serie, :calculo_dtoesp, :ls_tarifa,:ls_cliente
From   venfac
Where  venfac.empresa = :codigo_empresa
And    venfac.anyo    = :var_anyo
And    venfac.factura = :var_factura;

IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",SQLCA.sqlerrtext)

mascara = f_mascara_moneda(var_moneda)
mascara2 = "###,###,###,###.00"

int li_decimales_precio
string ls_mascara_moneda_tarifa

li_decimales_precio       = f_ventarifas_decimales_precios(codigo_empresa,ls_tarifa)
ls_mascara_moneda_tarifa  = f_mascara_decimales(li_decimales_precio)

SELECT isnull(venclientes.textopais1,'N'),
		 isnull(venclientes.textopais2,'N'),
		 isnull(venclientes.textopais3,'N')
INTO   :ls_listar_textos_pais1,
		 :ls_listar_textos_pais2,
		 :ls_listar_textos_pais3
FROM   venclientes  
WHERE  venclientes.empresa  = :codigo_empresa
AND    venclientes.codigo   = :ls_cliente;

//-----------------------
// texto pie factura
//-----------------------
CHOOSE CASE tipo
	CASE 1
		pie      = pie1
		destino  = destino1
	CASE 2		
		pie      = pie2
		destino  = destino2
	CASE 3
		pie      = pie3
		destino  = destino3
		// comprueba si tiene que poner texto de las partidas en el articulo
		n_partida = f_partida_sn_pais(var_pais)
END CHOOSE

select ltrim(rtrim(isnull(venseries.texto_factura,'')))
into   :ls_venseries_texto_factura
from   venseries
where  venseries.empresa = :codigo_empresa
and    venseries.serie   = :var_serie;

if trim(ls_venseries_texto_factura) <> "" then
	if trim(pie) <> "" then
		pie += char(13)+ls_venseries_texto_factura	
	else
		pie = ls_venseries_texto_factura	
	end if
end if

if ls_listar_textos_pais1 = 'S' or ls_listar_textos_pais2 = 'S' or ls_listar_textos_pais3 = 'S' then
	select ltrim(rtrim(isnull(ventextospais.pie1,''))),
			 ltrim(rtrim(isnull(ventextospais.pie2,''))),
			 ltrim(rtrim(isnull(ventextospais.pie3,'')))
	into   :ls_paises_texto_factura1,
			 :ls_paises_texto_factura2,
			 :ls_paises_texto_factura3
	from   ventextospais
	where  ventextospais.empresa = :codigo_empresa
	and    ventextospais.pais = :var_pais;
	
	//Todas las impresiones funcionan con el pie1
	//if tipo = 1 and ls_listar_textos_pais1 = 'S' then
		if trim(ls_paises_texto_factura1) <> "" then
			if trim(pie) <> "" then
				pie += char(13)+ls_paises_texto_factura1
			else
				pie = ls_paises_texto_factura1
			end if
		end if
	//end if
	/*
	if tipo = 2 and ls_listar_textos_pais2 = 'S' then
		if trim(ls_paises_texto_factura2) <> "" then
			if trim(pie) <> "" then
				pie += char(23)+ls_paises_texto_factura2
			else
				pie = ls_paises_texto_factura2
			end if
		end if
	end if	
	
	if tipo = 3 and ls_listar_textos_pais3 = 'S' then
		if trim(ls_paises_texto_factura3) <> "" then
			if trim(pie) <> "" then
				pie += char(33)+ls_paises_texto_factura3
			else
				pie = ls_paises_texto_factura3
			end if
		end if
	end if		
	*/
end if

f_textos_pie_pais(var_pais,pie)

lnpie = f_convierte_texto_en_array(pie,textpie)
/*
long ll_ultimo_espacio

lnpie  = 0
va2    = len(pie)
cadena = ""

for va = 1 to va2

	letra = Mid(pie,va,1)
	if asc(letra) > 31 then
		cadena = cadena + letra			
		if cadena = " " then cadena = ""
	end if
	
	if cadena = char(13) then cadena = ""
	
	//if Asc(Mid(pie,va,2)) = 13 then
	if asc(letra) = 13 then
		if trim(cadena) <> "" then
			lnpie = lnpie +1
			textpie[lnpie] = cadena //left(cadena,len(cadena)-2) //cadena//Mid(cadena,1,len(cadena) - 1)
		end if
		cadena = ""
	else
		//Vamos a buscar el ultimo espacio
		if Mid(pie,va,1) = " " then
			ll_ultimo_espacio = len(cadena)
		end if
		
		if len(cadena) = 157 then
			lnpie = lnpie +1
			textpie[lnpie] = Mid(cadena,1,ll_ultimo_espacio)
			cadena = right(cadena,len(cadena) - ll_ultimo_espacio)
			ll_ultimo_espacio = 0
		end if
	end if		
	
next

if Trim(cadena)<> "" and trim(cadena) <> char(13) then
	lnpie = lnpie +1
	textpie[lnpie] = cadena
end if
*/

//-------------------------------------------------

var_ejercicio = f_ejercicio_activo(codigo_empresa)

SELECT contaiva.iva,contaiva.recargo,contaiva.descripcion  
INTO   :iva,:tipo_recargo,:texto_iva  
FROM   contaiva  
WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
		( contaiva.empresa = :codigo_empresa ) AND  
		( contaiva.tipoiva = :tipo_iva )   ;
IF SQLCA.SQLCODE <> 0 Then 
	f_mensaje("Error en contaiva",SQLCA.sqlerrtext)
end if

IF Not IsNull(tipo_recargo) and Trim(tipo_recargo) <> "" Then
	SELECT contaiva.iva,contaiva.descripcion INTO :recargo,:texto_recargo
	FROM   contaiva  
	WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
			( contaiva.empresa = :codigo_empresa ) AND  
			( contaiva.tipoiva = :tipo_recargo )   ;
	IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en recargo",SQLCA.sqlerrtext)
END IF


//---------------------------------------------------------------------

//if unimetro="S" then
//	  f_mascara_columna(dw_preliminar,"precio",f_mascara_decimales(2))
//  else
//     f_mascara_columna(dw_preliminar,"precio",mascara)	
//End if	

dw_preliminar.SetItem(contador,"total_ptas",String(f_conversion_pesetas(var_total,cambio_euros),f_mascara_moneda("1")))//String(var_total*var_cambio,f_mascara_moneda("1")))


f_mascara_columna(dw_preliminar,"total",mascara)

if agrupa_referencias = 'S' then
	dw_proceso.dataobject = 'dw_proceso_venlifac_dto_agrupado'
else
	dw_proceso.dataobject = 'dw_proceso_venlifac_dto'
end if

f_mascara_columna(dw_preliminar,"c_precio",ls_mascara_moneda_tarifa)
f_mascara_columna(dw_preliminar,"precio",ls_mascara_moneda_tarifa)

dw_proceso.SetTransObject(SQLCA)

dw_proceso.retrieve(codigo_empresa,var_anyo,var_factura,"S")
//IF tipo <> 1 Then
//	dw_proceso.SetFilter("listar_aduana = 'S'")
//	dw_proceso.Filter()
//END IF
string ls_tipolinea,ls_gestionar_en_piezas

reg = dw_proceso.RowCount()
IF reg <> 0 Then
	For reg1 = 1 to reg
		ls_tipolinea = dw_proceso.GetItemSTring(reg1,"tipolinea")
		ls_gestionar_en_piezas = f_gestionar_en_piezas_ventipolin(codigo_empresa,ls_tipolinea)		
		
		acumulado    = 0
		//contador     = contador + 1
		var_clase       = dw_proceso.GetItemString(reg1,"clase")
		v_anyo_albaran  = dw_proceso.GetItemNumber(reg1,"anyo_albaran")
		v_albaran       = dw_proceso.GetItemNumber(reg1,"albaran")
		v_falbaran      = dw_proceso.GetItemDateTime(reg1,"falbaran")
		dtoesp          = dw_proceso.GetItemNumber(reg1,"dtoesp")
		if ls_gestionar_en_piezas = "S" then
			cantidad     	 = dw_proceso.GetItemNumber(reg1,"cantidad_pzs")
		else
			cantidad     	 = dw_proceso.GetItemNumber(reg1,"cantidad")
		end if
		var_tono     	 = dw_proceso.GetItemString(reg1,"tonochar")
		var_calibre  	 = dw_proceso.GetItemNumber(reg1,"calibre")
		var_tono_imprimir = dw_proceso.GetItemString(reg1,"tono_imprimir")
		var_calibre_imprimir = dw_proceso.GetItemString(reg1,"calibre_imprimir")
		var_tipo_linea  = dw_proceso.GetItemString(reg1,"tipolinea")
		var_tipo_pallet = dw_proceso.GetItemString(reg1,"tipo_pallet")
		var_caja     	 = dw_proceso.GetItemString(reg1,"caja")
		var_numpalet 	 = dw_proceso.GetItemNumber(reg1,"numpalet")
		var_obs_lin  	 = dw_proceso.GetItemString(reg1,"observ_lin")
		var_articulo    = dw_proceso.GetItemString(reg1,"articulo")
	
		CHOOSE CASE tipo
		 CASE  3
			if ls_gestionar_en_piezas = "S" and f_unidad_articulo(codigo_empresa,var_articulo) = '1'  then
				precio     = dw_proceso.GetItemNumber(reg1,"precio_pzs")
			else
				precio     = dw_proceso.GetItemNumber(reg1,"precio_aduana_neto")
			end if
			bruto      = dw_proceso.GetItemNumber(reg1,"importe_aduana")
			impdtopp   = dw_proceso.GetItemNumber(reg1,"impdtopp_aduana")
			impdto1    = dw_proceso.GetItemNumber(reg1,"impdtoesp1_aduana")
			impdto2    = dw_proceso.GetItemNumber(reg1,"impdtoesp2_aduana")			
			impdto3    = dw_proceso.GetItemNumber(reg1,"impdtoesp3_aduana")			
			impdto4    = dw_proceso.GetItemNumber(reg1,"impdtoesp4_aduana")			
		 CASE ELSE
			if ls_gestionar_en_piezas = "S" and f_unidad_articulo(codigo_empresa,var_articulo) = '1' then
				precio     = dw_proceso.GetItemNumber(reg1,"precio_pzs")
			else
				precio     = dw_proceso.GetItemNumber(reg1,"precio_neto")
			end if
			bruto      = dw_proceso.GetItemNumber(reg1,"importe")
			impdtopp   = dw_proceso.GetItemNumber(reg1,"impdtopp")
			impdto1    = dw_proceso.GetItemNumber(reg1,"impdtoesp1")
			impdto2    = dw_proceso.GetItemNumber(reg1,"impdtoesp2")			
			impdto3    = dw_proceso.GetItemNumber(reg1,"impdtoesp3")
			impdto4    = dw_proceso.GetItemNumber(reg1,"impdtoesp4")
		END CHOOSE

		acumulado    = bruto - impdtopp
		importedto1  = importedto1  + impdto1			 
		importedto2  = importedto2  + impdto2			 
		importedto3  = importedto3  + impdto3			 
		importedto4  = importedto4  + impdto4			 
		importedtopp = importedtopp + impdtopp			 
		contador = dw_preliminar.RowCount() + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		
		
		
		if ls_gestionar_en_piezas = "S" then
			var_tipo_unidad = "0"
		else
			var_tipo_unidad = dw_proceso.GetItemSTring(reg1,"tipo_unidad")
		end if
		if not isnull(var_articulo) and var_articulo <> "" then
			if ls_gestionar_en_piezas = "S" then
				decimales_unidad = f_decimales_unidad("0")
			else
				decimales_unidad = ftc_decimales_articulo(codigo_empresa, var_articulo)
			end if
		else
			decimales_unidad = 0
		end if
		
		SELECT familia INTO :var_familia FROM articulos WHERE empresa = :codigo_empresa AND codigo = :var_articulo;
		
		dw_preliminar.SetItem(contador,"tipo_unidad",var_tipo_unidad)
		dw_preliminar.SetItem(contador,"unimetro",unimetro)
		dw_preliminar.SetItem(contador,"unimetrosl",unimetrosl)		
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemNumber(reg1,"pallets"))
		dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemNumber(reg1,"cajas"))
		dw_preliminar.SetItem(contador,"total_cajas",dw_proceso.GetItemNumber(reg1,"total_cajas"))
		dw_preliminar.SetItem(contador,"numpalet",var_numpalet)
		dw_preliminar.SetItem(contador,"calculo_dtoesp",calculo_dtoesp)

		
		
		select piezascaja, metroscaja
			into :v_piezascaja, :v_metroscaja
			from almartcajas
			where empresa = :codigo_empresa
			and articulo = :var_articulo
			and caja = :var_caja;
		
		if tipo=3 and f_partida_sn_pais(var_pais)="S" then
			 cod_partida = f_partida_segun_familia(codigo_empresa,f_familia_articulo(codigo_empresa,var_articulo))
			 nom_partida = f_nombre_partida(codigo_empresa,cod_partida)
			 dw_preliminar.SetItem(contador,"articulo",trim(nom_partida)+" "+dw_proceso.GetItemString(reg1,"descripcion"))
    	else
		    dw_preliminar.SetItem(contador,"articulo",var_articulo + " " + dw_proceso.GetItemString(reg1,"descripcion"))	
		end if
	
		dw_preliminar.SetItem(contador,"tono",var_tono_imprimir)
		dw_preliminar.SetItem(contador,"calibre",dec(var_calibre_imprimir))
    	dw_preliminar.SetItem(contador,"tipo_pallet",dw_proceso.GetItemString(reg1,"tipo_pallet"))
   	dw_preliminar.SetItem(contador,"caja",dw_proceso.GetItemString(reg1,"caja"))		
		
		IF tipo <>3 Then
			dw_preliminar.SetItem(contador,"importe",String(Dec(dw_proceso.GetItemNumber(reg1,"importe")),mascara))
			IF var_tipo_unidad= "0" Then
				// *---* precio
					if cbx_1.checked and (unimetrosl<>"S") then
						dw_preliminar.SetItem(contador,"precio",dec(string(f_convertir("P",codigo_empresa,var_articulo,cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))),ls_mascara_moneda_tarifa)))
					 else
						if unimetrosl = "S" then
							dw_preliminar.SetItem(contador,"precio",dec(string(f_convertir_metrosl("P",codigo_empresa,var_articulo,cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))),ls_mascara_moneda_tarifa)))
						else
							if ls_gestionar_en_piezas = "S" and f_unidad_articulo(codigo_empresa,var_articulo) = '1' then
								dw_preliminar.SetItem(contador,"precio",Dec(String(dw_proceso.GetItemNumber(reg1,"precio_pzs"),ls_mascara_moneda_tarifa)))
							else
								dw_preliminar.SetItem(contador,"precio",Dec(String(dw_proceso.GetItemNumber(reg1,"precio_neto"),ls_mascara_moneda_tarifa)))
							end if
						end if
					end if
         else			
				if ls_gestionar_en_piezas = "S" and f_unidad_articulo(codigo_empresa,var_articulo) = '1' then
					dw_preliminar.SetItem(contador,"precio",Dec(String(dw_proceso.GetItemNumber(reg1,"precio_pzs"),ls_mascara_moneda_tarifa)))
				else
               dw_preliminar.SetItem(contador,"precio",Dec(String(dw_proceso.GetItemNumber(reg1,"precio_neto"),ls_mascara_moneda_tarifa)))
				end if
			End if
			
			dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento"))
			dw_preliminar.SetItem(contador,"dto1",dw_proceso.GetItemNumber(reg1,"dtoesp"))
			dw_preliminar.SetItem(contador,"dto2",dw_proceso.GetItemNumber(reg1,"dtoesp2"))
			dw_preliminar.SetItem(contador,"calculo_dtoesp",calculo_dtoesp)			
			
		ELSE
			dw_preliminar.SetItem(contador,"importe",String(Dec(dw_proceso.GetItemNumber(reg1,"importe_aduana")),mascara))
			// *---* precio
			if cbx_1.checked and (unimetrosl<>"S") then
				dw_preliminar.SetItem(contador,"precio",dec(string(f_convertir("P",codigo_empresa,var_articulo,cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))),ls_mascara_moneda_tarifa)))
			 else
				if unimetrosl = "S" then
					dw_preliminar.SetItem(contador,"precio",dec(string(f_convertir_metrosl("P",codigo_empresa,var_articulo,cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))),ls_mascara_moneda_tarifa)))
				else
					if ls_gestionar_en_piezas = "S" and f_unidad_articulo(codigo_empresa,var_articulo) = '1' then
						dw_preliminar.SetItem(contador,"precio",Dec(String(dw_proceso.GetItemNumber(reg1,"precio_pzs"),ls_mascara_moneda_tarifa)))
					else
						dw_preliminar.SetItem(contador,"precio",Dec(String(dw_proceso.GetItemNumber(reg1,"precio_neto"),ls_mascara_moneda_tarifa)))
					end if
				end if
			end if
			dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento_aduana"))
		END IF
		dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"formato")))
		dw_preliminar.SetItem(contador,"familia",f_nombre_familia(codigo_empresa,dw_proceso.GetItemString(reg1,"familia")))		
		dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"calidad")))
		
		if ls_gestionar_en_piezas = "S" then
			var_tipo_unidad="0"
			var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad_pzs")			
		else
			var_tipo_unidad=dw_proceso.GetItemSTring(reg1,"tipo_unidad")
			var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad")
		end if
		dw_preliminar.SetItem(contador, "decimales_unidad", decimales_unidad)
		
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" or var_articulo = '' Then
			IF var_tipo_unidad <> "1" Then
				if cbx_1.checked and (unimetrosl<>"S")then
					dw_preliminar.SetItem(contador,"piezas",0)
					dw_preliminar.SetItem(contador,"metros",f_convertir("M",codigo_empresa,var_articulo,var_cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))))
				else 
					if unimetrosl ="S" then
						// en la casilla piezas ponemos los ml
						//f_mascara_columna(dw_preliminar,"piezas",f_mascara_decimales(2))
						//***
						//f_mensaje("",String(f_convertir_metrosl("M",codigo_empresa,var_articulo,var_cantidad,dec(dw_preliminar.getitemstring(contador,"importe")))))
						dw_preliminar.SetItem(contador,"piezas",f_convertir_metrosl("M",codigo_empresa,var_articulo,var_cantidad,dec(dw_preliminar.getitemstring(contador,"importe"))))
						// Calcula los metros de las piezas
						//dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_piezas(codigo_empresa,var_articulo,var_caja,var_cantidad))
						//dw_preliminar.SetItem(contador,"metros",f_calculo_metros_cuadrados(codigo_empresa,var_articulo,var_cantidad))
						
						
						
				   else 
						dw_preliminar.SetItem(contador,"piezas",var_cantidad)
						// Calcula los metros de las piezas
						//dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_piezas(codigo_empresa,var_articulo,var_caja,var_cantidad))
						//dw_preliminar.SetItem(contador,"metros",f_calculo_metros_cuadrados(codigo_empresa,var_articulo,var_cantidad))
						
						//Calculamos los metros cuadrados según los metros 2 / caja
//						if var_familia = "2" then
//							if v_piezascaja > 0 then
//								cajas_parciales = var_cantidad / v_piezascaja		
//								var_metros = f_calculo_metros_desde_cajas(codigo_empresa,var_articulo, var_caja, cajas_parciales)
//							else
//								var_metros = 0
//							end if
//						else
//							var_metros = f_calculo_metros_cuadrados(codigo_empresa,var_articulo,var_cantidad)
//						end if

						//13-03-2017 ya no hacemos la conversion de piezas a metros
						/*if v_piezascaja > 0 then
							cajas_parciales = truncate(var_cantidad / v_piezascaja, 0)		
							var_metros = f_calculo_metros_desde_cajas(codigo_empresa,var_articulo, var_caja, cajas_parciales)
						else
							var_metros = 0
						end if*/
						//13-03-2017 ya no hacemos la conversion de piezas a metros
						var_metros = 0
						dw_preliminar.SetItem(contador,"metros",var_metros)		
					end if
				end if
			ELSE
				
				//13-03-2017 ya no hacemos la conversion de piezas a metros
				/*
				if v_metroscaja > 0 then
					piezas_calculadas = truncate(var_cantidad / v_metroscaja,0) * v_piezascaja
				else
					piezas_calculadas = 0
				end if				
				
				dw_preliminar.SetItem(contador,"piezas",piezas_calculadas)
				*/
				//13-03-2017 ya no hacemos la conversion de piezas a metros
				
				dw_preliminar.SetItem(contador,"metros",var_cantidad)
				dw_preliminar.SetItem(contador,"piezas",0)
			END IF
		ELSE
			dw_preliminar.SetItem(contador,"piezas",var_cantidad)
			var_descripcion = dw_proceso.GetItemString(reg1,"descripcion")
			dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))				
		END IF
		
		IF tipo <>3 then
			var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))
		ELSE
			var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe_aduana"))
		END IF
		C = ""
		//f_diccionario("TOTAL BRUTO",f_idioma_venfac(codigo_empresa,var_anyo,var_factura)
		//Añadimos idioma 03/2015
//		IF var_clase = "M" Then C = "(MUESTRAS)"
//		IF var_clase = "S" Then C = "(SIN CARGO)"
		IF var_clase = "M" Then C = "("+f_diccionario("MUESTRAS",f_idioma_venfac(codigo_empresa,var_anyo,var_factura))+")"
		IF var_clase = "S" Then C = "("+f_diccionario("SIN CARGO",f_idioma_venfac(codigo_empresa,var_anyo,var_factura))+")"
		
		des = dw_preliminar.GetItemString(contador,"articulo")
		IF Trim(des) <> "" Then 
			dw_preliminar.SetItem(contador,"articulo",des + " " +c)
		END IF
		if trim(var_obs_lin)<> "" then
			contador = dw_preliminar.RowCount() +1
			dw_preliminar.InsertRow(contador)
			dw_preliminar.SetItem(contador,"observ_linea",var_obs_lin)
      	f_valores(contador,tipo)
		end if
		
	Next
	reg1 = 0
	IF contador <> 0 then
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
      f_valores(contador,tipo)
		dw_preliminar.SetItem(contador - 1,"raya",1)
		dw_preliminar.SetItem(contador,"texto",f_diccionario("TOTAL BRUTO",f_idioma_venfac(codigo_empresa,var_anyo,var_factura)) + puntos)
		dw_preliminar.SetItem(contador,"importe",String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
	END IF
END IF

IF importedto1 <>0 then
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(dto1,"#0.00") + "% " +textdto1+puntos )
		dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto1),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total - importedto1
		contador  = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF
IF importedto2 <>0 then
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(dto2,"#0.00") + "% " +textdto2+puntos)
		dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto2),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total - importedto2
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF

IF importedto3 <>0 then
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(dto3,"#0.00") + "% " +textdto3+puntos)
		dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto3),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total - importedto3
	   contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF

//IF importedto4 <>0 then
if importedtopp <> 0 then	
	   contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(dto4,"#0.00") + "% " +f_diccionario(textdto4,f_idioma_venfac(codigo_empresa,var_anyo,var_factura))+puntos)
		dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedtopp),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total - Dec(String(importedtopp,mascara))
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF

dw_proceso.retrieve(codigo_empresa,var_anyo,var_factura,"N")
//IF tipo <> 1 Then
//	dw_proceso.SetFilter("listar_aduana = 'S'")
//	dw_proceso.Filter()
//END IF
reg = dw_proceso.RowCOunt()
IF reg <> 0 Then
	For reg1 = 1 to reg
		
		ls_tipolinea = dw_proceso.GetItemSTring(reg1,"tipolinea")
		ls_gestionar_en_piezas = f_gestionar_en_piezas_ventipolin(codigo_empresa,ls_tipolinea)				
		
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		
		v_anyo_albaran  = dw_proceso.GetItemNumber(reg1,"anyo_albaran")
		v_albaran       = dw_proceso.GetItemNumber(reg1,"albaran")
		v_falbaran      = dw_proceso.GetItemDateTime(reg1,"falbaran")
		
		f_valores(contador,tipo)
		var_clase    = dw_proceso.GetItemString(reg1,"clase")
		var_articulo = dw_proceso.GetItemString(reg1,"articulo")
		var_tono_imprimir = dw_proceso.GetItemString(reg1,"tono_imprimir")
		var_calibre_imprimir = dw_proceso.GetItemString(reg1,"calibre_imprimir")		
		var_numpalet = dw_proceso.GetItemNumber(reg1,"numpalet")		
		var_obs_lin  	 = dw_proceso.GetItemString(reg1,"observ_lin")
		
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemNumber(reg1,"pallets"))
		dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemNumber(reg1,"cajas"))
		dw_preliminar.SetItem(contador,"total_cajas",dw_proceso.GetItemNumber(reg1,"total_cajas"))
		dw_preliminar.SetItem(contador,"numpalet",dw_proceso.GetItemNumber(reg1,"numpalet"))
		dw_preliminar.SetItem(contador,"calculo_dtoesp",calculo_dtoesp)		
		
      if tipo=3 and f_partida_sn_pais(var_pais)="S" then
 		    cod_partida = f_partida_segun_familia(codigo_empresa,f_familia_articulo(codigo_empresa,var_articulo))
			 nom_partida = f_nombre_partida(codigo_empresa,cod_partida)
			 dw_preliminar.SetItem(contador,"articulo",trim(nom_partida)+" "+dw_proceso.GetItemString(reg1,"descripcion"))
		 else
	      dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))	
		end if
		dw_preliminar.SetItem(contador,"tono",var_tono_imprimir)
		dw_preliminar.SetItem(contador,"calibre",dec(var_calibre_imprimir))		
		if ls_gestionar_en_piezas = "S" and f_unidad_articulo(codigo_empresa,var_articulo) = '1' then
			dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemNumber(reg1,"precio_pzs"))
		else
			dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemNumber(reg1,"precio"))
		end if
		dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento"))
		dw_preliminar.SetItem(contador,"dto1",dw_proceso.GetItemNumber(reg1,"dtoesp"))
		dw_preliminar.SetItem(contador,"dto2",dw_proceso.GetItemNumber(reg1,"dtoesp2"))		
		dw_preliminar.SetItem(contador,"importe",String(Dec(dw_proceso.GetItemNumber(reg1,"importe")),mascara))
		dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"formato")))
		dw_preliminar.SetItem(contador,"familia",f_nombre_familia(codigo_empresa,dw_proceso.GetItemString(reg1,"familia")))		
		dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"calidad")))
		if ls_gestionar_en_piezas = "S" then
			var_tipo_unidad="0"
			var_cantidad=Dec(dw_proceso.GetItemNumber(reg1,"cantidad_pzs"))			
		else
			var_tipo_unidad=dw_proceso.GetItemString(reg1,"tipo_unidad")
			var_cantidad=Dec(dw_proceso.GetItemNumber(reg1,"cantidad"))
		end if
		dw_preliminar.SetItem(contador,"calculo_dtoesp",calculo_dtoesp)
		 
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad <> "1" Then
				dw_preliminar.SetItem(contador,"piezas",var_cantidad)
				dw_preliminar.SetItem(contador,"metros",0)
			ELSE
				dw_preliminar.SetItem(contador,"piezas",0)
				dw_preliminar.SetItem(contador,"metros",var_cantidad)
			END IF
		ELSE
			dw_preliminar.SetItem(contador,"piezas",var_cantidad)
			dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))	
	   END IF
		
		var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))		
		impdtopp =  Dec(STring(Dec(dw_proceso.GetItemNumber(reg1,"importe")) * dtopp / 100,mascara))
		importedtopp = importedtopp + impdtopp
		C = ""
		IF var_clase = "M" Then C = "(MUESTRAS)"
		IF var_clase = "S" Then C = "(SIN CARGO)"
		des = dw_preliminar.GetItemString(contador,"articulo")
		IF Trim(des) <> "" Then 
			dw_preliminar.SetItem(contador,"articulo",des + " " +c)
		END IF
		
		if trim(var_obs_lin)<> "" then
			contador = dw_preliminar.RowCount() +1
			dw_preliminar.InsertRow(contador)
			dw_preliminar.SetItem(contador,"observ_linea",var_obs_lin)
      	f_valores(contador,tipo)
		end if		
		
	NEXT
END IF

//----------------------------------------------------------------------------------------
// David 14-06-04 : Incluir suma del bruto de artículos con dto, más artículos sin dto
//----------------------------------------------------------------------------------------

//dw_preliminar.SetItem(contador,"raya",1)
IF reg <> 0 Then
	contador = dw_preliminar.RowCount() +1
	dw_preliminar.InsertRow(contador)
	dw_preliminar.SetItem(contador - 1,"raya",1)
	dw_preliminar.SetItem(contador,"texto",f_diccionario("TOTAL BRUTO",f_idioma_venfac(codigo_empresa,var_anyo,var_factura)) + puntos)
	dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
end if

//----------------------------------------------------------------------------------------
// David 14-06-04 : Fin Incluir suma del bruto de artículos con dto, más artículos sin dto
//----------------------------------------------------------------------------------------


/*
var_total = var_total - Dec(String(importedtopp,mascara))
IF importedtopp <>0 then
	contador = dw_preliminar.RowCount() +1
	dw_preliminar.InsertRow(contador)
	f_valores(contador,tipo)
	dw_preliminar.SetItem(contador,"texto",String(dtopp,"##.##") + "% " +f_diccionario("PRONTO PAGO",var_idioma)+puntos)
	IF importedtopp <0 Then
		dw_preliminar.SetItem(contador,"importe", + String(Dec(importedtopp * (-1)),mascara))
	ELSE
		dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedtopp),mascara))
	END IF
	dw_preliminar.SetItem(contador,"orden","2")
	dw_preliminar.SetItem(contador,"raya",1)
	contador = dw_preliminar.RowCount() +1
	dw_preliminar.InsertRow(contador)
	f_valores(contador,tipo)
	dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
	dw_preliminar.SetItem(contador,"orden","2")
END IF
*/

IF IsNull(iva)     Then iva = 0
IF IsNull(recargo) Then recargo = 0
importeiva      = Dec(STring(var_total * iva / 100,mascara))
importerecargo  = Dec(String(var_total * recargo / 100,mascara))

IF importeiva <>0 then
      contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto","IVA "+String(iva,"##") + "% " +puntos)
		dw_preliminar.SetItem(contador,"importe"," " + String(Dec(importeiva),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total + importeiva
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF
IF importerecargo <>0 then
      contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(recargo,"##") + "% " +texto_recargo+puntos)
		dw_preliminar.SetItem(contador,"importe"," " + String(Dec(importerecargo),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total + importerecargo
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),mascara))
		dw_preliminar.SetItem(contador,"orden","2")
END IF

// calculo resto de lineas para completar la hoja
var_paginas = Int(contador / (lineas+1))
resto = lineas - (contador - (var_paginas * lineas))

IF resto >= lnpie Then	// Hay espacio para los textos
	// calculo final de hoja
	For  re = 1 To resto - lnpie
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	For reg1 = 1 To lnpie
	   contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
	   f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"textopie",textpie[reg1])
		dw_preliminar.SetItem(contador,"orden","2")
	NEXT
ELSE
	For  re = 1 To resto
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	// calculo resto de lineas para completar la hoja
	var_paginas = Int(contador / lineas)
	resto = lineas - (contador - (var_paginas * lineas))

	// calculo final de hoja
	For  re = 1 To resto - lnpie
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	
	For reg1 = 1 To lnpie
		contador = dw_preliminar.RowCount() +1
		dw_preliminar.InsertRow(contador)
	   f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"textopie",textpie[reg1])
		dw_preliminar.SetItem(contador,"orden","2")
	NEXT
	
END IF

//if var_serie = "1" then
//	mascara_euros = f_mascara_moneda (f_codigo_euro())
//	texto_euro = "Euros :#"+String(f_conversion_euros(var_total,cambio_euros),mascara_euros)+"#  "
//else
//	texto_euro = ""
//end if

//dw_preliminar.SetItem(contador,"texto_total",&
//          			texto_euro+&
//			 			f_textopie2_venfac(codigo_empresa,var_anyo,var_factura) +"  "+f_nombre_moneda_abr(var_moneda) + "  #" +&
//						String(var_total,mascara)+"#")

dw_preliminar.SetItem(contador,"texto_total",&
          			texto_euro+&
			 			"TOTAL  "+f_nombre_moneda_abr(var_moneda) + "  #" +&
						String(var_total,mascara)+"#")
dw_preliminar.SetItem(contador,"total_ptas",String(f_conversion_pesetas(var_total,cambio_euros),f_mascara_moneda("1")))


dw_preliminar.SetItem(contador,"ultima","S")
end subroutine

public subroutine f_textos_pie_pais (string arg_pais, ref string arg_textos_pie);string ls_texto_pais,ls_paises_idioma,ls_paises_tipopais

select isnull(paises.idioma,''),
		 isnull(paises.tipopais,'')
into   :ls_paises_idioma,
		 :ls_paises_tipopais
from   paises
where  paises.pais = :arg_pais;

choose case ls_paises_tipopais
	case "C"
		//Comunitarios
		choose case ls_paises_idioma
			case "2"
				dw_declaracion_adquiriente.dataobject = "report_declaracion_adquiriente_fra"
				//Frances
				ls_texto_pais = "Conformément aux dispositions du règlement d'exécution (UE) 2018/1912 du Conseil européen du 4 décembre 2018 modifiant le règlement d'exécution (UE) nº 282/2011 en ce qui concerne certaines exonérations liées à des opérations intracommunautaires et donc, aux fins de justifier l'émission de la facture de l'opération de vente sans TVA, le client s'engage à envoyer à "+f_nombre_empresa(codigo_empresa)+" la déclaration écrite prévue dans le nouvel article 45 bis 1 b) au plus tard, le dix du mois suivant la livraison du matériau objet de la vente. De même, le client s'engage à envoyer à "+f_nombre_empresa(codigo_empresa)+" la CMR et la facture de transport que le client a souscrit afin d'attester auprès des autorités fiscales espagnoles que l'opération de vente est une opération intracommunautaire."
			case "4"
				dw_declaracion_adquiriente.dataobject = "report_declaracion_adquiriente_ale"
				//Aleman				
				ls_texto_pais = "Gemäß den Bestimmungen in der Durchführungsverordnung (EU) 2018/1912 des europäischen Rates vom 4. Dezember 2018 zur Änderung der Durchführungsverordnung (EU) Nr. 282/2011 hinsichtlich bestimmter  Befreiungen bei innergemeinschaftlichen Umsätzen und demzufolge zur Rechtfertigung der Ausstellung einer Rechnung für eine Verkaufstransaktion ohne Mehrwertsteuer, verpflichtet sich der Kunde, spätestens am zehnten Tag des auf die Lieferung folgenden Monats die schriftliche Erklärung gemäß Buchstabe b Ziffer 1 des neuen Artikels 45 an "+f_nombre_empresa(codigo_empresa)+" zu senden. Desgleichen verpflichtet sich der Kunde, "+f_nombre_empresa(codigo_empresa)+" den CMR-Frachtbrief und die Rechnung für den vom Kunden verpflichteten Transport vorzulegen, um gegenüber den spanischen Steuerbehörden nachzuweisen, dass es sich bei der Verkaufstransaktion um eine innergemeinschaftliche Lieferung handelte."
			case "5"
				dw_declaracion_adquiriente.dataobject = "report_declaracion_adquiriente_esp"
				//Italiano
				ls_texto_pais = "De conformidad con lo dispuesto en el Reglamento de ejecución(UE) 2018/1912 del Consejo europeo de 4 de diciembre de 2018 por el que se modifica el Reglamento de ejecución (UE) nº 282/2011 en lo que respecta a determinadas exenciones relacionadas con operaciones intracomunitarias, y por lo tanto a los efectos de justificar la emisión de la factura de la operación de compraventa sin IVA, el cliente se compromete a remitir a "+f_nombre_empresa(codigo_empresa)+" la declaración escrita prevista en el nuevo artículo 45 bis 1 b) a más tardar el décimo día del mes siguiente a la entrega del material objeto de la compraventa. Del mismo modo el cliente se compromete a remitir a "+f_nombre_empresa(codigo_empresa)+" el CMR y la factura de transporte que el cliente ha contratado el fin de acreditar ante las autoridades tributarias españolas que la operación de venta es una operación intracomunitaria."				
			case "6"
				dw_declaracion_adquiriente.dataobject = "report_declaracion_adquiriente_por"
				//Portugues
				ls_texto_pais = "Em conformidade com o disposto no Regulamento de Execução (UE) 2018/1912 do Conselho Europeu de 4 de dezembro de 2018, que altera o Regulamento de Execução (UE) nº 282/2011 no que diz respeito a determinadas isenções relacionadas com operações intracomunitárias e,portanto com o objectivo de justificar a emissão da factura da transação de vendas isentas de IVA,o cliente compromete-se a remitir a "+f_nombre_empresa(codigo_empresa)+", a declaração escrita prevista no novo artigo 45 bis 1 b), o mais tardar no décimo dia do mês seguinte à entrega do material. Da mesma forma, o cliente compromete-se a enviar a "+f_nombre_empresa(codigo_empresa)+" o CMR e a factura de transporte que o cliente contratou, com a finalidade de provar às autoridades fiscais espanholas que a operação de venda é uma operação intracomunitária."
			case else
				dw_declaracion_adquiriente.dataobject = "report_declaracion_adquiriente_ing"
				//Ingles				
				ls_texto_pais = "Pursuant to the provisions of Council Implementing Regulation (EU) 2018/1912 of 4th December, amending Implementing Regulation (EU)  282/2011, as regards certain exemptions for intra-Community transactions, and therefore for the purpose of justifying the issue of non-VAT sales invoices, the customer undertakes to send the written statement stipulated in the new article 45 bis 1b)  to "+f_nombre_empresa(codigo_empresa)+", no later than the tenth day of the month following the supply of the material that is the object of sale. Likewise, the customer undertakes to send the CMR and the invoice for carriage hired by the customer to "+f_nombre_empresa(codigo_empresa)+" as proof before the Spanish tax authorities that the sales transaction is an intra-Community operation."   				
		end choose
		
		integer li_anyo
		long    ll_factura
		
		li_anyo     = integer(em_anyo.text)
		ll_factura  = long(em_factura.text)		
		
		dw_declaracion_adquiriente.settransobject(sqlca)
		if cbx_declaracion_entrada_entrega_intracom.checked then
			dw_declaracion_adquiriente.retrieve(codigo_empresa,li_anyo,ll_factura)
		else
			dw_declaracion_adquiriente.reset()
		end if
	case else
		ls_texto_pais = ""
		dw_declaracion_adquiriente.reset()
end choose

arg_textos_pie += char(13)+ls_texto_pais
end subroutine

public function integer f_convierte_texto_en_array (string arg_pie, ref string arg_array[]);integer li_lineas,li_ancho_maximo = 162,li_ultimo_espacio
long    ll_indice_texto,ll_tamaño_texto
string  ls_caracter,ls_linea

li_lineas = 0
ll_tamaño_texto = len(arg_pie)

For ll_indice_texto = 1 To ll_tamaño_texto
	ls_caracter = mid(arg_pie,ll_indice_texto,1)
	
	if asc(ls_caracter) > 31 then
		ls_linea += ls_caracter
	end if
	
	if ls_caracter = " " then li_ultimo_espacio = len(ls_linea)
	
	if asc(ls_caracter) = 13 and trim(ls_linea) <> "" then
		li_lineas ++
		arg_array[li_lineas] = ls_linea
		ls_linea = ""
		li_ultimo_espacio = 0
	else
		if len(ls_linea) > li_ancho_maximo then
			li_lineas ++
			arg_array[li_lineas] = left(ls_linea,li_ultimo_espacio)
			ls_linea = right(ls_linea,len(ls_linea)-li_ultimo_espacio)
			li_ultimo_espacio = 0			
		end if
	end if		
Next

IF Trim(ls_linea)<> "" Then
	li_lineas ++
	arg_array[li_lineas] = ls_linea
END IF

return li_lineas
end function

event open;call super::open;
istr_parametros.s_titulo_ventana="Listado Facturas"
dw_preliminar.visible = FALSE
This.title=istr_parametros.s_titulo_ventana


dw_preliminar.SetTransObject(SQLCA)
listado_partidas.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_facturas.SetTransObject(SQLCA)

em_anyo.text = String(Year(Today()))
var_tipo = 1
cabecera.text = "Si"
istr_parametros = Message.PowerObjectParm
		 
IF istr_parametros.i_nargumentos>1 THEN
      em_anyo.text=istr_parametros.s_argumentos[2]	
      em_factura.text=istr_parametros.s_argumentos[3]	
	  	IF istr_parametros.i_nargumentos > 3 Then		  
			
			   if istr_parametros.s_argumentos[4] <> "No" then
			   		cabecera.text = "Si"
				end if
				
			   if istr_parametros.i_nargumentos >= 5 then
			  	   	em_copias1.text = istr_parametros.s_argumentos[5]
				end if

				if istr_parametros.i_nargumentos >= 6 then
					dw_preliminar.Modify(" datawindow.printer = "+istr_parametros.s_argumentos[6])
				end if
								
				if istr_parametros.i_nargumentos >= 7 and istr_parametros.s_argumentos[7] = "S" then
					cbx_matric.checked = true
				else
					cbx_matric.checked = false
				end if				
								
				if istr_parametros.i_nargumentos >= 8 then				
					if istr_parametros.s_argumentos[8] = "S" then
						cbx_declaracion_entrada_entrega_intracom.checked = true
					else
						cbx_declaracion_entrada_entrega_intracom.checked = false
					end if
				end if
																
				em_factura.TriggerEvent("modificado")
				istr_parametros.i_nargumentos=0
				cb_2.triggerevent(Clicked!) //cb_1.
				Close(This)
				//Return
		END IF
	
END IF





end event

on ue_listar;//dw_report  = dw_detalle
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

on w_lis_venfacturas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_factura=create em_factura
this.st_3=create st_3
this.dw_proceso=create dw_proceso
this.em_copias1=create em_copias1
this.st_13=create st_13
this.cabecera=create cabecera
this.st_7=create st_7
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.st_pagina=create st_pagina
this.em_copias2=create em_copias2
this.em_copias3=create em_copias3
this.gb_3=create gb_3
this.st_1=create st_1
this.st_33=create st_33
this.st_44=create st_44
this.cb_3=create cb_3
this.listado_partidas=create listado_partidas
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cbx_matric=create cbx_matric
this.cbx_nom_agente=create cbx_nom_agente
this.pb_imprimir_preli=create pb_imprimir_preli
this.gb_2=create gb_2
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.uo_manejo=create uo_manejo
this.uo_1=create uo_1
this.dw_facturas=create dw_facturas
this.dw_preliminar=create dw_preliminar
this.dw_declaracion_adquiriente=create dw_declaracion_adquiriente
this.cbx_declaracion_entrada_entrega_intracom=create cbx_declaracion_entrada_entrega_intracom
this.cbx_agrupar_ref=create cbx_agrupar_ref
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_factura
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.dw_proceso
this.Control[iCurrent+7]=this.em_copias1
this.Control[iCurrent+8]=this.st_13
this.Control[iCurrent+9]=this.cabecera
this.Control[iCurrent+10]=this.st_7
this.Control[iCurrent+11]=this.st_cliente
this.Control[iCurrent+12]=this.st_codcli
this.Control[iCurrent+13]=this.st_pagina
this.Control[iCurrent+14]=this.em_copias2
this.Control[iCurrent+15]=this.em_copias3
this.Control[iCurrent+16]=this.gb_3
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.st_33
this.Control[iCurrent+19]=this.st_44
this.Control[iCurrent+20]=this.cb_3
this.Control[iCurrent+21]=this.listado_partidas
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.cb_1
this.Control[iCurrent+24]=this.cb_2
this.Control[iCurrent+25]=this.cbx_matric
this.Control[iCurrent+26]=this.cbx_nom_agente
this.Control[iCurrent+27]=this.pb_imprimir_preli
this.Control[iCurrent+28]=this.gb_2
this.Control[iCurrent+29]=this.cbx_2
this.Control[iCurrent+30]=this.cbx_1
this.Control[iCurrent+31]=this.uo_manejo
this.Control[iCurrent+32]=this.uo_1
this.Control[iCurrent+33]=this.dw_facturas
this.Control[iCurrent+34]=this.dw_preliminar
this.Control[iCurrent+35]=this.dw_declaracion_adquiriente
this.Control[iCurrent+36]=this.cbx_declaracion_entrada_entrega_intracom
this.Control[iCurrent+37]=this.cbx_agrupar_ref
this.Control[iCurrent+38]=this.cb_4
end on

on w_lis_venfacturas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_factura)
destroy(this.st_3)
destroy(this.dw_proceso)
destroy(this.em_copias1)
destroy(this.st_13)
destroy(this.cabecera)
destroy(this.st_7)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.st_pagina)
destroy(this.em_copias2)
destroy(this.em_copias3)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.st_33)
destroy(this.st_44)
destroy(this.cb_3)
destroy(this.listado_partidas)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cbx_matric)
destroy(this.cbx_nom_agente)
destroy(this.pb_imprimir_preli)
destroy(this.gb_2)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.uo_manejo)
destroy(this.uo_1)
destroy(this.dw_facturas)
destroy(this.dw_preliminar)
destroy(this.dw_declaracion_adquiriente)
destroy(this.cbx_declaracion_entrada_entrega_intracom)
destroy(this.cbx_agrupar_ref)
destroy(this.cb_4)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_venfacturas
integer y = 840
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_venfacturas
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_factura)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_venfacturas
integer x = 23
integer y = 16
integer width = 3904
integer height = 88
end type

type pb_1 from upb_salir within w_lis_venfacturas
integer x = 3941
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_2 from statictext within w_lis_venfacturas
integer x = 27
integer y = 132
integer width = 297
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 12632256
string text = "Factura:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF dw_facturas.Retrieve(codigo_empresa,Dec(em_anyo.text)) <> 0 Then 
	dw_facturas.visible = TRUE
END IF
end event

type em_anyo from u_em_campo within w_lis_venfacturas
integer x = 329
integer y = 132
integer width = 201
integer taborder = 0
end type

type em_factura from u_em_campo within w_lis_venfacturas
integer x = 576
integer y = 132
integer width = 315
integer taborder = 10
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = "Ä"
end type

event modificado;string serie

f_dat()
serie = f_serie_venfac(codigo_empresa,dec(em_anyo.text),dec(em_factura.text))

if serie = "3" then
	em_copias1.enabled = false
	em_copias1.text = "0"
	em_copias2.enabled = true
	IF istr_parametros.i_nargumentos>1 THEN
      IF istr_parametros.i_nargumentos = 5 Then		  
			em_copias2.text = istr_parametros.s_argumentos[5]
		END IF
	ELSE
		em_copias2.text = "1"
	END IF
else
	em_copias1.enabled = true
	IF istr_parametros.i_nargumentos>1 THEN
      IF istr_parametros.i_nargumentos = 5 Then		  
			em_copias1.text = istr_parametros.s_argumentos[5]
		END IF
	ELSE
		em_copias1.text = "1"
	END IF
	em_copias2.enabled = false
	em_copias2.text = "0"
end if
call super::modificado
end event

type st_3 from statictext within w_lis_venfacturas
integer x = 530
integer y = 120
integer width = 46
integer height = 84
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
boolean focusrectangle = false
end type

type dw_proceso from datawindow within w_lis_venfacturas
boolean visible = false
integer x = 2711
integer y = 128
integer width = 494
integer height = 180
boolean bringtotop = true
string dataobject = "dw_proceso_venlifac_dto_agrupado"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_copias1 from editmask within w_lis_venfacturas
integer x = 1847
integer y = 220
integer width = 165
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 16777215
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string displaydata = " ~v¼~rpbedit050"
double increment = 1
end type

event getfocus;this.selectText(1,2)
end event

type st_13 from statictext within w_lis_venfacturas
integer x = 1563
integer y = 132
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cabecera:"
boolean focusrectangle = false
end type

type cabecera from dropdownlistbox within w_lis_venfacturas
integer x = 1842
integer y = 120
integer width = 192
integer height = 220
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_lis_venfacturas
integer x = 32
integer y = 244
integer width = 297
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_cliente from statictext within w_lis_venfacturas
integer x = 539
integer y = 244
integer width = 923
integer height = 88
boolean bringtotop = true
integer textsize = -8
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

type st_codcli from statictext within w_lis_venfacturas
integer x = 334
integer y = 244
integer width = 201
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_pagina from statictext within w_lis_venfacturas
boolean visible = false
integer x = 2821
integer y = 160
integer width = 306
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_copias2 from editmask within w_lis_venfacturas
event getfocus pbm_ensetfocus
integer x = 1851
integer y = 308
integer width = 160
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 16777215
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string displaydata = " ~v¼~rpbedit050"
double increment = 1
end type

event getfocus;this.selectText(1,2)
end event

type em_copias3 from editmask within w_lis_venfacturas
event getfocus pbm_ensetfocus
boolean visible = false
integer x = 1851
integer y = 400
integer width = 160
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 16777215
boolean enabled = false
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string displaydata = " ~v¼~rpbedit050"
double increment = 1
end type

event getfocus;this.selectText(1,2)
end event

type gb_3 from groupbox within w_lis_venfacturas
integer x = 5
integer y = 80
integer width = 1518
integer height = 276
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_1 from statictext within w_lis_venfacturas
integer x = 1536
integer y = 228
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Comercial"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_33 from statictext within w_lis_venfacturas
integer x = 1531
integer y = 312
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Aduana"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_44 from statictext within w_lis_venfacturas
boolean visible = false
integer x = 1550
integer y = 412
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Adu.Ext."
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_3 from u_boton within w_lis_venfacturas
event clicked pbm_bnclicked
integer x = 2199
integer y = 120
integer width = 375
integer height = 96
integer taborder = 100
string text = "&Partidas"
end type

event clicked;call super::clicked;f_dat()
Dec anyo,factura,fpeso,fpeso_neto,lpeso,lpeso_neto
anyo     =  Dec(em_anyo.text)
factura  =  Dec(em_factura.text)
fpeso      = f_peso_venfac(codigo_empresa,anyo,factura)
fpeso_neto = f_peso_neto_venfac(codigo_empresa,anyo,factura)


Select Sum(venlifac.peso), sum(venlifac.peso_neto)
Into  :lpeso,:lpeso_neto 
from  venlifac
Where venlifac.empresa = :codigo_empresa
And   venlifac.anyo    = :anyo
And   venlifac.factura = :factura;

listado_partidas.Retrieve(codigo_empresa,anyo,factura,fpeso - lpeso,fpeso_neto - lpeso_neto)
f_imprimir_datawindow(listado_partidas)
end event

type listado_partidas from datawindow within w_lis_venfacturas
boolean visible = false
integer x = 571
integer y = 20
integer width = 494
integer height = 76
integer taborder = 120
boolean bringtotop = true
string dataobject = "report_list_venfacturas_partidas"
boolean livescroll = true
end type

type gb_1 from groupbox within w_lis_venfacturas
integer x = 3634
integer y = 124
integer width = 411
integer height = 328
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type cb_1 from u_boton within w_lis_venfacturas
integer x = 3648
integer y = 160
integer width = 384
integer height = 96
integer taborder = 80
boolean bringtotop = true
string text = "&Preliminar"
end type

event clicked;/*
Dec hh,fra,an
Long numpallets[],var_numpalet,limite
Int cont,i

if len(em_factura.text)=0 then
	MessageBox("Introduzca la factura","" ,Exclamation!, OK!, 2)
    f_activar_campo(em_factura)
	Return
else
	hh = 0
	an = Dec(em_anyo.text)
	fra = Dec(em_factura.text)
	Select count(*) Into :hh  from venfac
	where empresa = :codigo_empresa
	And   anyo    = :an
	And   factura = :fra;
	IF IsNull(hh) Then hh = 0
	IF hh = 0 Then
		f_mensaje("La factura no existe",trim(nombre_usuario)+" La Factura introducida no existe")
		f_activar_campo(em_factura)
		Return
	end if
End if
lineas=19
f_inicio()
dw_preliminar.DataObject = "report_list_venfacturas1"
f_dat()
//lineas = 19
ante_albaran = 0
bultos_totales = 0
pallets_totales = 0
var_paginas_a_imprimir = 0
dw_preliminar.DataObject = "report_list_venfacturas1"
dw_preliminar.settransobject(sqlca)
//if cbx_matric.checked then
//	lineas = 24
//	dw_preliminar.DataObject = "report_list_venfacturas1_matric"
//else
//	lineas=23
//	dw_preliminar.DataObject = "report_list_venfacturas1"
//end if

f_activar_campo(em_factura)


//DAVID: Queremos que salga siempre el tipo 2
var_tipo = 2

//if em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
//	var_tipo = 1		
//end if
//if em_copias2.text <> "0" and Trim(em_copias2.text) <> "" Then
//	var_tipo = 2		
//end if


dw_preliminar.visible= FALSE
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE
dw_preliminar.reset()
dw_preliminar.SetRedraw(FALSE)
f_proceso(var_tipo)
f_pagina()
dw_preliminar.modify( "copia.visible = 0 ")
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "90" + ")")

for i = 1 to dw_preliminar.Rowcount()
	var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
	if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
		limite = upperbound(numpallets)
		if var_numpalet > limite then
			pallets_totales = pallets_totales +1		
			numpallets[var_numpalet] = 1
		else
			if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
				pallets_totales = pallets_totales +1		
				numpallets[var_numpalet] = 1
			end if
		end if
	end if
next
for i = 1 to dw_preliminar.Rowcount()
	dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
	f_valores(i,var_tipo)
next
dw_preliminar.insertrow(0)
//dw_preliminar.deleterow(0)
dw_preliminar.visible= TRUE
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE
dw_preliminar.groupcalc()
dw_preliminar.SetRedraw(TRUE)

*/

Dec hh,fra,an
int cont
Long i,var_numpalet,limite
Long numpallets[]

hh = 0

ante_albaran = 0
bultos_totales = 0
pallets_totales = 0
var_paginas_a_imprimir = 0
an = Dec(em_anyo.text)
fra = Dec(em_factura.text)
 
Select count(*) 
Into :hh  
from venfac
where empresa = :codigo_empresa
And   anyo    = :an
And   factura = :fra;

IF IsNull(hh) Then hh = 0

IF hh = 0 Then
	f_mensaje("La factura no existe",trim(nombre_usuario)+" La Factura introducida no existe")
	f_activar_campo(em_factura)
	return
else
	f_inicio()
	f_dat()
	lineas=19
	
	dw_preliminar.DataObject = "report_list_venfacturas1"
   dw_preliminar.Settransobject(SQLCA)
	dw_preliminar.visible = true
//	if cbx_matric.checked then

//		lineas = 24
//		dw_preliminar.DataObject = "report_list_venfacturas1_matric"
//	else
//		lineas=20
//		dw_preliminar.DataObject = "report_list_venfacturas1"
//	end if
	
	if len(em_factura.text)=0 then
		MessageBox("Introduzca la factura","" ,Exclamation!, OK!, 2)
		f_activar_campo(em_factura)
		Return
	End if
	
	//dw_preliminar.visible= FALSE
	//uo_manejo.visible = FALSE
	//pb_imprimir_preli.visible = FALSE
	
	// *** El número de líneas para los drivers de NT y 95 son distintas
	Environment env
	integer rtn
	rtn = GetEnvironment(env)
	if rtn <>1 then f_mensaje("Imprimir Factura","Error al intentar imprimir")
//	CHOOSE CASE env.OSType
//		CASE Windows!
//			lineas = 25
//		CASE WindowsNT!
//			lineas = 25
//		CASE ELSE
//			lineas = 25
//	END CHOOSE

	IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
		var_tipo = 1		
		for cont=1 to integer(em_copias1.text)
			if cont=1 then
				dw_preliminar.reset()
				if cbx_matric.checked then
					f_proceso_matric(1)
				else
					f_proceso(1)
				end if
				dw_preliminar.modify( "copia.visible = 0 ")
			else
				dw_preliminar.modify( "copia.visible = 1 ")			
				dw_preliminar.modify( "copia.x = 900 ")
				dw_preliminar.modify( "copia.y = 2300 ")
				dw_preliminar.modify( "copia.width = 1500 ")
				dw_preliminar.modify( "copia.height = 500 ")
			end if
			for i = 1 to dw_preliminar.Rowcount()
				var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
				if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
					limite = upperbound(numpallets)
					if var_numpalet > limite then
						pallets_totales = pallets_totales +1		
						numpallets[var_numpalet] = 1
					else
						if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
							pallets_totales = pallets_totales +1		
							numpallets[var_numpalet] = 1
						end if
					end if
				end if
			next
			for i = 1 to dw_preliminar.Rowcount()
				dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
				f_valores(i,var_tipo)
			next
		//	IF dw_preliminar.RowCount() <> 0 Then dw_preliminar.Print(TRUE)					
		next
	END IF
		
	IF em_copias2.text <> "0" and Trim(em_copias2.text) <> "" Then
		var_tipo = 2
		for cont=1 to integer(em_copias2.text)
			if cont=1 then
				dw_preliminar.reset()
				if cbx_matric.checked then
					f_proceso_matric(2)
				else
					f_proceso(2)
				end if
				dw_preliminar.modify( "copia.visible = 0 ")
			else
				dw_preliminar.modify( "copia.visible = 1 ")			
				dw_preliminar.modify( "copia.x = 900 ")
				dw_preliminar.modify( "copia.y = 2300 ")
				dw_preliminar.modify( "copia.width = 1500 ")
				dw_preliminar.modify( "copia.height = 500 ")
			end if
			for i = 1 to dw_preliminar.Rowcount()
				var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
				if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
					limite = upperbound(numpallets)
					if var_numpalet > limite then
						pallets_totales = pallets_totales +1		
						numpallets[var_numpalet] = 1
					else
						if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
							pallets_totales = pallets_totales +1		
							numpallets[var_numpalet] = 1
						end if
					end if
				end if
			next
			for i = 1 to dw_preliminar.Rowcount()
				dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
				f_valores(i,var_tipo)
			next
		//	IF dw_preliminar.RowCount() <> 0 Then dw_preliminar.Print(TRUE)					
		next
	END IF
		
	IF em_copias3.text <> "0" and Trim(em_copias3.text) <> "" Then
		var_tipo = 3
		for cont=1 to integer(em_copias3.text)
			if cont=1 then
				dw_preliminar.reset()
				if cbx_matric.checked then
					f_proceso_matric(3)
				else
					f_proceso(3)
				end if
				dw_preliminar.modify( "copia.visible = 0 ")
			else
				dw_preliminar.modify( "copia.visible = 1 ")			
				dw_preliminar.modify( "copia.x = 900 ")
				dw_preliminar.modify( "copia.y = 2300 ")
				dw_preliminar.modify( "copia.width = 1500 ")
				dw_preliminar.modify( "copia.height = 500 ")
			end if
			for i = 1 to dw_preliminar.Rowcount()
				var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
				if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
					limite = upperbound(numpallets)
					if var_numpalet > limite then
						pallets_totales = pallets_totales +1		
						numpallets[var_numpalet] = 1
					else
						if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
							pallets_totales = pallets_totales +1		
							numpallets[var_numpalet] = 1
						end if
					end if
				end if
			next
			for i = 1 to dw_preliminar.Rowcount()
				dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
				f_valores(i,var_tipo)
			next
		//	IF dw_preliminar.RowCount() <> 0 Then dw_preliminar.Print(TRUE)					
		next		
		// dw_preliminar.Print(TRUE)
	END IF
		
	if dw_declaracion_adquiriente.rowcount() > 0 then
		dw_declaracion_adquiriente.print(false)
	end if		
				
	f_activar_campo(em_factura)
			
End If



	



end event

type cb_2 from u_boton within w_lis_venfacturas
event clicked pbm_bnclicked
integer x = 3653
integer y = 256
integer width = 384
integer height = 96
integer taborder = 90
boolean bringtotop = true
string text = "&Imprimir"
end type

event clicked;Dec hh,fra,an
int cont
Long i,var_numpalet,limite
Long numpallets[]

hh = 0

ante_albaran = 0
bultos_totales = 0
pallets_totales = 0
var_paginas_a_imprimir = 0
an = Dec(em_anyo.text)
fra = Dec(em_factura.text)
 
Select count(*) 
Into :hh  
from venfac
where empresa = :codigo_empresa
And   anyo    = :an
And   factura = :fra;

IF IsNull(hh) Then hh = 0

IF hh = 0 Then
	f_mensaje("La factura no existe",trim(nombre_usuario)+" La Factura introducida no existe")
	f_activar_campo(em_factura)
	return
else
	f_inicio()
	f_dat()
	lineas=19
	
	dw_preliminar.DataObject = "report_list_venfacturas1"
   	dw_preliminar.Settransobject(SQLCA)

//	if cbx_matric.checked then

//		lineas = 24
//		dw_preliminar.DataObject = "report_list_venfacturas1_matric"
//	else
//		lineas=20
//		dw_preliminar.DataObject = "report_list_venfacturas1"
//	end if
	
	if len(em_factura.text)=0 then
		MessageBox("Introduzca la factura","" ,Exclamation!, OK!, 2)
		f_activar_campo(em_factura)
		Return
	End if
	
	dw_preliminar.visible= FALSE
	uo_manejo.visible = FALSE
	pb_imprimir_preli.visible = FALSE
	
	// *** El número de líneas para los drivers de NT y 95 son distintas
	Environment env
	integer rtn
	rtn = GetEnvironment(env)
	if rtn <>1 then f_mensaje("Imprimir Factura","Error al intentar imprimir")
//	CHOOSE CASE env.OSType
//		CASE Windows!
//			lineas = 25
//		CASE WindowsNT!
//			lineas = 25
//		CASE ELSE
//			lineas = 25
//	END CHOOSE

	IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
		var_tipo = 1		
		for cont=1 to integer(em_copias1.text)
			if cont=1 then
				dw_preliminar.reset()
				if cbx_matric.checked then
					f_proceso_matric(1)
				else
					f_proceso(1)
				end if
				dw_preliminar.modify( "copia.visible = 0 ")
			else
				dw_preliminar.modify( "copia.visible = 1 ")			
				dw_preliminar.modify( "copia.x = 900 ")
				dw_preliminar.modify( "copia.y = 2300 ")
				dw_preliminar.modify( "copia.width = 1500 ")
				dw_preliminar.modify( "copia.height = 500 ")
			end if
			for i = 1 to dw_preliminar.Rowcount()
				var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
				if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
					limite = upperbound(numpallets)
					if var_numpalet > limite then
						pallets_totales = pallets_totales +1		
						numpallets[var_numpalet] = 1
					else
						if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
							pallets_totales = pallets_totales +1		
							numpallets[var_numpalet] = 1
						end if
					end if
				end if
			next
			for i = 1 to dw_preliminar.Rowcount()
				dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
				f_valores(i,var_tipo)
			next
			IF dw_preliminar.RowCount() <> 0 Then dw_preliminar.Print(TRUE)					
		next
	END IF
		
	IF em_copias2.text <> "0" and Trim(em_copias2.text) <> "" Then
		var_tipo = 2
		for cont=1 to integer(em_copias2.text)
			if cont=1 then
				dw_preliminar.reset()
				if cbx_matric.checked then
					f_proceso_matric(2)
				else
					f_proceso(2)
				end if
				dw_preliminar.modify( "copia.visible = 0 ")
			else
				dw_preliminar.modify( "copia.visible = 1 ")			
				dw_preliminar.modify( "copia.x = 900 ")
				dw_preliminar.modify( "copia.y = 2300 ")
				dw_preliminar.modify( "copia.width = 1500 ")
				dw_preliminar.modify( "copia.height = 500 ")
			end if
			for i = 1 to dw_preliminar.Rowcount()
				var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
				if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
					limite = upperbound(numpallets)
					if var_numpalet > limite then
						pallets_totales = pallets_totales +1		
						numpallets[var_numpalet] = 1
					else
						if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
							pallets_totales = pallets_totales +1		
							numpallets[var_numpalet] = 1
						end if
					end if
				end if
			next
			for i = 1 to dw_preliminar.Rowcount()
				dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
				f_valores(i,var_tipo)
			next
			IF dw_preliminar.RowCount() <> 0 Then dw_preliminar.Print(TRUE)					
		next
	END IF
		
	IF em_copias3.text <> "0" and Trim(em_copias3.text) <> "" Then
		var_tipo = 3
		for cont=1 to integer(em_copias3.text)
			if cont=1 then
				dw_preliminar.reset()
				if cbx_matric.checked then
					f_proceso_matric(3)
				else
					f_proceso(3)
				end if
				dw_preliminar.modify( "copia.visible = 0 ")
			else
				dw_preliminar.modify( "copia.visible = 1 ")			
				dw_preliminar.modify( "copia.x = 900 ")
				dw_preliminar.modify( "copia.y = 2300 ")
				dw_preliminar.modify( "copia.width = 1500 ")
				dw_preliminar.modify( "copia.height = 500 ")
			end if
			for i = 1 to dw_preliminar.Rowcount()
				var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
				if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
					limite = upperbound(numpallets)
					if var_numpalet > limite then
						pallets_totales = pallets_totales +1		
						numpallets[var_numpalet] = 1
					else
						if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
							pallets_totales = pallets_totales +1		
							numpallets[var_numpalet] = 1
						end if
					end if
				end if
			next
			for i = 1 to dw_preliminar.Rowcount()
				dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
				f_valores(i,var_tipo)
			next
			IF dw_preliminar.RowCount() <> 0 Then dw_preliminar.Print(TRUE)					
		next		
		// dw_preliminar.Print(TRUE)
	END IF
		
	if dw_declaracion_adquiriente.rowcount() > 0 then
		dw_declaracion_adquiriente.print(false)
	end if		
				
	f_activar_campo(em_factura)
			
End If


end event

type cbx_matric from checkbox within w_lis_venfacturas
boolean visible = false
integer x = 2094
integer y = 132
integer width = 261
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Matric."
end type

type cbx_nom_agente from checkbox within w_lis_venfacturas
boolean visible = false
integer x = 2094
integer y = 216
integer width = 485
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nombre Agente"
boolean checked = true
end type

type pb_imprimir_preli from picturebutton within w_lis_venfacturas
boolean visible = false
integer x = 2459
integer y = 124
integer width = 101
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_factura)
end event

type gb_2 from groupbox within w_lis_venfacturas
boolean visible = false
integer x = 2057
integer y = 304
integer width = 603
integer height = 176
integer taborder = 110
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cbx_2 from checkbox within w_lis_venfacturas
boolean visible = false
integer x = 2080
integer y = 404
integer width = 553
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unidades a M.L."
end type

type cbx_1 from checkbox within w_lis_venfacturas
integer x = 2080
integer y = 340
integer width = 553
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Unidades a Metros"
end type

type uo_manejo from u_manejo_datawindow within w_lis_venfacturas
boolean visible = false
integer x = 2784
integer y = 336
integer width = 475
integer height = 164
integer taborder = 70
end type

event valores;call super::valores;dw_data =dw_preliminar
f_pagina()
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type uo_1 from u_selec_impresoras within w_lis_venfacturas
integer x = 18
integer y = 372
integer width = 1499
integer height = 132
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type dw_facturas from datawindow within w_lis_venfacturas
boolean visible = false
integer x = 215
integer y = 668
integer width = 1202
integer height = 516
integer taborder = 20
string dataobject = "dw_list_venfacturas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	Reset()
	visible = FALSE
	f_activar_campo(em_factura)
END IF
end event

event doubleclicked;IF row = 0 Then Return
   em_factura.text = STring(GetItemNumber(row,"venfac_factura"))
	Reset()
	visible = FALSE
	em_factura.TriggerEvent("modificado")
	f_activar_campo(em_factura)

end event

type dw_preliminar from datawindow within w_lis_venfacturas
boolean visible = false
integer x = 55
integer y = 512
integer width = 3991
integer height = 2476
boolean bringtotop = true
string dataobject = "report_list_venfacturas1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type dw_declaracion_adquiriente from datawindow within w_lis_venfacturas
boolean visible = false
integer x = 2706
integer width = 1170
integer height = 92
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Declaracion Adquiriente Intracomunitario"
string dataobject = "report_declaracion_adquiriente_ing"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_declaracion_entrada_entrega_intracom from checkbox within w_lis_venfacturas
integer x = 2679
integer y = 164
integer width = 1285
integer height = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Imprimir Declaracion Entrega Intr."
boolean checked = true
end type

type cbx_agrupar_ref from checkbox within w_lis_venfacturas
integer x = 2679
integer y = 240
integer width = 677
integer height = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19474154
long backcolor = 553648127
string text = "Agrupar Referencias"
boolean checked = true
end type

type cb_4 from u_boton within w_lis_venfacturas
integer x = 3653
integer y = 352
integer width = 384
integer height = 96
integer taborder = 100
boolean bringtotop = true
string text = "&PDF"
end type

event clicked;Dec hh,fra,an
int cont,li_rc
Long i,var_numpalet,limite, ll_aux
Long numpallets[]
string  ls_folderfile, ls_path, ls_file, v_cliente, v_serie, tipo	
integer li_return
hh = 0



ante_albaran = 0
bultos_totales = 0
pallets_totales = 0
var_paginas_a_imprimir = 0
an = Dec(em_anyo.text)
fra = Dec(em_factura.text)

tipo = 'Fact'
 
Select count(*) 
Into :hh  
from venfac
where empresa = :codigo_empresa
And   anyo    = :an
And   factura = :fra;

IF IsNull(hh) Then hh = 0

IF hh = 0 Then
	f_mensaje("La factura no existe",trim(nombre_usuario)+" La Factura introducida no existe")
	f_activar_campo(em_factura)
	return
else
	f_inicio()
	f_dat()
	//lineas=19
	lineas=20
	
	dw_preliminar.DataObject = "report_list_venfacturas1"
   dw_preliminar.Settransobject(SQLCA)

//	if cbx_matric.checked then

//		lineas = 24
//		dw_preliminar.DataObject = "report_list_venfacturas1_matric"
//	else
//		lineas=20
//		dw_preliminar.DataObject = "report_list_venfacturas1"
//	end if
	
	if len(em_factura.text)=0 then
		MessageBox("Introduzca la factura","" ,Exclamation!, OK!, 2)
		f_activar_campo(em_factura)
		Return
	End if
	
	dw_preliminar.visible= FALSE
	uo_manejo.visible = FALSE
	pb_imprimir_preli.visible = FALSE
	
	// *** El número de líneas para los drivers de NT y 95 son distintas
	Environment env
	integer rtn
	rtn = GetEnvironment(env)
	if rtn <>1 then f_mensaje("Imprimir Factura","Error al intentar imprimir")
//	CHOOSE CASE env.OSType
//		CASE Windows!
//			lineas = 25
//		CASE WindowsNT!
//			lineas = 25
//		CASE ELSE
//			lineas = 25
//	END CHOOSE

	IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
		var_tipo = 1		
		for cont=1 to integer(em_copias1.text)
			if cont=1 then
				dw_preliminar.reset()
				if cbx_matric.checked then
					f_proceso_matric(1)
				else
					f_proceso(1)
				end if
				dw_preliminar.modify( "copia.visible = 0 ")
			else
				dw_preliminar.modify( "copia.visible = 1 ")			
				dw_preliminar.modify( "copia.x = 900 ")
				dw_preliminar.modify( "copia.y = 2300 ")
				dw_preliminar.modify( "copia.width = 1500 ")
				dw_preliminar.modify( "copia.height = 500 ")
			end if
			for i = 1 to dw_preliminar.Rowcount()
				var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
				if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
					limite = upperbound(numpallets)
					if var_numpalet > limite then
						pallets_totales = pallets_totales +1		
						numpallets[var_numpalet] = 1
					else
						if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
							pallets_totales = pallets_totales +1		
							numpallets[var_numpalet] = 1
						end if
					end if
				end if
			next
			for i = 1 to dw_preliminar.Rowcount()
				dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
				f_valores(i,var_tipo)
			next
			IF dw_preliminar.RowCount() <> 0 Then
				
				/*
				ls_file = ""
				ls_path = ""
				li_rc = GetFileSaveName ( "Selecciona una carpeta", &
   				ls_path, ls_file, "PDF")
 
				ls_folderfile = ls_path
				
				dw_preliminar.Object.DataWindow.Export.PDF.Method = NativePDF!
				li_return = dw_preliminar.SaveAs(ls_folderfile, PDF!, false)
				*/
				
				/*	IMPRIMIR EN PDF DIRECTO */
		
				SELECT distinct genter.razon,
				 venlifac.serie
				INTO   
				 :v_cliente, 
				 :v_serie			
				FROM   venlifac
				INNER JOIN (select * from genter where tipoter = 'C') as genter on genter.empresa = venlifac.empresa and genter.codigo = venlifac.cliente
				Where  venlifac.empresa      = :codigo_empresa
				And    venlifac.anyo			  = :an
				And    venlifac.factura      = :fra;
			
				for ll_aux=1 to len(v_cliente)
					if mid(v_cliente,ll_aux,1)="." then
						v_cliente = replace(v_cliente,ll_aux,1, "")	
					end if
					if mid(v_cliente,ll_aux,1)="/" then
						v_cliente = replace(v_cliente,ll_aux,1, " ")	
					end if
				next
				
					
				ls_file = ""
				
				ls_path = "\\amazonas\usuarios\COMERCIAL\WOW\aaaaaFACTURAS\"+string(an)+"\FACTURAS\"+"SERIE "+v_serie
				 
				//li_rc = GetFileSaveName ( "Selecciona una carpeta", &
				//  		ls_path, ls_file, "PDF")
				 
				ls_folderfile = ls_path + "\"+string(fra)+" "+v_cliente+" "+tipo
								
				dw_preliminar.Object.DataWindow.Export.PDF.Method = NativePDF!
				li_return = dw_preliminar.SaveAs(ls_folderfile, PDF!, false)
				 
				if li_return <> 1 then 
					messagebox("Error","Ha ocurrido un error")
				else
					messagebox("Exito","Se ha guardado el archivo "+ls_folderfile+".pdf")
				end if
						
			end if					
		next
	END IF
		
	IF em_copias2.text <> "0" and Trim(em_copias2.text) <> "" Then
		var_tipo = 2
		for cont=1 to integer(em_copias2.text)
			if cont=1 then
				dw_preliminar.reset()
				if cbx_matric.checked then
					f_proceso_matric(2)
				else
					f_proceso(2)
				end if
				dw_preliminar.modify( "copia.visible = 0 ")
			else
				dw_preliminar.modify( "copia.visible = 1 ")			
				dw_preliminar.modify( "copia.x = 900 ")
				dw_preliminar.modify( "copia.y = 2300 ")
				dw_preliminar.modify( "copia.width = 1500 ")
				dw_preliminar.modify( "copia.height = 500 ")
			end if
			for i = 1 to dw_preliminar.Rowcount()
				var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
				if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
					limite = upperbound(numpallets)
					if var_numpalet > limite then
						pallets_totales = pallets_totales +1		
						numpallets[var_numpalet] = 1
					else
						if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
							pallets_totales = pallets_totales +1		
							numpallets[var_numpalet] = 1
						end if
					end if
				end if
			next
			for i = 1 to dw_preliminar.Rowcount()
				dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
				f_valores(i,var_tipo)
			next
			IF dw_preliminar.RowCount() <> 0 Then 
				
					/*
				ls_file = ""
				ls_path = ""
				li_rc = GetFileSaveName ( "Selecciona una carpeta", &
   				ls_path, ls_file, "PDF")
 
				ls_folderfile = ls_path
				
				dw_preliminar.Object.DataWindow.Export.PDF.Method = NativePDF!
				li_return = dw_preliminar.SaveAs(ls_folderfile, PDF!, false)
				*/
				
				/*	IMPRIMIR EN PDF DIRECTO */
		
				SELECT distinct genter.razon,
				 venlifac.serie
				INTO   
				 :v_cliente, 
				 :v_serie			
				FROM   venlifac
				INNER JOIN (select * from genter where tipoter = 'C') as genter on genter.empresa = venlifac.empresa and genter.codigo = venlifac.cliente
				Where  venlifac.empresa      = :codigo_empresa
				And    venlifac.anyo			  = :an
				And    venlifac.factura      = :fra;
				
				for ll_aux=1 to len(v_cliente)
					if mid(v_cliente,ll_aux,1)="." then
						v_cliente = replace(v_cliente,ll_aux,1, "")	
					end if
					if mid(v_cliente,ll_aux,1)="/" then
						v_cliente = replace(v_cliente,ll_aux,1, " ")	
					end if
				next
					
				ls_file = ""
				
				ls_path = "\\amazonas\usuarios\COMERCIAL\WOW\aaaaaFACTURAS\"+string(an)+"\FACTURAS\"+"SERIE "+v_serie
				 
				//li_rc = GetFileSaveName ( "Selecciona una carpeta", &
				//  		ls_path, ls_file, "PDF")
				 
				ls_folderfile = ls_path + "\"+string(fra)+" "+v_cliente+" "+tipo
								
				dw_preliminar.Object.DataWindow.Export.PDF.Method = NativePDF!
				li_return = dw_preliminar.SaveAs(ls_folderfile, PDF!, false)
				 
				if li_return <> 1 then 
					messagebox("Error","Ha ocurrido un error")
				else
					messagebox("Exito","Se ha guardado el archivo "+ls_folderfile+".pdf")
				end if
				
			end if							
		next
	END IF
		
	IF em_copias3.text <> "0" and Trim(em_copias3.text) <> "" Then
		var_tipo = 3
		for cont=1 to integer(em_copias3.text)
			if cont=1 then
				dw_preliminar.reset()
				if cbx_matric.checked then
					f_proceso_matric(3)
				else
					f_proceso(3)
				end if
				dw_preliminar.modify( "copia.visible = 0 ")
			else
				dw_preliminar.modify( "copia.visible = 1 ")			
				dw_preliminar.modify( "copia.x = 900 ")
				dw_preliminar.modify( "copia.y = 2300 ")
				dw_preliminar.modify( "copia.width = 1500 ")
				dw_preliminar.modify( "copia.height = 500 ")
			end if
			for i = 1 to dw_preliminar.Rowcount()
				var_numpalet = dw_preliminar.GetItemNumber(i,"numpalet")
				if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
					limite = upperbound(numpallets)
					if var_numpalet > limite then
						pallets_totales = pallets_totales +1		
						numpallets[var_numpalet] = 1
					else
						if (numpallets[var_numpalet] = 0) or (isnull(numpallets[var_numpalet])) then
							pallets_totales = pallets_totales +1		
							numpallets[var_numpalet] = 1
						end if
					end if
				end if
			next
			for i = 1 to dw_preliminar.Rowcount()
				dw_preliminar.SetItem(i,"total_pallets",pallets_totales)
				f_valores(i,var_tipo)
			next
			IF dw_preliminar.RowCount() <> 0 Then 
				
					/*
				ls_file = ""
				ls_path = ""
				li_rc = GetFileSaveName ( "Selecciona una carpeta", &
   				ls_path, ls_file, "PDF")
 
				ls_folderfile = ls_path
				
				dw_preliminar.Object.DataWindow.Export.PDF.Method = NativePDF!
				li_return = dw_preliminar.SaveAs(ls_folderfile, PDF!, false)
				*/
				
				/*	IMPRIMIR EN PDF DIRECTO */
		
				SELECT distinct genter.razon,
				 venlifac.serie
				INTO   
				 :v_cliente, 
				 :v_serie			
				FROM   venlifac
				INNER JOIN (select * from genter where tipoter = 'C') as genter on genter.empresa = venlifac.empresa and genter.codigo = venlifac.cliente
				Where  venlifac.empresa      = :codigo_empresa
				And    venlifac.anyo			  = :an
				And    venlifac.factura      = :fra;
				
	
				for ll_aux=1 to len(v_cliente)
					if mid(v_cliente,ll_aux,1)="." then
						v_cliente = replace(v_cliente,ll_aux,1, "")	
					end if
					if mid(v_cliente,ll_aux,1)="/" then
						v_cliente = replace(v_cliente,ll_aux,1, " ")	
					end if
				next
					
				ls_file = ""
				
				ls_path = "\\amazonas\usuarios\COMERCIAL\WOW\aaaaaFACTURAS\"+string(an)+"\FACTURAS\"+"SERIE "+v_serie
				 
				//li_rc = GetFileSaveName ( "Selecciona una carpeta", &
				//  		ls_path, ls_file, "PDF")
				 
				ls_folderfile = ls_path + "\"+string(fra)+" "+v_cliente+" "+tipo
								
				dw_preliminar.Object.DataWindow.Export.PDF.Method = NativePDF!
				li_return = dw_preliminar.SaveAs(ls_folderfile, PDF!, false)
				 
				if li_return <> 1 then 
					messagebox("Error","Ha ocurrido un error")
				else
					messagebox("Exito","Se ha guardado el archivo "+ls_folderfile+".pdf")
				end if
				
			end if							
		next		
		// dw_preliminar.Print(TRUE)
	END IF
		
	if dw_declaracion_adquiriente.rowcount() > 0 then
		
		/*
		ls_file = ""
		ls_path = ""
		li_rc = GetFileSaveName ( "Selecciona una carpeta", &
   			ls_path, ls_file, "PDF")
 
		ls_folderfile = ls_path
				
		dw_declaracion_adquiriente.Object.DataWindow.Export.PDF.Method = NativePDF!
		li_return = dw_declaracion_adquiriente.SaveAs(ls_folderfile, PDF!, false)
		
		*/
		
		/*	IMPRIMIR EN PDF DIRECTO */
		
		SELECT distinct genter.razon,
		venlifac.serie
		INTO   
		:v_cliente, 
		:v_serie			
		FROM   venlifac
		INNER JOIN (select * from genter where tipoter = 'C') as genter on genter.empresa = venlifac.empresa and genter.codigo = venlifac.cliente
		Where  venlifac.empresa      = :codigo_empresa
		And    venlifac.anyo			  = :an
		And    venlifac.factura      = :fra;
		
		for ll_aux=1 to len(v_cliente)
			if mid(v_cliente,ll_aux,1)="." then
						v_cliente = replace(v_cliente,ll_aux,1, "")	
			end if
			if mid(v_cliente,ll_aux,1)="/" then
						v_cliente = replace(v_cliente,ll_aux,1, " ")	
			end if
		next
					
		ls_file = ""
				
		ls_path = "\\amazonas\usuarios\COMERCIAL\WOW\aaaaaFACTURAS\"+string(an)+"\FACTURAS\"+"SERIE "+v_serie
				 
		//li_rc = GetFileSaveName ( "Selecciona una carpeta", &
		//  		ls_path, ls_file, "PDF")
				 
		ls_folderfile = ls_path + "\"+string(fra)+" "+v_cliente+" Declaration"
								
		dw_declaracion_adquiriente.Object.DataWindow.Export.PDF.Method = NativePDF!
		li_return = dw_declaracion_adquiriente.SaveAs(ls_folderfile, PDF!, false)
		
				 
		if li_return <> 1 then 
			messagebox("Error","Ha ocurrido un error")
		else
			messagebox("Exito","Se ha guardado el archivo "+ls_folderfile+".pdf")
		end if
		
	end if		
				
	f_activar_campo(em_factura)
			
End If
end event

