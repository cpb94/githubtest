$PBExportHeader$w_lis_venalbaranes.srw
forward
global type w_lis_venalbaranes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_venalbaranes
end type
type st_2 from statictext within w_lis_venalbaranes
end type
type em_anyo from u_em_campo within w_lis_venalbaranes
end type
type em_albaran from u_em_campo within w_lis_venalbaranes
end type
type st_3 from statictext within w_lis_venalbaranes
end type
type st_6 from statictext within w_lis_venalbaranes
end type
type em_copias1 from editmask within w_lis_venalbaranes
end type
type cb_2 from u_boton within w_lis_venalbaranes
end type
type cb_1 from u_boton within w_lis_venalbaranes
end type
type pb_imprimir_preli from picturebutton within w_lis_venalbaranes
end type
type st_13 from statictext within w_lis_venalbaranes
end type
type cabecera from dropdownlistbox within w_lis_venalbaranes
end type
type uo_manejo from u_manejo_datawindow within w_lis_venalbaranes
end type
type st_7 from statictext within w_lis_venalbaranes
end type
type st_cliente from statictext within w_lis_venalbaranes
end type
type st_codcli from statictext within w_lis_venalbaranes
end type
type st_pagina from statictext within w_lis_venalbaranes
end type
type gb_3 from groupbox within w_lis_venalbaranes
end type
type st_14 from statictext within w_lis_venalbaranes
end type
type valorado from dropdownlistbox within w_lis_venalbaranes
end type
type aduana from dropdownlistbox within w_lis_venalbaranes
end type
type st_22 from statictext within w_lis_venalbaranes
end type
type cbx_matric from checkbox within w_lis_venalbaranes
end type
type dw_preliminar from datawindow within w_lis_venalbaranes
end type
type uo_1 from u_selec_impresoras within w_lis_venalbaranes
end type
type cb_3 from u_boton within w_lis_venalbaranes
end type
type gb_2 from groupbox within w_lis_venalbaranes
end type
type gb_1 from groupbox within w_lis_venalbaranes
end type
end forward

global type w_lis_venalbaranes from w_int_con_empresa
integer x = 46
integer y = 48
integer width = 3904
integer height = 3352
string menuname = ""
boolean resizable = true
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_albaran em_albaran
st_3 st_3
st_6 st_6
em_copias1 em_copias1
cb_2 cb_2
cb_1 cb_1
pb_imprimir_preli pb_imprimir_preli
st_13 st_13
cabecera cabecera
uo_manejo uo_manejo
st_7 st_7
st_cliente st_cliente
st_codcli st_codcli
st_pagina st_pagina
gb_3 gb_3
st_14 st_14
valorado valorado
aduana aduana
st_22 st_22
cbx_matric cbx_matric
dw_preliminar dw_preliminar
uo_1 uo_1
cb_3 cb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_lis_venalbaranes w_lis_venalbaranes

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli
Dec{4}  var_total
integer lineas = 20
integer lnpie,contador,var_tipo
String  var_clase,c,des

end variables

forward prototypes
public subroutine f_pagina ()
public subroutine f_valores (integer registro, integer tipo)
public subroutine f_proceso (integer tipo)
public subroutine f_proceso_old (integer tipo)
end prototypes

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")
end subroutine

public subroutine f_valores (integer registro, integer tipo);Dec{0} var_anyo,var_albaran
dec{2} var_peso
String var_tipo_cliente,var_cliente,texto1,texto2,texto3,texto,var_serie,var_envio,var_deposito
Datetime var_falbaran
Int mostrar_plinea

var_anyo     = Dec(em_anyo.text)
var_albaran = Dec(em_albaran.text)
SELECT venalb.falbaran,      venalb.cliente,
		 venalb.textcomercial1,
		 venalb.textaduanaesp1, venalb.textaduanaext1,
       venalb.serie,venalb.envio,venalb.deposito,
		 venalb.peso
INTO :var_falbaran,   :var_cliente, 
	  :texto1, :texto2, :texto3,
	  :var_serie,:var_envio,:var_deposito,
	  :var_peso
	  FROM venalb  
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    albaran= :var_albaran;

CHOOSE CASE tipo
	CASE 1
		texto = texto1
	CASE 2
		texto = texto2
	CASE 3
		texto = texto3
END CHOOSE

mostrar_plinea = 0
SELECT ISNULL(mostrar_peso_linea,0) INTO :mostrar_plinea 
FROM venclientes
WHERE empresa = :codigo_empresa AND codigo = :var_cliente;

IF cabecera.text = "Si" Then
	dw_preliminar.SetItem(registro,"ver_cabecera","S")
ELSE
	dw_preliminar.SetItem(registro,"ver_cabecera","N")
END IF
if Trim(var_idioma) = "1" Then var_idioma="1"

dw_preliminar.SetItem(registro,"falbaran",var_falbaran)
dw_preliminar.SetItem(registro,"clase",var_clase)
dw_preliminar.SetItem(registro,"texto_cabecera",texto)
dw_preliminar.SetItem(registro,"tipo",tipo)
dw_preliminar.SetItem(registro,"empresa",codigo_empresa)
dw_preliminar.SetItem(registro,"anyo",var_anyo)
dw_preliminar.SetItem(registro,"albaran",var_albaran)
dw_preliminar.SetItem(registro,"idioma",var_idioma)
dw_preliminar.SetItem(registro,"serie",var_serie)
dw_preliminar.SetItem(registro,"moneda",var_moneda)
dw_preliminar.SetItem(registro,"cliente",var_cliente)
dw_preliminar.SetItem(registro,"deposito",var_deposito)
dw_preliminar.SetItem(registro,"envio",var_envio)
dw_preliminar.SetItem(registro,"mostrar_plinea",mostrar_plinea)

//		IF valorado.text <> "Si" then
//			dw_preliminar.SetItem(registro,"peso",var_peso)
//		end if

dw_preliminar.SetItem(registro,"total",String(var_total))

IF Int(registro/lineas)  * lineas = registro Then 
	dw_preliminar.SetItem(registro,"fin",1)
ELSE
	dw_preliminar.SetItem(registro,"fin",2)
END IF
end subroutine

public subroutine f_proceso (integer tipo);dw_preliminar.SetRedraw(FALSE)
dw_preliminar.enabled = FALSE
Dec{0} var_anyo,var_albaran,resto,re,var_paginas,var_ejercicio,total_cajas,var_numpalet, linea_alb
long va,va2
String  textpie[],pie,pie1,pie2,pie3,letra,var_articulo,tipo_iva,tipo_recargo,puntos
String var_tono,textopie2,cadena,texto_iva,texto_recargo,var_tipo_pallet,var_caja,var_ref_cli
Integer reg,reg1
Dec{4}  var_calibre,var_cantidad,acumulado,dto1,impdto1,dto2,impdto2,dto3,impdto3,&
		  dto4,impdto4,dtopp,impdtopp,aculumado,dtoesp,precio,cantidad,bruto,importe,iva,recargo,importeiva,importerecargo

DateTime var_falbaran
String   var_tipo_unidad,textdto1,textdto2,textdto3,textdto4,tipodto1,&
         tipodto2,tipodto3,tipodto4,tipo_cliente,linea
DataStore dw_proceso			
String sel
Dec{4}   importedto1,importedto2,importedto3,importedto4,importedtopp
string cod_art_cli, v_caja,ls_tarifa
long v_piezascaja, v_pallets
Dec cajas_parciales, v_metroscaja
Dec pneto_linea,pbruto_linea
Int decimales_unidad
Long piezas_calculadas
string var_tono_imprimir,var_calibre_imprimir
			
var_total = 0
puntos= "........................................"
contador    = 0
acumulado   = 0
importedto1 = 0
importedto2 = 0
importedto3 = 0
importedto4 = 0
importedtopp= 0 
var_anyo      = Dec(em_anyo.text)
var_albaran   = Dec(em_albaran.text)

Select dtoesp1,tipodto1,explicaciondto1,
		 dtoesp2,tipodto2,explicaciondto2,
		 dtoesp3,tipodto3,explicaciondto3,
		 dtoesp4,tipodto4,explicaciondto4,
		 dtopp,textcomercial2,textaduanaesp2,textaduanaext2,tipoiva,tarifa
Into	:dto1,:tipodto1,:textdto1,
		:dto2,:tipodto2,:textdto2,
		:dto3,:tipodto3,:textdto3,
		:dto4,:tipodto4,:textdto4,
		:dtopp,:pie1,:pie2,:pie3,
		:tipo_iva,:ls_tarifa
From   venalb
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    albaran= :var_albaran;
var_ejercicio = f_ejercicio_activo(codigo_empresa)

SELECT contaiva.iva,contaiva.recargo,contaiva.descripcion  
INTO :iva,:tipo_recargo,:texto_iva  
FROM contaiva  
WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
	( contaiva.empresa = :codigo_empresa ) AND  
	( contaiva.tipoiva = :tipo_iva )   ;
			
IF Not IsNull(tipo_recargo) and Trim(tipo_recargo) <> "" Then
	SELECT  contaiva.iva,contaiva.descripcion INTO :recargo,:texto_recargo
	FROM   contaiva  
	WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
			( contaiva.empresa = :codigo_empresa ) AND  
			( contaiva.tipoiva = :tipo_recargo )   ;			
END IF

int li_decimales_precio
string ls_mascara_moneda_tarifa

li_decimales_precio       = f_ventarifas_decimales_precios(codigo_empresa,ls_tarifa)
ls_mascara_moneda_tarifa  = f_mascara_decimales(li_decimales_precio)
//---------------------------------------------------------------------

