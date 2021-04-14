$PBExportHeader$w_lis_venalbaranes_facturados_old.srw
forward
global type w_lis_venalbaranes_facturados_old from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_venalbaranes_facturados_old
end type
type st_2 from statictext within w_lis_venalbaranes_facturados_old
end type
type em_anyo from u_em_campo within w_lis_venalbaranes_facturados_old
end type
type em_albaran from u_em_campo within w_lis_venalbaranes_facturados_old
end type
type st_3 from statictext within w_lis_venalbaranes_facturados_old
end type
type st_6 from statictext within w_lis_venalbaranes_facturados_old
end type
type em_copias1 from editmask within w_lis_venalbaranes_facturados_old
end type
type cb_2 from u_boton within w_lis_venalbaranes_facturados_old
end type
type cb_1 from u_boton within w_lis_venalbaranes_facturados_old
end type
type pb_imprimir_preli from picturebutton within w_lis_venalbaranes_facturados_old
end type
type st_13 from statictext within w_lis_venalbaranes_facturados_old
end type
type cabecera from dropdownlistbox within w_lis_venalbaranes_facturados_old
end type
type gb_1 from groupbox within w_lis_venalbaranes_facturados_old
end type
type st_7 from statictext within w_lis_venalbaranes_facturados_old
end type
type st_cliente from statictext within w_lis_venalbaranes_facturados_old
end type
type st_codcli from statictext within w_lis_venalbaranes_facturados_old
end type
type st_pagina from statictext within w_lis_venalbaranes_facturados_old
end type
type gb_3 from groupbox within w_lis_venalbaranes_facturados_old
end type
type uo_1 from u_selec_impresoras within w_lis_venalbaranes_facturados_old
end type
type st_14 from statictext within w_lis_venalbaranes_facturados_old
end type
type valorado from dropdownlistbox within w_lis_venalbaranes_facturados_old
end type
type aduana from dropdownlistbox within w_lis_venalbaranes_facturados_old
end type
type st_22 from statictext within w_lis_venalbaranes_facturados_old
end type
type cbx_matric from checkbox within w_lis_venalbaranes_facturados_old
end type
type gb_5 from groupbox within w_lis_venalbaranes_facturados_old
end type
type dw_preliminar from datawindow within w_lis_venalbaranes_facturados_old
end type
type uo_manejo from u_manejo_datawindow within w_lis_venalbaranes_facturados_old
end type
end forward

global type w_lis_venalbaranes_facturados_old from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 3817
integer height = 3296
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
gb_1 gb_1
st_7 st_7
st_cliente st_cliente
st_codcli st_codcli
st_pagina st_pagina
gb_3 gb_3
uo_1 uo_1
st_14 st_14
valorado valorado
aduana aduana
st_22 st_22
cbx_matric cbx_matric
gb_5 gb_5
dw_preliminar dw_preliminar
uo_manejo uo_manejo
end type
global w_lis_venalbaranes_facturados_old w_lis_venalbaranes_facturados_old

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli
Dec{4}  var_total
integer lineas =  26,anyo_fac //lineas =  32
integer lnpie,contador,var_tipo
String  var_clase,c,des
dec fac
end variables

forward prototypes
public subroutine f_pagina ()
public subroutine f_valores (integer registro, integer tipo)
public subroutine f_proceso (integer tipo)
end prototypes

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")
end subroutine

public subroutine f_valores (integer registro, integer tipo);Dec{0} var_anyo,var_albaran
String var_tipo_cliente,var_cliente,texto1,texto2,texto3,texto,var_serie,var_envio,var_deposito
string observaciones_fac
Datetime var_falbaran
Int mostrar_plinea


var_anyo     = Dec(em_anyo.text)
var_albaran = Dec(em_albaran.text)

SELECT venlifac.falbaran,      venlifac.cliente,
       venlifac.serie,venlifac.envio,venlifac.deposito
INTO :var_falbaran,   :var_cliente, 
	  :var_serie,:var_envio,:var_deposito
FROM venlifac
Where  venlifac.empresa = :codigo_empresa
	And    venlifac.anyo_albaran    = :var_anyo
	And    venlifac.albaran= :var_albaran
	group by venlifac.empresa,venlifac.anyo,venlifac.albaran,venlifac.falbaran,
			venlifac.cliente,venlifac.serie,venlifac.envio,deposito;



SELECT venfac.textcomercial1,
		 venfac.textaduanaesp1, venfac.textaduanaext1, venfac.observaciones_alb
INTO :texto1, :texto2, :texto3, :observaciones_fac
	  FROM venfac
