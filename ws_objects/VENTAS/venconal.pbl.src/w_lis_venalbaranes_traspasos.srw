$PBExportHeader$w_lis_venalbaranes_traspasos.srw
forward
global type w_lis_venalbaranes_traspasos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_venalbaranes_traspasos
end type
type st_2 from statictext within w_lis_venalbaranes_traspasos
end type
type em_anyo from u_em_campo within w_lis_venalbaranes_traspasos
end type
type em_albaran from u_em_campo within w_lis_venalbaranes_traspasos
end type
type st_3 from statictext within w_lis_venalbaranes_traspasos
end type
type st_6 from statictext within w_lis_venalbaranes_traspasos
end type
type em_copias1 from editmask within w_lis_venalbaranes_traspasos
end type
type cb_imprimir_albaran from u_boton within w_lis_venalbaranes_traspasos
end type
type cb_preliminar_albaran from u_boton within w_lis_venalbaranes_traspasos
end type
type pb_imprimir_preli from picturebutton within w_lis_venalbaranes_traspasos
end type
type st_13 from statictext within w_lis_venalbaranes_traspasos
end type
type cabecera from dropdownlistbox within w_lis_venalbaranes_traspasos
end type
type gb_1 from groupbox within w_lis_venalbaranes_traspasos
end type
type st_7 from statictext within w_lis_venalbaranes_traspasos
end type
type st_cliente from statictext within w_lis_venalbaranes_traspasos
end type
type st_codcli from statictext within w_lis_venalbaranes_traspasos
end type
type st_pagina from statictext within w_lis_venalbaranes_traspasos
end type
type uo_1 from u_selec_impresoras within w_lis_venalbaranes_traspasos
end type
type st_14 from statictext within w_lis_venalbaranes_traspasos
end type
type valorado from dropdownlistbox within w_lis_venalbaranes_traspasos
end type
type aduana from dropdownlistbox within w_lis_venalbaranes_traspasos
end type
type st_22 from statictext within w_lis_venalbaranes_traspasos
end type
type pb_preliminar_albaran from picturebutton within w_lis_venalbaranes_traspasos
end type
type pb_imprimir_albaran from picturebutton within w_lis_venalbaranes_traspasos
end type
type cb_imprimir_cmr from u_boton within w_lis_venalbaranes_traspasos
end type
type cb_preliminar_cmr from u_boton within w_lis_venalbaranes_traspasos
end type
type pb_preliminar_cmr from picturebutton within w_lis_venalbaranes_traspasos
end type
type pb_imprimir_cmr from picturebutton within w_lis_venalbaranes_traspasos
end type
type uo_manejo from u_manejo_datawindow within w_lis_venalbaranes_traspasos
end type
type gb_cmr from groupbox within w_lis_venalbaranes_traspasos
end type
type dw_preliminar from datawindow within w_lis_venalbaranes_traspasos
end type
type sle_numdoc from u_em_campo within w_lis_venalbaranes_traspasos
end type
type uo_tipo_traspaso from u_em_campo_2 within w_lis_venalbaranes_traspasos
end type
type em_fecha from u_em_campo within w_lis_venalbaranes_traspasos
end type
type gb_4 from groupbox within w_lis_venalbaranes_traspasos
end type
type gb_2 from groupbox within w_lis_venalbaranes_traspasos
end type
type gb_5 from groupbox within w_lis_venalbaranes_traspasos
end type
type gb_3 from groupbox within w_lis_venalbaranes_traspasos
end type
end forward

global type w_lis_venalbaranes_traspasos from w_int_con_empresa
integer width = 3712
integer height = 2100
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_albaran em_albaran
st_3 st_3
st_6 st_6
em_copias1 em_copias1
cb_imprimir_albaran cb_imprimir_albaran
cb_preliminar_albaran cb_preliminar_albaran
pb_imprimir_preli pb_imprimir_preli
st_13 st_13
cabecera cabecera
gb_1 gb_1
st_7 st_7
st_cliente st_cliente
st_codcli st_codcli
st_pagina st_pagina
uo_1 uo_1
st_14 st_14
valorado valorado
aduana aduana
st_22 st_22
pb_preliminar_albaran pb_preliminar_albaran
pb_imprimir_albaran pb_imprimir_albaran
cb_imprimir_cmr cb_imprimir_cmr
cb_preliminar_cmr cb_preliminar_cmr
pb_preliminar_cmr pb_preliminar_cmr
pb_imprimir_cmr pb_imprimir_cmr
uo_manejo uo_manejo
gb_cmr gb_cmr
dw_preliminar dw_preliminar
sle_numdoc sle_numdoc
uo_tipo_traspaso uo_tipo_traspaso
em_fecha em_fecha
gb_4 gb_4
gb_2 gb_2
gb_5 gb_5
gb_3 gb_3
end type
global w_lis_venalbaranes_traspasos w_lis_venalbaranes_traspasos

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli
Dec{4}  var_total
integer lineas = 22
integer lnpie,contador,var_tipo
String  var_clase,c,des,referencia,is_tipo_traspaso,is_observaciones
long v_pedido,ant_pedido
boolean automatico = false

//str_almparamtrasp istr_almparamtrasp

end variables

forward prototypes
public subroutine f_pagina ()
public subroutine f_valores (integer registro, integer tipo)
public subroutine f_proceso (integer tipo)
end prototypes

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")
end subroutine

public subroutine f_valores (integer registro, integer tipo);long     var_anyo,var_albaran,lineas_deposito
String   var_tipo_cliente,var_cliente,texto1,texto2,texto3,texto,var_serie,var_envio,var_deposito,texto_referencia,var_numpedcli
Datetime var_falbaran

var_anyo    = year(date(em_fecha.text))//Dec(em_anyo.text)
var_albaran = dec(sle_numdoc.text)//Dec(em_albaran.text)

//SELECT venalb.falbaran,
//		 venalb.cliente,
//		 venalb.textcomercial1,
//		 venalb.textaduanaesp1, 
//		 venalb.textaduanaext1,
//       venalb.serie,
//		 venalb.envio
//INTO   :var_falbaran,
//		 :var_cliente, 
//	    :texto1,
//		 :texto2,
//		 :texto3,
//	    :var_serie,
//		 :var_envio
//FROM   venalb  
//Where  empresa = :codigo_empresa
//And    anyo    = :var_anyo
//And    albaran= :var_albaran;

