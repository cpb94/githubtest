$PBExportHeader$w_lis_venproformas.srw
forward
global type w_lis_venproformas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_venproformas
end type
type st_2 from statictext within w_lis_venproformas
end type
type em_anyo from u_em_campo within w_lis_venproformas
end type
type em_proforma from u_em_campo within w_lis_venproformas
end type
type st_3 from statictext within w_lis_venproformas
end type
type st_4 from statictext within w_lis_venproformas
end type
type st_idioma from statictext within w_lis_venproformas
end type
type dw_proceso from datawindow within w_lis_venproformas
end type
type dw_preliminar from datawindow within w_lis_venproformas
end type
type st_5 from statictext within w_lis_venproformas
end type
type em_copias2 from editmask within w_lis_venproformas
end type
type st_6 from statictext within w_lis_venproformas
end type
type em_copias1 from editmask within w_lis_venproformas
end type
type cb_2 from u_boton within w_lis_venproformas
end type
type rb_comercial from radiobutton within w_lis_venproformas
end type
type rb_nacional from radiobutton within w_lis_venproformas
end type
type rb_extranjero from radiobutton within w_lis_venproformas
end type
type cb_1 from u_boton within w_lis_venproformas
end type
type st_12 from statictext within w_lis_venproformas
end type
type em_copias3 from editmask within w_lis_venproformas
end type
type st_1 from statictext within w_lis_venproformas
end type
type st_moneda from statictext within w_lis_venproformas
end type
type pb_imprimir_preli from picturebutton within w_lis_venproformas
end type
type st_13 from statictext within w_lis_venproformas
end type
type cabecera from dropdownlistbox within w_lis_venproformas
end type
type uo_manejo from u_manejo_datawindow within w_lis_venproformas
end type
type gb_1 from groupbox within w_lis_venproformas
end type
type st_7 from statictext within w_lis_venproformas
end type
type st_cliente from statictext within w_lis_venproformas
end type
type st_codcli from statictext within w_lis_venproformas
end type
type st_pagina from statictext within w_lis_venproformas
end type
type uo_1 from u_selec_impresoras within w_lis_venproformas
end type
type cajas from dropdownlistbox within w_lis_venproformas
end type
type st_15 from statictext within w_lis_venproformas
end type
type gb_3 from groupbox within w_lis_venproformas
end type
end forward

global type w_lis_venproformas from w_int_con_empresa
integer width = 3735
integer height = 3404
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_proforma em_proforma
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
uo_1 uo_1
cajas cajas
st_15 st_15
gb_3 gb_3
end type
global w_lis_venproformas w_lis_venproformas

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli
Dec{4}  var_total
integer lineas = 27
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

public subroutine f_proceso (integer tipo);Dec{0} var_anyo,var_proforma,resto,re,var_paginas,var_ejercicio
long va,va2
String  textpie[],pie,pie1,pie2,pie3,letra,var_articulo,tipo_iva,tipo_recargo,puntos,mascara
String textopie2,cadena,texto_iva,texto_recargo
Integer reg,reg1
Dec{4}  var_cantidad,acumulado,dto1,impdto1,dto2,impdto2,dto3,impdto3,&
		  dto4,impdto4,dtopp,impdtopp,aculumado,dtoesp,precio,cantidad,bruto,importe,iva,recargo,importeiva,importerecargo

DateTime var_fproforma
String   var_tipo_unidad,textdto1,textdto2,textdto3,textdto4,tipodto1,&
         tipodto2,tipodto3,tipodto4,tipo_cliente,linea,var_caja
			
Dec{4}   importedto1,importedto2,importedto3,importedto4,importedtopp
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
var_proforma  = Dec(em_proforma.text)
Select dtoesp1,tipodto1,explicaciondto1,
		 dtoesp2,tipodto2,explicaciondto2,
		 dtoesp3,tipodto3,explicaciondto3,
		 dtoesp4,tipodto4,explicaciondto4,
		 dtopp,textcomercial2,textaduanaesp2,
		 textaduanaext2,tipoiva,idioma,divisa
Into   :dto1,:tipodto1,:textdto1,
       :dto2,:tipodto2,:textdto2,
       :dto3,:tipodto3,:textdto3,
       :dto4,:tipodto4,:textdto4,:dtopp,
		 :pie1,:pie2,:pie3,:tipo_iva,:var_idioma,:var_moneda