f_mascara_columna(dw_preliminar,"precio",ls_mascara_moneda_tarifa)
f_mascara_columna(dw_preliminar,"total",f_mascara_moneda(var_moneda))


String ampli = ""
if tipo=3 then ampli = " AND venlialb.precio_aduana <> 0   "

Sel = " SELECT venlialb.* " +&
	   " FROM venlialb  "+&
	   " WHERE  venlialb.empresa = '"+ codigo_empresa +"'" +&
	   " AND venlialb.anyo       = "+String(var_anyo,"######")+&
	   " AND venlialb.albaran    = "+String(var_albaran,"#########") +&
	   " AND venlialb.control_descuentos = 'S'   "+&
	     ampli +&
  	   " ORDER BY empresa ASC,anyo ASC,albaran ASC,numpalet ASC" //David 06-10-05
//	   " ORDER BY empresa ASC,anyo ASC,albaran ASC,convert (integer, linea) ASC" //David 06-10-05
//	   " ORDER BY empresa ASC,anyo ASC,albaran ASC,numpalet ASC,familia ASC,formato asc,"+&   
//		" articulo asc,calidad asc,tonochar asc,calibre asc,cantidad desc"

Sel = " SELECT venlialb.tipolinea, " +&
		"        venlialb.clase, " +&
		"        venlialb.dtoesp, " +&
		"        sum(venlialb.cantidad) as cantidad, " +&
		"        min(venlialb.linea) as linea, " +&
		"        venlialb.tonochar, " +&
		"        venlialb.calibre, " +&
		"        venlialb.tono_imprimir, " +&
		"        venlialb.calibre_imprimir, " +&
		"        venlialb.tipo_pallet, " +&
		"        venlialb.caja, " +&
		"        min(isnull(venlialb.bulto_desde_orden_carga,venlialb.numpalet)) as numpalet, " +&
		"        venlialb.numpedcli, " +&
		"        sum(venlialb.peso_neto) as peso_neto, " +&
		"        sum(venlialb.peso) as peso_bruto, " +&
		"        venlialb.precio_neto, " +&
		"        sum(venlialb.importe) as importe, " +&
		"        sum(venlialb.impdtopp) as impdtopp, " +&
		"        sum(venlialb.impdtoesp1) as impdtoesp1, " +&
		"        sum(venlialb.impdtoesp2) as impdtoesp2, " +&
		"        sum(venlialb.impdtoesp3) as impdtoesp3, " +&
		"        sum(venlialb.impdtoesp4) as impdtoesp4, " +&
		"        venlialb.articulo, " +&
		"        venlialb.caja, " +&
		"        sum(venlialb.pallets) as pallets, " +&
		"        sum(venlialb.total_cajas) as total_cajas, " +&
		"        venlialb.descripcion, " +&
		"        venlialb.tipo_pallet, " +&
		"        min(venlialb.descuento) as descuento, " +&
		"        venlialb.dtoesp, " +&
		"        venlialb.dtoesp2, " +&
		"        venlialb.formato, " +&
		"        venlialb.familia, " +&
		"        venlialb.calidad, " +&
		"        venlialb.tipo_unidad, " +&
		"        venlialb.clase, " +&
		"        venlialb.anyo_pedido_origen, " +&
		"        venlialb.pedido_origen, " +&
		"        venlialb.linea_pedido_origen, " +&
		"        venlialb.cantidad_pzs, "+&
		"        venlialb.precio_pzs "+&
	   " FROM   venlialb  "+&
	   " WHERE  venlialb.empresa = '"+ codigo_empresa +"'" +&
	   " AND venlialb.anyo       = "+String(var_anyo,"######")+&
	   " AND venlialb.albaran    = "+String(var_albaran,"#########") +&
	   " AND venlialb.control_descuentos = 'S'   "+&
	     ampli +&
		" GROUP BY venlialb.tipolinea, " +&
		"        venlialb.clase, " +&
		"        venlialb.dtoesp, " +&
		"        venlialb.tonochar, " +&
		"        venlialb.calibre, " +&
		"        venlialb.tono_imprimir, " +&
		"        venlialb.calibre_imprimir, " +&
		"        venlialb.tipo_pallet, " +&
		"        venlialb.caja, " +&
		"        venlialb.numpedcli, " +&
		"        venlialb.precio_neto, " +&
		"        venlialb.articulo, " +&
		"        venlialb.caja, " +&
		"        venlialb.descripcion, " +&
		"        venlialb.tipo_pallet, " +&
		"        venlialb.dtoesp, " +&
		"        venlialb.dtoesp2, " +&
		"        venlialb.formato, " +&
		"        venlialb.familia, " +&
		"        venlialb.calidad, " +&
		"        venlialb.tipo_unidad, " +&
		"        venlialb.clase, " +&
		"        venlialb.anyo_pedido_origen, " +&
		"        venlialb.pedido_origen, " +&
		"        venlialb.linea_pedido_origen, " +&
		"        venlialb.cantidad_pzs, "+&
		"        venlialb.precio_pzs "+&
  	   " ORDER BY min(isnull(venlialb.bulto_desde_orden_carga,venlialb.numpalet)) ASC"				
		  
f_cargar_cursor_nuevo(sel, dw_proceso)
reg = dw_proceso.RowCount()

string ls_tipolinea,ls_gestionar_en_piezas

IF reg <> 0 Then
	For reg1 = 1 to reg
		if (valorado.text = "No" and (dw_proceso.GetItemSTring(reg1,"tipolinea")='5' or dw_proceso.GetItemSTring(reg1,"tipolinea")='14' or &
				dw_proceso.GetItemSTring(reg1,"tipolinea")='15' or dw_proceso.GetItemSTring(reg1,"tipolinea")='16')) and 0 = 1 Then
			// En Equipe no quieren que aparezca el tipo de lina 5 (Trans. y Fletes)
			// en los albaranes no valorados
		else
			ls_tipolinea = dw_proceso.GetItemSTring(reg1,"tipolinea")
			ls_gestionar_en_piezas = f_gestionar_en_piezas_ventipolin(codigo_empresa,ls_tipolinea)
			
			acumulado = 0			
			contador  = contador + 1
			var_clase     = dw_proceso.GetItemString(contador,"clase")
			dtoesp        = dw_proceso.GetItemNumber(contador,"dtoesp")
			if ls_gestionar_en_piezas = "S" then
				cantidad      = dw_proceso.GetItemNumber(contador,"cantidad_pzs")
			else
				cantidad      = dw_proceso.GetItemNumber(contador,"cantidad")
			end if
			linea_alb     = dw_proceso.GetItemNumber(contador,"linea")
			var_tono      = dw_proceso.GetItemString(contador,"tonochar")
			var_calibre   = dw_proceso.GetItemNumber(contador,"calibre")
			var_tono_imprimir    = dw_proceso.GetItemString(contador,"tono_imprimir")
			var_calibre_imprimir = dw_proceso.GetItemString(contador,"calibre_imprimir")
			
			var_tipo_pallet = dw_proceso.GetItemSTring(contador,"tipo_pallet")
			var_caja      = dw_proceso.GetItemSTring(contador,"caja")
			var_numpalet  = dw_proceso.GetItemNumber(contador,"numpalet")
			var_ref_cli   = dw_proceso.GetItemString(contador,"numpedcli")
			pneto_linea   = dw_proceso.GetItemDecimal(contador,"peso_neto")
			pbruto_linea  = dw_proceso.GetItemDecimal(contador,"peso_bruto")
			CHOOSE CASE tipo
			 CASE  3
				if ls_gestionar_en_piezas = "S" then
					precio       = dw_proceso.GetItemNumber(reg1,"precio_pzs")
				else
					precio       = dw_proceso.GetItemNumber(reg1,"precio_neto_aduana")
				end if
				bruto        = dw_proceso.GetItemNumber(reg1,"importe_aduana")
				impdtopp     = dw_proceso.GetItemNumber(reg1,"impdtopp_aduana")
				impdto1      = dw_proceso.GetItemNumber(reg1,"impdtoesp1_aduana")
				impdto2      = dw_proceso.GetItemNumber(reg1,"impdtoesp2_aduana")			
				impdto3      = dw_proceso.GetItemNumber(reg1,"impdtoesp3_aduana")			
				impdto4      = dw_proceso.GetItemNumber(reg1,"impdtoesp4_aduana")			
			 CASE ELSE
				if ls_gestionar_en_piezas = "S" then
					precio       = dw_proceso.GetItemNumber(reg1,"precio_pzs")
				else				
					precio        = dw_proceso.GetItemNumber(reg1,"precio_neto")
				end if
				bruto         = dw_proceso.GetItemNumber(reg1,"importe")
				impdtopp      = dw_proceso.GetItemNumber(reg1,"impdtopp")
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
		
			dw_preliminar.InsertRow(contador)
			
			f_valores(contador,tipo)
			var_articulo = dw_proceso.GetItemSTring(reg1,"articulo")
			if not isnull(var_articulo) and var_articulo <> "" then
				if ls_gestionar_en_piezas = "S" then
					decimales_unidad = f_decimales_unidad("0")
				else
					decimales_unidad = ftc_decimales_articulo(codigo_empresa, var_articulo)
				end if
			else
				decimales_unidad = 0
			end if
			
			select cod_cliente 
			into :cod_art_cli
			from articulos
			where empresa = :codigo_empresa
			and codigo = :var_articulo;
			
			if  isnull (cod_art_cli) then cod_Art_cli = ''
			
			v_caja = dw_proceso.GetItemSTring(reg1,"caja")

			select piezascaja, metroscaja
			into :v_piezascaja, :v_metroscaja
			from almartcajas
			where empresa = :codigo_empresa
			and articulo = :var_articulo
			and caja = :v_caja;

			dw_preliminar.SetItem(contador,"cod_art_cli",cod_art_cli)
			dw_preliminar.SetItem(contador,"piezascaja",v_piezascaja)
