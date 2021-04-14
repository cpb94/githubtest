$PBExportHeader$w_lis_venalbaranes_volcados.srw
forward
global type w_lis_venalbaranes_volcados from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_venalbaranes_volcados
end type
type st_2 from statictext within w_lis_venalbaranes_volcados
end type
type em_anyo from u_em_campo within w_lis_venalbaranes_volcados
end type
type em_albaran from u_em_campo within w_lis_venalbaranes_volcados
end type
type st_3 from statictext within w_lis_venalbaranes_volcados
end type
type dw_proceso from datawindow within w_lis_venalbaranes_volcados
end type
type dw_preliminar from datawindow within w_lis_venalbaranes_volcados
end type
type st_6 from statictext within w_lis_venalbaranes_volcados
end type
type em_copias1 from editmask within w_lis_venalbaranes_volcados
end type
type cb_2 from u_boton within w_lis_venalbaranes_volcados
end type
type cb_1 from u_boton within w_lis_venalbaranes_volcados
end type
type pb_imprimir_preli from picturebutton within w_lis_venalbaranes_volcados
end type
type uo_manejo from u_manejo_datawindow within w_lis_venalbaranes_volcados
end type
type gb_1 from groupbox within w_lis_venalbaranes_volcados
end type
type st_7 from statictext within w_lis_venalbaranes_volcados
end type
type st_cliente from statictext within w_lis_venalbaranes_volcados
end type
type st_codcli from statictext within w_lis_venalbaranes_volcados
end type
type st_pagina from statictext within w_lis_venalbaranes_volcados
end type
type gb_3 from groupbox within w_lis_venalbaranes_volcados
end type
type uo_1 from u_selec_impresoras within w_lis_venalbaranes_volcados
end type
type st_14 from statictext within w_lis_venalbaranes_volcados
end type
type valorado from dropdownlistbox within w_lis_venalbaranes_volcados
end type
end forward

global type w_lis_venalbaranes_volcados from w_int_con_empresa
integer x = 46
integer y = 16
integer width = 3589
integer height = 2244
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_albaran em_albaran
st_3 st_3
dw_proceso dw_proceso
dw_preliminar dw_preliminar
st_6 st_6
em_copias1 em_copias1
cb_2 cb_2
cb_1 cb_1
pb_imprimir_preli pb_imprimir_preli
uo_manejo uo_manejo
gb_1 gb_1
st_7 st_7
st_cliente st_cliente
st_codcli st_codcli
st_pagina st_pagina
gb_3 gb_3
uo_1 uo_1
st_14 st_14
valorado valorado
end type
global w_lis_venalbaranes_volcados w_lis_venalbaranes_volcados

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli
Dec{4}  var_total
integer lineas = 25
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

public subroutine f_proceso (integer tipo);Dec{0} var_anyo,var_albaran,resto,re,var_paginas,var_ejercicio,total_cajas
long va,va2
String  textpie[],pie,pie1,pie2,pie3,letra,var_articulo,tipo_iva,tipo_recargo,puntos
String textopie2,cadena,texto_iva,texto_recargo,var_tipo_pallet
Integer reg,reg1
Dec{4}  var_tono,var_calibre,var_cantidad,acumulado,dto1,impdto1,dto2,impdto2,dto3,impdto3,&
		  dto4,impdto4,dtopp,impdtopp,aculumado,dtoesp,precio,cantidad,bruto,importe,iva,recargo,importeiva,importerecargo