var_falbaran = datetime(date(em_fecha.text))
var_cliente = ""//f_empresas_genter_codigo_cli_autfra(codigo_empresa)
texto1 = ""
texto2 = ""
texto3 = ""
var_serie = f_serie_venclientes(codigo_empresa,var_cliente)
var_envio = ""


//select count(*)
//into   :lineas_deposito
//from   venlialb
//Where  empresa = :codigo_empresa
//And    anyo    = :var_anyo
//And    albaran = :var_albaran
//and    deposito = 'S';

lineas_deposito = 0

if isnull(lineas_deposito) then lineas_deposito = 0

if lineas_deposito > 0 then
	var_deposito = "S"
else
	var_deposito = "N"
end if

CHOOSE CASE tipo
	CASE 1
		texto = texto1
	CASE 2
		texto = texto2
	CASE 3
		texto = texto3
END CHOOSE
if v_pedido<>ant_pedido then //meles
//	meles
	dw_preliminar.InsertRow(registro)
	if IsNull(referencia) or referencia="" then
		texto_referencia=""
	else
		texto_referencia="   S/Ref. "+referencia
	end If	
	texto_referencia=" Ped.  "+string(v_pedido)+texto_referencia

	dw_preliminar.SetItem(registro,"texto_referencia",texto_referencia)
	ant_pedido = v_pedido
	//fin meles
	IF cabecera.text = "Si" Then
		dw_preliminar.SetItem(registro,"ver_cabecera","S")
	ELSE
		dw_preliminar.SetItem(registro,"ver_cabecera","N")
	END IF
	if Trim(var_idioma) = "1" Then var_idioma="3"

	if isnull(var_numpedcli) then var_numpedcli = ""
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
	dw_preliminar.SetItem(registro,"numpedcli",var_numpedcli)	
	dw_preliminar.SetItem(registro,"observaciones",is_observaciones)
	IF Int(registro/lineas)  * lineas = registro Then 
		dw_preliminar.SetItem(registro,"fin",1)
	ELSE
		dw_preliminar.SetItem(registro,"fin",2)
	END IF
	registro = registro+1
end if //finmeles

contador=registro

IF cabecera.text = "Si" Then
	dw_preliminar.SetItem(registro,"ver_cabecera","S")
ELSE
	dw_preliminar.SetItem(registro,"ver_cabecera","N")
END IF

if isnull(var_numpedcli) then var_numpedcli = ""
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
dw_preliminar.SetItem(registro,"numpedcli",var_numpedcli)	
dw_preliminar.SetItem(registro,"observaciones",is_observaciones)

IF Int(registro/lineas)  * lineas = registro Then 
	dw_preliminar.SetItem(registro,"fin",1)
ELSE
	dw_preliminar.SetItem(registro,"fin",2)
END IF


end subroutine

public subroutine f_proceso (integer tipo);Dec{0}   var_anyo,var_albaran,resto,re,var_paginas,var_ejercicio,total_cajas
long     va,va2,ll_donde
String   textpie[],pie,pie1,pie2,pie3,letra,var_articulo,tipo_iva,tipo_recargo,puntos
String   var_tono,textopie2,cadena,texto_iva,texto_recargo,var_tipo_pallet,var_caja
Integer  reg,reg1
Dec{4}   var_calibre,var_cantidad,acumulado,dto1,impdto1,dto2,impdto2,dto3,impdto3,&
		   dto4,impdto4,dtopp,impdtopp,aculumado,dtoesp,precio,cantidad,bruto,importe,iva,recargo,importeiva,importerecargo
DateTime var_falbaran
String   var_tipo_unidad,textdto1,textdto2,textdto3,textdto4,tipodto1,&
         tipodto2,tipodto3,tipodto4,tipo_cliente,linea
String   sel,texto_albaran_cliente,var_cliente
Dec{4}   importedto1,importedto2,importedto3,importedto4,importedtopp,var_cantidad_pallets,var_cantidad_pico
long ll_pallets,ll_cajas
string ls_tipo_pallet,ls_caja

DataStore dw_proceso			

dw_preliminar.SetRedraw(FALSE)
dw_preliminar.enabled = FALSE


var_total   = 0
puntos      = "........................................"
contador    = 0
acumulado   = 0
importedto1 = 0
importedto2 = 0
importedto3 = 0
importedto4 = 0
importedtopp= 0 
var_anyo    = year(date(em_fecha.text))//Dec(em_anyo.text)
var_albaran = dec(sle_numdoc.text)//Dec(em_albaran.text)

//Select dtoesp1,tipodto1,explicaciondto1,
//		 dtoesp2,tipodto2,explicaciondto2,
//		 dtoesp3,tipodto3,explicaciondto3,
//		 dtoesp4,tipodto4,explicaciondto4,
//		 dtopp,textcomercial2,textaduanaesp2,
//		 textaduanaext2,tipoiva,
//		 cliente
//Into   :dto1,:tipodto1,:textdto1,
//       :dto2,:tipodto2,:textdto2,
//       :dto3,:tipodto3,:textdto3,
//       :dto4,:tipodto4,:textdto4,
//		 :dtopp,:pie1,:pie2,:pie3,
//		 :tipo_iva,:var_cliente
//From   venalb
//Where  empresa = :codigo_empresa
//And    anyo    = :var_anyo
//And    albaran= :var_albaran;

dto1 = 0
tipodto1 = ""
textdto1 = ""
dto2 = 0
tipodto2 = ""
textdto2 = ""
dto3 = 0
tipodto3 = ""
textdto3 = ""
dto4 = 0
tipodto4 = ""
textdto4 = ""
dtopp = 0
pie1 = ""
pie2 = ""
pie3 = ""
tipo_iva = ""
var_cliente = ""//f_empresas_genter_codigo_cli_autfra(codigo_empresa)

var_ejercicio = f_ejercicio_activo(codigo_empresa)

//SELECT contaiva.iva,contaiva.recargo,contaiva.descripcion  
//INTO   :iva,:tipo_recargo,:texto_iva  
//FROM   contaiva  
//WHERE ( contaiva.ejercicio = :var_ejercicio ) 
//AND  	( contaiva.empresa = :codigo_empresa ) 
//AND  	( contaiva.tipoiva = :tipo_iva )   ;
		
