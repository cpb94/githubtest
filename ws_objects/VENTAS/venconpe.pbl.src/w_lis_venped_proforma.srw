$PBExportHeader$w_lis_venped_proforma.srw
forward
global type w_lis_venped_proforma from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_venped_proforma
end type
type st_2 from statictext within w_lis_venped_proforma
end type
type em_anyo from u_em_campo within w_lis_venped_proforma
end type
type em_pedido from u_em_campo within w_lis_venped_proforma
end type
type st_3 from statictext within w_lis_venped_proforma
end type
type st_4 from statictext within w_lis_venped_proforma
end type
type st_idioma from statictext within w_lis_venped_proforma
end type
type dw_proceso from datawindow within w_lis_venped_proforma
end type
type dw_preliminar from datawindow within w_lis_venped_proforma
end type
type st_5 from statictext within w_lis_venped_proforma
end type
type em_copias2 from editmask within w_lis_venped_proforma
end type
type st_6 from statictext within w_lis_venped_proforma
end type
type em_copias1 from editmask within w_lis_venped_proforma
end type
type cb_2 from u_boton within w_lis_venped_proforma
end type
type rb_comercial from radiobutton within w_lis_venped_proforma
end type
type rb_nacional from radiobutton within w_lis_venped_proforma
end type
type rb_extranjero from radiobutton within w_lis_venped_proforma
end type
type cb_1 from u_boton within w_lis_venped_proforma
end type
type st_12 from statictext within w_lis_venped_proforma
end type
type em_copias3 from editmask within w_lis_venped_proforma
end type
type st_1 from statictext within w_lis_venped_proforma
end type
type st_moneda from statictext within w_lis_venped_proforma
end type
type pb_imprimir_preli from picturebutton within w_lis_venped_proforma
end type
type st_13 from statictext within w_lis_venped_proforma
end type
type cabecera from dropdownlistbox within w_lis_venped_proforma
end type
type uo_manejo from u_manejo_datawindow within w_lis_venped_proforma
end type
type gb_1 from groupbox within w_lis_venped_proforma
end type
type st_7 from statictext within w_lis_venped_proforma
end type
type st_cliente from statictext within w_lis_venped_proforma
end type
type st_codcli from statictext within w_lis_venped_proforma
end type
type st_pagina from statictext within w_lis_venped_proforma
end type
type gb_3 from groupbox within w_lis_venped_proforma
end type
type uo_1 from u_selec_impresoras within w_lis_venped_proforma
end type
type st_14 from statictext within w_lis_venped_proforma
end type
type cajas from dropdownlistbox within w_lis_venped_proforma
end type
type gb_5 from groupbox within w_lis_venped_proforma
end type
type em_neto from editmask within w_lis_venped_proforma
end type
type em_bruto from editmask within w_lis_venped_proforma
end type
type st_9 from statictext within w_lis_venped_proforma
end type
type st_10 from statictext within w_lis_venped_proforma
end type
type st_8 from statictext within w_lis_venped_proforma
end type
type em_bascula from editmask within w_lis_venped_proforma
end type
type cbx_agrupar_ref from checkbox within w_lis_venped_proforma
end type
type cb_3 from u_boton within w_lis_venped_proforma
end type
end forward

global type w_lis_venped_proforma from w_int_con_empresa
integer width = 3817
integer height = 3556
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_pedido em_pedido
st_3 st_3
st_4 st_4
st_idioma st_idioma
dw_proceso dw_proceso
dw_preliminar dw_preliminar
st_5 st_5
em_copias2 em_copias2
st_6 st_6
em_copias1 em_copias1
cb_2 cb_2
rb_comercial rb_comercial
rb_nacional rb_nacional
rb_extranjero rb_extranjero
cb_1 cb_1
st_12 st_12
em_copias3 em_copias3
st_1 st_1
st_moneda st_moneda
pb_imprimir_preli pb_imprimir_preli
st_13 st_13
cabecera cabecera
uo_manejo uo_manejo
gb_1 gb_1
st_7 st_7
st_cliente st_cliente
st_codcli st_codcli
st_pagina st_pagina
gb_3 gb_3
uo_1 uo_1
st_14 st_14
cajas cajas
gb_5 gb_5
em_neto em_neto
em_bruto em_bruto
st_9 st_9
st_10 st_10
st_8 st_8
em_bascula em_bascula
cbx_agrupar_ref cbx_agrupar_ref
cb_3 cb_3
end type
global w_lis_venped_proforma w_lis_venped_proforma

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli,is_envio
Dec{4}  var_total
integer lineas = 24//26
integer lnpie,contador,var_tipo

end variables

forward prototypes
public subroutine f_pagina ()
public subroutine f_proceso (integer tipo)
public subroutine f_valores (integer registro, integer tipo)
end prototypes

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")
end subroutine

public subroutine f_proceso (integer tipo);Dec{0} var_anyo,var_pedido,resto,re,var_paginas,var_ejercicio,var_numpalet
long va,va2
String  textpie[],pie,pie1,pie2,pie3,letra,var_articulo,tipo_iva,tipo_recargo,puntos,v_mascara, var_familia
String textopie2,cadena,texto_iva,texto_recargo
Integer reg,reg1
Dec{4}  var_total_cajas,var_cantidad,acumulado,dto1,impdto1,dto2,impdto2,dto3,impdto3,&
		  dto4,impdto4,dtopp,impdtopp,aculumado,dtoesp,precio,cantidad,bruto,importe,iva,recargo,importeiva,importerecargo

DateTime var_fpedido
String   var_tipo_unidad,textdto1,textdto2,textdto3,textdto4,tipodto1,&
         tipodto2,tipodto3,tipodto4,tipo_cliente,linea
			
Dec{4}   importedto1,importedto2,importedto3,importedto4,importedtopp
Int decimales_unidad
string agrupa_referencias ,ls_tarifa
string var_tono_imprimir,var_calibre_imprimir,venped_calculo_dtoesp 

if cbx_agrupar_ref.checked then
	agrupa_referencias = 'S'
else
	agrupa_referencias = 'N'