DateTime var_falbaran
String   var_tipo_unidad,textdto1,textdto2,textdto3,textdto4,tipodto1,&
         tipodto2,tipodto3,tipodto4,tipo_cliente,linea
			
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
var_albaran  = Dec(em_albaran.text)
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
From   venalb2
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
reg = dw_proceso.retrieve(codigo_empresa,var_anyo,var_albaran,"S")
IF reg <> 0 Then
	For reg1 = 1 to reg
		acumulado = 0
		contador  = contador + 1
		dtoesp       = Dec(f_valor_columna(dw_proceso,contador,"dtoesp"))
		cantidad     = Dec(f_valor_columna(dw_proceso,contador,"cantidad"))
		var_tono     = Dec(f_valor_columna(dw_proceso,contador,"tono"))
		var_calibre     = Dec(f_valor_columna(dw_proceso,contador,"calibre"))
		var_tipo_pallet     = f_valor_columna(dw_proceso,contador,"tipo_pallet")
		CHOOSE CASE tipo
		 CASE  3
			precio       = dw_proceso.GetItemNumber(reg1,"precio_neto_aduana")
			bruto       = dw_proceso.GetItemNumber(reg1,"importe_aduana")
			impdtopp      = dw_proceso.GetItemNumber(reg1,"impdtopp_aduana")
			impdto1      = dw_proceso.GetItemNumber(reg1,"impdtoesp1_aduana")
			impdto2      = dw_proceso.GetItemNumber(reg1,"impdtoesp2_aduana")			
			impdto3      = dw_proceso.GetItemNumber(reg1,"impdtoesp3_aduana")			
			impdto4      = dw_proceso.GetItemNumber(reg1,"impdtoesp4_aduana")			
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
		
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		var_articulo = f_valor_columna(dw_proceso,reg1,"articulo")
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		f_asignar_columna(dw_preliminar,contador,"pallets",f_valor_columna(dw_proceso,reg1,"pallets"))
		f_asignar_columna(dw_preliminar,contador,"cajas",f_valor_columna(dw_proceso,reg1,"total_cajas"))
		f_asignar_columna(dw_preliminar,contador,"articulo",f_valor_columna(dw_proceso,reg1,"descripcion"))
		f_asignar_columna(dw_preliminar,contador,"tono",f_valor_columna(dw_proceso,reg1,"tono"))
		f_asignar_columna(dw_preliminar,contador,"calibre",f_valor_columna(dw_proceso,reg1,"calibre"))
   	f_asignar_columna(dw_preliminar,contador,"tipo_pallet",f_valor_columna(dw_proceso,reg1,"tipo_pallet"))
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
		var_cantidad=Dec(f_valor_columna(dw_proceso,reg1,"cantidad"))
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad= "0" Then
				f_asignar_columna(dw_preliminar,contador,"piezas",String(var_cantidad))
				f_asignar_columna(dw_preliminar,contador,"metros","0")
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
	IF valorado.text = "Si" Then
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
END IF

IF valorado.text = "Si" Then
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
END IF

reg = dw_proceso.retrieve(codigo_empresa,var_anyo,var_albaran,"N")
IF reg <> 0 Then
	For reg1 = 1 to reg
		contador  = contador + 1
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		var_articulo = f_valor_columna(dw_proceso,reg1,"articulo")
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		f_asignar_columna(dw_preliminar,contador,"pallets",f_valor_columna(dw_proceso,reg1,"pallets"))
		f_asignar_columna(dw_preliminar,contador,"cajas",f_valor_columna(dw_proceso,reg1,"total_cajas"))
		f_asignar_columna(dw_preliminar,contador,"articulo",f_valor_columna(dw_proceso,reg1,"descripcion"))
		f_asignar_columna(dw_preliminar,contador,"precio",f_valor_columna(dw_proceso,reg1,"precio"))
		f_asignar_columna(dw_preliminar,contador,"descuento",f_valor_columna(dw_proceso,reg1,"descuento"))
		f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(f_valor_columna(dw_proceso,reg1,"importe")),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"formato",f_nombre_formato_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"formato")))
		f_asignar_columna(dw_preliminar,contador,"calidad",f_nombre_calidad_abr(codigo_empresa,f_valor_columna(dw_proceso,reg1,"calidad")))
		var_tipo_unidad=f_valor_columna(dw_proceso,reg1,"tipo_unidad")
		var_cantidad=Dec(f_valor_columna(dw_proceso,reg1,"cantidad"))
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad= "0" Then
				f_asignar_columna(dw_preliminar,contador,"piezas",String(var_cantidad))
				f_asignar_columna(dw_preliminar,contador,"metros","0")
			ELSE
				f_asignar_columna(dw_preliminar,contador,"piezas","0")
				f_asignar_columna(dw_preliminar,contador,"metros",String(var_cantidad))
			END IF
		ELSE
			// Modificacion según Carlos
			//f_asignar_columna(dw_preliminar,contador,"articulo",String(var_cantidad,"####")+ " " + f_valor_columna(dw_proceso,reg1,"descripcion"))
	   	f_asignar_columna(dw_preliminar,contador,"articulo",f_valor_columna(dw_proceso,reg1,"descripcion"))
	   
						
		END IF
	var_total = var_total + dw_proceso.GetItemNumber(reg1,"importe")
   impdtopp =  Dec(String(dw_proceso.GetItemNumber(reg1,"importe") * dtopp / 100,f_mascara_moneda(var_moneda)))
	Next
		contador = contador + 1
		dw_preliminar.InsertRow(contador)
      f_valores(contador,tipo)
		f_asignar_columna(dw_preliminar,contador - 1,"raya","1")
		f_asignar_columna(dw_preliminar,contador,"texto","")
		f_asignar_columna(dw_preliminar,contador,"importe",String(Dec(var_total),f_mascara_moneda(var_moneda)))
		f_asignar_columna(dw_preliminar,contador,"orden","2")