//			dw_preliminar.SetItem(contador,"linea",dw_proceso.GetItemNumber(reg1,"linea"))

			dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
			v_pallets = dw_proceso.GetItemNumber(reg1,"pallets")
			dw_preliminar.SetItem(contador,"pallets",v_pallets)
			
//				dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemNumber(reg1,"pallets"))
			dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemNumber(reg1,"total_cajas"))
			dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))
			dw_preliminar.SetItem(contador,"cod_articulo",var_articulo)
			dw_preliminar.SetItem(contador,"tono",var_tono_imprimir)
			dw_preliminar.SetItem(contador,"calibre",dec(var_calibre_imprimir))
			dw_preliminar.SetItem(contador,"tipo_pallet",dw_proceso.GetItemSTring(reg1,"tipo_pallet"))
			dw_preliminar.SetItem(contador,"caja",dw_proceso.GetItemSTring(reg1,"caja"))		
			dw_preliminar.SetItem(contador,"numpalet",var_numpalet)	
			dw_preliminar.SetItem(contador,"ref_cli",var_ref_cli)
			dw_preliminar.SetItem(contador,"pneto_linea",pneto_linea)			
			dw_preliminar.SetItem(contador,"peso_neto",pneto_linea)	
			dw_preliminar.SetItem(contador,"peso",pbruto_linea)	
				
			IF tipo <>3 Then
				dw_preliminar.SetItem(contador,"importe",String(dw_proceso.GetItemNumber(reg1,"importe"),f_mascara_moneda(var_moneda)))
				if ls_gestionar_en_piezas = "S" then
					dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemNumber(reg1,"precio_pzs"))
				else				
					dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemNumber(reg1,"precio_neto"))
				end if
				dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento"))
				dw_preliminar.SetItem(contador,"dto1",dw_proceso.GetItemNumber(reg1,"dtoesp"))
				dw_preliminar.SetItem(contador,"dto2",dw_proceso.GetItemNumber(reg1,"dtoesp2"))
			ELSE
				if ls_gestionar_en_piezas = "S" then
					dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemNumber(reg1,"precio_pzs"))
				else
					dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemNumber(reg1,"precio_aduana_neto"))
				end if
				dw_preliminar.SetItem(contador,"importe",String(dw_proceso.GetItemNumber(reg1,"importe_aduana"),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento_aduana"))
			END IF
			dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"formato")))
			dw_preliminar.SetItem(contador,"familia",f_nombre_familia_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"familia")))		
			dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"calidad")))
		
			if ls_gestionar_en_piezas = "S" then
				var_tipo_unidad="0"
				var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad_pzs")				
			else
				var_tipo_unidad=dw_proceso.GetItemString(reg1,"tipo_unidad")
				var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad")
			end if
			
			dw_preliminar.SetItem(contador, "decimales_unidad", decimales_unidad)
			
//			IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad <> "1" Then
				dw_preliminar.SetItem(contador,"piezas",var_cantidad)
				//dw_preliminar.SetItem(contador,"metros",f_calculo_metros_cuadrados(codigo_empresa,var_articulo,var_cantidad))
				
				//Calculamos los metros cuadrados según los metros 2 / caja
				//13-03-2017 ya no hacemos la conversion de piezas a metros
				/*
				if v_piezascaja > 0 then
					cajas_parciales = truncate(var_cantidad / v_piezascaja, 0)				
					dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_cajas(codigo_empresa,var_articulo, v_caja, cajas_parciales))
				else
					dw_preliminar.SetItem(contador,"metros",0.000)
				end if*/
				//13-03-2017 ya no hacemos la conversion de piezas a metros
				dw_preliminar.SetItem(contador,"metros",0.000)
			ELSE
				if v_metroscaja > 0 then
					piezas_calculadas = truncate(var_cantidad / v_metroscaja,0) * v_piezascaja
				else
					piezas_calculadas = 0
				end if
				IF (dw_proceso.GetItemSTring(reg1,"tipolinea")='5' or dw_proceso.GetItemSTring(reg1,"tipolinea")='14' or dw_proceso.GetItemSTring(reg1,"tipolinea")='15' or dw_proceso.GetItemSTring(reg1,"tipolinea")='16') THEN
					dw_preliminar.SetItem(contador,"metros","0")
					dw_preliminar.SetItem(contador,"piezas","0")
				ELSE
					dw_preliminar.SetItem(contador,"metros",var_cantidad)
					dw_preliminar.SetItem(contador,"piezas",0)
					//13-03-2017 ya no hacemos la conversion de piezas a metros
					/*
					dw_preliminar.SetItem(contador,"piezas",piezas_calculadas)
					*/
					//13-03-2017 ya no hacemos la conversion de piezas a metros
				END IF
			END IF
//			ELSE
//				dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####")+ " " + dw_proceso.GetItemString(reg1,"descripcion"))
//			END IF
				
			IF tipo <>3 then
				var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))
			ELSE
				var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe_aduana"))
			END IF
			C = ""
			IF var_clase = "M" Then C = "(MUESTRAS)"
			IF var_clase = "S" Then C = "(SIN CARGO)"
			des = dw_preliminar.GetItemString(contador,"articulo")
			IF Trim(des) <> "" Then 
				dw_preliminar.SetItem(contador,"articulo",des + " " +c)
			END IF
		end if
	Next
	
	//ES NECESARIO INSERTAR AL MENOS DOS LINEAS DE PEDIDO PARA QUE SALGA LA CABECERA (Inexplicable!!!) 
	IF contador <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	end if	
	
	//POSTERIORMENTE ELIMINAMOS LA LINEA (INUTIL). EN VALORADO ES NECESARIO PARA SEPARAR LOS TOTALES
	if valorado.text = "No" then
		dw_preliminar.deleterow(dw_preliminar.rowcount())
		contador = dw_preliminar.rowcount()
	end if
	
	
	IF valorado.text = "Si" Then
		IF contador <>0 then
//			contador = contador + 1
//			dw_preliminar.InsertRow(contador)
//			f_val ores(contador,tipo)
			dw_preliminar.SetItem(contador - 1,"raya",1)
			dw_preliminar.SetItem(contador,"texto",f_diccionario("TOTAL BRUTO",var_idioma) + puntos)
			dw_preliminar.SetItem(contador,"importe",String(Dec(var_total),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
		END IF
	END IF
END IF

IF valorado.text = "Si" Then
	IF importedto1 <>0 then
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"texto",String(dto1,"##") + "% " +textdto1+puntos )
			dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto1),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
			dw_preliminar.SetItem(contador,"raya",1)
			var_total = var_total - importedto1
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
	END IF
	IF importedto2 <>0 then
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"texto",String(dto2,"##") + "% " +textdto2+puntos)
	
			dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto2),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
			dw_preliminar.SetItem(contador,"raya",1)
			var_total = var_total - importedto2
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
	END IF
	IF importedto3 <>0 then
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"texto",String(dto3,"##") + "% " +textdto3+puntos)
			dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto3),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
			dw_preliminar.SetItem(contador,"raya",1)
			var_total = var_total - importedto3
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
	END IF
	//IF importedto4 <>0 then
	if importedtopp <> 0 then
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"texto",String(dto4,"##") + "% " +textdto4+puntos)
			dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedtopp),f_mascara_moneda(var_moneda))) //String(Dec(importedto4),f_mascara_moneda(var_moneda))
			dw_preliminar.SetItem(contador,"orden","2")
			dw_preliminar.SetItem(contador,"raya",1)
			var_total = var_total - importedtopp//- importedto4
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
	END IF
END IF

Sel = " SELECT venlialb.* " +&
		" FROM   venlialb  "+&
		" WHERE  venlialb.empresa = '"+ codigo_empresa +"'" +&
		" AND venlialb.anyo = "+String(var_anyo,"######")+&
		" AND venlialb.albaran = "+String(var_albaran,"#########") +&
		" AND venlialb.control_descuentos = 'N'   "+&
		  ampli +&
		" ORDER BY empresa ASC,anyo ASC,albaran ASC,convert(integer, linea) ASC " // David 06-10-05
//		" ORDER BY empresa ASC,anyo ASC,albaran ASC,numpalet ASC "   