end if

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
var_pedido  = Dec(em_pedido.text)
Select dtoesp1,tipodto1,explicaciondto1,
		 dtoesp2,tipodto2,explicaciondto2,
		 dtoesp3,tipodto3,explicaciondto3,
		 dtoesp4,tipodto4,explicaciondto4,
		 dtopp,textcomercial2,textaduanaesp2,textaduanaext2,tipoiva,isnull(venped.envio,''),venped.tarifa,isnull(venped.calculo_dtoesp,'')
Into   :dto1,:tipodto1,:textdto1,
       :dto2,:tipodto2,:textdto2,
       :dto3,:tipodto3,:textdto3,
       :dto4,:tipodto4,:textdto4,:dtopp,:pie1,:pie2,:pie3,:tipo_iva,:is_envio,:ls_tarifa,:venped_calculo_dtoesp 
From   venped
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    pedido  = :var_pedido;


var_ejercicio  = var_anyo // f_ejercicio_activo(codigo_empresa)
v_mascara = f_mascara_moneda(var_moneda)

if trim(venped_calculo_dtoesp) = "" then venped_calculo_dtoesp = "N"

int li_decimales_precio
string ls_mascara_moneda_tarifa

li_decimales_precio       = f_ventarifas_decimales_precios(codigo_empresa,ls_tarifa)
ls_mascara_moneda_tarifa  = f_mascara_decimales(li_decimales_precio)

  SELECT contaiva.iva,contaiva.recargo,contaiva.descripcion  
    INTO :iva,:tipo_recargo,:texto_iva  
    FROM contaiva  
   WHERE (contaiva.ejercicio = :var_ejercicio ) AND  
         (contaiva.empresa = :codigo_empresa ) AND  
         (contaiva.tipoiva = :tipo_iva )   ;
			
  IF Not IsNull(tipo_recargo) and Trim(tipo_recargo) <> "" Then
  		SELECT  contaiva.iva,contaiva.descripcion INTO :recargo,:texto_recargo
   	 FROM   contaiva  
   	WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
      	   ( contaiva.empresa = :codigo_empresa ) AND  
         	( contaiva.tipoiva = :tipo_recargo )   ;			
  END IF


textopie2 = f_nombre1_venpiepedido(codigo_empresa,var_idioma)
lnpie = 0
CHOOSE CASE tipo
	CASE 1
		pie= pie1
	CASE 2
		pie= pie2
	CASE 3
		pie= pie3
END CHOOSE
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
IF Trim(textopie2) <> "" Then
	// Una linea en blanco entre textos
	lnpie = lnpie + 1
	textpie[lnpie] = ""
	lnpie = lnpie + 1
	textpie[lnpie] = textopie2
END IF
IF lnpie <>0 Then
	// Una linea en blanco despues de textos
	lnpie = lnpie + 1
	textpie[lnpie] = ""
END IF

//if var_moneda = "1" then
//	f_mascara_columna(dw_preliminar,"precio","###,###,##0.0")
//else
//	f_mascara_columna(dw_preliminar,"precio",ls_mascara_moneda_tarifa)
//end if
//f_mascara_columna(dw_preliminar,"total",f_mascara_moneda(var_moneda))

// Imprimir cagrupando referencias
if agrupa_referencias = 'S' then
	dw_proceso.dataobject = 'dw_proceso_venliped_dto_agrupado'
else
	dw_proceso.dataobject = 'dw_proceso_venliped_dto'
end if

f_mascara_columna(dw_preliminar,"precio",ls_mascara_moneda_tarifa)

f_mascara_columna(dw_preliminar,"total",f_mascara_moneda(var_moneda))

dw_proceso.SetTransObject(SQLCA)

string ls_tipolinea,ls_gestionar_en_piezas