END IF

IF valorado.text = "Si" Then
	IF importedtopp <>0 then
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			f_asignar_columna(dw_preliminar,contador,"texto",String(dtopp,"##") + "% " +f_diccionario("PRONTO PAGO",var_idioma)+puntos)
			IF importedtopp <0 Then
				 f_asignar_columna(dw_preliminar,contador,"importe","" + String(Dec(importedtopp) * (-1),f_mascara_moneda(var_moneda)))
			  ELSE
				 f_asignar_columna(dw_preliminar,contador,"importe","-" + String(Dec(importedtopp),f_mascara_moneda(var_moneda)))
			END IF
			f_asignar_columna(dw_preliminar,contador,"orden","2")
			f_asignar_columna(dw_preliminar,contador,"raya","1")
			var_total = var_total - importedtopp
			contador = contador + 1
			dw_preliminar.InsertRow(contador)
			f_valores(contador,tipo)
			f_asignar_columna(dw_preliminar,contador,"importe", + String(Dec(var_total),f_mascara_moneda(var_moneda)))
			f_asignar_columna(dw_preliminar,contador,"orden","2")
	End if
End if
IF IsNull(iva)     Then iva = 0
IF IsNull(recargo) Then recargo = 0
importeiva      = Dec(String(var_total * iva / 100,f_mascara_moneda(var_moneda)))
importerecargo  = Dec(STring(var_total * recargo / 100,f_mascara_moneda(var_moneda)))
IF valorado.text = "Si" Then
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
                  "TOTAL  "+f_nombre_moneda_abr(var_moneda) + "  #" +&
						String(var_total,f_mascara_moneda(var_moneda))+"#")
f_asignar_columna(dw_preliminar,contador,"ultima","S")




end subroutine

public subroutine f_valores (integer registro, integer tipo);Dec{0} var_anyo,var_albaran
String var_tipo_cliente,var_cliente,texto1,texto2,texto3,texto,var_serie,var_envio
Datetime var_falbaran
var_anyo     = Dec(em_anyo.text)
var_albaran = Dec(em_albaran.text)
SELECT venalb2.falbaran,      venalb2.cliente,
		 venalb2.textcomercial1,
		 venalb2.textaduanaesp1, venalb2.textaduanaext1,
       venalb2.serie,venalb2.envio