Sel = " SELECT venlialb.tipolinea, " +&
		"        venlialb.clase, " +&
		"        venlialb.dtoesp, " +&
		"        sum(venlialb.cantidad) as cantidad, " +&
		"        min(venlialb.linea) as linea, " +&
		"        venlialb.tonochar, " +&
		"        venlialb.calibre, " +&
		"        venlialb.tono_imprimir, " +&
		"        venlialb.calibre_imprimir, " +&
		"        venlialb.tipo_pallet, " +&
		"        venlialb.caja, " +&
		"        min(isnull(venlialb.bulto_desde_orden_carga,venlialb.numpalet)) as numpalet, " +&
		"        venlialb.numpedcli, " +&
		"        sum(venlialb.peso_neto) as peso_neto, " +&
		"        sum(venlialb.peso) as peso_bruto, " +&
		"        venlialb.precio, " +&
		"        venlialb.precio_neto, " +&
		"        sum(venlialb.importe) as importe, " +&
		"        sum(venlialb.impdtopp) as impdtopp, " +&
		"        sum(venlialb.impdtoesp1) as impdtoesp1, " +&
		"        sum(venlialb.impdtoesp2) as impdtoesp2, " +&
		"        sum(venlialb.impdtoesp3) as impdtoesp3, " +&
		"        sum(venlialb.impdtoesp4) as impdtoesp4, " +&
		"        venlialb.articulo, " +&
		"        venlialb.caja, " +&
		"        sum(venlialb.pallets) as pallets, " +&
		"        sum(venlialb.total_cajas) as total_cajas, " +&
		"        venlialb.descripcion, " +&
		"        venlialb.tipo_pallet, " +&
		"        min(venlialb.descuento) as descuento, " +&
		"        venlialb.dtoesp, " +&
		"        venlialb.dtoesp2, " +&
		"        venlialb.formato, " +&
		"        venlialb.familia, " +&
		"        venlialb.calidad, " +&
		"        venlialb.tipo_unidad, " +&
		"        venlialb.clase, " +&
		"        venlialb.anyo_pedido_origen, " +&
		"        venlialb.pedido_origen, " +&
		"        venlialb.linea_pedido_origen, " +&
		"        venlialb.cantidad_pzs, "+&
		"        venlialb.precio_pzs "+&
	   " FROM   venlialb  "+&
	   " WHERE  venlialb.empresa = '"+ codigo_empresa +"'" +&
	   " AND venlialb.anyo       = "+String(var_anyo,"######")+&
	   " AND venlialb.albaran    = "+String(var_albaran,"#########") +&
	   " AND venlialb.control_descuentos = 'N'   "+&
	     ampli +&
		" GROUP BY venlialb.tipolinea, " +&
		"        venlialb.clase, " +&
		"        venlialb.dtoesp, " +&
		"        venlialb.tonochar, " +&
		"        venlialb.calibre, " +&
		"        venlialb.tono_imprimir, " +&
		"        venlialb.calibre_imprimir, " +&
		"        venlialb.tipo_pallet, " +&
		"        venlialb.caja, " +&
		"        venlialb.numpedcli, " +&
		"        venlialb.precio, " +&
		"        venlialb.precio_neto, " +&
		"        venlialb.articulo, " +&
		"        venlialb.caja, " +&
		"        venlialb.descripcion, " +&
		"        venlialb.tipo_pallet, " +&
		"        venlialb.dtoesp, " +&
		"        venlialb.dtoesp2, " +&
		"        venlialb.formato, " +&
		"        venlialb.familia, " +&
		"        venlialb.calidad, " +&
		"        venlialb.tipo_unidad, " +&
		"        venlialb.clase, " +&
		"        venlialb.anyo_pedido_origen, " +&
		"        venlialb.pedido_origen, " +&
		"        venlialb.linea_pedido_origen, " +&
		"        venlialb.cantidad_pzs, "+&
		"        venlialb.precio_pzs "+&
  	   " ORDER BY min(isnull(venlialb.bulto_desde_orden_carga,venlialb.numpalet)) ASC"				
		  
//dw_proceso= f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, dw_proceso)
reg = dw_proceso.RowCount()

IF reg <> 0 Then
	For reg1 = 1 to reg
		if (valorado.text = "No" and (dw_proceso.GetItemSTring(reg1,"tipolinea")='5' or dw_proceso.GetItemSTring(reg1,"tipolinea")='14' or dw_proceso.GetItemSTring(reg1,"tipolinea")='15' or dw_proceso.GetItemSTring(reg1,"tipolinea")='16')) and 0 = 1 Then
			// En Equipe no quieren que aparezca el tipo de lina 5 (Trans. y Fletes)
			// en los albaranes no valorados
		else
			ls_tipolinea = dw_proceso.GetItemSTring(reg1,"tipolinea")
			ls_gestionar_en_piezas = f_gestionar_en_piezas_ventipolin(codigo_empresa,ls_tipolinea)						
			
		   contador  = contador + 1
		   var_clase    = dw_proceso.GetItemString(reg1,"clase")
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			var_articulo = dw_proceso.GetItemString(reg1,"articulo")
			var_tono_imprimir    = dw_proceso.GetItemString(reg1,"tono_imprimir")
			var_calibre_imprimir = dw_proceso.GetItemString(reg1,"calibre_imprimir")						
			v_caja = dw_proceso.GetItemSTring(reg1,"caja")
			pneto_linea   = dw_proceso.GetItemDecimal(reg1,"peso_neto")
			pbruto_linea  = dw_proceso.GetItemDecimal(reg1,"peso_bruto")			
			
			select piezascaja, metroscaja
			into :v_piezascaja, :v_metroscaja
			from almartcajas
			where empresa = :codigo_empresa
			and articulo = :var_articulo
			and caja = :v_caja;
			
			dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))

			v_pallets = dw_proceso.GetItemNumber(reg1,"pallets")

			dw_preliminar.SetItem(contador,"pallets",v_pallets)
//			dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemnumber(reg1,"pallets"))
			dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemnumber(reg1,"total_cajas"))
			dw_preliminar.SetItem(contador,"piezascaja",v_piezascaja)
			dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemstring(reg1,"descripcion"))

			dw_preliminar.SetItem(contador,"cod_articulo",var_articulo)
			dw_preliminar.SetItem(contador,"tono",var_tono_imprimir)
			dw_preliminar.SetItem(contador,"calibre",dec(var_calibre_imprimir))			
			
			if ls_gestionar_en_piezas = "S" then
				dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemnumber(reg1,"precio_pzs"))
			else
				dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemnumber(reg1,"precio"))
			end if
			
			dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemnumber(reg1,"descuento"))
			dw_preliminar.SetItem(contador,"dto1",dw_proceso.GetItemNumber(reg1,"dtoesp"))
			dw_preliminar.SetItem(contador,"dto2",dw_proceso.GetItemNumber(reg1,"dtoesp2"))
			dw_preliminar.SetItem(contador,"importe",String(dw_proceso.GetItemnumber(reg1,"importe"),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,dw_proceso.GetItemstring(reg1,"formato")))
			dw_preliminar.SetItem(contador,"familia",f_nombre_familia_abr(codigo_empresa,dw_proceso.GetItemstring(reg1,"familia")))
			dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemstring(reg1,"calidad")))
			if ls_gestionar_en_piezas = "S" then
				var_tipo_unidad = "0"
				var_cantidad    = dw_proceso.GetItemNumber(reg1,"cantidad_pzs")				
			else
				var_tipo_unidad = dw_proceso.GetItemSTring(reg1,"tipo_unidad")
				var_cantidad    = dw_proceso.GetItemNumber(reg1,"cantidad")
			end if
			
			decimales_unidad = f_decimales_unidad(var_tipo_unidad)
			
			dw_preliminar.SetItem(contador,"numpalet",dw_proceso.GetItemnumber(reg1,"numpalet"))	
			dw_preliminar.SetItem(contador,"ref_cli",dw_proceso.GetItemstring(reg1,"numpedcli"))

			dw_preliminar.SetItem(contador, "decimales_unidad", decimales_unidad)

			dw_preliminar.SetItem(contador,"pneto_linea",pneto_linea)			
			dw_preliminar.SetItem(contador,"peso_neto",pneto_linea)	
			dw_preliminar.SetItem(contador,"peso",pbruto_linea)	
			
//			IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
				IF var_tipo_unidad <> "1" Then
					dw_preliminar.SetItem(contador,"piezas",var_cantidad)
					//Calculamos los metros cuadrados según los metros 2 / caja
					//13-03-2017 ya no hacemos la conversion de piezas a metros
					/*
					if v_piezascaja > 0 then
						cajas_parciales = truncate(var_cantidad / v_piezascaja, 0)				
						dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_cajas(codigo_empresa,var_articulo, v_caja, cajas_parciales))
					else
						dw_preliminar.SetItem(contador,"metros","0.000")
					end if*/
					//13-03-2017 ya no hacemos la conversion de piezas a metros
					dw_preliminar.SetItem(contador,"metros","0.000")
				ELSE
					if v_metroscaja > 0 then
						piezas_calculadas = truncate(var_cantidad / v_metroscaja,0) * v_piezascaja
					else
						piezas_calculadas = 0
					end if					
					IF (dw_proceso.GetItemSTring(reg1,"tipolinea")='5' or dw_proceso.GetItemSTring(reg1,"tipolinea")='14' or dw_proceso.GetItemSTring(reg1,"tipolinea")='15' or dw_proceso.GetItemSTring(reg1,"tipolinea")='16') THEN
						dw_preliminar.SetItem(contador,"metros","0")
						dw_preliminar.SetItem(contador,"piezas","0")
					ELSE
						dw_preliminar.SetItem(contador,"metros",var_cantidad)
						dw_preliminar.SetItem(contador,"piezas",0)
						//13-03-2017 ya no hacemos la conversion de piezas a metros
						/*
						dw_preliminar.SetItem(contador,"piezas",piezas_calculadas)
						*/
						//13-03-2017 ya no hacemos la conversion de piezas a metros
					END IF
				END IF