From   venproformas
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    proforma= :var_proforma;
var_ejercicio = f_ejercicio_activo(codigo_empresa)
mascara = f_mascara_moneda(var_moneda)

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


//textopie2 = f_nombre1_venpieproforma(codigo_empresa,var_idioma)
textopie2 = ""
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
	f_contador_procesos(va,va2)
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


f_mascara_columna(dw_preliminar,"precio",mascara)
f_mascara_columna(dw_preliminar,"total",mascara)
reg = dw_proceso.retrieve(codigo_empresa,var_anyo,var_proforma,"S")
IF reg <> 0 Then
	For reg1 = 1 to reg
		f_contador_procesos(reg1,reg)
		acumulado = 0
		contador  = contador + 1
		tipo_cliente = f_valor_columna(dw_proceso,reg1,"tipo_cliente")
		dtoesp       = Dec(f_valor_columna(dw_proceso,contador,"dtoesp"))
		cantidad     = Dec(f_valor_columna(dw_proceso,contador,"cantidad"))
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
			precio       = dw_proceso.GetItemNumber(reg1,"precio_neto")
			bruto        = dw_proceso.GetItemNumber(reg1,"importe")
			impdtopp     = dw_proceso.GetItemNumber(reg1,"impdtopp")
			impdto1      = dw_proceso.GetItemNumber(reg1,"impdtoesp1")
			impdto2      = dw_proceso.GetItemNumber(reg1,"impdtoesp2")			
			impdto3      = dw_proceso.GetItemNumber(reg1,"impdtoesp3")
			impdto4      = dw_proceso.GetItemNumber(reg1,"impdtoesp4")
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
		f_asignar_columna(dw_preliminar,contador,"pallets",f_valor_columna(dw_proceso,reg1,"pallets"))
		f_asignar_columna(dw_preliminar,contador,"cajas",f_valor_columna(dw_proceso,reg1,"cajas"))
		f_asignar_columna(dw_preliminar,contador,"total_cajas",f_valor_columna(dw_proceso,reg1,"total_cajas"))
		f_asignar_columna(dw_preliminar,contador,"articulo",f_valor_columna(dw_proceso,reg1,"descripcion"))
		IF tipo <>3 Then
			f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(f_valor_columna(dw_proceso,reg1,"importe")),f_mascara_moneda(var_moneda)))
			f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio_neto"))
			f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"descuento"))
		ELSE
			f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio_aduana_neto"))
			f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(f_valor_columna(dw_proceso,reg1,"importe_aduana")),f_mascara_moneda(var_moneda)))
			f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"descuento_aduana"))
		END IF
		f_asignar_columna(dw_preliminar,contador,"formato",f_nombre_formato_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"formato")))
		f_asignar_columna(dw_preliminar,contador,"calidad",f_nombre_calidad_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"calidad")))
		var_tipo_unidad=f_valor_columna(dw_proceso,reg1,"tipo_unidad")
		var_caja = f_valor_columna(dw_proceso,reg1,"caja")
		var_cantidad=Dec(f_valor_columna(dw_proceso,reg1,"cantidad"))
		f_asignar_columna(dw_preliminar,contador,"tipo_unidad",var_tipo_unidad)
   	f_asignar_columna(dw_preliminar,contador,"caja",var_caja)
		
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad= "0" Then
				f_asignar_columna(dw_preliminar,contador,"piezas",String(var_cantidad))
				// Calcula los metros de las piezas
				dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_piezas(codigo_empresa,var_articulo,var_caja,var_cantidad))
			ELSE
				f_asignar_columna(dw_preliminar,contador,"piezas","0")
				f_asignar_columna(dw_preliminar,contador,"metros",String(var_cantidad))
			END IF
		ELSE
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
		f_asignar_columna(dw_preliminar,contador,"texto",String(dto1,"##") + "% " +textdto1+puntos )

		f_asignar_columna(dw_preliminar,contador,"importe","-" + String(Dec(importedto1),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
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
		f_asignar_columna(dw_preliminar,contador,"texto",String(dto2,"##") + "% " +textdto2+puntos)

		f_asignar_columna(dw_preliminar,contador,"importe","-" + String(Dec(importedto2),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
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
		f_asignar_columna(dw_preliminar,contador,"texto",String(dto3,"##") + "% " +textdto3+puntos)
		f_asignar_columna(dw_preliminar,contador,"importe","-" + String(Dec(importedto3),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		var_total = var_total - importedto3
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF

IF importedto4 <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(dto4,"##") + "% " +textdto4+puntos)
		f_asignar_columna(dw_preliminar,contador,"importe","-" + String(Dec(importedto4),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		var_total = var_total - importedto4
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF





reg = dw_proceso.retrieve(codigo_empresa,var_anyo,var_proforma,"N")
IF reg <> 0 Then
	For reg1 = 1 to reg
		contador  = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		var_articulo = f_valor_columna(dw_proceso,reg1,"articulo")
		f_asignar_columna(dw_preliminar,contador,"pallets",f_valor_columna(dw_proceso,reg1,"pallets"))
		f_asignar_columna(dw_preliminar,contador,"cajas",f_valor_columna(dw_proceso,reg1,"cajas"))
		f_asignar_columna(dw_preliminar,contador,"total_cajas",f_valor_columna(dw_proceso,reg1,"total_cajas"))
		f_asignar_columna(dw_preliminar,contador,"articulo",f_valor_columna(dw_proceso,reg1,"descripcion"))
		f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio"))
		f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"descuento"))
		f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(f_valor_columna(dw_proceso,reg1,"importe")),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"formato",f_nombre_formato_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"formato")))
		f_asignar_columna(dw_preliminar,contador,"calidad",f_nombre_calidad_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"calidad")))
		var_caja=f_valor_columna(dw_proceso,reg1,"caja")
		var_tipo_unidad=f_valor_columna(dw_proceso,reg1,"tipo_unidad")
		var_cantidad=Dec(f_valor_columna(dw_proceso,reg1,"cantidad"))
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad= "0" Then
				f_asignar_columna(dw_preliminar,contador,"piezas",String(var_cantidad))
				// Calcula los metros de las piezas
				dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_piezas(codigo_empresa,var_articulo,var_caja,var_cantidad))
			ELSE
				f_asignar_columna(dw_preliminar,contador,"piezas","0")
				f_asignar_columna(dw_preliminar,contador,"metros",String(var_cantidad))
			END IF
		ELSE
	   	f_asignar_columna(dw_preliminar,contador,"articulo",f_valor_columna(dw_proceso,reg1,"descripcion"))
		END IF
	var_total = var_total + dw_proceso.GetItemNumber(reg1,"importe")
	impdtopp =  dw_proceso.GetItemNumber(reg1,"importe") * dtopp / 100
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