INTO :var_falbaran,   :var_cliente, 
	  :texto1, :texto2, :texto3,
	  :var_serie,:var_envio
	  FROM venalb2  
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


      if Trim(var_idioma) = "1" Then var_idioma="3"
		
		dw_preliminar.SetItem(registro,"falbaran",var_falbaran)
		f_asignar_columna(dw_preliminar,registro,"texto_cabecera",texto)
		f_asignar_columna(dw_preliminar,registro,"tipo",String(tipo))
		f_asignar_columna(dw_preliminar,registro,"empresa",codigo_empresa)
		f_asignar_columna(dw_preliminar,registro,"anyo",String(var_anyo))
		f_asignar_columna(dw_preliminar,registro,"albaran",String(var_albaran))
		f_asignar_columna(dw_preliminar,registro,"idioma",var_idioma)
		f_asignar_columna(dw_preliminar,registro,"serie",var_serie)
		f_asignar_columna(dw_preliminar,registro,"moneda",var_moneda)
		f_asignar_columna(dw_preliminar,registro,"cliente",var_cliente)
		f_asignar_columna(dw_preliminar,registro,"envio",var_envio)
		f_asignar_columna(dw_preliminar,registro,"total",String(var_total))
		IF Int(registro/lineas)  * lineas = registro Then 
			f_asignar_columna(dw_preliminar,registro,"fin","1")
		ELSE
			f_asignar_columna(dw_preliminar,registro,"fin","2")
		END IF
end subroutine

event open;call super::open;Integer r,j
istr_parametros.s_titulo_ventana="Listado albaranes Volcados"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))
var_tipo = 1
istr_parametros = Message.PowerObjectParm

IF istr_parametros.i_nargumentos>1 THEN
     em_anyo.text    = istr_parametros.s_argumentos[2]	
	  em_albaran.text = istr_parametros.s_argumentos[3]	
     
 	  IF Not IsNull(em_albaran.text) and Trim(em_albaran.text) <> "" Then
	  	  em_albaran.TriggerEvent("modificado")
	     istr_parametros.i_nargumentos=0
    	  em_copias1.text = istr_parametros.s_argumentos[4]
		  valorado.text = "No"
		  if istr_parametros.s_argumentos[5]="S" then  valorado.text = "Si"
		  if istr_parametros.s_argumentos[6]="S" then  
			  cb_2.triggerevent(Clicked!)
			  Close(This)
		  End if
		  
     END IF
     
	Return
END IF

valorado.text = "Si"


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

on w_lis_venalbaranes_volcados.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_albaran=create em_albaran
this.st_3=create st_3
this.dw_proceso=create dw_proceso
this.dw_preliminar=create dw_preliminar
this.st_6=create st_6
this.em_copias1=create em_copias1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_manejo=create uo_manejo
this.gb_1=create gb_1
this.st_7=create st_7
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.st_pagina=create st_pagina
this.gb_3=create gb_3
this.uo_1=create uo_1
this.st_14=create st_14
this.valorado=create valorado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_albaran
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.dw_proceso
this.Control[iCurrent+7]=this.dw_preliminar
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.em_copias1
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.pb_imprimir_preli
this.Control[iCurrent+13]=this.uo_manejo
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.st_7
this.Control[iCurrent+16]=this.st_cliente
this.Control[iCurrent+17]=this.st_codcli
this.Control[iCurrent+18]=this.st_pagina
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.uo_1
this.Control[iCurrent+21]=this.st_14
this.Control[iCurrent+22]=this.valorado
end on

on w_lis_venalbaranes_volcados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_albaran)
destroy(this.st_3)
destroy(this.dw_proceso)
destroy(this.dw_preliminar)
destroy(this.st_6)
destroy(this.em_copias1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_imprimir_preli)
destroy(this.uo_manejo)
destroy(this.gb_1)
destroy(this.st_7)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.st_pagina)
destroy(this.gb_3)
destroy(this.uo_1)
destroy(this.st_14)
destroy(this.valorado)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_venalbaranes_volcados
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_venalbaranes_volcados
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_albaran)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_venalbaranes_volcados
integer x = 9
integer y = 4
integer width = 2450
integer height = 96
end type

type pb_1 from upb_salir within w_lis_venalbaranes_volcados
integer x = 3383
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_lis_venalbaranes_volcados
integer x = 14
integer y = 160
integer width = 302
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
string text = "Albaran:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_lis_venalbaranes_volcados
integer x = 329
integer y = 156
integer width = 192
integer height = 80
integer taborder = 0
end type

type em_albaran from u_em_campo within w_lis_venalbaranes_volcados
integer x = 562
integer y = 156
integer width = 210
integer height = 80
integer taborder = 30
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######"
string displaydata = "~b"
end type