Where  venfac.empresa = :codigo_empresa
And    venfac.anyo    = :anyo_fac
And    venfac.factura= :fac;


CHOOSE CASE tipo
	CASE 1
		texto = texto1
	CASE 2
		texto = texto2
	CASE 3
		texto = texto3
END CHOOSE

      IF cabecera.text = "Si" Then
			dw_preliminar.SetItem(registro,"ver_cabecera","S")
		ELSE
			dw_preliminar.SetItem(registro,"ver_cabecera","N")
		END IF
      if Trim(var_idioma) = "1" Then var_idioma="3"
		
mostrar_plinea = 0
SELECT ISNULL(mostrar_peso_linea,0) INTO :mostrar_plinea 
FROM venclientes
WHERE empresa = :codigo_empresa AND codigo = :var_cliente;
		
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
		dw_preliminar.SetItem(registro,"total",String(var_total))
		dw_preliminar.SetItem(registro,"obs_fac", observaciones_fac)
	dw_preliminar.SetItem(registro,"mostrar_plinea",mostrar_plinea)
	
		IF Int(registro/lineas)  * lineas = registro Then 
			dw_preliminar.SetItem(registro,"fin",1)
		ELSE
			dw_preliminar.SetItem(registro,"fin",2)
		END IF
end subroutine

public subroutine f_proceso (integer tipo);dw_preliminar.SetRedraw(FALSE)
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
         tipodto2,tipodto3,tipodto4,tipo_cliente,linea
DataStore dw_proceso			
String sel
Dec{4}   importedto1,importedto2,importedto3,importedto4,importedtopp
Dec cajas_parciales, v_piezascaja, v_pal, peso_neto
String v_caja
Int decimales_unidad
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
From   venfac
Where  empresa = :codigo_empresa
And    anyo    = :anyo_fac
And    factura= :fac;
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
if tipo=3 then ampli = " AND venlifac.precio_aduana <> 0   "

Sel = " SELECT venlifac.* " +&
	   " FROM venlifac  "+&
	   " WHERE  venlifac.empresa = '"+ codigo_empresa +"'" +&
	   " AND venlifac.anyo       = "+String(var_anyo,"######")+&
	   " AND venlifac.albaran    = "+String(var_albaran,"#########") +&
	   " AND venlifac.control_descuentos = 'S'   "+&
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
		var_tono_imprimir = dw_proceso.GetItemString(contador,"tono_imprimir")
		var_calibre_imprimir = dw_proceso.GetItemString(contador,"calibre_imprimir")		
		var_tipo_pallet = dw_proceso.GetItemSTring(contador,"tipo_pallet")
		var_caja      = dw_proceso.GetItemSTring(contador,"caja")
      var_numpalet  = dw_proceso.GetItemNumber(contador,"numpalet")
		var_ref_cli   = dw_proceso.GetItemString(contador,"numpedcli")
		peso_neto = dw_proceso.GetItemNumber(contador,"peso_neto")
		
		if upper(var_ref_cli) = "PROMOCION" then
			var_ref_cli = f_diccionario("PROMOCION",var_idioma)
		end if
	
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
		var_articulo = dw_proceso.GetItemSTring(reg1,"articulo")
		if not isnull(var_articulo) and var_articulo <> "" then
			decimales_unidad = ftc_decimales_articulo(codigo_empresa, var_articulo)
		else
			decimales_unidad = 0
		end if
		
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		dw_preliminar.SetItem(contador,"cod_articulo",var_articulo)
		if valorado.text = 'Si' then
			v_pal = dw_proceso.GetItemNumber(reg1,"numpalet")
			dw_preliminar.SetItem(contador,"pallets",v_pal)
		else
			dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemNumber(reg1,"pallets"))
		end if
		dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemNumber(reg1,"total_cajas"))
		dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))
		dw_preliminar.SetItem(contador,"tono",var_tono_imprimir)
		dw_preliminar.SetItem(contador,"calibre",dec(var_calibre_imprimir))
		dw_preliminar.SetItem(contador,"tipo_pallet",dw_proceso.GetItemSTring(reg1,"tipo_pallet"))
		dw_preliminar.SetItem(contador,"caja",dw_proceso.GetItemSTring(reg1,"caja"))		
		dw_preliminar.SetItem(contador,"numpalet",var_numpalet)	
		dw_preliminar.SetItem(contador,"ref_cli",var_ref_cli)
		dw_preliminar.SetItem(contador,"pneto_linea",peso_neto)
		
		
		v_caja = dw_proceso.GetItemSTring(reg1,"caja")
		select piezascaja
		into :v_piezascaja
		from almartcajas
		where empresa = :codigo_empresa
		and articulo = :var_articulo
		and caja = :v_caja;
		
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
		dw_preliminar.SetItem(contador, "decimales_unidad", decimales_unidad)
		
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad= "0" Then
				dw_preliminar.SetItem(contador,"piezas",var_cantidad)
				//dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_piezas(codigo_empresa,var_articulo,dw_proceso.GetItemSTring(reg1,"caja"),var_cantidad))
				if v_piezascaja > 0 then
					cajas_parciales = var_cantidad / v_piezascaja		
					//dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_cajas(codigo_empresa,var_articulo,v_caja, cajas_parciales))
					dw_preliminar.SetItem(contador,"metros",0)
				end if
			ELSE
				dw_preliminar.SetItem(contador,"piezas","0")
				dw_preliminar.SetItem(contador,"metros",var_cantidad)
			END IF
		ELSE
			dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####")+ " " + dw_proceso.GetItemString(reg1,"descripcion"))
		END IF
		
		IF tipo <>3 then
			var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))
		ELSE
			var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe_aduana"))
		END IF
		C = ""