reg = dw_proceso.retrieve(codigo_empresa,var_anyo,var_pedido,"S")
IF reg <> 0 Then
	For reg1 = 1 to reg
		ls_tipolinea = dw_proceso.GetItemSTring(reg1,"tipolinea")
		ls_gestionar_en_piezas = f_gestionar_en_piezas_ventipolin(codigo_empresa,ls_tipolinea)		
		
		acumulado = 0
		contador  = contador + 1
		dtoesp       = Dec(f_valor_columna(dw_proceso,contador,"dtoesp"))
		if ls_gestionar_en_piezas = "S" then
			cantidad     = Dec(f_valor_columna(dw_proceso,contador,"cantidad_pzs"))
		else
			cantidad     = Dec(f_valor_columna(dw_proceso,contador,"cantidad_facturar"))
		end if
		
		CHOOSE CASE tipo
		 CASE  3
			if ls_gestionar_en_piezas = "S" then
				precio       = dw_proceso.GetItemNumber(reg1,"precio_pzs")
			else
				precio       = dw_proceso.GetItemNumber(reg1,"precio_aduana_neto")
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
				precio       = dw_proceso.GetItemNumber(reg1,"precio_neto")
			end if
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
		
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		var_articulo = f_valor_columna(dw_proceso,reg1,"articulo")
		if not isnull(var_articulo) and var_articulo <> "" then
			if ls_gestionar_en_piezas = "S" then
				decimales_unidad = f_decimales_unidad("0")
			else
				decimales_unidad = ftc_decimales_articulo(codigo_empresa, var_articulo)
			end if
		else
			decimales_unidad = 0
		end if
		
		f_asignar_columna(dw_preliminar,contador,"pallets",f_valor_columna(dw_proceso,reg1,"pallets"))
		f_asignar_columna(dw_preliminar,contador,"cajas",f_valor_columna(dw_proceso,reg1,"cajas"))
		f_asignar_columna(dw_preliminar,contador,"piezascaja", string(dw_proceso.object.almartcajas_piezascaja[reg1]))
		f_asignar_columna(dw_preliminar,contador,"total_cajas",f_valor_columna(dw_proceso,reg1,"total_cajas"))
		f_asignar_columna(dw_preliminar,contador,"caja",f_valor_columna(dw_proceso,reg1,"caja"))
		//dw_preliminar.object.caja[contador] = String(dw_proceso.object.caja[reg])
		f_asignar_columna(dw_preliminar,contador,"articulo",var_articulo + " " +f_valor_columna(dw_proceso,reg1,"descripcion"))
		f_asignar_columna(dw_preliminar,contador,"numpalet",f_valor_columna(dw_proceso,reg1,"numpalet"))
		IF tipo <>3 Then
			f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(f_valor_columna(dw_proceso,reg1,"importe")),f_mascara_moneda(var_moneda)))
			if ls_gestionar_en_piezas = "S" then
				f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio_pzs"))
			else
				f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio_neto"))
			end if
			//f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"descuento"))
			if venped_calculo_dtoesp = "N" then
				f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"dtoesp"))
				f_asignar_columna(dw_preliminar,contador,"descuento2",f_valor_columna(dw_proceso,reg1,"dtoesp2"))
			else
				f_asignar_columna(dw_preliminar,contador,"descuento","0")
				f_asignar_columna(dw_preliminar,contador,"descuento2","0")				
			end if
		ELSE
			if ls_gestionar_en_piezas = "S" then
				f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio_pzs"))
			else
				f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio_aduana_neto"))
			end if
			f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(f_valor_columna(dw_proceso,reg1,"importe_aduana")),f_mascara_moneda(var_moneda)))
			//f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"descuento_aduana"))
			if venped_calculo_dtoesp = "N" then
				f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"dtoesp"))
				f_asignar_columna(dw_preliminar,contador,"descuento2",f_valor_columna(dw_proceso,reg1,"dtoesp2"))
			else
				f_asignar_columna(dw_preliminar,contador,"descuento","0")
				f_asignar_columna(dw_preliminar,contador,"descuento2","0")				
			end if
		END IF
		f_asignar_columna(dw_preliminar,contador,"formato",f_nombre_formato_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"formato")))
		f_asignar_columna(dw_preliminar,contador,"calidad",f_nombre_calidad_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"calidad")))
		if ls_gestionar_en_piezas = "S" then
			var_tipo_unidad="0"
			var_cantidad=Dec(f_valor_columna(dw_proceso,reg1,"cantidad_pzs"))			
		else
			var_tipo_unidad=f_valor_columna(dw_proceso,reg1,"tipo_unidad")
			var_cantidad=Dec(f_valor_columna(dw_proceso,reg1,"cantidad_facturar"))
		end if
		//f_asignar_columna(dw_preliminar,contador,"decimales_unidad",decimales_unidad)
		dw_preliminar.SetItem(contador, "decimales_unidad", decimales_unidad)
		
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad <> "1" Then
				f_asignar_columna(dw_preliminar,contador,"piezas",String(var_cantidad))
				//13-03-2017 ya no hacemos la conversion de piezas a metros
				/*
				SELECT familia INTO :var_familia FROM articulos WHERE empresa = :codigo_empresa AND codigo = :var_articulo;
				if var_familia = "2" then //WOW - Cajas completas
					f_asignar_columna(dw_preliminar,contador,"metros",string(f_calculo_metros_desde_cajas(codigo_empresa,var_articulo, String(f_valor_columna(dw_proceso,reg1,"caja")),  Dec(f_valor_columna(dw_proceso,reg1,"total_cajas"))),"###,###.00"))
				else //Calculo de metros por piezas
					f_asignar_columna(dw_preliminar,contador,"metros",string(f_calculo_metros_cuadrados(codigo_empresa,var_articulo,var_cantidad),"###,###.00"))
				end if
				*/
				//13-03-2017 ya no hacemos la conversion de piezas a metros
				f_asignar_columna(dw_preliminar,contador,"metros","0")
			ELSE
				f_asignar_columna(dw_preliminar,contador,"piezas",string(f_convertir_m2_a_piezas_articulo_caja(codigo_empresa,var_articulo,f_valor_columna(dw_proceso,reg1,"caja"),var_cantidad),"#####0"))
				f_asignar_columna(dw_preliminar,contador,"metros",String(var_cantidad))
			END IF
		ELSE
			f_asignar_columna(dw_preliminar,contador,"piezas","0")
			f_asignar_columna(dw_preliminar,contador,"metros","0")
			f_asignar_columna(dw_preliminar,contador,"articulo",String(var_cantidad,"####")+ " " + f_valor_columna(dw_proceso,reg1,"descripcion"))
		END IF
		IF tipo <>3 then
			var_total = var_total + Dec(f_valor_columna(dw_proceso,reg1,"importe"))
		ELSE
			var_total = var_total + Dec(f_valor_columna(dw_proceso,reg1,"importe_aduana"))
		END IF
		
	Next
	IF contador <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
      f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador - 1,"raya","1")
		f_asignar_columna(dw_preliminar,contador,"texto",f_diccionario("TOTAL BRUTO",var_idioma) + puntos)
		f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
	END IF
END IF