IF importedtopp <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(dtopp,"##") + "% " +f_diccionario("PRONTO PAGO",var_idioma)+puntos)
		IF importedtopp > 0 Then
			f_asignar_columna(dw_preliminar,contador,"importe","-" + String(importedtopp ,f_mascara_moneda(var_moneda)))
		ELSE
			f_asignar_columna(dw_preliminar,contador,"importe", String(importedtopp * (-1),f_mascara_moneda(var_moneda)))
		END IF
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
		var_total = var_total - importedtopp
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF




IF IsNull(iva)     Then iva = 0
IF IsNull(recargo) Then recargo = 0
importeiva      = Dec(String(var_total * iva / 100,mascara))
importerecargo  = Dec(String(var_total * recargo / 100,mascara))
IF importeiva <>0 then
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador,"texto",String(iva,"##") + "% " +texto_iva+puntos)
		f_asignar_columna(dw_preliminar,contador,"importe"," " + String(Dec(importeiva),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
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
		f_asignar_columna(dw_preliminar,contador,"texto",String(recargo,"##") + "% " +texto_recargo+puntos)
		f_asignar_columna(dw_preliminar,contador,"importe"," " + String(Dec(importerecargo),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
		f_asignar_columna(dw_preliminar,contador,"raya","1")
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
                  f_textopie2_venproformas(codigo_empresa,var_anyo,var_proforma) +&
						"  "+f_nombre_moneda_abr(var_moneda) + "  #" +&
						String(var_total,f_mascara_moneda(var_moneda))+"#")
f_asignar_columna(dw_preliminar,contador,"ultima","S")




end subroutine

public subroutine f_valores (integer registro, integer tipo);Dec{0} var_anyo,var_proforma
String var_tipo_cliente,var_cliente,texto1,texto2,texto3,texto,var_serie
Datetime var_fproforma
var_anyo     = Dec(em_anyo.text)
var_proforma = Dec(em_proforma.text)
SELECT venproformas.fproforma,   
       venproformas.cliente,   
       venproformas.tipo_cliente,
       venproformas.textcomercial1,
       venproformas.textaduanaesp1,
       venproformas.textaduanaext1,
       venproformas.serie
INTO :var_fproforma,   
     :var_cliente,   
     :var_tipo_cliente,
	  :texto1,
	  :texto2,
	  :texto3,
	  :var_serie
	  FROM venproformas  
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    proforma= :var_proforma;

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
			f_asignar_columna(dw_preliminar,registro,"var_cajas","S")
		ELSE
			f_asignar_columna(dw_preliminar,registro,"var_cajas","N")
		END IF
      if Trim(var_idioma) = "1" Then var_idioma="3"
		
		dw_preliminar.SetItem(registro,"fproforma",var_fproforma)
		f_asignar_columna(dw_preliminar,registro,"texto_cabecera",texto)
		f_asignar_columna(dw_preliminar,registro,"tipo",String(tipo))
		f_asignar_columna(dw_preliminar,registro,"empresa",codigo_empresa)
		f_asignar_columna(dw_preliminar,registro,"anyo",String(var_anyo))
		f_asignar_columna(dw_preliminar,registro,"proforma",String(var_proforma))
		f_asignar_columna(dw_preliminar,registro,"idioma",var_idioma)
		f_asignar_columna(dw_preliminar,registro,"serie",var_serie)
		f_asignar_columna(dw_preliminar,registro,"tipo_cliente",var_tipo_cliente)
		f_asignar_columna(dw_preliminar,registro,"moneda",var_moneda)
		f_asignar_columna(dw_preliminar,registro,"cliente",var_cliente)
		f_asignar_columna(dw_preliminar,registro,"total",String(var_total))
		IF Int(registro/lineas)  * lineas = registro Then 
			f_asignar_columna(dw_preliminar,registro,"fin","1")
		ELSE
			f_asignar_columna(dw_preliminar,registro,"fin","2")
		END IF
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Listado proformas"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))
rb_comercial.checked = TRUE
var_tipo = 1
istr_parametros = Message.PowerObjectParm
IF istr_parametros.i_nargumentos>1 THEN
     em_anyo.text=istr_parametros.s_argumentos[2]	
     em_proforma.text=istr_parametros.s_argumentos[3]	
	  em_proforma.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
END IF
cabecera.text = "No"
cajas.text = "No"



end event

on w_lis_venproformas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_proforma=create em_proforma
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
this.uo_1=create uo_1
this.cajas=create cajas
this.st_15=create st_15
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_proforma
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
this.Control[iCurrent+32]=this.uo_1
this.Control[iCurrent+33]=this.cajas
this.Control[iCurrent+34]=this.st_15
this.Control[iCurrent+35]=this.gb_3
end on

on w_lis_venproformas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_proforma)
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
destroy(this.uo_1)
destroy(this.cajas)
destroy(this.st_15)
destroy(this.gb_3)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_venproformas
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_venproformas
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_proforma)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_venproformas
integer x = 37
integer y = 8
integer width = 3630
integer height = 80
end type

type pb_1 from upb_salir within w_lis_venproformas
integer x = 3547
integer y = 132
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_2 from statictext within w_lis_venproformas
integer x = 64
integer y = 156
integer width = 251
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Proforma:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_lis_venproformas
integer x = 325
integer y = 152
integer width = 192
integer taborder = 0
end type

type em_proforma from u_em_campo within w_lis_venproformas
integer x = 558
integer y = 152
integer width = 210
integer taborder = 30
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###"
string displaydata = "˜"
end type

event modificado;var_idioma      = f_idioma_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(em_proforma.text))
var_moneda      = f_divisa_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(em_proforma.text))
var_tipocli     = f_tipo_cliente_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(em_proforma.text))
var_codcli      = f_codcli_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(em_proforma.text))