//		IF var_clase = "M" Then C = "(MUESTRAS)"
//		IF var_clase = "S" Then C = "(SIN CARGO)"	
		IF var_clase = "M" Then C = "(" + f_diccionario("MUESTRAS",var_idioma) + ")"
		IF var_clase = "S" Then C = "(" + f_diccionario("SIN CARGO",var_idioma) + ")"
		
		
		des = dw_preliminar.GetItemString(contador,"articulo")
		IF Trim(des) <> "" Then 
			dw_preliminar.SetItem(contador,"articulo",des + " " +c)
		END IF
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
				dw_preliminar.SetItem(contador,"texto",String(dto1,"##.00") + "% " +textdto1+puntos )
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
				dw_preliminar.SetItem(contador,"texto",String(dto2,"##.00") + "% " +textdto2+puntos)
		
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
				dw_preliminar.SetItem(contador,"texto",String(dto3,"##.00") + "% " +textdto3+puntos)
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
				dw_preliminar.SetItem(contador,"texto",String(dto4,"##.00") + "% " +textdto4+puntos)
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

Sel = " SELECT venlifac.* " +&
		" FROM   venlifac  "+&
		" WHERE  venlifac.empresa = '"+ codigo_empresa +"'" +&
		" AND venlifac.anyo = "+String(var_anyo,"######")+&
		" AND venlifac.albaran = "+String(var_albaran,"#########") +&
		" AND venlifac.control_descuentos = 'N'   "+&
		  ampli +&
		" ORDER BY empresa ASC,anyo ASC,albaran ASC,numpalet ASC,linea ASC "

//dw_proceso= f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, dw_proceso)
reg = dw_proceso.RowCount()

IF reg <> 0 Then
	For reg1 = 1 to reg
		contador  = contador + 1
		var_clase    = dw_proceso.GetItemString(reg1,"clase")
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		var_articulo = dw_proceso.GetItemString(reg1,"articulo")
		var_tono_imprimir = dw_proceso.GetItemString(reg1,"tono_imprimir")
		var_calibre_imprimir = dw_proceso.GetItemString(reg1,"calibre_imprimir")		
		
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		//dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemnumber(reg1,"pallets"))
		
		if valorado.text = 'Si' then
			v_pal = dw_proceso.GetItemNumber(reg1,"numpalet")
			dw_preliminar.SetItem(contador,"pallets",v_pal)
		else
			dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemNumber(reg1,"pallets"))
		end if
		
		dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemnumber(reg1,"total_cajas"))
		dw_preliminar.SetItem(contador,"cod_articulo",var_articulo)
		dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemstring(reg1,"descripcion"))
		dw_preliminar.SetItem(contador,"tono",var_tono_imprimir)
		dw_preliminar.SetItem(contador,"calibre",dec(var_calibre_imprimir))		
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
		dw_preliminar.SetItem(contador,"numpalet",dw_proceso.GetItemNumber(reg1,"numpalet"))	
		//dw_preliminar.SetItem(contador,"ref_cli",dw_proceso.GetItemstring(reg1,"numpecli"))
		dw_preliminar.SetItem(contador, "decimales_unidad", decimales_unidad)
		
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad= "0" Then
				dw_preliminar.SetItem(contador,"piezas",var_cantidad)
				dw_preliminar.SetItem(contador,"metros",0)
			ELSE
				dw_preliminar.SetItem(contador,"piezas",0)
				dw_preliminar.SetItem(contador,"metros",var_cantidad)
			END IF
		ELSE
			// Modificacion según Carlos
			//dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####")+ " " + dw_proceso.GetItem(reg1,"descripcion"))
	   	dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))
	   
						
		END IF
		C = ""