IF importedto1 <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(dto1,"##.##0") + "% " +textdto1+puntos )

		f_asignar_columna(dw_preliminar,contador,"importe","-" + String(Dec(importedto1),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		importedto1 = round(importedto1,2)
		var_total = var_total - importedto1
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF
IF importedto2 <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(dto2,"##.##0") + "% " +textdto2+puntos)

		f_asignar_columna(dw_preliminar,contador,"importe","-" + String(Dec(importedto2),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		importedto2 = round(importedto2,2)
		var_total = var_total - importedto2
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF

IF importedto3 <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(dto3,"##.##0") + "% " +textdto3+puntos)
		f_asignar_columna(dw_preliminar,contador,"importe","-" + String(Dec(importedto3),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		importedto3 = round(importedto3,2)
		var_total = var_total - importedto3
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF

IF importedtopp <> 0 then //importedto4 <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(dto4,"##.##0") + "% " +textdto4+puntos)
		f_asignar_columna(dw_preliminar,contador,"importe","-" + String(Dec(importedtopp),f_mascara_moneda(var_moneda))) //String(Dec(importedto4),f_mascara_moneda(var_moneda))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		importedtopp = round(importedtopp,2) //importedto4 = round(importedto4,2)
		var_total = var_total - importedtopp // var_total = var_total - importedto4
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF

reg = dw_proceso.retrieve(codigo_empresa,var_anyo,var_pedido,"N")
IF reg <> 0 Then
	For reg1 = 1 to reg
		contador  = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		
		ls_tipolinea = dw_proceso.GetItemSTring(reg1,"tipolinea")
		ls_gestionar_en_piezas = f_gestionar_en_piezas_ventipolin(codigo_empresa,ls_tipolinea)				
		
		var_articulo = f_valor_columna(dw_proceso,reg1,"articulo")
		f_asignar_columna(dw_preliminar,contador,"pallets",f_valor_columna(dw_proceso,reg1,"pallets"))
		f_asignar_columna(dw_preliminar,contador,"cajas",f_valor_columna(dw_proceso,reg1,"cajas"))
		f_asignar_columna(dw_preliminar,contador,"piezascaja", string(dw_proceso.object.almartcajas_piezascaja[reg1]))
		f_asignar_columna(dw_preliminar,contador,"total_cajas",f_valor_columna(dw_proceso,reg1,"total_cajas"))
		f_asignar_columna(dw_preliminar,contador,"articulo",f_valor_columna(dw_proceso,reg1,"descripcion"))
		if ls_gestionar_en_piezas = "S" then
			f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio_pzs"))
		else
			f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio"))
		end if
		//f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"descuento"))
		if venped_calculo_dtoesp = "N" then
			f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"dtoesp"))
			f_asignar_columna(dw_preliminar,contador,"descuento2",f_valor_columna(dw_proceso,reg1,"dtoesp2"))
		else
			f_asignar_columna(dw_preliminar,contador,"descuento","0")
			f_asignar_columna(dw_preliminar,contador,"descuento2","0")			
		end if
		f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(f_valor_columna(dw_proceso,reg1,"importe")),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"formato",f_nombre_formato_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"formato")))
		f_asignar_columna(dw_preliminar,contador,"calidad",f_nombre_calidad_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"calidad")))
		f_asignar_columna(dw_preliminar,contador,"numpalet",f_valor_columna(dw_proceso,reg1,"numpalet"))
		if ls_gestionar_en_piezas = "S" then
			var_tipo_unidad="0"
			var_cantidad=Dec(f_valor_columna(dw_proceso,reg1,"cantidad_pzs"))			
		else
			var_tipo_unidad=f_valor_columna(dw_proceso,reg1,"tipo_unidad")
			var_cantidad=Dec(f_valor_columna(dw_proceso,reg1,"cantidad_facturar"))
		end if
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad <> "1" Then
				f_asignar_columna(dw_preliminar,contador,"piezas",String(var_cantidad))
				//13-03-2017 ya no hacemos la conversion de piezas a metros
				/*				
				SELECT familia INTO :var_familia FROM articulos WHERE empresa = :codigo_empresa AND codigo = :var_articulo;
				if var_familia = "2" then //WOW - Cajas completas
					f_asignar_columna(dw_preliminar,contador,"metros",string(f_calculo_metros_desde_cajas(codigo_empresa,var_articulo, String(f_valor_columna(dw_proceso,reg1,"caja")),  Dec(f_valor_columna(dw_proceso,reg1,"total_cajas"))),"###,###.00"))
				else //Calculo de metros por piezas
					f_asignar_columna(dw_preliminar,contador,"metros",string(f_calculo_metros_cuadrados(codigo_empresa,var_articulo,var_cantidad),"###,###.00"))
				end if
				*/
				//13-03-2017 ya no hacemos la conversion de piezas a metros
				f_asignar_columna(dw_preliminar,contador,"metros","0")
			ELSE
				f_asignar_columna(dw_preliminar,contador,"piezas",string(f_convertir_m2_a_piezas_articulo_caja(codigo_empresa,var_articulo,f_valor_columna(dw_proceso,reg1,"caja"),var_cantidad),"#####0"))
				f_asignar_columna(dw_preliminar,contador,"metros",String(var_cantidad))
			END IF
		ELSE
			// Modificacion según Carlos
			//f_asignar_columna(dw_preliminar,contador,"articulo",String(var_cantidad,"####")+ " " + f_valor_columna(dw_proceso,reg1,"descripcion"))
	   	f_asignar_columna(dw_preliminar,contador,"articulo",f_valor_columna(dw_proceso,reg1,"descripcion"))
			f_asignar_columna(dw_preliminar,contador,"metros","0")
	   	f_asignar_columna(dw_preliminar,contador,"piezas","0")
		END IF
	var_total = var_total + dw_proceso.GetItemNumber(reg1,"importe")
   impdtopp =  Dec(string(dw_proceso.GetItemNumber(reg1,"importe") * dtopp / 100,v_mascara))
   importedtopp = importedtopp + impdtopp			 
	Next
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
      f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador - 1,"raya","1")
		f_asignar_columna(dw_preliminar,contador,"texto","")
		f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF

/*
IF importedtopp <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(dtopp,"##.0") + "% " +f_diccionario("PRONTO PAGO",var_idioma)+puntos)
		IF importedtopp > 0 Then
			f_asignar_columna(dw_preliminar,contador,"importe","-" + String(importedtopp,f_mascara_moneda(var_moneda)))
		ELSE
			f_asignar_columna(dw_preliminar,contador,"importe", + String(importedtopp * (-1),f_mascara_moneda(var_moneda)))
		END IF
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		importedtopp = round(importedtopp,2)
		var_total = var_total - importedtopp
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF
*/