st_idioma.text  = f_nombre_idioma(var_idioma)
st_moneda.text  = f_nombre_moneda(var_moneda)
st_codcli.text  = var_codcli

if var_tipocli="S" then
	  st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)
  else
	  st_cliente.text = f_nombre_vencliproforma(codigo_empresa,var_codcli)
End if

call super::modificado
end event

type st_3 from statictext within w_lis_venproformas
integer x = 517
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
long backcolor = 67108864
boolean enabled = false
string text = "-"
boolean focusrectangle = false
end type

type st_4 from statictext within w_lis_venproformas
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

type st_idioma from statictext within w_lis_venproformas
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

type dw_proceso from datawindow within w_lis_venproformas
boolean visible = false
integer x = 2030
integer y = 20
integer width = 494
integer height = 60
boolean bringtotop = true
string dataobject = "dw_proceso_venliproformas_dto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_preliminar from datawindow within w_lis_venproformas
boolean visible = false
integer y = 548
integer width = 3680
integer height = 2628
boolean bringtotop = true
string dataobject = "report_list_venproformas1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
end type

type st_5 from statictext within w_lis_venproformas
integer x = 1230
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

type em_copias2 from editmask within w_lis_venproformas
integer x = 1691
integer y = 224
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
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string displaydata = "~r˜pbedit050"
double increment = 1
end type