//		IF var_clase = "M" Then C = "(MUESTRAS)"
//		IF var_clase = "S" Then C = "(SIN CARGO)"
		IF var_clase = "M" Then C = "(" + f_diccionario("MUESTRAS",var_idioma) + ")"
		IF var_clase = "S" Then C = "(" + f_diccionario("SIN CARGO",var_idioma) + ")"
		
		des = dw_preliminar.GetItemString(contador,"articulo")
		IF Trim(des) <> "" Then 
			dw_preliminar.SetItem(contador,"articulo",des + " " +c)
		END IF
	var_total = var_total + Dec(dw_proceso.GetItemNumber(reg1,"importe"))		
   impdtopp     =  Dec(String(Dec(dw_proceso.GetItemNumber(reg1,"importe"))		 * dtopp / 100,f_mascara_moneda(var_moneda)))
   importedtopp = importedtopp + impdtopp			 
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

event open;call super::open;//LISTADO DW
//report_list_venalbaranes1_facturado
//report_list_venalbaranes1_sinval_mat_fac

Integer r,j
istr_parametros.s_titulo_ventana="Listado albaranes facturados"
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
		  cb_2.triggerevent(Clicked!)
	  END IF
	NEXT
	Close(This)
	Return
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

on w_lis_venalbaranes_facturados_old.create
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
this.gb_1=create gb_1
this.st_7=create st_7
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.st_pagina=create st_pagina
this.gb_3=create gb_3
this.uo_1=create uo_1
this.st_14=create st_14
this.valorado=create valorado
this.aduana=create aduana
this.st_22=create st_22
this.cbx_matric=create cbx_matric
this.gb_5=create gb_5
this.dw_preliminar=create dw_preliminar
this.uo_manejo=create uo_manejo
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
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.st_cliente
this.Control[iCurrent+16]=this.st_codcli
this.Control[iCurrent+17]=this.st_pagina
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.uo_1
this.Control[iCurrent+20]=this.st_14
this.Control[iCurrent+21]=this.valorado
this.Control[iCurrent+22]=this.aduana
this.Control[iCurrent+23]=this.st_22
this.Control[iCurrent+24]=this.cbx_matric
this.Control[iCurrent+25]=this.gb_5
this.Control[iCurrent+26]=this.dw_preliminar
this.Control[iCurrent+27]=this.uo_manejo
end on

on w_lis_venalbaranes_facturados_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
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
destroy(this.gb_1)
destroy(this.st_7)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.st_pagina)
destroy(this.gb_3)
destroy(this.uo_1)
destroy(this.st_14)
destroy(this.valorado)
destroy(this.aduana)
destroy(this.st_22)
destroy(this.cbx_matric)
destroy(this.gb_5)
destroy(this.dw_preliminar)
destroy(this.uo_manejo)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_venalbaranes_facturados_old
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_venalbaranes_facturados_old
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_albaran)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_venalbaranes_facturados_old
integer x = 14
integer y = 4
integer width = 3566
integer height = 84
end type

type pb_1 from upb_salir within w_lis_venalbaranes_facturados_old
integer x = 3602
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_2 from statictext within w_lis_venalbaranes_facturados_old
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

type em_anyo from u_em_campo within w_lis_venalbaranes_facturados_old
integer x = 329
integer y = 156
integer width = 192
integer height = 80
integer taborder = 0
end type

type em_albaran from u_em_campo within w_lis_venalbaranes_facturados_old
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

event modificado;int anyo
dec albaran

anyo=integer(em_anyo.text)
albaran=Dec(em_albaran.text)