IF IsNull(iva)     Then iva = 0
IF IsNull(recargo) Then recargo = 0
importeiva      = Dec(String(var_total * iva / 100,v_mascara))
importerecargo  = Dec(String(var_total * recargo / 100,v_mascara))
IF importeiva <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(iva,"##.0") + "% " +texto_iva+puntos)
		f_asignar_columna(dw_preliminar,contador,"importe"," " + String(Dec(importeiva),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		importeiva = round(importeiva,2)
		var_total = var_total + importeiva
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF
IF importerecargo <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(recargo,"##.0") + "% " +texto_recargo+puntos)
		f_asignar_columna(dw_preliminar,contador,"importe"," " + String(Dec(importerecargo),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		importerecargo = round(importerecargo,2)
		var_total = var_total + importerecargo
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
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
		f_asignar_columna(dw_preliminar,contador,"textopie",textpie[reg1])
		f_asignar_columna(dw_preliminar,contador,"orden","2")

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
		f_asignar_columna(dw_preliminar,contador,"textopie",textpie[reg1])
		f_asignar_columna(dw_preliminar,contador,"orden","2")
	NEXT
	
END IF

		
f_asignar_columna(dw_preliminar,contador,"texto_total",&
                  f_textopie2_venped(codigo_empresa,var_anyo,var_pedido) +&
						"  "+f_nombre_moneda_abr(var_moneda) + "  #" +&
						String(var_total,f_mascara_moneda(var_moneda))+"#")
f_asignar_columna(dw_preliminar,contador,"ultima","S")
end subroutine

public subroutine f_valores (integer registro, integer tipo);Dec{0} var_anyo,var_pedido
String var_cliente,texto1,texto2,texto3,texto,var_serie,vid
Datetime var_fpedido
var_anyo     = Dec(em_anyo.text)
var_pedido = Dec(em_pedido.text)
SELECT venped.fpedido,   
       venped.cliente,   
       venped.textcomercial1,
       venped.textaduanaesp1,
       venped.textaduanaext1,
       venped.serie
INTO :var_fpedido,   
     :var_cliente,   
	  :texto1,
	  :texto2,
	  :texto3,
	  :var_serie
	  FROM venped  
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    pedido= :var_pedido;

CHOOSE CASE tipo
	CASE 1
		texto = texto1
	CASE 2
		texto = texto2
	CASE 3
		texto = texto3
END CHOOSE

      IF cabecera.text = "Si" Then
			f_asignar_columna(dw_preliminar,registro,"ver_cabecera","S")
		ELSE
			f_asignar_columna(dw_preliminar,registro,"ver_cabecera","N")
		END IF
		   IF cajas.text = "Si" Then
			f_asignar_columna(dw_preliminar,registro,"ver_cajas","S")
		ELSE
			f_asignar_columna(dw_preliminar,registro,"ver_cajas","N")
		END IF
		vid = var_idioma
      if Trim(var_idioma) = "1" Then vid="3"
		
		f_asignar_columna(dw_preliminar,registro,"envio",is_envio)
		dw_preliminar.SetItem(registro,"fpedido",var_fpedido)
		f_asignar_columna(dw_preliminar,registro,"texto_cabecera",texto)
		f_asignar_columna(dw_preliminar,registro,"tipo",String(tipo))
		f_asignar_columna(dw_preliminar,registro,"empresa",codigo_empresa)
		f_asignar_columna(dw_preliminar,registro,"anyo",String(var_anyo))
		f_asignar_columna(dw_preliminar,registro,"pedido",String(var_pedido))
		f_asignar_columna(dw_preliminar,registro,"idioma",var_idioma)
		f_asignar_columna(dw_preliminar,registro,"vid",vid)
		f_asignar_columna(dw_preliminar,registro,"serie",var_serie)
		f_asignar_columna(dw_preliminar,registro,"moneda",var_moneda)
		f_asignar_columna(dw_preliminar,registro,"cliente",var_cliente)
		f_asignar_columna(dw_preliminar,registro,"total",String(var_total))
		  
		dw_preliminar.object.var_peso_neto[registro]  = dec(em_neto.text)
      
		if em_bascula.text <> "" and dec(em_bascula.text) > 0 then
			dw_preliminar.object.var_peso_bruto[registro] = dec(em_bascula.text)
		else
			dw_preliminar.object.var_peso_bruto[registro] = dec(em_bruto.text)
		end if
		
		IF Int(registro/lineas)  * lineas = registro Then 
			f_asignar_columna(dw_preliminar,registro,"fin","1")
		ELSE
			f_asignar_columna(dw_preliminar,registro,"fin","2")
		END IF
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Listado pedidos formato proformas"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))
rb_comercial.checked = TRUE
var_tipo = 1
istr_parametros = Message.PowerObjectParm
IF istr_parametros.i_nargumentos>1 THEN
     em_anyo.text     = istr_parametros.s_argumentos[2]	
     em_pedido.text = istr_parametros.s_argumentos[3]	
	  em_pedido.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
END IF
cabecera.text = "Si"
cajas.text = "Si"



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

on w_lis_venped_proforma.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_pedido=create em_pedido
this.st_3=create st_3
this.st_4=create st_4
this.st_idioma=create st_idioma
this.dw_proceso=create dw_proceso
this.dw_preliminar=create dw_preliminar
this.st_5=create st_5
this.em_copias2=create em_copias2
this.st_6=create st_6
this.em_copias1=create em_copias1
this.cb_2=create cb_2
this.rb_comercial=create rb_comercial
this.rb_nacional=create rb_nacional
this.rb_extranjero=create rb_extranjero
this.cb_1=create cb_1
this.st_12=create st_12
this.em_copias3=create em_copias3
this.st_1=create st_1
this.st_moneda=create st_moneda
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_13=create st_13
this.cabecera=create cabecera
this.uo_manejo=create uo_manejo
this.gb_1=create gb_1
this.st_7=create st_7
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.st_pagina=create st_pagina
this.gb_3=create gb_3
this.uo_1=create uo_1
this.st_14=create st_14
this.cajas=create cajas
this.gb_5=create gb_5
this.em_neto=create em_neto
this.em_bruto=create em_bruto
this.st_9=create st_9
this.st_10=create st_10
this.st_8=create st_8
this.em_bascula=create em_bascula
this.cbx_agrupar_ref=create cbx_agrupar_ref
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_pedido
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_idioma
this.Control[iCurrent+8]=this.dw_proceso
this.Control[iCurrent+9]=this.dw_preliminar
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.em_copias2
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.em_copias1
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.rb_comercial
this.Control[iCurrent+16]=this.rb_nacional
this.Control[iCurrent+17]=this.rb_extranjero
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.st_12
this.Control[iCurrent+20]=this.em_copias3
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.st_moneda
this.Control[iCurrent+23]=this.pb_imprimir_preli
this.Control[iCurrent+24]=this.st_13
this.Control[iCurrent+25]=this.cabecera
this.Control[iCurrent+26]=this.uo_manejo
this.Control[iCurrent+27]=this.gb_1
this.Control[iCurrent+28]=this.st_7
this.Control[iCurrent+29]=this.st_cliente
this.Control[iCurrent+30]=this.st_codcli
this.Control[iCurrent+31]=this.st_pagina
this.Control[iCurrent+32]=this.gb_3
this.Control[iCurrent+33]=this.uo_1
this.Control[iCurrent+34]=this.st_14
this.Control[iCurrent+35]=this.cajas
this.Control[iCurrent+36]=this.gb_5
this.Control[iCurrent+37]=this.em_neto
this.Control[iCurrent+38]=this.em_bruto
this.Control[iCurrent+39]=this.st_9
this.Control[iCurrent+40]=this.st_10
this.Control[iCurrent+41]=this.st_8
this.Control[iCurrent+42]=this.em_bascula
this.Control[iCurrent+43]=this.cbx_agrupar_ref
this.Control[iCurrent+44]=this.cb_3
end on

on w_lis_venped_proforma.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_pedido)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_idioma)
destroy(this.dw_proceso)
destroy(this.dw_preliminar)
destroy(this.st_5)
destroy(this.em_copias2)
destroy(this.st_6)
destroy(this.em_copias1)
destroy(this.cb_2)
destroy(this.rb_comercial)
destroy(this.rb_nacional)
destroy(this.rb_extranjero)
destroy(this.cb_1)
destroy(this.st_12)
destroy(this.em_copias3)
destroy(this.st_1)
destroy(this.st_moneda)
destroy(this.pb_imprimir_preli)
destroy(this.st_13)
destroy(this.cabecera)
destroy(this.uo_manejo)
destroy(this.gb_1)
destroy(this.st_7)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.st_pagina)
destroy(this.gb_3)
destroy(this.uo_1)
destroy(this.st_14)
destroy(this.cajas)
destroy(this.gb_5)
destroy(this.em_neto)
destroy(this.em_bruto)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_8)
destroy(this.em_bascula)
destroy(this.cbx_agrupar_ref)
destroy(this.cb_3)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_venped_proforma
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_venped_proforma
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_pedido)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_venped_proforma
integer x = 37
integer y = 8
integer width = 3305
integer height = 96
end type