//			ELSE
//				// Modificacion según Carlos
//				//dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####")+ " " + dw_proceso.GetItem(reg1,"descripcion"))
//				dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))
//			
//							
//			END IF
			C = ""
			IF var_clase = "M" Then C = "(MUESTRAS)"
			IF var_clase = "S" Then C = "(SIN CARGO)"
			des = dw_preliminar.GetItemString(contador,"articulo")
			IF Trim(des) <> "" Then 
				dw_preliminar.SetItem(contador,"articulo",des + " " +c)
			END IF
		var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))		
		impdtopp     =  Dec(String(Dec(dw_proceso.GetItemNumber(reg1,"importe"))		 * dtopp / 100,f_mascara_moneda(var_moneda)))
		importedtopp = importedtopp + impdtopp			 
	end if
	Next
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
      f_valores(contador,tipo)
		dw_preliminar.SetItem(contador - 1,"raya",1)
		dw_preliminar.SetItem(contador,"texto","")
		dw_preliminar.SetItem(contador,"importe",String(Dec(var_total),f_mascara_moneda(var_moneda)))
		dw_preliminar.SetItem(contador,"orden","2")
END IF



IF valorado.text = "Si" Then
	/*
		IF importedtopp <>0 then
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"texto",String(dtopp,"##") + "% " +f_diccionario("PRONTO PAGO",var_idioma)+puntos)
				IF importedtopp > 0 Then
					dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedtopp),f_mascara_moneda(var_moneda)))
				ELse
					dw_preliminar.SetItem(contador,"importe", + String(Dec(importedtopp)* (-1),f_mascara_moneda(var_moneda)))
				End If
				dw_preliminar.SetItem(contador,"orden","2")
				dw_preliminar.SetItem(contador,"raya",1)
				var_total = var_total - importedtopp
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
		END IF
	*/		
End if
IF tipo = 3 Then iva = 0
IF IsNull(iva)     Then iva = 0
IF IsNull(recargo) Then recargo = 0
importeiva      = Dec(String(var_total * iva / 100,f_mascara_moneda(var_moneda)))
importerecargo  = Dec(STring(var_total * recargo / 100,f_mascara_moneda(var_moneda)))
IF valorado.text = "Si" Then
	IF importeiva <>0 then
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"texto",String(iva,"##") + "% " +texto_iva+puntos)
			dw_preliminar.SetItem(contador,"importe"," " + String(Dec(importeiva),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
			dw_preliminar.SetItem(contador,"raya",1)
			var_total = var_total + importeiva
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
	END IF
	IF importerecargo <>0 then
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"texto",String(recargo,"##") + "% " +texto_recargo+puntos)
			dw_preliminar.SetItem(contador,"importe"," " + String(Dec(importerecargo),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
			dw_preliminar.SetItem(contador,"raya",1)
			var_total = var_total + importerecargo
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"orden","2")
	END IF
END IF

// calculo resto de lineas para completar la hoja
var_paginas = Int(contador / lineas)
resto       = lineas - (contador - (var_paginas * lineas))

/*
IF resto >= lnpie Then	// Hay espacio para los textos
	// calculo final de hoja
	For  re = 1 To resto - lnpie
		contador = contador + 1 
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	For reg1 = 1 To lnpie
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
	   f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"textopie",textpie[reg1])
		dw_preliminar.SetItem(contador,"orden","2")
	NEXT
ELSE
	For  re = 1 To resto
		contador = contador + 1 
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	// calculo resto de lineas para completar la hoja
	var_paginas = Int(contador / lineas)
	resto = lineas - (contador - (var_paginas * lineas))
	// calculo final de hoja
	For  re = 1 To resto - lnpie
		contador = contador + 1 
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	For reg1 = 1 To lnpie
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
	   f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"textopie",textpie[reg1])
		dw_preliminar.SetItem(contador,"orden","2")
	NEXT
END IF	
*/

dw_preliminar.SetItem(contador,"texto_total",&
                  "TOTAL  "+f_nombre_moneda_abr(var_moneda) + "  #" +&
						String(var_total,f_mascara_moneda(var_moneda))+"#")
dw_preliminar.SetItem(contador,"ultima","S")
dw_preliminar.SetRedraw(TRUE)
dw_preliminar.enabled = TRUE



destroy dw_proceso
end subroutine

public subroutine f_proceso_old (integer tipo);dw_preliminar.SetRedraw(FALSE)
dw_preliminar.enabled = FALSE
Dec{0} var_anyo,var_albaran,resto,re,var_paginas,var_ejercicio,total_cajas,var_numpalet
long va,va2
String  textpie[],pie,pie1,pie2,pie3,letra,var_articulo,tipo_iva,tipo_recargo,puntos
String var_tono,textopie2,cadena,texto_iva,texto_recargo,var_tipo_pallet,var_caja,var_ref_cli
Integer reg,reg1
Dec{4}  var_calibre,var_cantidad,acumulado,dto1,impdto1,dto2,impdto2,dto3,impdto3,&
		  dto4,impdto4,dtopp,impdtopp,aculumado,dtoesp,precio,cantidad,bruto,importe,iva,recargo,importeiva,importerecargo

DateTime var_falbaran
String   var_tipo_unidad,textdto1,textdto2,textdto3,textdto4,tipodto1,&
         tipodto2,tipodto3,tipodto4,tipo_cliente,linea,var_observaciones
DataStore dw_proceso			
String sel
Dec{4}   importedto1,importedto2,importedto3,importedto4,importedtopp



messagebox("", "")
			


var_total = 0
puntos= "........................................"
contador    = 0
acumulado   = 0
importedto1 = 0
importedto2 = 0
importedto3 = 0
importedto4 = 0
importedtopp= 0 
var_anyo      = Dec(em_anyo.text)
var_albaran   = Dec(em_albaran.text)
var_observaciones = f_observaciones_venalb(codigo_empresa,var_anyo,var_albaran)

Select dtoesp1,tipodto1,explicaciondto1,
		 dtoesp2,tipodto2,explicaciondto2,
		 dtoesp3,tipodto3,explicaciondto3,
		 dtoesp4,tipodto4,explicaciondto4,
		 dtopp,textcomercial2,textaduanaesp2,textaduanaext2,tipoiva
Into   :dto1,:tipodto1,:textdto1,
       :dto2,:tipodto2,:textdto2,
       :dto3,:tipodto3,:textdto3,
       :dto4,:tipodto4,:textdto4,
		 :dtopp,:pie1,:pie2,:pie3,
		 :tipo_iva
From   venalb
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    albaran= :var_albaran;
var_ejercicio = f_ejercicio_activo(codigo_empresa)

  SELECT contaiva.iva,contaiva.recargo,contaiva.descripcion  
    INTO :iva,:tipo_recargo,:texto_iva  
    FROM contaiva  
   WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
         ( contaiva.empresa = :codigo_empresa ) AND  
         ( contaiva.tipoiva = :tipo_iva )   ;
			
  IF Not IsNull(tipo_recargo) and Trim(tipo_recargo) <> "" Then
  		SELECT  contaiva.iva,contaiva.descripcion INTO :recargo,:texto_recargo
   	 FROM   contaiva  
   	WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
      	   ( contaiva.empresa = :codigo_empresa ) AND  
         	( contaiva.tipoiva = :tipo_recargo )   ;			
  END IF


//---------------------------------------------------------------------

f_mascara_columna(dw_preliminar,"precio",f_mascara_moneda(var_moneda))
f_mascara_columna(dw_preliminar,"total",f_mascara_moneda(var_moneda))
String ampli = ""
if tipo=3 then ampli = " AND venlialb.precio_aduana <> 0   "

Sel = " SELECT venlialb.* " +&
	   " FROM venlialb  "+&
	   " WHERE  venlialb.empresa = '"+ codigo_empresa +"'" +&
	   " AND venlialb.anyo       = "+String(var_anyo,"######")+&
	   " AND venlialb.albaran    = "+String(var_albaran,"#########") +&
	   " AND venlialb.control_descuentos = 'S'   "+&
	     ampli +&
	   " ORDER BY empresa ASC,anyo ASC,albaran ASC,numpalet ASC,familia ASC,formato asc,"+&
		" articulo asc,calidad asc,tonochar asc,calibre asc,cantidad desc"
		
//dw_proceso= f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, dw_proceso)
reg = dw_proceso.RowCount()

IF reg <> 0 Then
	For reg1 = 1 to reg
		acumulado = 0
		contador  = contador + 1
		var_clase     = dw_proceso.GetItemString(contador,"clase")
		dtoesp        = dw_proceso.GetItemNumber(contador,"dtoesp")
		cantidad      = dw_proceso.GetItemNumber(contador,"cantidad")
		var_tono      = dw_proceso.GetItemString(contador,"tonochar")
		var_calibre   = dw_proceso.GetItemNumber(contador,"calibre")
		var_tipo_pallet = dw_proceso.GetItemSTring(contador,"tipo_pallet")
		var_caja      = dw_proceso.GetItemSTring(contador,"caja")
		var_numpalet  = dw_proceso.GetItemNumber(contador,"numpalet")
		var_ref_cli   = dw_proceso.GetItemString(contador,"numpedcli")
		CHOOSE CASE tipo
		 CASE  3
			precio       = dw_proceso.GetItemNumber(reg1,"precio_neto_aduana")
			bruto        = dw_proceso.GetItemNumber(reg1,"importe_aduana")
			impdtopp     = dw_proceso.GetItemNumber(reg1,"impdtopp_aduana")
			impdto1      = dw_proceso.GetItemNumber(reg1,"impdtoesp1_aduana")
			impdto2      = dw_proceso.GetItemNumber(reg1,"impdtoesp2_aduana")			
			impdto3      = dw_proceso.GetItemNumber(reg1,"impdtoesp3_aduana")			
			impdto4      = dw_proceso.GetItemNumber(reg1,"impdtoesp4_aduana")			
		 CASE ELSE
			precio        = dw_proceso.GetItemNumber(reg1,"precio_neto")
			bruto         = dw_proceso.GetItemNumber(reg1,"importe")
			impdtopp      = dw_proceso.GetItemNumber(reg1,"impdtopp")
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
		
		if valorado.text = "No" and dw_proceso.GetItemSTring(reg1,"tipolinea")='5' Then
			// En Equipe no quieren que aparezca el tipo de lina 5 (Trans. y Fletes)
			// en los albaranes no valorados
		else
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			var_articulo = dw_proceso.GetItemSTring(reg1,"articulo")
			dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
			dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemNumber(reg1,"pallets"))
			dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemNumber(reg1,"total_cajas"))
			dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))
			dw_preliminar.SetItem(contador,"cod_articulo",var_articulo)
			dw_preliminar.SetItem(contador,"tono",dw_proceso.GetItemString(reg1,"tonochar"))
			dw_preliminar.SetItem(contador,"calibre",dw_proceso.GetItemNumber(reg1,"calibre"))
			dw_preliminar.SetItem(contador,"tipo_pallet",dw_proceso.GetItemSTring(reg1,"tipo_pallet"))
			dw_preliminar.SetItem(contador,"caja",dw_proceso.GetItemSTring(reg1,"caja"))		
			dw_preliminar.SetItem(contador,"numpalet",var_numpalet)	
			dw_preliminar.SetItem(contador,"ref_cli",var_ref_cli)
			dw_preliminar.SetItem(contador,"observ",var_observaciones)
			
			IF tipo <>3 Then
				dw_preliminar.SetItem(contador,"importe",String(dw_proceso.GetItemNumber(reg1,"importe"),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemNumber(reg1,"precio_neto"))
				dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento"))
				dw_preliminar.SetItem(contador,"dto1",dw_proceso.GetItemNumber(reg1,"dtoesp"))
				dw_preliminar.SetItem(contador,"dto2",dw_proceso.GetItemNumber(reg1,"dtoesp2"))
			ELSE
				dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemNumber(reg1,"precio_aduana_neto"))
				dw_preliminar.SetItem(contador,"importe",String(dw_proceso.GetItemNumber(reg1,"importe_aduana"),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemNumber(reg1,"descuento_aduana"))
			END IF
			dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"formato")))
			dw_preliminar.SetItem(contador,"familia",f_nombre_familia_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"familia")))		
			dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"calidad")))
			var_tipo_unidad=dw_proceso.GetItemString(reg1,"tipo_unidad")
			var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad")