event getfocus;this.selectText(1,2)
end event

type st_6 from statictext within w_lis_venproformas
integer x = 1193
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

type em_copias1 from editmask within w_lis_venproformas
integer x = 1691
integer y = 128
integer width = 174
integer height = 88
integer taborder = 40
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

type cb_2 from u_boton within w_lis_venproformas
event clicked pbm_bnclicked
integer x = 2167
integer y = 132
integer width = 325
integer height = 72
integer taborder = 100
string text = "&Imprimir"
end type

event clicked;call super::clicked;if len(em_proforma.text)=0 then
	MessageBox("Introduzca la proforma","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_proforma)
	Return
End if

var_idioma = f_idioma_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(em_proforma.text))
var_moneda = f_divisa_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(em_proforma.text))
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
f_activar_campo(em_proforma)


end event

type rb_comercial from radiobutton within w_lis_venproformas
integer x = 3026
integer y = 232
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

type rb_nacional from radiobutton within w_lis_venproformas
integer x = 3026
integer y = 288
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

type rb_extranjero from radiobutton within w_lis_venproformas
integer x = 3026
integer y = 348
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

type cb_1 from u_boton within w_lis_venproformas
integer x = 3003
integer y = 152
integer width = 384
integer height = 72
integer taborder = 110
boolean bringtotop = true
string text = "&Preliminar"
end type

event clicked;call super::clicked;if len(em_proforma.text)=0 then
	MessageBox("Introduzca la proforma","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_proforma)
	Return
End if

f_activar_campo(em_proforma)

em_proforma.TriggerEvent("modificado")
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

type st_12 from statictext within w_lis_venproformas
integer x = 1189
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

type em_copias3 from editmask within w_lis_venproformas
integer x = 1691
integer y = 320
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

type st_1 from statictext within w_lis_venproformas
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

type st_moneda from statictext within w_lis_venproformas
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

type pb_imprimir_preli from picturebutton within w_lis_venproformas
boolean visible = false
integer x = 2597
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
string picturename = "PRINT!"
end type

event clicked;OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_proforma)
end event

type st_13 from statictext within w_lis_venproformas
integer x = 2171
integer y = 240
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
string text = "Cab"
boolean focusrectangle = false
end type

type cabecera from dropdownlistbox within w_lis_venproformas
integer x = 2299
integer y = 228
integer width = 192
integer height = 220
integer taborder = 90
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

type uo_manejo from u_manejo_datawindow within w_lis_venproformas
boolean visible = false
integer x = 2121
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

type gb_1 from groupbox within w_lis_venproformas
integer x = 2976
integer y = 112
integer width = 439
integer height = 300
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_7 from statictext within w_lis_venproformas
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

type st_cliente from statictext within w_lis_venproformas
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

type st_codcli from statictext within w_lis_venproformas
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

type st_pagina from statictext within w_lis_venproformas
integer x = 2085
integer y = 428
integer width = 361
integer height = 80
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

type uo_1 from u_selec_impresoras within w_lis_venproformas
integer x = 27
integer y = 552
integer height = 108
integer taborder = 80
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type cajas from dropdownlistbox within w_lis_venproformas
integer x = 2299
integer y = 324
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

type st_15 from statictext within w_lis_venproformas
integer x = 2167
integer y = 336
integer width = 123
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

type gb_3 from groupbox within w_lis_venproformas
integer x = 5
integer y = 80
integer width = 2574
integer height = 460
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