type pb_1 from upb_salir within w_lis_venped_proforma
integer x = 3570
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_2 from statictext within w_lis_venped_proforma
integer x = 14
integer y = 164
integer width = 206
integer height = 68
boolean bringtotop = true
integer textsize = -8
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

type em_anyo from u_em_campo within w_lis_venped_proforma
integer x = 242
integer y = 152
integer width = 192
integer taborder = 0
end type

type em_pedido from u_em_campo within w_lis_venped_proforma
integer x = 475
integer y = 152
integer width = 210
integer taborder = 30
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######"
string displaydata = "Ä"
end type

event modificado;dec var_peso_neto,var_peso_bruto, var_peso_bascula

var_idioma      = f_idioma_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
var_moneda      = f_divisa_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
var_tipocli     = "S"
var_codcli      = f_cliente_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
var_peso_neto   = f_peso_neto_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
var_peso_bruto  = f_peso_bruto_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
//var_peso_bascula =  ftc_peso_bascula_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
st_idioma.text  = f_nombre_idioma(var_idioma)
st_moneda.text  = f_nombre_moneda(var_moneda)
st_codcli.text  = var_codcli

st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)
em_neto.text    = string(var_peso_neto,"###,###,##0")
em_bruto.text   = string(var_peso_bruto,"###,###,##0")
//em_bascula.text   = string(var_peso_bascula,"###,##0")
call super::modificado
end event

type st_3 from statictext within w_lis_venped_proforma
integer x = 434
integer y = 128
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

type st_4 from statictext within w_lis_venped_proforma
integer x = 27
integer y = 348
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
string text = "Idioma:"
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_idioma from statictext within w_lis_venped_proforma
integer x = 329
integer y = 348
integer width = 686
integer height = 80
boolean bringtotop = true
integer textsize = -9
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

type dw_proceso from datawindow within w_lis_venped_proforma
boolean visible = false
integer x = 3378
integer y = 12
integer width = 192
integer height = 104
boolean bringtotop = true
string dataobject = "dw_proceso_venliped_dto_agrupado"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_preliminar from datawindow within w_lis_venped_proforma
boolean visible = false
integer y = 568
integer width = 3744
integer height = 2744
boolean bringtotop = true
string dataobject = "report_list_venpedido_proforma1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type st_5 from statictext within w_lis_venped_proforma
integer x = 1193
integer y = 240
integer width = 457
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
string text = "Aduana Nacional:"
boolean focusrectangle = false
end type

type em_copias2 from editmask within w_lis_venped_proforma
integer x = 1655
integer y = 224
integer width = 174
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string displaydata = "~r˜pbedit050"
double increment = 1
end type

event getfocus;this.selectText(1,2)
end event

type st_6 from statictext within w_lis_venped_proforma
integer x = 1157
integer y = 140
integer width = 489
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Copias  Comercial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_copias1 from editmask within w_lis_venped_proforma
integer x = 1655
integer y = 128
integer width = 174
integer height = 88
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

type cb_2 from u_boton within w_lis_venped_proforma
event clicked pbm_bnclicked
integer x = 2167
integer y = 160
integer width = 306
integer height = 92
integer taborder = 120
string text = "&Imprimir"
end type

event clicked;call super::clicked;if len(em_pedido.text)=0 then
	MessageBox("Introduzca la pedido","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_pedido)
	Return
End if

var_idioma = f_idioma_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
var_moneda = f_divisa_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
st_idioma.text  = f_nombre_idioma(var_idioma)
st_moneda.text  = f_nombre_moneda(var_moneda)
dw_preliminar.visible= FALSE
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE

IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
 dw_preliminar.reset()
 f_proceso(1)
 dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)
 dw_preliminar.Print(TRUE)