event modificado;var_idioma      = f_idioma_venalb2(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda      = f_divisa_venalb2(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_codcli      = f_cliente_venalb2(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
st_codcli.text  = var_codcli
st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)
call super::modificado
end event

type st_3 from statictext within w_lis_venalbaranes_volcados
integer x = 521
integer y = 140
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

type dw_proceso from datawindow within w_lis_venalbaranes_volcados
boolean visible = false
integer x = 2030
integer y = 20
integer width = 494
integer height = 60
boolean bringtotop = true
string dataobject = "dw_proceso_venlialb2_dto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_preliminar from datawindow within w_lis_venalbaranes_volcados
boolean visible = false
integer y = 544
integer width = 3474
integer height = 1400
boolean bringtotop = true
string dataobject = "report_list_venalb2"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_lis_venalbaranes_volcados
integer x = 937
integer y = 156
integer width = 256
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Copias :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_copias1 from editmask within w_lis_venalbaranes_volcados
integer x = 1202
integer y = 156
integer width = 174
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

type cb_2 from u_boton within w_lis_venalbaranes_volcados
event clicked pbm_bnclicked
integer x = 2811
integer y = 208
integer width = 384
integer height = 72
integer taborder = 70
string text = "&Imprimir"
end type

event clicked;call super::clicked;IF valorado.text = "Si" Then
	dw_preliminar.DataObject = "report_list_venalbaranes1_volcado"
Else
	dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_volcado"
END IF
if len(em_albaran.text)=0 then
	MessageBox("Introduzca la albaran","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_albaran)
	Return
End if

var_idioma = f_idioma_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda = f_divisa_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
dw_preliminar.visible= FALSE
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE

IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
 dw_preliminar.reset()
 f_proceso(1)
 dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)
 dw_preliminar.Print(TRUE)
END IF
f_activar_campo(em_albaran)


end event

type cb_1 from u_boton within w_lis_venalbaranes_volcados
integer x = 2811
integer y = 128
integer width = 384
integer height = 72
integer taborder = 80
boolean bringtotop = true
string text = "&Preliminar"
end type

event clicked;call super::clicked;IF valorado.text = "Si" Then
	dw_preliminar.DataObject = "report_list_venalbaranes1_volcado"
Else
	dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_volcado"
END IF
if len(em_albaran.text)=0 then
	MessageBox("Introduzca la pedido","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_albaran)
	Return
End if

f_activar_campo(em_albaran)

em_albaran.TriggerEvent("modificado")
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

type pb_imprimir_preli from picturebutton within w_lis_venalbaranes_volcados
boolean visible = false
integer x = 3246
integer y = 424
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
f_activar_campo(em_albaran)
end event

type uo_manejo from u_manejo_datawindow within w_lis_venalbaranes_volcados
boolean visible = false
integer x = 2770
integer y = 380
integer width = 599
integer height = 160
end type

event valores;call super::valores;dw_data =dw_preliminar
f_pagina()
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_1 from groupbox within w_lis_venalbaranes_volcados
integer x = 2784
integer y = 88
integer width = 439
integer height = 212
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_7 from statictext within w_lis_venalbaranes_volcados
integer x = 27
integer y = 324
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

type st_cliente from statictext within w_lis_venalbaranes_volcados
integer x = 535
integer y = 324
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

type st_codcli from statictext within w_lis_venalbaranes_volcados
integer x = 329
integer y = 324
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

type st_pagina from statictext within w_lis_venalbaranes_volcados
integer x = 1733
integer y = 456
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

type gb_3 from groupbox within w_lis_venalbaranes_volcados
integer x = 5
integer y = 80
integer width = 2048
integer height = 348
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type uo_1 from u_selec_impresoras within w_lis_venalbaranes_volcados
integer x = 27
integer y = 436
integer height = 108
integer taborder = 60
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type st_14 from statictext within w_lis_venalbaranes_volcados
integer x = 1568
integer y = 156
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
string text = "Valorado:"
boolean focusrectangle = false
end type

type valorado from dropdownlistbox within w_lis_venalbaranes_volcados
integer x = 1833
integer y = 144
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