iva = 0
tipo_recargo = ""
texto_iva = ""
		
IF Not IsNull(tipo_recargo) and Trim(tipo_recargo) <> "" Then
	SELECT  contaiva.iva,contaiva.descripcion INTO :recargo,:texto_recargo
	 FROM   contaiva  
	WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
			( contaiva.empresa = :codigo_empresa ) AND  
			( contaiva.tipoiva = :tipo_recargo )   ;			
END IF


//---------------------------------------------------------------------

f_mascara_columna(dw_preliminar,"precio",f_mascara_precios_fra_moneda(var_moneda))
f_mascara_columna(dw_preliminar,"total",f_mascara_moneda(var_moneda))

//Imprimimos en el pie los textos del cliente
texto_albaran_cliente = ""//f_texto_albaran_venclientes(codigo_empresa,var_cliente)

va2 = len(texto_albaran_cliente)

long ll_contador_letras

cadena = ""
ll_contador_letras = 0

For va = 1 To va2
	letra= Mid(texto_albaran_cliente,va,1)
	cadena = cadena + letra
	ll_contador_letras ++
	IF Asc(Mid(texto_albaran_cliente,va,2))= 13 or ll_contador_letras = 135 Then
			lnpie = lnpie +1
			IF Asc(Mid(pie,va,2))= 13 then
				textpie[lnpie] = Mid(cadena,1,len(cadena) - 1)
				cadena = ""
				va = va +1
			else
				textpie[lnpie] = cadena
				cadena = ""						
			end if
			ll_contador_letras = 0			
	END IF
Next
IF Trim(cadena)<> "" Then
		lnpie = lnpie +1
		textpie[lnpie] = cadena
END IF
//Fin Imprimimos en el pie los textos del cliente

//Observaciones
//Sel = "SELECT isnull(almacenmovimientos.observaciones,'') as observaciones "+&
//		"FROM almacenmovimientos "+&
//		"WHERE ( almacenmovimientos.empresa = '"+codigo_empresa+"' ) AND "+&
//		"		( almacenmovimientos.fecha_mov = '"+string(datetime(date(em_fecha.text)),formato_fecha_cursores)+"' ) AND "+&
//		"		( almacenmovimientos.tipomov = '102' or almacenmovimientos.tipomov = '103' ) AND "+&
//		"		( almacenmovimientos.situacion <> 'A' ) AND "+&
//		"		( almacenmovimientos.numdoc = '"+sle_numdoc.text+"' ) and "+&
//		"     ( isnull(almacenmovimientos.observaciones,'') <> '' ) and "+&
//		"     ( almacenmovimientos.almacen in (select codigo from almalmacen where empresa = '"+codigo_empresa+"' and zona_carga = '1')) "+&
//		"GROUP BY isnull(almacenmovimientos.observaciones,'') "
//
//dw_proceso= f_cargar_cursor(sel)

reg = 0 //dw_proceso.RowCount()

For reg1 = 1 to reg
	is_observaciones += dw_proceso.object.observaciones[reg1]
	
	if reg1 < reg then is_observaciones = is_observaciones+char(13)
next
//Observaciones

Sel = "SELECT almacenmovimientos.articulo, "+&
      "       abs(isnull(sum(almacenmovimientos.cantidads - almacenmovimientos.cantidade),0)) as cantidad, "+&
      "       almacenmovimientos.calidad, "+&
      "       almacenmovimientos.calibre, "+&
      "       almacenmovimientos.tipo_pallet, "+&
      "       almacenmovimientos.caja, "+&
      "       almacenmovimientos.tonochar "+&
		"FROM almacenmovimientos "+&
		"WHERE ( almacenmovimientos.empresa = '"+codigo_empresa+"' ) AND "+&
		"		( almacenmovimientos.fecha_mov = '"+string(datetime(date(em_fecha.text)),formato_fecha_cursores)+"' ) AND "+&
		"		( almacenmovimientos.tipomov = '102' or almacenmovimientos.tipomov = '103' ) AND "+&
		"		( almacenmovimientos.situacion <> 'A' ) AND "+&
		"		( almacenmovimientos.numdoc = '"+sle_numdoc.text+"' ) and "+&
		"     ( almacenmovimientos.almacen in (select codigo from almalmacen where empresa = '"+codigo_empresa+"' and zona_carga = '1')) "+&
		"GROUP BY almacenmovimientos.articulo, "+&
      "       almacenmovimientos.calidad, "+&
      "       almacenmovimientos.calibre, "+&
      "       almacenmovimientos.tipo_pallet, "+&
      "       almacenmovimientos.caja, "+&
      "       almacenmovimientos.tonochar, "+&
		"       almacenmovimientos.empresa , "+&
		"		  almacenmovimientos.anyo , "+&
		"		  almacenmovimientos.f_alta , "+&
		"		  almacenmovimientos.nummov "	+&	
		"ORDER BY almacenmovimientos.empresa ASC, "+&
		"			almacenmovimientos.anyo ASC, "+&
		"			almacenmovimientos.f_alta DESC, "+&
		"			almacenmovimientos.nummov ASC"

Sel = "SELECT isnull(alm_bultos_lineas.articulo,'') as articulo, "+&
      "		 sum(cantidad) as cantidad, "+&
      "		 isnull(alm_bultos_lineas.calidad,'') as calidad, "+&
      "		 isnull(alm_bultos_lineas.calibre,0) as calibre, "+&
      "		 isnull(alm_bultos.tipo_pallet,'') as tipo_pallet, "+& 
      "		 isnull(alm_bultos_lineas.caja,'') as caja, "+&
      "		 isnull(alm_bultos_lineas.tono,'') as tonochar "+&  
      "FROM   alm_bultos, "+&
      "		 alm_bultos_lineas, "+&
      "		 almubimapa_codbar "+&
      "WHERE   ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
      "and  	( alm_bultos.id_ubicacion = almubimapa_codbar.id ) "+&
      "and   ( ( alm_bultos.empresa = '1' ) "+&
      "AND  	( almubimapa_codbar.almacen = '' ) "+&
      "AND  	( almubimapa_codbar.zona = '' ) "+&
      "AND  	( almubimapa_codbar.fila = 1 ) "+&
      "AND  	( almubimapa_codbar.altura = 1 ) ) "+&
      "GROUP BY alm_bultos_lineas.articulo, "+&
      "         alm_bultos_lineas.calidad, "+&
      "         alm_bultos_lineas.calibre, "+&
      "         alm_bultos.tipo_pallet, "+&
      "         alm_bultos_lineas.caja, "+&
      "         alm_bultos_lineas.tono"