//			IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
				IF var_tipo_unidad= "0" Then
					dw_preliminar.SetItem(contador,"piezas",var_cantidad)
					dw_preliminar.SetItem(contador,"metros",f_calculo_metros_cuadrados(codigo_empresa,var_articulo,var_cantidad))
				ELSE
					dw_preliminar.SetItem(contador,"piezas","0")
					dw_preliminar.SetItem(contador,"metros",var_cantidad)
				END IF
//			ELSE
//				dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####")+ " " + dw_proceso.GetItemString(reg1,"descripcion"))
//			END IF
			
			IF tipo <>3 then
				var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))
			ELSE
				var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe_aduana"))
			END IF
			C = ""
			IF var_clase = "M" Then C = "(MUESTRAS)"
			IF var_clase = "S" Then C = "(SIN CARGO)"
			des = dw_preliminar.GetItemString(contador,"articulo")
			IF Trim(des) <> "" Then 
				dw_preliminar.SetItem(contador,"articulo",des + " " +c)
			END IF
		end if
	Next
	
	IF valorado.text = "Si" Then
	  IF contador <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
      f_valores(contador,tipo)
		dw_preliminar.SetItem(contador - 1,"raya",1)
		dw_preliminar.SetItem(contador,"texto",f_diccionario("TOTAL BRUTO",var_idioma) + puntos)
		dw_preliminar.SetItem(contador,"importe",String(Dec(var_total),f_mascara_moneda(var_moneda)))
		dw_preliminar.SetItem(contador,"orden","2")
	  END IF
	END IF
END IF

IF valorado.text = "Si" Then
		IF importedto1 <>0 then
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"texto",String(dto1,"##") + "% " +textdto1+puntos )
				dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto1),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
				dw_preliminar.SetItem(contador,"raya",1)
				var_total = var_total - importedto1
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
		END IF
		IF importedto2 <>0 then
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"texto",String(dto2,"##") + "% " +textdto2+puntos)
		
				dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto2),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
				dw_preliminar.SetItem(contador,"raya",1)
				var_total = var_total - importedto2
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
		END IF
		IF importedto3 <>0 then
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"texto",String(dto3,"##") + "% " +textdto3+puntos)
				dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto3),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
				dw_preliminar.SetItem(contador,"raya",1)
				var_total = var_total - importedto3
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
		END IF
		IF importedto4 <>0 then
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"texto",String(dto4,"##") + "% " +textdto4+puntos)
				dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedto4),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
				dw_preliminar.SetItem(contador,"raya",1)
				var_total = var_total - importedto4
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
		END IF
END IF

Sel = " SELECT venlialb.* " +&
		" FROM   venlialb  "+&
		" WHERE  venlialb.empresa = '"+ codigo_empresa +"'" +&
		" AND venlialb.anyo = "+String(var_anyo,"######")+&
		" AND venlialb.albaran = "+String(var_albaran,"#########") +&
		" AND venlialb.control_descuentos = 'N'   "+&
		  ampli +&
		" ORDER BY empresa ASC,anyo ASC,albaran ASC,numpalet ASC "

//dw_proceso= f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, dw_proceso)
reg = dw_proceso.RowCount()

IF reg <> 0 Then
	For reg1 = 1 to reg
		contador  = contador + 1
		var_clase    = dw_proceso.GetItemString(reg1,"clase")
		
		if valorado.text = "No" and dw_proceso.GetItemSTring(reg1,"tipolinea")='5' Then
			// En Equipe no quieren que aparezca el tipo de lina 5 (Trans. y Fletes)
			// en los albaranes no valorados
		else
		
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			var_articulo = dw_proceso.GetItemString(reg1,"articulo")
			dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
			dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemnumber(reg1,"pallets"))
			dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemnumber(reg1,"total_cajas"))
			dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemstring(reg1,"descripcion"))
			dw_preliminar.SetItem(contador,"cod_articulo",var_articulo)
			dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemnumber(reg1,"precio"))
			dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemnumber(reg1,"descuento"))
			dw_preliminar.SetItem(contador,"dto1",dw_proceso.GetItemNumber(reg1,"dtoesp"))
			dw_preliminar.SetItem(contador,"dto2",dw_proceso.GetItemNumber(reg1,"dtoesp2"))
			dw_preliminar.SetItem(contador,"importe",String(dw_proceso.GetItemnumber(reg1,"importe"),f_mascara_moneda(var_moneda)))
			dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,dw_proceso.GetItemstring(reg1,"formato")))
			dw_preliminar.SetItem(contador,"familia",f_nombre_familia_abr(codigo_empresa,dw_proceso.GetItemstring(reg1,"familia")))
			dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemstring(reg1,"calidad")))
			var_tipo_unidad=dw_proceso.GetItemSTring(reg1,"tipo_unidad")
			var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad")
			dw_preliminar.SetItem(contador,"numpalet",dw_proceso.GetItemnumber(reg1,"numpalet"))	
			dw_preliminar.SetItem(contador,"ref_cli",dw_proceso.GetItemstring(reg1,"numpedcli"))
			dw_preliminar.SetItem(contador,"observ",var_observaciones)
			
//			IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
				IF var_tipo_unidad= "0" Then
					dw_preliminar.SetItem(contador,"piezas",var_cantidad)
					dw_preliminar.SetItem(contador,"metros","0")
				ELSE
					dw_preliminar.SetItem(contador,"piezas","0")
					dw_preliminar.SetItem(contador,"metros",var_cantidad)
				END IF
//			ELSE
//				// Modificacion según Carlos
//				//dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####")+ " " + dw_proceso.GetItem(reg1,"descripcion"))
//				dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))
//			
//							
//			END IF
			C = ""
			IF var_clase = "M" Then C = "(MUESTRAS)"
			IF var_clase = "S" Then C = "(SIN CARGO)"
			des = dw_preliminar.GetItemString(contador,"articulo")
			IF Trim(des) <> "" Then 
				dw_preliminar.SetItem(contador,"articulo",des + " " +c)
			END IF
		var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))		
		impdtopp     =  Dec(String(Dec(dw_proceso.GetItemNumber(reg1,"importe"))		 * dtopp / 100,f_mascara_moneda(var_moneda)))
		importedtopp = importedtopp + impdtopp			 
	end if
	Next
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
      f_valores(contador,tipo)
		dw_preliminar.SetItem(contador - 1,"raya",1)
		dw_preliminar.SetItem(contador,"texto","")
		dw_preliminar.SetItem(contador,"importe",String(Dec(var_total),f_mascara_moneda(var_moneda)))
		dw_preliminar.SetItem(contador,"orden","2")
END IF