END IF
IF em_copias2.text <> "0" and Trim(em_copias2.text) <> "" Then
 dw_preliminar.reset()
 f_proceso(2)
 dw_preliminar.Modify(" datawindow.print.copies = "+em_copias2.text)
 dw_preliminar.Print(TRUE)
END IF
IF em_copias3.text <> "0" and Trim(em_copias3.text) <> "" Then
 dw_preliminar.reset()
 f_proceso(3)
 dw_preliminar.Modify(" datawindow.print.copies = "+em_copias3.text)
 dw_preliminar.Print(TRUE)
END IF
f_activar_campo(em_pedido)


end event

type rb_comercial from radiobutton within w_lis_venped_proforma
integer x = 3296
integer y = 204
integer width = 357
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Comercial"
boolean lefttext = true
end type

event clicked;rb_comercial.Checked = FALSE
rb_nacional.Checked = FALSE
rb_extranjero.Checked = False

This.Checked = TRUE
var_tipo = 1
end event

type rb_nacional from radiobutton within w_lis_venped_proforma
integer x = 3296
integer y = 260
integer width = 357
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Nacional"
boolean lefttext = true
end type

event clicked;rb_comercial.Checked = FALSE
rb_nacional.Checked = FALSE
rb_extranjero.Checked = False

This.Checked = TRUE
var_tipo = 2
end event

type rb_extranjero from radiobutton within w_lis_venped_proforma
integer x = 3296
integer y = 320
integer width = 357
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Extranjero"
boolean lefttext = true
end type

event clicked;rb_comercial.Checked = FALSE
rb_nacional.Checked = FALSE
rb_extranjero.Checked = False

This.Checked = TRUE
var_tipo = 3
end event

type cb_1 from u_boton within w_lis_venped_proforma
integer x = 3273
integer y = 124
integer width = 384
integer height = 72
integer taborder = 130
boolean bringtotop = true
string text = "&Preliminar"
end type

event clicked;call super::clicked;if len(em_pedido.text)=0 then
	MessageBox("Introduzca la pedido","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_pedido)
	Return
End if

f_activar_campo(em_pedido)

em_pedido.TriggerEvent("modificado")
dw_preliminar.visible= FALSE
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE
dw_preliminar.reset()
dw_preliminar.SetRedraw(FALSE)
f_proceso(var_tipo)
f_pagina()
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "75" + ")")
dw_preliminar.visible= TRUE
uo_manejo.visible = TRUE
pb_imprimir_preli.visible = TRUE
dw_preliminar.SetRedraw(TRUE)


end event

type st_12 from statictext within w_lis_venped_proforma
integer x = 1152
integer y = 332
integer width = 494
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Aduana Extranjera:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_copias3 from editmask within w_lis_venped_proforma
integer x = 1655
integer y = 320
integer width = 174
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string displaydata = "~r˜pbedit050"
double increment = 1
end type

event getfocus;this.selectText(1,2)
end event

type st_1 from statictext within w_lis_venped_proforma
integer x = 27
integer y = 268
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
string text = "Moneda:"
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_moneda from statictext within w_lis_venped_proforma
integer x = 329
integer y = 268
integer width = 686
integer height = 80
boolean bringtotop = true
integer textsize = -9
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

type pb_imprimir_preli from picturebutton within w_lis_venped_proforma
boolean visible = false
integer x = 3621
integer y = 436
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
string picturename = "print!"
end type

event clicked;OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_pedido)
end event

type st_13 from statictext within w_lis_venped_proforma
integer x = 1874
integer y = 224
integer width = 251
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
string text = "Cabecera"
boolean focusrectangle = false
end type

type cabecera from dropdownlistbox within w_lis_venped_proforma
integer x = 1911
integer y = 292
integer width = 192
integer height = 220
integer taborder = 80
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

type uo_manejo from u_manejo_datawindow within w_lis_venped_proforma
boolean visible = false
integer x = 3136
integer y = 392
integer width = 599
integer height = 160
end type

event valores;call super::valores;dw_data =dw_preliminar
f_pagina()
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_1 from groupbox within w_lis_venped_proforma
integer x = 3246
integer y = 84
integer width = 439
integer height = 300
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_7 from statictext within w_lis_venped_proforma
integer x = 27
integer y = 428
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

type st_cliente from statictext within w_lis_venped_proforma
integer x = 535
integer y = 428
integer width = 1129
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

type st_codcli from statictext within w_lis_venped_proforma
integer x = 329
integer y = 428
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

type st_pagina from statictext within w_lis_venped_proforma
integer x = 1678
integer y = 428
integer width = 302
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

type gb_3 from groupbox within w_lis_venped_proforma
integer x = 5
integer y = 80
integer width = 2491
integer height = 460
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type uo_1 from u_selec_impresoras within w_lis_venped_proforma
integer x = 23
integer y = 628
integer taborder = 90
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type st_14 from statictext within w_lis_venped_proforma
integer x = 709
integer y = 152
integer width = 119
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
string text = "Pl/Cj"
boolean focusrectangle = false
end type

type cajas from dropdownlistbox within w_lis_venped_proforma
integer x = 832
integer y = 152
integer width = 192
integer height = 220
integer taborder = 40
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

type gb_5 from groupbox within w_lis_venped_proforma
integer x = 2555
integer y = 112
integer width = 434
integer height = 408
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type em_neto from editmask within w_lis_venped_proforma
integer x = 2624
integer y = 312
integer width = 293
integer height = 68
integer taborder = 110
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0"
end type

event getfocus;this.SelectText (1,len(this.text))
end event

type em_bruto from editmask within w_lis_venped_proforma
integer x = 2624
integer y = 196
integer width = 293
integer height = 68
integer taborder = 100
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0"
end type

event getfocus;this.SelectText (1,len(this.text))

end event