dw_proceso= f_cargar_cursor(sel)		
reg = dw_proceso.RowCount()

For reg1 = 1 to reg
	//Vamos a separar pallets y picos
	var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad")
	var_articulo = dw_proceso.GetItemSTring(reg1,"articulo")
	ls_tipo_pallet = dw_proceso.GetItemSTring(reg1,"tipo_pallet")
	ls_caja = dw_proceso.GetItemSTring(reg1,"caja")
	
	cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
									 ls_tipo_pallet,&
									 ls_caja,&
									 0,&
									 0,&
									 var_cantidad)
							  
	ll_pallets = dec(Mid(cadena,1,6))
	ll_cajas = dec(Mid(cadena,13,6))

	if ll_cajas > 0 and ll_pallets > 0 then
		cadena = f_calculo_unidades(codigo_empresa,var_articulo,&
										 ls_tipo_pallet,&
										 ls_caja,&
										 ll_pallets,&
										 0,&
										 0)		
										 
		var_cantidad_pallets = dec(Mid(cadena,19,9))
		var_cantidad_pico = var_cantidad - var_cantidad_pallets
		if var_cantidad_pico > 0 then
			dw_proceso.object.cantidad[reg1] = var_cantidad_pallets
			ll_donde = dw_proceso.insertrow(reg1+1)
			dw_proceso.object.data[ll_donde] = dw_proceso.object.data[reg1]
			dw_proceso.object.cantidad[ll_donde] = var_cantidad_pico
			reg1 ++ 
			reg ++
		end if
	end if

next
	
IF reg <> 0 Then
	For reg1 = 1 to reg
		acumulado = 0
		contador  = contador + 1
		var_clase    = "V"//dw_proceso.GetItemString(reg1,"clase")
		v_pedido     = 0//dw_proceso.object.pedido_origen[reg1]
		referencia   = ""//dw_proceso.GetItemString(reg1,"numpedcli")		
		dtoesp       = 0//dw_proceso.GetItemNumber(reg1,"dtoesp")
		cantidad     = dw_proceso.GetItemNumber(reg1,"cantidad")
		var_tono     = dw_proceso.GetItemString(reg1,"tonochar")
//		var_tono     = ""
		var_calibre  = dw_proceso.GetItemNumber(reg1,"calibre")
		var_tipo_pallet = dw_proceso.GetItemSTring(reg1,"tipo_pallet")
		var_caja     = dw_proceso.GetItemSTring(reg1,"caja")
		CHOOSE CASE tipo
		 CASE  3
//			precio       = dw_proceso.GetItemNumber(reg1,"precio_neto_aduana")
//			bruto       = dw_proceso.GetItemNumber(reg1,"importe_aduana")
//			impdtopp      = dw_proceso.GetItemNumber(reg1,"impdtopp_aduana")
//			impdto1      = dw_proceso.GetItemNumber(reg1,"impdtoesp1_aduana")
//			impdto2      = dw_proceso.GetItemNumber(reg1,"impdtoesp2_aduana")			
//			impdto3      = dw_proceso.GetItemNumber(reg1,"impdtoesp3_aduana")			
//			impdto4      = dw_proceso.GetItemNumber(reg1,"impdtoesp4_aduana")	
			precio       = 0//dw_proceso.GetItemNumber(reg1,"precio_neto")
			bruto       = 0//dw_proceso.GetItemNumber(reg1,"importe")
			impdtopp       = 0//dw_proceso.GetItemNumber(reg1,"impdtopp")
			impdto1       = 0//dw_proceso.GetItemNumber(reg1,"impdtoesp1")
			impdto2       = 0//dw_proceso.GetItemNumber(reg1,"impdtoesp2")			
			impdto3       = 0//dw_proceso.GetItemNumber(reg1,"impdtoesp3")
			impdto4       = 0//dw_proceso.GetItemNumber(reg1,"impdtoesp4")			
		 CASE ELSE
			precio       = 0//dw_proceso.GetItemNumber(reg1,"precio_neto")
			bruto       = 0//dw_proceso.GetItemNumber(reg1,"importe")
			impdtopp       = 0//dw_proceso.GetItemNumber(reg1,"impdtopp")
			impdto1       = 0//dw_proceso.GetItemNumber(reg1,"impdtoesp1")
			impdto2       = 0//dw_proceso.GetItemNumber(reg1,"impdtoesp2")			
			impdto3       = 0//dw_proceso.GetItemNumber(reg1,"impdtoesp3")
			impdto4       = 0//dw_proceso.GetItemNumber(reg1,"impdtoesp4")
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
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		
		var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad")
		ls_tipo_pallet = dw_proceso.GetItemSTring(reg1,"tipo_pallet")
		ls_caja = dw_proceso.GetItemSTring(reg1,"caja")
		
		 cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
											 ls_tipo_pallet,&
											 ls_caja,&
											 0,&
											 0,&
											 var_cantidad)
									  
		 ll_pallets = dec(Mid(cadena,1,6))
		 //em_cajas.text = Mid(cadena,7,6)
		 ll_cajas = dec(Mid(cadena,13,6))
		 //em_cantidad.text = Mid(cadena,19,9)	
		
		dw_preliminar.SetItem(contador,"pallets",ll_pallets)
		dw_preliminar.SetItem(contador,"cajas",ll_cajas)
		dw_preliminar.SetItem(contador,"articulo",f_nombre_articulo(codigo_empresa,var_articulo))
		dw_preliminar.SetItem(contador,"codigo_articulo",dw_proceso.GetItemString(reg1,"articulo"))
		
		dw_preliminar.SetItem(contador,"tono",dw_proceso.GetItemString(reg1,"tonochar"))