IF valorado.text = "Si" Then
		IF importedtopp <>0 then
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"texto",String(dtopp,"##") + "% " +f_diccionario("PRONTO PAGO",var_idioma)+puntos)
				IF importedtopp > 0 Then
					dw_preliminar.SetItem(contador,"importe","-" + String(Dec(importedtopp),f_mascara_moneda(var_moneda)))
				ELse
					dw_preliminar.SetItem(contador,"importe", + String(Dec(importedtopp)* (-1),f_mascara_moneda(var_moneda)))
				End If
				dw_preliminar.SetItem(contador,"orden","2")
				dw_preliminar.SetItem(contador,"raya",1)
				var_total = var_total - importedtopp
				contador = contador + 1
				dw_preliminar.InsertRow(contador)
				f_valores(contador,tipo)
				dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
				dw_preliminar.SetItem(contador,"orden","2")
		END IF
End if
IF tipo = 3 Then iva = 0
IF IsNull(iva)     Then iva = 0
IF IsNull(recargo) Then recargo = 0
importeiva      = Dec(String(var_total * iva / 100,f_mascara_moneda(var_moneda)))
importerecargo  = Dec(STring(var_total * recargo / 100,f_mascara_moneda(var_moneda)))
IF valorado.text = "Si" Then
IF importeiva <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(iva,"##") + "% " +texto_iva+puntos)
		dw_preliminar.SetItem(contador,"importe"," " + String(Dec(importeiva),f_mascara_moneda(var_moneda)))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total + importeiva
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		dw_preliminar.SetItem(contador,"orden","2")
END IF
IF importerecargo <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"texto",String(recargo,"##") + "% " +texto_recargo+puntos)
		dw_preliminar.SetItem(contador,"importe"," " + String(Dec(importerecargo),f_mascara_moneda(var_moneda)))
		dw_preliminar.SetItem(contador,"orden","2")
		dw_preliminar.SetItem(contador,"raya",1)
		var_total = var_total + importerecargo
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		dw_preliminar.SetItem(contador,"orden","2")
END IF
END IF





// calculo resto de lineas para completar la hoja
	var_paginas = Int(contador / lineas)
	resto = lineas - (contador - (var_paginas * lineas))

IF resto >= lnpie Then	// Hay espacio para los textos
	// calculo final de hoja
	For  re = 1 To resto - lnpie
		contador = contador + 1 
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	For reg1 = 1 To lnpie
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
	   f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"textopie",textpie[reg1])
		dw_preliminar.SetItem(contador,"orden","2")
	NEXT
ELSE
	For  re = 1 To resto
		contador = contador + 1 
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	// calculo resto de lineas para completar la hoja
	var_paginas = Int(contador / lineas)
	resto = lineas - (contador - (var_paginas * lineas))
	// calculo final de hoja
	For  re = 1 To resto - lnpie
		contador = contador + 1 
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
	NEXT
	For reg1 = 1 To lnpie
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
	   f_valores(contador,tipo)
		dw_preliminar.SetItem(contador,"textopie",textpie[reg1])
		dw_preliminar.SetItem(contador,"orden","2")
	NEXT
END IF	


dw_preliminar.SetItem(contador,"texto_total",&
                  "TOTAL  "+f_nombre_moneda_abr(var_moneda) + "  #" +&
						String(var_total,f_mascara_moneda(var_moneda))+"#")
dw_preliminar.SetItem(contador,"ultima","S")
dw_preliminar.SetRedraw(TRUE)
dw_preliminar.enabled = TRUE

destroy dw_proceso
end subroutine

event open;call super::open;//REPORTS ALBARANES *************************************
//report_list_venalbaranes1_sinval_matric
//report_list_venalbaranes1
//*****************************************************


Integer r,j
istr_parametros.s_titulo_ventana="Listado albaranes"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))
var_tipo = 1
cabecera.text = "Si"
valorado.text = "No"
aduana.text = "No"
istr_parametros = Message.PowerObjectParm

IF istr_parametros.i_nargumentos>1 THEN
	j= istr_parametros.i_nargumentos - 3
	FOR r = 1 To j
     em_anyo.text=istr_parametros.s_argumentos[3]	
	  em_albaran.text=istr_parametros.s_argumentos[r+3]	
	  IF Not IsNull(em_albaran.text) and Trim(em_albaran.text) <> "" Then
	  	  em_albaran.TriggerEvent("modificado")
	     istr_parametros.i_nargumentos=0
		  em_copias1.text = istr_parametros.s_argumentos[2]
		  IF integer(em_copias1.text) > 0 THEN //SONIA - 04/2015
			  cb_2.triggerevent(Clicked!)
		end if
	  END IF
	NEXT
	 IF integer(em_copias1.text) > 0 THEN //SONIA - 04/2015
		Close(This)
		Return
	else
		cb_1.triggerevent(Clicked!)
	end if
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

on w_lis_venalbaranes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_albaran=create em_albaran
this.st_3=create st_3
this.st_6=create st_6
this.em_copias1=create em_copias1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_13=create st_13
this.cabecera=create cabecera
this.uo_manejo=create uo_manejo
this.st_7=create st_7
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.st_pagina=create st_pagina
this.gb_3=create gb_3
this.st_14=create st_14
this.valorado=create valorado
this.aduana=create aduana
this.st_22=create st_22
this.cbx_matric=create cbx_matric
this.dw_preliminar=create dw_preliminar
this.uo_1=create uo_1
this.cb_3=create cb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_albaran
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.em_copias1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.pb_imprimir_preli
this.Control[iCurrent+11]=this.st_13
this.Control[iCurrent+12]=this.cabecera
this.Control[iCurrent+13]=this.uo_manejo
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.st_cliente
this.Control[iCurrent+16]=this.st_codcli
this.Control[iCurrent+17]=this.st_pagina
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.st_14
this.Control[iCurrent+20]=this.valorado
this.Control[iCurrent+21]=this.aduana
this.Control[iCurrent+22]=this.st_22
this.Control[iCurrent+23]=this.cbx_matric
this.Control[iCurrent+24]=this.dw_preliminar
this.Control[iCurrent+25]=this.uo_1
this.Control[iCurrent+26]=this.cb_3
this.Control[iCurrent+27]=this.gb_2
this.Control[iCurrent+28]=this.gb_1
end on

on w_lis_venalbaranes.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_albaran)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.em_copias1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_imprimir_preli)
destroy(this.st_13)
destroy(this.cabecera)
destroy(this.uo_manejo)
destroy(this.st_7)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.st_pagina)
destroy(this.gb_3)
destroy(this.st_14)
destroy(this.valorado)
destroy(this.aduana)
destroy(this.st_22)
destroy(this.cbx_matric)
destroy(this.dw_preliminar)
destroy(this.uo_1)
destroy(this.cb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_venalbaranes
integer x = 978
integer y = 2508
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_venalbaranes
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_albaran)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_venalbaranes
integer x = 14
integer y = 4
integer width = 3790
integer height = 80
end type

type pb_1 from upb_salir within w_lis_venalbaranes
integer x = 3689
integer y = 304
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_2 from statictext within w_lis_venalbaranes
integer x = 14
integer y = 136
integer width = 302
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Albaran:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_lis_venalbaranes
integer x = 329
integer y = 128
integer width = 192
integer height = 80
integer taborder = 0
end type

type em_albaran from u_em_campo within w_lis_venalbaranes
integer x = 562
integer y = 128
integer width = 210
integer height = 80
integer taborder = 30
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######"
string displaydata = "~b"
end type

event modificado;var_idioma      = f_idioma_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda      = f_divisa_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_codcli      = f_cliente_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
st_codcli.text  = var_codcli
st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)
call super::modificado
end event

type st_3 from statictext within w_lis_venalbaranes
integer x = 521
integer y = 116
integer width = 46
integer height = 92
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

type st_6 from statictext within w_lis_venalbaranes
integer x = 937
integer y = 136
integer width = 256
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Copias:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_copias1 from editmask within w_lis_venalbaranes
integer x = 1207
integer y = 128
integer width = 192
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

type cb_2 from u_boton within w_lis_venalbaranes
event clicked pbm_bnclicked
integer x = 3351
integer y = 304
integer width = 338
integer height = 96
integer taborder = 80
string text = "&Imprimir"
end type

event clicked;int cont
var_tipo = 1
string v_cliente, v_valorar_alb
long v_albaran

v_albaran = long(em_albaran.text)

select cliente 
into :v_cliente
from venalb
where empresa = :codigo_empresa
and anyo = :em_anyo.text
and albaran = :v_albaran;

select valorar_alb
into :v_valorar_alb
from venclientes
where empresa = :codigo_empresa
and codigo = :v_cliente;

if v_valorar_alb = 'S' then
	valorado.text = 'Si'
end if

dw_preliminar.visible=false
iF aduana.text = "Si" Then var_tipo = 3
IF valorado.text = "Si" Then
	dw_preliminar.DataObject = "report_list_venalbaranes1"
	dw_preliminar.Settransobject(SQLCA)
	lineas=22
Else
	dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_matric"
	dw_preliminar.Settransobject(SQLCA)
	lineas=23
//	if cbx_matric.checked then
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_matric"
//		lineas=32
//	else
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval"
//		lineas=22
//	end if
END IF
if len(em_albaran.text)=0 then
	MessageBox("Introduzca el albaran","" ,Exclamation!, OK!, 2)
	f_activar_campo(em_albaran)
	Return
End if

var_idioma = f_idioma_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda = f_divisa_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE

IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
	dw_preliminar.retrieve()
	for cont=1 to integer(em_copias1.text)
		if cont=1 then
			dw_preliminar.reset()
			
			f_proceso(var_tipo)
			dw_preliminar.modify( "copia.visible = 0 ")
		else
			dw_preliminar.modify( "copia.visible = 1 ")			
			dw_preliminar.modify( "copia.x = 5500 ")
			dw_preliminar.modify( "copia.y = 13000 ")
			dw_preliminar.modify( "copia.width = 8500 ")
			dw_preliminar.modify( "copia.height = 2500 ")
		end if
		dw_preliminar.groupcalc()
		
		IF dw_preliminar.RowCount() <> 0 Then 
			if valorado.text = "No" and cont=1 then
				f_valores(dw_preliminar.insertrow(0), var_tipo)
			end if
			dw_preliminar.Print(TRUE)					
		end if
	next

END IF
f_activar_campo(em_albaran)

// pruebas de pasar argumentos para el nested report cabecera_legal
//dw_preliminar.object.empresa[1] = codigo_empresa
//dw_preliminar.Object.dw_2.Nest_Arguments = ( codigo_empresa )
//dw_preliminar.Modify("dw_2.Nest_Arguments=("+codigo_empresa+")")

dw_preliminar.retrieve()
end event

type cb_1 from u_boton within w_lis_venalbaranes
integer x = 2706
integer y = 304
integer width = 338
integer height = 96
integer taborder = 90
boolean bringtotop = true
string text = "&Preliminar"
end type

event clicked;var_tipo = 1
dw_preliminar.visible=false
dw_preliminar.reset()
dw_preliminar.SetRedraw(FALSE)
iF aduana.text = "Si" Then var_tipo = 3
IF valorado.text = "Si" Then
	dw_preliminar.DataObject = "report_list_venalbaranes1"
	lineas = 22
Else
	dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_matric"
	lineas = 23
//	if cbx_matric.checked then
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_matric"
//		lineas=32
//	else
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_matric"
//		lineas=22
//	end if
END IF
if len(em_albaran.text)=0 then
	MessageBox("Introduzca la pedido","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_albaran)
	Return
End if

f_activar_campo(em_albaran)

em_albaran.TriggerEvent("modificado")
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE

environment env
GetEnvironment(env)

f_proceso(var_tipo)
f_pagina()
dw_preliminar.modify( "copia.visible = 0 ")
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "110" + ")")

if dw_preliminar.RowCount() <> 0 and valorado.text = "No" then
	f_valores(dw_preliminar.insertrow(0), var_tipo)
end if

dw_preliminar.visible= TRUE
uo_manejo.visible = TRUE
//pb_imprimir_preli.visible = TRUE
dw_preliminar.SetRedraw(TRUE)


end event

type pb_imprimir_preli from picturebutton within w_lis_venalbaranes
boolean visible = false
integer x = 2565
integer y = 236
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Print!"
end type

event clicked;OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_albaran)
end event

type st_13 from statictext within w_lis_venalbaranes
integer x = 1568
integer y = 136
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cabecera:"
boolean focusrectangle = false
end type

type cabecera from dropdownlistbox within w_lis_venalbaranes
integer x = 1833
integer y = 124
integer width = 192
integer height = 220
integer taborder = 70
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

type uo_manejo from u_manejo_datawindow within w_lis_venalbaranes
boolean visible = false
integer x = 2071
integer y = 196
integer width = 480
integer height = 160
end type

event valores;call super::valores;dw_data =dw_preliminar
f_pagina()
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type st_7 from statictext within w_lis_venalbaranes
integer x = 27
integer y = 320
integer width = 297
integer height = 80
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

type st_cliente from statictext within w_lis_venalbaranes
integer x = 535
integer y = 320
integer width = 1490
integer height = 80
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

type st_codcli from statictext within w_lis_venalbaranes
integer x = 329
integer y = 320
integer width = 201
integer height = 80
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

type st_pagina from statictext within w_lis_venalbaranes
integer x = 3401
integer y = 220
integer width = 361
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

type gb_3 from groupbox within w_lis_venalbaranes
integer x = 5
integer y = 80
integer width = 2048
integer height = 332
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_14 from statictext within w_lis_venalbaranes
integer x = 1568
integer y = 232
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Valorado:"
boolean focusrectangle = false
end type

type valorado from dropdownlistbox within w_lis_venalbaranes
integer x = 1833
integer y = 220
integer width = 192
integer height = 220
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type aduana from dropdownlistbox within w_lis_venalbaranes
integer x = 1207
integer y = 220
integer width = 192
integer height = 220
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

type st_22 from statictext within w_lis_venalbaranes
integer x = 933
integer y = 232
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Aduana:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_matric from checkbox within w_lis_venalbaranes
boolean visible = false
integer x = 2171
integer y = 364
integer width = 311
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Matricial"
boolean checked = true
end type

type dw_preliminar from datawindow within w_lis_venalbaranes
boolean visible = false
integer x = 37
integer y = 448
integer width = 3762
integer height = 2712
string dataobject = "report_list_venalbaranes1_sinval_matric"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type uo_1 from u_selec_impresoras within w_lis_venalbaranes
integer x = 2386
integer y = 120
integer width = 1394
integer height = 100
integer taborder = 60
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type cb_3 from u_boton within w_lis_venalbaranes
integer x = 3040
integer y = 304
integer width = 315
integer height = 96
integer taborder = 90
boolean bringtotop = true
string text = "&PDF"
end type

event clicked;int cont, li_return
var_tipo = 1
string v_cliente, v_valorar_alb, albaran, anyo, v_serie, ls_file, ls_path, ls_folderfile, tipo
long v_albaran

v_albaran = long(em_albaran.text)

anyo = em_anyo.text
albaran = em_albaran.text

tipo = "Alb"

select cliente 
into :v_cliente
from venalb
where empresa = :codigo_empresa
and anyo = :em_anyo.text
and albaran = :v_albaran;

select valorar_alb
into :v_valorar_alb
from venclientes
where empresa = :codigo_empresa
and codigo = :v_cliente;

if v_valorar_alb = 'S' then
	valorado.text = 'Si'
end if

dw_preliminar.visible=false
iF aduana.text = "Si" Then var_tipo = 3
IF valorado.text = "Si" Then
	dw_preliminar.DataObject = "report_list_venalbaranes1"
	dw_preliminar.Settransobject(SQLCA)
	lineas=22
Else
	dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_matric"
	dw_preliminar.Settransobject(SQLCA)
	lineas=23
//	if cbx_matric.checked then
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_matric"
//		lineas=32
//	else
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval"
//		lineas=22
//	end if
END IF
if len(em_albaran.text)=0 then
	MessageBox("Introduzca el albaran","" ,Exclamation!, OK!, 2)
	f_activar_campo(em_albaran)
	Return
End if

var_idioma = f_idioma_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda = f_divisa_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE

IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
	dw_preliminar.retrieve()
	for cont=1 to integer(em_copias1.text)
		if cont=1 then
			dw_preliminar.reset()
			
			f_proceso(var_tipo)
			dw_preliminar.modify( "copia.visible = 0 ")
		else
			dw_preliminar.modify( "copia.visible = 1 ")			
			dw_preliminar.modify( "copia.x = 5500 ")
			dw_preliminar.modify( "copia.y = 13000 ")
			dw_preliminar.modify( "copia.width = 8500 ")
			dw_preliminar.modify( "copia.height = 2500 ")
		end if
		dw_preliminar.groupcalc()
		
		IF dw_preliminar.RowCount() <> 0 Then 
			if valorado.text = "No" and cont=1 then
				f_valores(dw_preliminar.insertrow(0), var_tipo)
			end if
			//dw_preliminar.Print(TRUE)
			
			/*	IMPRIMIR EN PDF DIRECTO */
			
			SELECT distinct genter.razon,
			 venlialb.serie
			INTO   
			 :v_cliente, 
			 :v_serie			
			FROM   venlialb
			INNER JOIN (select * from genter where tipoter = 'C') as genter on genter.empresa = venlialb.empresa and genter.codigo = venlialb.cliente
			Where  venlialb.empresa      = :codigo_empresa
			And    venlialb.anyo = :anyo
			And    venlialb.albaran      = :albaran;
			
			long ll_aux
			
			for ll_aux=1 to len(v_cliente)
					if mid(v_cliente,ll_aux,1)="." then
						v_cliente = replace(v_cliente,ll_aux,1, "")	
					end if
					if mid(v_cliente,ll_aux,1)="/" then
						v_cliente = replace(v_cliente,ll_aux,1, " ")	
					end if
			next
			
			ls_file = ""
			
			ls_path = "\\amazonas\usuarios\COMERCIAL\WOW\aaaaaFACTURAS\"+anyo+"\ALBARANES\"+"SERIE "+v_serie+"-ALB"
			
			//li_rc = GetFileSaveName ( "Selecciona una carpeta", &
			//  		ls_path, ls_file, "PDF")
			 
			ls_folderfile = ls_path + "\"+albaran+" "+v_cliente+" "+tipo
				
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
f_activar_campo(em_albaran)

// pruebas de pasar argumentos para el nested report cabecera_legal
//dw_preliminar.object.empresa[1] = codigo_empresa
//dw_preliminar.Object.dw_2.Nest_Arguments = ( codigo_empresa )
//dw_preliminar.Modify("dw_2.Nest_Arguments=("+codigo_empresa+")")

dw_preliminar.retrieve()
end event

type gb_2 from groupbox within w_lis_venalbaranes
integer x = 2693
integer y = 260
integer width = 1115
integer height = 152
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_lis_venalbaranes
integer x = 2368
integer y = 88
integer width = 1435
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