var_idioma      = f_idioma_venalb_venlifac(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda      = f_divisa_venalb_venlifac(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_codcli      = f_cliente_venalb_venlifac(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
st_codcli.text  = var_codcli
st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)

SELECT venfac.anyo,venfac.factura
INTO :anyo_fac,:fac
	  FROM venfac,venlifac
Where  venlifac.empresa = :codigo_empresa
And    venlifac.anyo_albaran    = :anyo
And    venlifac.albaran= :albaran
and    venlifac.empresa=venfac.empresa 
and	 venlifac.anyo=venfac.anyo 
and    venlifac.factura=venfac.factura
group by venlifac.empresa,venlifac.anyo,venlifac.albaran,venfac.anyo,venfac.factura;


call super::modificado
end event

type st_3 from statictext within w_lis_venalbaranes_facturados_old
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

type st_6 from statictext within w_lis_venalbaranes_facturados_old
integer x = 937
integer y = 128
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

type em_copias1 from editmask within w_lis_venalbaranes_facturados_old
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

type cb_2 from u_boton within w_lis_venalbaranes_facturados_old
event clicked pbm_bnclicked
integer x = 3191
integer y = 216
integer width = 384
integer height = 72
integer taborder = 80
string text = "&Imprimir"
end type

event clicked;var_tipo = 1
iF aduana.text = "Si" Then var_tipo = 3
IF valorado.text = "Si" Then
	dw_preliminar.DataObject = "report_list_venalbaranes1_facturado_old"
Else
	dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_mat_fac"

//	if cbx_matric.checked then
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_mat_fac"
//	else
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_factura"
//	end if
END IF
dw_preliminar.SetTransObject(SQLCA)
if len(em_albaran.text)=0 then
	MessageBox("Introduzca el albaran","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_albaran)
	Return
End if

var_idioma = f_idioma_venalb_venlifac(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda = f_divisa_venalb_venlifac(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
dw_preliminar.visible= FALSE
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE

IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
 dw_preliminar.reset()
 f_proceso(var_tipo)
 dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)
 IF dw_preliminar.RowCount() <> 0 Then dw_preliminar.Print(TRUE)
END IF
f_activar_campo(em_albaran)


end event

type cb_1 from u_boton within w_lis_venalbaranes_facturados_old
integer x = 3182
integer y = 140
integer width = 384
integer height = 72
integer taborder = 90
boolean bringtotop = true
string text = "&Preliminar"
end type

event clicked;var_tipo = 1
iF aduana.text = "Si" Then var_tipo = 3
IF valorado.text = "Si" Then
	dw_preliminar.DataObject = "report_list_venalbaranes1_facturado"
	lineas = 22
Else
	dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_mat_fac"
	lineas = 24
	
	lineas = 26
//	if cbx_matric.checked then
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_mat_fac"
//	else
//		dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_factura"
//	end if
END IF
dw_preliminar.Settransobject(SQLCA)	

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

type pb_imprimir_preli from picturebutton within w_lis_venalbaranes_facturados_old
boolean visible = false
integer x = 3625
integer y = 420
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

type st_13 from statictext within w_lis_venalbaranes_facturados_old
integer x = 1568
integer y = 136
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

type cabecera from dropdownlistbox within w_lis_venalbaranes_facturados_old
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

type gb_1 from groupbox within w_lis_venalbaranes_facturados_old
integer x = 3163
integer y = 96
integer width = 439
integer height = 212
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_7 from statictext within w_lis_venalbaranes_facturados_old
integer x = 27
integer y = 336
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

type st_cliente from statictext within w_lis_venalbaranes_facturados_old
integer x = 535
integer y = 336
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

type st_codcli from statictext within w_lis_venalbaranes_facturados_old
integer x = 329
integer y = 336
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

type st_pagina from statictext within w_lis_venalbaranes_facturados_old
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

type gb_3 from groupbox within w_lis_venalbaranes_facturados_old
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

type uo_1 from u_selec_impresoras within w_lis_venalbaranes_facturados_old
integer x = 27
integer y = 436
integer taborder = 60
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type st_14 from statictext within w_lis_venalbaranes_facturados_old
integer x = 1568
integer y = 232
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

type valorado from dropdownlistbox within w_lis_venalbaranes_facturados_old
integer x = 1833
integer y = 220
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

type aduana from dropdownlistbox within w_lis_venalbaranes_facturados_old
integer x = 1207
integer y = 212
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

type st_22 from statictext within w_lis_venalbaranes_facturados_old
integer x = 942
integer y = 224
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
string text = "Aduana:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_matric from checkbox within w_lis_venalbaranes_facturados_old
integer x = 3223
integer y = 324
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

type gb_5 from groupbox within w_lis_venalbaranes_facturados_old
integer x = 3163
integer y = 288
integer width = 439
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_preliminar from datawindow within w_lis_venalbaranes_facturados_old
boolean visible = false
integer y = 540
integer width = 3739
integer height = 2492
string dataobject = "report_list_venalbaranes1_facturado_old"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type uo_manejo from u_manejo_datawindow within w_lis_venalbaranes_facturados_old
boolean visible = false
integer x = 3150
integer y = 376
integer width = 599
integer height = 160
end type

event valores;call super::valores;dw_data =dw_preliminar
f_pagina()
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