//		dw_preliminar.SetItem(contador,"tono","")
		dw_preliminar.SetItem(contador,"calibre",dw_proceso.GetItemNumber(reg1,"calibre"))
		dw_preliminar.SetItem(contador,"tipo_pallet",dw_proceso.GetItemSTring(reg1,"tipo_pallet"))
		dw_preliminar.SetItem(contador,"caja",var_caja)		
		IF tipo <>3 Then
			dw_preliminar.SetItem(contador,"importe","0")
			dw_preliminar.SetItem(contador,"precio",0)
			dw_preliminar.SetItem(contador,"descuento",0)
		ELSE
			dw_preliminar.SetItem(contador,"precio",0)
			dw_preliminar.SetItem(contador,"importe","0")
			dw_preliminar.SetItem(contador,"descuento",0)
		END IF
		dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,f_formato_articulo(codigo_empresa,var_articulo)))
		dw_preliminar.SetItem(contador,"familia",f_nombre_familia(codigo_empresa,f_familia_articulo(codigo_empresa,var_articulo)))		
		if dw_proceso.GetItemString(reg1,"calidad") = '1' and var_cliente = '10208' then
			f_asignar_columna(dw_preliminar,contador,"calidad",'1ª')
		else		
			dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemString(reg1,"calidad")))
		end if
		var_tipo_unidad=f_unidad_articulo(codigo_empresa,var_articulo)
		var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad")
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad <> "1" Then
				dw_preliminar.SetItem(contador,"piezas",var_cantidad)
				//dw_preliminar.SetItem(contador,"metros",f_calculo_metros_desde_piezas(codigo_empresa,var_articulo,dw_proceso.GetItemSTring(reg1,"caja"),var_cantidad))
				dw_preliminar.SetItem(contador,"metros",0)
			ELSE
				dw_preliminar.SetItem(contador,"piezas",0)
				dw_preliminar.SetItem(contador,"metros",var_cantidad)
			END IF
		ELSE
			//dw_preliminar.SetItem(contador,"piezas",String(var_cantidad,"#######"))
			dw_preliminar.SetItem(contador,"piezas",var_cantidad)
			dw_preliminar.SetItem(contador,"metros",0)
			dw_preliminar.SetItem(contador,"articulo",f_nombre_articulo(codigo_empresa,var_articulo))
			//dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####")+ " " + dw_proceso.GetItemString(reg1,"descripcion"))
		END IF
		
		IF tipo <>3 then
			var_total = var_total + 0
		ELSE
			var_total = var_total + 0
		END IF
		C = ""
		IF var_clase = "M" Then C = "(MUESTRAS)"
		IF var_clase = "S" Then C = "(SIN CARGO)"
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
				dw_preliminar.SetItem(contador,"texto",String(dto1,"##.##") + "% " +textdto1+puntos )
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
				dw_preliminar.SetItem(contador,"texto",String(dto2,"##.##") + "% " +textdto2+puntos)
		
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
				dw_preliminar.SetItem(contador,"texto",String(dto3,"##.##") + "% " +textdto3+puntos)
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
				dw_preliminar.SetItem(contador,"texto",String(dto4,"##.##") + "% " +textdto4+puntos)
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

Sel = " SELECT * " +&
		" FROM   venlialb  "+&
		" WHERE  venlialb.empresa = '"+ codigo_empresa +"'" +&
		" AND    venlialb.anyo = "+String(var_anyo,"#####0")+&
		" AND    venlialb.albaran = "+String(var_albaran,"########0") +&
		" AND    venlialb.control_descuentos = 'N'   "+&
		" and 0 = 1"+&
		" ORDER BY empresa ASC,anyo ASC,albaran ASC,linea ASC "
		
dw_proceso = f_cargar_cursor(sel)		
reg = dw_proceso.RowCount()

IF reg > 0 Then
	For reg1 = 1 to reg
		contador  = contador + 1
		//meles
		var_clase    = dw_proceso.GetItemString(reg1,"clase")
		v_pedido     = dw_proceso.object.pedido_origen[reg1]
		referencia   = dw_proceso.GetItemString(reg1,"numpedcli")		
		dtoesp       = dw_proceso.GetItemNumber(reg1,"dtoesp")
		cantidad     = dw_proceso.GetItemNumber(reg1,"cantidad")
		var_tono     = dw_proceso.GetItemString(reg1,"tonochar")
		var_tono     = ""
		var_calibre  = dw_proceso.GetItemNumber(reg1,"calibre")
		var_tipo_pallet = dw_proceso.GetItemSTring(reg1,"tipo_pallet")
		var_caja     = dw_proceso.GetItemSTring(reg1,"caja")
		//fin meles
		dw_preliminar.InsertRow(contador)
		f_valores(contador,tipo)
		var_articulo = dw_proceso.GetItemString(reg1,"articulo")
		dw_preliminar.SetItem(contador,"codigo_formato",f_formato_articulo(codigo_empresa,var_articulo))
		dw_preliminar.SetItem(contador,"pallets",dw_proceso.GetItemnumber(reg1,"pallets"))
		dw_preliminar.SetItem(contador,"cajas",dw_proceso.GetItemnumber(reg1,"total_cajas"))
		dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemstring(reg1,"descripcion"))
		dw_preliminar.SetItem(contador,"codigo_articulo",dw_proceso.GetItemString(reg1,"articulo"))
		dw_preliminar.SetItem(contador,"tono",dw_proceso.GetItemString(reg1,"tonochar"))