type st_9 from statictext within w_lis_venped_proforma
integer x = 2583
integer y = 148
integer width = 242
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Peso Bruto"
boolean focusrectangle = false
end type

type st_10 from statictext within w_lis_venped_proforma
integer x = 2583
integer y = 268
integer width = 219
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Peso Neto"
boolean focusrectangle = false
end type

type st_8 from statictext within w_lis_venped_proforma
boolean visible = false
integer x = 2583
integer y = 388
integer width = 393
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Peso Bascula (KG)"
boolean focusrectangle = false
end type

type em_bascula from editmask within w_lis_venped_proforma
boolean visible = false
integer x = 2624
integer y = 436
integer width = 293
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,##0"
end type

event modified;Int existe, anyo
String pedido
Dec peso

anyo = integer(em_anyo.text)
pedido = em_pedido.text
peso = dec(em_bascula.text)

existe = 0
SELECT COUNT(*) INTO :existe FROM venped WHERE empresa = :codigo_empresa AND anyo = :anyo AND pedido = :pedido;
if not isnull(existe) and existe = 1 then
	if peso = 0 then
		UPDATE venped SET peso_bascula_kg = NULL WHERE empresa = :codigo_empresa AND anyo = :anyo AND pedido = :pedido;
	else
		UPDATE venped SET peso_bascula_kg = :peso WHERE empresa = :codigo_empresa AND anyo = :anyo AND pedido = :pedido;
	end if
end if
end event

event getfocus;this.SelectText (1,len(this.text))
end event

type cbx_agrupar_ref from checkbox within w_lis_venped_proforma
integer x = 1801
integer y = 428
integer width = 677
integer height = 80
boolean bringtotop = true
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

type cb_3 from u_boton within w_lis_venped_proforma
integer x = 2167
integer y = 276
integer width = 306
integer height = 92
integer taborder = 130
boolean bringtotop = true
string text = "&PDF"
end type

event clicked;call super::clicked;int li_rc,li_return
string ls_file, ls_path, ls_folderfile
string anyo, pedido, cliente, tipo

if len(em_pedido.text)=0 then
	MessageBox("Introduzca la pedido","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_pedido)
	Return
End if

var_idioma = f_idioma_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
var_moneda = f_divisa_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
st_idioma.text  = f_nombre_idioma(var_idioma)
st_moneda.text  = f_nombre_moneda(var_moneda)
dw_preliminar.visible= FALSE
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE

anyo = em_anyo.text
pedido = em_pedido.text

tipo = 'Prof'

SELECT isnull(razon,'')
INTO :cliente
FROM venped 
inner join (select * from genter where tipoter = 'C') as genter on genter.empresa = venped.empresa and genter.codigo = venped.cliente
Where  venped.empresa = :codigo_empresa
And    anyo    = :anyo
And    pedido= :pedido;

long ll_aux

for ll_aux=1 to len(cliente)
	
	if mid(cliente,ll_aux,1)="." then
		cliente = replace(cliente,ll_aux,1, "")	
	end if
	
	if mid(cliente,ll_aux,1)="/" then
		cliente = replace(cliente,ll_aux,1, " ")	
	end if
next


IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
 dw_preliminar.reset()
 f_proceso(1)
 dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)

 ls_file = ""
 
 ls_path = "\\amazonas\usuarios\COMERCIAL\WOW\aaaaaPEDIDOS Y PROFORMAS\2021 Enero-"
 
 //li_rc = GetFileSaveName ( "Selecciona una carpeta", &
 //  		ls_path, ls_file, "PDF")
 
 ls_folderfile = ls_path + "\"+pedido+" "+cliente+" "+tipo
				
 dw_preliminar.Object.DataWindow.Export.PDF.Method = NativePDF!
 li_return = dw_preliminar.SaveAs(ls_folderfile, PDF!, false)
 
 if li_return <> 1 then 
	messagebox("Error","Ha ocurrido un error")
 else
	messagebox("Exito","Se ha guardado el archivo "+ls_folderfile+".pdf")
 end if
 
END IF
 
IF em_copias2.text <> "0" and Trim(em_copias2.text) <> "" Then
 dw_preliminar.reset()
 f_proceso(2)
 dw_preliminar.Modify(" datawindow.print.copies = "+em_copias2.text)
 ls_file = ""
 
 ls_path = "\\amazonas\usuarios\COMERCIAL\WOW\aaaaaPEDIDOS Y PROFORMAS\2021 Enero-"
 
 //li_rc = GetFileSaveName ( "Selecciona una carpeta", &
 //  		ls_path, ls_file, "PDF")
 
 ls_folderfile = ls_path + "\"+pedido+" "+cliente+" "+tipo
				
 dw_preliminar.Object.DataWindow.Export.PDF.Method = NativePDF!
 li_return = dw_preliminar.SaveAs(ls_folderfile, PDF!, false)
 
 if li_return <> 1 then 
	messagebox("Error","Ha ocurrido un error")
 else
	messagebox("Exito","Se ha guardado el archivo "+ls_folderfile+".pdf")
 end if
end if
IF em_copias3.text <> "0" and Trim(em_copias3.text) <> "" Then
 dw_preliminar.reset()
 f_proceso(3)
 dw_preliminar.Modify(" datawindow.print.copies = "+em_copias3.text)
  ls_file = ""
 
 ls_path = "\\amazonas\usuarios\COMERCIAL\WOW\aaaaaPEDIDOS Y PROFORMAS\2021 Enero-"
 
 //li_rc = GetFileSaveName ( "Selecciona una carpeta", &
 //  		ls_path, ls_file, "PDF")
 
 ls_folderfile = ls_path + "\"+pedido+" "+cliente+" "+tipo
				
 dw_preliminar.Object.DataWindow.Export.PDF.Method = NativePDF!
 li_return = dw_preliminar.SaveAs(ls_folderfile, PDF!, false)
 
 if li_return <> 1 then 
	messagebox("Error","Ha ocurrido un error")
 else
	messagebox("Exito","Se ha guardado el archivo "+ls_folderfile+".pdf")
 end if
 
END IF
f_activar_campo(em_pedido)


end event