//		dw_preliminar.SetItem(contador,"tono","")
		dw_preliminar.SetItem(contador,"calibre",dw_proceso.GetItemNumber(reg1,"calibre"))
		dw_preliminar.SetItem(contador,"tipo_pallet",dw_proceso.GetItemSTring(reg1,"tipo_pallet"))
		dw_preliminar.SetItem(contador,"caja",var_caja)				
		dw_preliminar.SetItem(contador,"precio",dw_proceso.GetItemnumber(reg1,"precio"))
		dw_preliminar.SetItem(contador,"descuento",dw_proceso.GetItemnumber(reg1,"descuento"))
		dw_preliminar.SetItem(contador,"importe",String(dw_proceso.GetItemnumber(reg1,"importe"),f_mascara_moneda(var_moneda)))
		dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,dw_proceso.GetItemstring(reg1,"formato")))
		dw_preliminar.SetItem(contador,"familia",f_nombre_familia(codigo_empresa,dw_proceso.GetItemstring(reg1,"familia")))
		if dw_proceso.GetItemString(reg1,"calidad") = '1' and var_cliente = '10208' then
			f_asignar_columna(dw_preliminar,contador,"calidad",'1ª')
		else		
			dw_preliminar.SetItem(contador,"calidad",f_nombre_calidad_abr(codigo_empresa,dw_proceso.GetItemstring(reg1,"calidad")))
		end if
		var_tipo_unidad=dw_proceso.GetItemSTring(reg1,"tipo_unidad")
		var_cantidad=dw_proceso.GetItemNumber(reg1,"cantidad")
		IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
			IF var_tipo_unidad <> "1" Then
				dw_preliminar.SetItem(contador,"piezas",var_cantidad)
				dw_preliminar.SetItem(contador,"metros",0)
			ELSE
				dw_preliminar.SetItem(contador,"piezas",0)
				dw_preliminar.SetItem(contador,"metros",var_cantidad)
			END IF
		ELSE
			// Modificacion según Carlos
			//dw_preliminar.SetItem(contador,"articulo",String(var_cantidad,"####")+ " " + dw_proceso.GetItem(reg1,"descripcion"))
			dw_preliminar.SetItem(contador,"piezas",String(var_cantidad,"####"))
	   	dw_preliminar.SetItem(contador,"articulo",dw_proceso.GetItemString(reg1,"descripcion"))
	   						
		END IF
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
				dw_preliminar.SetItem(contador,"texto",String(dtopp,"##.##") + "% " +f_diccionario("PRONTO PAGO",var_idioma)+puntos)
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
		dw_preliminar.SetItem(contador,"texto_pie",textpie[reg1])
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
		dw_preliminar.SetItem(contador,"texto_pie",textpie[reg1])
		dw_preliminar.SetItem(contador,"orden","2")
	NEXT
END IF	


dw_preliminar.SetItem(contador,"texto_total",&
                  "TOTAL  "+f_nombre_moneda_abr(var_moneda) + "  #" +&
						String(var_total,f_mascara_moneda(var_moneda))+"#")
dw_preliminar.SetItem(contador,"ultima","S")
dw_preliminar.SetRedraw(TRUE)
dw_preliminar.enabled = TRUE




end subroutine

event open;call super::open;Integer r,j,copias_valorado,anyo,copias
long    albaran
string  cliente
istr_parametros.s_titulo_ventana="Listado albaranes"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))
var_tipo = 1
cabecera.text = "Si"
valorado.text = "No"
aduana.text = "No"

IF istr_parametros.i_nargumentos>1 THEN
	cabecera.text = "Si"
	
	em_fecha.text=istr_parametros.s_argumentos[2]	
	uo_tipo_traspaso.em_codigo.text=istr_parametros.s_argumentos[3]	
	sle_numdoc.text=istr_parametros.s_argumentos[4]
	
	uo_tipo_traspaso.event modificado(0,0)
	
	cliente = ""//f_empresas_genter_codigo_cli_autfra(codigo_empresa)
	
	copias          = f_num_copias_albaran_venclientes(codigo_empresa,cliente)		
	automatico = true
	em_albaran.TriggerEvent("modificado")
	istr_parametros.i_nargumentos = 0
	
	em_copias1.text = string(copias,"#0")
	valorado.text = "No"
		
	cb_imprimir_albaran.triggerevent(Clicked!)
	
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

on w_lis_venalbaranes_traspasos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_albaran=create em_albaran
this.st_3=create st_3
this.st_6=create st_6
this.em_copias1=create em_copias1
this.cb_imprimir_albaran=create cb_imprimir_albaran
this.cb_preliminar_albaran=create cb_preliminar_albaran
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_13=create st_13
this.cabecera=create cabecera
this.gb_1=create gb_1
this.st_7=create st_7
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.st_pagina=create st_pagina
this.uo_1=create uo_1
this.st_14=create st_14
this.valorado=create valorado
this.aduana=create aduana
this.st_22=create st_22
this.pb_preliminar_albaran=create pb_preliminar_albaran
this.pb_imprimir_albaran=create pb_imprimir_albaran
this.cb_imprimir_cmr=create cb_imprimir_cmr
this.cb_preliminar_cmr=create cb_preliminar_cmr
this.pb_preliminar_cmr=create pb_preliminar_cmr
this.pb_imprimir_cmr=create pb_imprimir_cmr
this.uo_manejo=create uo_manejo
this.gb_cmr=create gb_cmr
this.dw_preliminar=create dw_preliminar
this.sle_numdoc=create sle_numdoc
this.uo_tipo_traspaso=create uo_tipo_traspaso
this.em_fecha=create em_fecha
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_5=create gb_5
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_albaran
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.em_copias1
this.Control[iCurrent+8]=this.cb_imprimir_albaran
this.Control[iCurrent+9]=this.cb_preliminar_albaran
this.Control[iCurrent+10]=this.pb_imprimir_preli
this.Control[iCurrent+11]=this.st_13
this.Control[iCurrent+12]=this.cabecera
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.st_cliente
this.Control[iCurrent+16]=this.st_codcli
this.Control[iCurrent+17]=this.st_pagina
this.Control[iCurrent+18]=this.uo_1
this.Control[iCurrent+19]=this.st_14
this.Control[iCurrent+20]=this.valorado
this.Control[iCurrent+21]=this.aduana
this.Control[iCurrent+22]=this.st_22
this.Control[iCurrent+23]=this.pb_preliminar_albaran
this.Control[iCurrent+24]=this.pb_imprimir_albaran
this.Control[iCurrent+25]=this.cb_imprimir_cmr
this.Control[iCurrent+26]=this.cb_preliminar_cmr
this.Control[iCurrent+27]=this.pb_preliminar_cmr
this.Control[iCurrent+28]=this.pb_imprimir_cmr
this.Control[iCurrent+29]=this.uo_manejo
this.Control[iCurrent+30]=this.gb_cmr
this.Control[iCurrent+31]=this.dw_preliminar
this.Control[iCurrent+32]=this.sle_numdoc
this.Control[iCurrent+33]=this.uo_tipo_traspaso
this.Control[iCurrent+34]=this.em_fecha
this.Control[iCurrent+35]=this.gb_4
this.Control[iCurrent+36]=this.gb_2
this.Control[iCurrent+37]=this.gb_5
this.Control[iCurrent+38]=this.gb_3
end on

on w_lis_venalbaranes_traspasos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_albaran)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.em_copias1)
destroy(this.cb_imprimir_albaran)
destroy(this.cb_preliminar_albaran)
destroy(this.pb_imprimir_preli)
destroy(this.st_13)
destroy(this.cabecera)
destroy(this.gb_1)
destroy(this.st_7)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.st_pagina)
destroy(this.uo_1)
destroy(this.st_14)
destroy(this.valorado)
destroy(this.aduana)
destroy(this.st_22)
destroy(this.pb_preliminar_albaran)
destroy(this.pb_imprimir_albaran)
destroy(this.cb_imprimir_cmr)
destroy(this.cb_preliminar_cmr)
destroy(this.pb_preliminar_cmr)
destroy(this.pb_imprimir_cmr)
destroy(this.uo_manejo)
destroy(this.gb_cmr)
destroy(this.dw_preliminar)
destroy(this.sle_numdoc)
destroy(this.uo_tipo_traspaso)
destroy(this.em_fecha)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_5)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_venalbaranes_traspasos
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_venalbaranes_traspasos
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_albaran)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_venalbaranes_traspasos
integer x = 14
integer y = 4
integer width = 3479
integer height = 96
end type

type pb_1 from upb_salir within w_lis_venalbaranes_traspasos
integer x = 3511
integer y = 8
integer width = 142
integer height = 112
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type st_2 from statictext within w_lis_venalbaranes_traspasos
integer x = 2894
integer y = 132
integer width = 302
integer height = 80
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

type em_anyo from u_em_campo within w_lis_venalbaranes_traspasos
integer x = 3209
integer y = 128
integer width = 192
integer height = 80
integer taborder = 0
end type

type em_albaran from u_em_campo within w_lis_venalbaranes_traspasos
integer x = 3442
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

type st_3 from statictext within w_lis_venalbaranes_traspasos
integer x = 3401
integer y = 112
integer width = 46
integer height = 92
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
string text = "-"
boolean focusrectangle = false
end type

type st_6 from statictext within w_lis_venalbaranes_traspasos
integer x = 1083
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
string text = "Copias :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_copias1 from editmask within w_lis_venalbaranes_traspasos
integer x = 1353
integer y = 136
integer width = 192
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
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

type cb_imprimir_albaran from u_boton within w_lis_venalbaranes_traspasos
event clicked pbm_bnclicked
integer x = 2171
integer y = 328
integer width = 320
integer height = 84
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Imprimir"
end type

event clicked;var_tipo = 1
iF aduana.text = "Si" Then var_tipo = 3

dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_traspas"	
lineas = 22

dw_preliminar.settransobject(sqlca)

//if len(em_albaran.text)=0 then
//	MessageBox("Introduzca la albaran","" ,Exclamation!, OK!, 2)
//   f_activar_campo(em_albaran)
//	Return
//End if

var_idioma = f_idioma_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
var_moneda = f_divisa_venalb(codigo_empresa,Dec(em_anyo.text),Dec(em_albaran.text))
dw_preliminar.visible= FALSE
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE
IF em_copias1.text <> "0" and Trim(em_copias1.text) <> "" Then
	dw_preliminar.reset()
	f_proceso(var_tipo)
	dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)
	IF dw_preliminar.RowCount() <> 0 Then 
		if automatico then
			if valorado.text = "Si" then
				dw_preliminar.print(true)
			else
				dw_preliminar.print(true)		
			end if
		else
			dw_preliminar.print(true)
		end if
	end if	
END IF
f_activar_campo(em_albaran)


end event

type cb_preliminar_albaran from u_boton within w_lis_venalbaranes_traspasos
integer x = 2171
integer y = 244
integer width = 320
integer height = 84
integer taborder = 100
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Preliminar"
end type

event clicked;var_tipo = 1
iF aduana.text = "Si" Then var_tipo = 3

dw_preliminar.DataObject = "report_list_venalbaranes1_sinval_traspas"
lineas = 22

dw_preliminar.settransobject(sqlca)
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

type pb_imprimir_preli from picturebutton within w_lis_venalbaranes_traspasos
boolean visible = false
integer x = 3506
integer y = 328
integer width = 101
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\print.bmp"
end type

event clicked;OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_albaran)
end event

type st_13 from statictext within w_lis_venalbaranes_traspasos
integer x = 1568
integer y = 140
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

type cabecera from dropdownlistbox within w_lis_venalbaranes_traspasos
integer x = 1833
integer y = 128
integer width = 192
integer height = 220
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
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

type gb_1 from groupbox within w_lis_venalbaranes_traspasos
integer x = 2053
integer y = 192
integer width = 453
integer height = 236
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Albarán"
end type

type st_7 from statictext within w_lis_venalbaranes_traspasos
integer x = 1472
integer y = 440
integer width = 297
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
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

type st_cliente from statictext within w_lis_venalbaranes_traspasos
integer x = 1979
integer y = 440
integer width = 1490
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
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

type st_codcli from statictext within w_lis_venalbaranes_traspasos
integer x = 1774
integer y = 440
integer width = 201
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
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

type st_pagina from statictext within w_lis_venalbaranes_traspasos
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

type uo_1 from u_selec_impresoras within w_lis_venalbaranes_traspasos
integer x = 27
integer y = 436
integer height = 100
integer taborder = 70
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type st_14 from statictext within w_lis_venalbaranes_traspasos
integer x = 1568
integer y = 240
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

type valorado from dropdownlistbox within w_lis_venalbaranes_traspasos
integer x = 1833
integer y = 228
integer width = 192
integer height = 220
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
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

type aduana from dropdownlistbox within w_lis_venalbaranes_traspasos
integer x = 1353
integer y = 224
integer width = 192
integer height = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 700
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

type st_22 from statictext within w_lis_venalbaranes_traspasos
integer x = 1088
integer y = 236
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

type pb_preliminar_albaran from picturebutton within w_lis_venalbaranes_traspasos
integer x = 2066
integer y = 244
integer width = 101
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\prelimi.bmp"
end type

event clicked;cb_preliminar_albaran.triggerevent(clicked!)
end event

type pb_imprimir_albaran from picturebutton within w_lis_venalbaranes_traspasos
integer x = 2066
integer y = 328
integer width = 101
integer height = 84
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;cb_imprimir_albaran.triggerevent(clicked!)
end event

type cb_imprimir_cmr from u_boton within w_lis_venalbaranes_traspasos
integer x = 2624
integer y = 328
integer width = 320
integer height = 84
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Imprimir"
end type

event clicked;int  anyo
long albaran

//Variables de conversion
anyo		= dec(em_anyo.text)
albaran	= dec(em_albaran.text)


dw_preliminar.reset()
dw_preliminar.dataobject = "report_list_cmr"
dw_preliminar.SetRedraw(FALSE)
f_carga_dw_cmr(codigo_empresa,anyo,string(albaran),dw_preliminar)
dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "75" + ")")
dw_preliminar.visible = TRUE
uo_manejo.visible = TRUE
pb_imprimir_preli.visible = TRUE
dw_preliminar.SetRedraw(TRUE)

f_imprimir_datawindow(dw_preliminar)
end event

type cb_preliminar_cmr from u_boton within w_lis_venalbaranes_traspasos
integer x = 2624
integer y = 244
integer width = 320
integer height = 84
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Preliminar"
end type

event clicked;int  anyo
long albaran

//Variables de conversion
anyo		= dec(em_anyo.text)
albaran	= dec(em_albaran.text)


dw_preliminar.reset()
dw_preliminar.dataobject = "report_list_cmr"
dw_preliminar.SetRedraw(FALSE)
f_carga_dw_cmr(codigo_empresa,anyo,string(albaran),dw_preliminar)
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "75" + ")")
dw_preliminar.visible = TRUE
uo_manejo.visible = TRUE
pb_imprimir_preli.visible = TRUE
dw_preliminar.SetRedraw(TRUE)


end event

type pb_preliminar_cmr from picturebutton within w_lis_venalbaranes_traspasos
integer x = 2519
integer y = 244
integer width = 101
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\prelimi.bmp"
end type

event clicked;cb_preliminar_cmr.triggerevent(clicked!)
end event

type pb_imprimir_cmr from picturebutton within w_lis_venalbaranes_traspasos
integer x = 2519
integer y = 328
integer width = 101
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;cb_imprimir_cmr.triggerevent(clicked!)
end event

type uo_manejo from u_manejo_datawindow within w_lis_venalbaranes_traspasos
boolean visible = false
integer x = 3035
integer y = 280
integer width = 599
integer height = 160
end type

event valores;call super::valores;dw_data =dw_preliminar
f_pagina()
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_cmr from groupbox within w_lis_venalbaranes_traspasos
integer x = 2505
integer y = 192
integer width = 453
integer height = 236
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "CMR"
end type

type dw_preliminar from datawindow within w_lis_venalbaranes_traspasos
boolean visible = false
integer x = 14
integer y = 544
integer width = 3630
integer height = 1256
string dataobject = "report_list_venalbaranes1_sinval_traspas"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type sle_numdoc from u_em_campo within w_lis_venalbaranes_traspasos
integer x = 370
integer y = 160
integer taborder = 70
boolean bringtotop = true
string mask = "######"
end type

event modificado;call super::modificado;string movimientos[2]
datetime fecha
fecha = Datetime(Date(em_fecha.text))
//if ante_numdoc=sle_numdoc.text then return

//f_cargar_str_almparamtrasp(codigo_empresa,is_tipo_traspaso,istr_almparamtrasp)

movimientos[1] = "102"//istr_almparamtrasp.almtipomov_tipomov_e
movimientos[2] = "103"//istr_almparamtrasp.almtipomov_tipomov_s 

//dw_3.retrieve(codigo_empresa,fecha,movimientos,sle_numdoc.text)
end event

type uo_tipo_traspaso from u_em_campo_2 within w_lis_venalbaranes_traspasos
event destroy ( )
integer x = 32
integer y = 312
integer width = 1010
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tipo_traspaso.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;string movimientos[2]
datetime fecha
fecha = Datetime(Date(em_fecha.text))
//
is_tipo_traspaso = uo_tipo_traspaso.em_codigo.text
uo_tipo_traspaso.em_campo.text = uo_tipo_traspaso.em_codigo.text//f_descripcion_almparamtrasp(codigo_empresa,uo_tipo_traspaso.em_codigo.text)

IF Trim(uo_tipo_traspaso.em_campo.text)="" THEN 
 f_activar_campo(uo_tipo_traspaso.em_campo)
 uo_tipo_traspaso.em_codigo.text=""
else
	
/// cargamos los parametros de control de permisos 
/// según el tipo de traspaso
//f_cargar_str_almparamtrasp(codigo_empresa,is_tipo_traspaso,istr_almparamtrasp)

	
movimientos[1] = '102'//istr_almparamtrasp.almtipomov_tipomov_e
movimientos[2] = '103'//istr_almparamtrasp.almtipomov_tipomov_s 

END IF




/// moVIMIENTOS DE ENTRADA Y SAI
end event

event getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION DE TRASPASO"
ue_datawindow     = "dw_ayuda_almparamtrasp"
ue_filtro         = "" 
end event

type em_fecha from u_em_campo within w_lis_venalbaranes_traspasos
integer x = 32
integer y = 164
integer width = 302
integer taborder = 70
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_4 from groupbox within w_lis_venalbaranes_traspasos
integer x = 352
integer y = 116
integer width = 293
integer height = 148
integer taborder = 270
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Nº Docu."
end type

type gb_2 from groupbox within w_lis_venalbaranes_traspasos
integer x = 18
integer y = 264
integer width = 1047
integer height = 148
integer taborder = 280
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo Traspaso"
end type

type gb_5 from groupbox within w_lis_venalbaranes_traspasos
integer x = 18
integer y = 116
integer width = 334
integer height = 148
integer taborder = 280
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type gb_3 from groupbox within w_lis_venalbaranes_traspasos
integer x = 5
integer y = 80
integer width = 2048
integer height = 348
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

