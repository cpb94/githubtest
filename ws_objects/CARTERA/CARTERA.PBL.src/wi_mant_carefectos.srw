$PBExportHeader$wi_mant_carefectos.srw
$PBExportComments$€
forward
global type wi_mant_carefectos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_carefectos
end type
type em_anyo from u_em_campo within wi_mant_carefectos
end type
type st_ntelefonos from statictext within wi_mant_carefectos
end type
type gb_1 from groupbox within wi_mant_carefectos
end type
type pb_1 from upb_imprimir within wi_mant_carefectos
end type
type dw_listado1 from datawindow within wi_mant_carefectos
end type
type cb_1 from commandbutton within wi_mant_carefectos
end type
end forward

shared variables

end variables

global type wi_mant_carefectos from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 3008
integer height = 2084
pb_calculadora pb_calculadora
em_anyo em_anyo
st_ntelefonos st_ntelefonos
gb_1 gb_1
pb_1 pb_1
dw_listado1 dw_listado1
cb_1 cb_1
end type
global wi_mant_carefectos wi_mant_carefectos

type variables
	// Tipo Tercero

string ic_tipoter
datawindowchild idwc_nompro
datawindowchild idwc_codpostal
datawindowchild idwc_codpais,idwc_codmoneda
String espera =""
string  antecliente
dec    anteimporte
end variables

event open;call super::open;//f_posicion_inicio(This)
pb_calculadora.visible=FALSE

istr_parametros.s_titulo_ventana = "Mantenimiento efectos"
//istr_parametros.s_listado        = "report_carefectos"

This.title=istr_parametros.s_titulo_ventana

em_anyo.text=string(year(today()))
f_mascara_columna(dw_1,"anyofra",f_mascara_decimales(0))
//f_mascara_columna(dw_1,"factura",f_mascara_decimales(0))
f_mascara_columna(dw_1,"recibo",f_mascara_decimales(0))
f_mascara_columna(dw_1,"importe",f_mascara_decimales(2))
f_mascara_columna(dw_1,"divisas",f_mascara_decimales(2))
f_mascara_columna(dw_1,"remesa",f_mascara_decimales(0))
f_mascara_columna(dw_1,"efectoagrupa",f_mascara_decimales(0))
f_mascara_columna(dw_1,"anyoagrupa",f_mascara_decimales(0))


  // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      em_anyo.text=istr_parametros.s_argumentos[2]
		sle_valor.text=istr_parametros.s_argumentos[3]
		espera=istr_parametros.s_argumentos[4]
		
      IF Trim(em_anyo.text)<>""and Not IsNull(em_anyo.text)and Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		   wi_mant_carefectos.triggerevent("ue_recuperar")
      END IF 
	END IF

f_activar_campo(sle_valor)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(trim(em_anyo.text))
 criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)
 
 seleccion    =  criterio[1]+criterio[2]+criterio[3]

 tabla        = "carefectos"

 dw_1.Retrieve(codigo_empresa,dec(em_anyo.text),dec(sle_valor.text))
if dw_1.rowcount() > 0 then 
	antecliente = dw_1.object.cliente[dw_1.getrow()]
	anteimporte = dw_1.object.importe[dw_1.getrow()]
else
	antecliente = ""
	anteimporte = 0
end if
CALL Super::ue_recuperar



end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"anyo",dec(em_anyo.text))
dw_1.setitem(dw_1.getrow(),"orden",dec(sle_valor.text))






end event

event ue_desactiva_claves;call super::ue_desactiva_claves;
		// Activamos los campos clave añadidos


sle_valor.enabled   = FALSE
em_anyo.enabled   = FALSE
pb_calculadora.visible=FALSE
end event

event ue_activa_claves;call super::ue_activa_claves;
		// Activamos los campos clave añadidos

sle_valor.enabled = TRUE
em_anyo.enabled   = TRUE
pb_calculadora.visible = TRUE
end event

on wi_mant_carefectos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.em_anyo=create em_anyo
this.st_ntelefonos=create st_ntelefonos
this.gb_1=create gb_1
this.pb_1=create pb_1
this.dw_listado1=create dw_listado1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.em_anyo
this.Control[iCurrent+3]=this.st_ntelefonos
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.dw_listado1
this.Control[iCurrent+7]=this.cb_1
end on

on wi_mant_carefectos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.em_anyo)
destroy(this.st_ntelefonos)
destroy(this.gb_1)
destroy(this.pb_1)
destroy(this.dw_listado1)
destroy(this.cb_1)
end on

event ue_actualiza_dw;call super::ue_actualiza_dw;dec importe
long anyo,orden
str_carefectos carefectos
importe = dw_1.object.importe[dw_1.getrow()]
if (anteimporte <> 0) and (importe < anteimporte) then
	if messagebox("Atención","Ha modificado el importe del efecto.~n¿Desea generar otro efecto por la diferencia?",Question!,YesNo!,2) = 1 then
		anyo  = dw_1.object.anyo[dw_1.getrow()]
		orden = dw_1.object.orden[dw_1.getrow()]

		if f_cargar_str_carefectos(codigo_empresa,anyo,orden,carefectos) then
			carefectos.orden   = f_orden_carparam(carefectos.empresa,carefectos.anyo)
			select max(carefectos.recibo)
			into   :carefectos.recibo
			from   carefectos
			where  carefectos.empresa = :carefectos.empresa
			and    carefectos.anyofra = :carefectos.anyofra
			and    carefectos.factura = :carefectos.factura;
			if isnull(carefectos.recibo) then carefectos.recibo = 0
			carefectos.recibo ++
			carefectos.importe = anteimporte - carefectos.importe
			carefectos.divisas = carefectos.importe * carefectos.cambio
			IF Not f_insert_carefectos(carefectos) Then 
				rollback;
				messagebox("Error","Se ha producido un error al grabar en cartera")
			else
				commit;
//				if messagebox("Proceso Correcto","Se ha generado el recibo :~n"+&
//								string(carefectos.anyo,"#,###")+"/"+string(carefectos.orden,"#,###")+&
//								"  De "+f_razon_genter(codigo_empresa,"C",carefectos.cliente)+&
//								"~nPor un importe de "+string(carefectos.importe,"###,###,##0"+" Pts.")+&
//								"~n~n	¿Desea visualizarlo?",Question!,YesNo!,2) = 1 then
//					em_anyo.text   = string(carefectos.anyo)								
//					sle_valor.text = string(carefectos.orden)
//					sle_valor.triggerevent("modificado")
//				end if
				//** Se queda el registro anterior bloqueado
				f_mensaje("Proceso Correcto","Se ha generado el recibo :~n"+&
								string(carefectos.anyo,"#,###")+"/"+string(carefectos.orden,"#,###")+&
								"  De "+f_razon_genter(codigo_empresa,"C",carefectos.cliente)+&
								"~nPor un importe de "+string(carefectos.importe,"###,###,##0.00"+" €."))
																
			end if
		else			
			messagebox("Atención","Se ha producido un error al duplicar el efecto")
		end if
	end if
end if
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_carefectos
integer x = 9
integer y = 328
integer width = 2935
integer height = 1552
string dataobject = "dw_carefectos"
end type

event dw_1::key;String var_fpago,var_domiciliacion
string var_moneda,var_pais,var_agente1
string var_tipodoc,var_recibir_dmto
string var_cuenta
dec    var_cambio,var_cambio_euros,var_comision1

bus_filtro=""
bus_titulo=""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "fpago"
      bus_datawindow = "dw_ayuda_carforpag"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION DE FORMAS DE PAGO"
	CASE "tipodoc"
      bus_datawindow = "dw_ayuda_cartipodoc"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION TIPOS DE DOCUMENTOS"	
	CASE "monedas"
      bus_datawindow = "dw_ayuda_divisas"
      bus_titulo = "VENTANA SELECCION DE MONEDAS"
		valor_empresa = FALSE
   CASE "cliente"
      bus_datawindow = "dw_ayuda_clientes"
      bus_titulo = "VENTANA SELECCION DE CLIENTES"
		valor_empresa = true
	CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
      bus_titulo = "VENTANA SELECCION DE AGENTES"
		valor_empresa = true	
	CASE "situacion"
      bus_datawindow = "dw_ayuda_carsituacion"
      bus_titulo = "VENTANA SELECCION DE SITUACIÓN"
		valor_empresa = true	
   CASE "domiciliacion"
      bus_datawindow = "dw_ayuda_vendomiciliacion"
      bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		valor_empresa = true	
	CASE "banco"
      bus_datawindow = "dw_ayuda_carbancos"
      bus_titulo = "VENTANA SELECCION DE BANCO"
		valor_empresa = true					      
	CASE "banco_docu"
      bus_datawindow = "dw_ayuda_carbancos"
      bus_titulo = "VENTANA SELECCION DE BANCO"
		valor_empresa = true					      
		
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

IF Key = KeyTab! Then
		String codcli
		IF GetRow() = 0 Then Return
		AcceptText()
		codcli    = GetItemString(This.GetRow(),"cliente")
		
		if Integer(codcli)=0 then Return
		
		CHOOSE CASE GetColumnName()
			
			CASE "cliente"
		     
				SELECT venclientes.agente1,
						 venclientes.comision1,
						 venclientes.cod_pago,
						 venclientes.domiciliacion
				INTO   :var_agente1,
						 :var_comision1,
						 :var_fpago,
						 :var_domiciliacion
				FROM   venclientes  
				WHERE  venclientes.empresa = :codigo_empresa 
				AND    venclientes.codigo = :codcli;

		
				Select  genter.pais,
						  genter.moneda,
						  genter.cuenta
				Into    :var_pais,
						  :var_moneda,
						  :var_cuenta
				From    genter
				Where   genter.empresa = :codigo_empresa 
				And     genter.tipoter = 'C'
				And     genter.codigo  = :codcli;

			  	var_cambio = f_cambio_moneda(var_moneda)
				  
				var_cambio_euros = f_cambio_euros(var_moneda)
				
				var_tipodoc = f_tipodoc_carforpag(codigo_empresa,var_fpago)
				
				var_recibir_dmto = f_cartipodoc_recibir_dcto(codigo_empresa,var_fpago)
				 
				dw_1.object.fpago[dw_1.getrow()] = var_fpago
				dw_1.object.domiciliacion[dw_1.getrow()] = var_domiciliacion
				dw_1.object.pais[dw_1.getrow()] = var_pais
				dw_1.object.agente1[dw_1.getrow()] = var_agente1
				dw_1.object.tipodoc[dw_1.getrow()] = var_tipodoc
				dw_1.object.recibir_dmto[dw_1.getrow()] = var_recibir_dmto
				dw_1.object.cuenta[dw_1.getrow()] = var_cuenta
//				IF modo = "I" Then				
				IF codcli <> antecliente Then
					dw_1.object.monedas[dw_1.getrow()] = var_moneda
					dw_1.object.cambio[dw_1.getrow()] = var_cambio
					dw_1.object.cambio_euros[dw_1.getrow()] = var_cambio_euros
				end if
				
				dw_1.AcceptText()
				//End if
		 
				antecliente = codcli
						 
			case "fpago"
				var_fpago   = dw_1.object.fpago[dw_1.getrow()]
				var_tipodoc = f_tipodoc_carforpag(codigo_empresa,var_fpago)
				dw_1.object.tipodoc[dw_1.getrow()] = var_tipodoc
				dw_1.AcceptText()
		END CHOOSE
		
		

END IF



end event

event dw_1::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
//      f_valores_numericos(dw_1,"anyofra")
//       f_valores_numericos(dw_1,"factura")
//		  f_valores_numericos(dw_1,"recibo")
//		   f_valores_numericos(dw_1,"importe")
//			 f_valores_numericos(dw_1,"remesa")
//			  f_valores_numericos(dw_1,"efectoagrupa")
//			   f_valores_numericos(dw_1,"anyoagrupa")
//				 
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_1::clicked;call super::clicked;valor_empresa = TRUE
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_carefectos"

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_pais'
	valor_empresa = FALSE
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
      
CASE 'pb_cuenta'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   OpenWithParm(wi_mant_clientes2,lstr_param)  
CASE 'pb_agente'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente1")
   OpenWithParm(wi_mant_venagentes,lstr_param)  
CASE 'pb_tipodoc'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipodoc")
   OpenWithParm(wi_mant_cartipodoc,lstr_param)  
CASE 'pb_fpago'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"fpago")
   OpenWithParm(wi_mant_carforpag,lstr_param)  
CASE 'pb_monedas'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"monedas")
   OpenWithParm(wi_mant_divisas,lstr_param)  
CASE 'pb_situacion'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"situacion")
   OpenWithParm(wi_mant_carsituacion,lstr_param)  
CASE "pb_domi"
	valor_empresa = false
 	lstr_param.i_nargumentos    = 3
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
 	lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"domiciliacion")
 	OpenWithParm(wi_mant_vendomiciliacion,lstr_param)
CASE "pb_banco"
	valor_empresa = false
 	lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"banco")
 	OpenWithParm(wi_mant_carbancos,lstr_param)
CASE "pb_banco_docu"
	valor_empresa = false
 	lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"banco_docu")
 	OpenWithParm(wi_mant_carbancos,lstr_param)
	 
END CHOOSE



end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "fpago"
      bus_datawindow = "dw_ayuda_carforpag"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION DE FORMAS DE PAGO"
	CASE "tipodoc"
      bus_datawindow = "dw_ayuda_cartipodoc"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION TIPOS DE DOCUMENTOS"	
	CASE "monedas"
      bus_datawindow = "dw_ayuda_divisas"
      bus_titulo = "VENTANA SELECCION DE MONEDAS"
		valor_empresa = FALSE
   CASE "cliente"
      bus_datawindow = "dw_ayuda_clientes"
      bus_titulo = "VENTANA SELECCION DE CLIENTES"
		valor_empresa = true
	CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
      bus_titulo = "VENTANA SELECCION DE AGENTES"
		valor_empresa = true	
	CASE "situacion"
      bus_datawindow = "dw_ayuda_carsituacion"
      bus_titulo = "VENTANA SELECCION DE SITUACIÓN"
		valor_empresa = true	
   CASE "domiciliacion"
      bus_datawindow = "dw_ayuda_vendomiciliacion"
      bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		valor_empresa = true	
	CASE "banco"
      bus_datawindow = "dw_ayuda_carbancos"
      bus_titulo = "VENTANA SELECCION DE BANCO"
		valor_empresa = true			   
	CASE "banco_docu"
      bus_datawindow = "dw_ayuda_carbancos"
      bus_titulo = "VENTANA SELECCION DE BANCO"
		valor_empresa = true			   
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown


end event

event dw_1::getfocus;call super::getfocus;Integer registros,var_orden,var_anyo

var_anyo=dec(em_anyo.text)
var_orden=dec(sle_valor.text)

Select count(*) Into :registros From carhistorico
Where  carhistorico.empresa       = :codigo_empresa
and    carhistorico.anyo    = :var_anyo
and    carhistorico.orden   = :var_orden;

IF registros<>0 THEN
	messagebox("Orden Erroneo","Ese orden figura en el histórico")
	f_activar_campo(sle_valor)
END IF



end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;Dec{2}	impptas
String	fpago

IF dwo.Name = "domiciliacion" THEN
	fpago=dw_1.GetitemString(dw_1.Getrow(),"fpago")
	dw_1.setitem(dw_1.getrow(),"tipodoc",f_tipodoc_carforpag(codigo_empresa,fpago))
END IF

IF dwo.Name = "importe" THEN
	impptas = dw_1.GetItemNumber(row,"divisas") / dw_1.GetItemNumber(row,"cambio")
	dw_1.SetItem(row,"importe",impptas)
END IF
end event

event dw_1::itemchanged;call super::itemchanged;
if dwo.name = 'pago_a_cuenta' then
	if data = 'S' then
		this.object.factura[row]  = 'A CUENTA'
		this.object.recibo[row]   = 1
		this.object.anyofra[row]  = year(today())
		this.object.ffra[row]     = datetime(today())
		this.object.fvto[row]     = datetime(today())
		this.object.fvto_original[row] = datetime(today())
	end if
else
	if dwo.name = 'factura' then
		if this.object.pago_a_cuenta[row] = 'S' then
			if isnumber(left(data,1)) then
				messagebox("¡Atención!","El dato debe comenzar obligatoriamente con una letra.")
				return 2
			end if
		end if
	end if	
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_carefectos
integer x = 32
integer y = 184
integer width = 183
integer height = 68
string text = "Año:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_carefectos
integer x = 1664
integer y = 180
integer height = 76
end type

event cb_insertar::clicked;String factura, factura_sql[], factura_aux
Datetime fvto, max_fvto
Dec anyofra
Long i

iF cb_insertar.enabled =TRUE THEN 
	dw_1.AcceptText()
   string fpago
	IF Trim(dw_1.GetItemString(dw_1.GetRow(),"tipodoc")) = "" THEN
		fpago=dw_1.GetitemString(dw_1.Getrow(),"fpago")
		dw_1.setitem(dw_1.getrow(),"tipodoc",f_tipodoc_carforpag(codigo_empresa,fpago))
	END IF
	
	IF Trim(dw_1.GetItemString(dw_1.GetRow(),"situacion")) = "" THEN
		MessageBox("Error", "Introduzca la situación")
		return
	END IF
	
	factura = dw_1.GetItemString(dw_1.GetRow(),"factura")
	anyofra = dw_1.GetItemNumber(dw_1.GetRow(),"anyofra")
	fvto = dw_1.GetItemDatetime(dw_1.GetRow(),"fvto")
	//EN CASO DE QUE UN EFECTO AGRUPE VARIAS FACTURAS, VIENE SEPARADO POR ESPACIO EN BLANCO
	i = 1
	factura_aux = factura
	do while pos(factura, " ") <> 0
		factura_sql[i] = left(factura, pos(factura, " ") - 1)
		factura = mid(factura, pos(factura, " ") + 1)
		i++
	loop
	factura_sql[i] = factura
	factura = factura_aux
	

   // Comprueba campos obligatorios que no estan en la datawindow
   string var_pais,var_serie,var_cuenta,var_nacional,var_cliente
	
	var_pais     = dw_1.GetitemString(dw_1.Getrow(),"pais")
	var_cliente  = dw_1.GetitemString(dw_1.Getrow(),"cliente")
	var_serie    = dw_1.GetitemString(dw_1.Getrow(),"serie")
	var_cuenta   = dw_1.GetitemString(dw_1.Getrow(),"cuenta")
	var_nacional = dw_1.GetitemString(dw_1.Getrow(),"nacional")
	
	var_serie = f_serie_venclientes(codigo_empresa,var_cliente)
   dw_1.setitem(dw_1.getrow(),"serie",var_serie)
   
	IF f_tipo_pais(var_pais) = "N" Then
      	 var_nacional = "S"
        ELSE
       	 var_nacional = "N"
   END IF
   dw_1.setitem(dw_1.getrow(),"nacional",var_nacional)
   	
	var_cuenta = f_cuenta_genter(codigo_empresa,'C',var_cliente)
	dw_1.setitem(dw_1.getrow(),"cuenta",var_cuenta)
   
END IF

call super::clicked

if reg_insertado then
	SELECT MAX(fvto) INTO :max_fvto
	FROM carefectos 
	WHERE empresa = :codigo_empresa AND anyofra = :anyofra AND factura = :factura;
	
	if isnull(max_fvto) or fvto >= max_fvto then
		For i = 1 to upperbound(factura_sql)
			UPDATE carcomisiones 
			SET fvto = :fvto 
			WHERE  empresa = :codigo_empresa AND anyo = :anyofra AND factura = :factura_sql[i];
		next
		UPDATE carcomisiones 
		SET fvto = :fvto 
		WHERE  empresa = :codigo_empresa AND anyo = :anyofra AND factura = :factura;
	end if
end if


end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_carefectos
integer x = 2075
integer y = 180
integer height = 76
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_carefectos
integer x = 695
integer y = 176
integer width = 311
integer taborder = 30
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = ""
end type

event sle_valor::getfocus;call super::getfocus;if Trim(em_anyo.text)="" then
        f_activar_campo(em_anyo)	
        RETURN
end iF

pb_calculadora.visible=TRUE



end event

event sle_valor::rbuttondown;call super::rbuttondown;return
end event

event sle_valor::tecla_enter;call super::tecla_enter;return
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_carefectos
integer x = 2487
integer y = 180
integer height = 76
end type

event cb_salir::clicked;IF cb_insertar.enabled=TRUE THEN
	call Super::Clicked
ELSE
	IF espera = "" THEN
		close(parent)
	ELSE
		CloseWithReturn(wi_mant_carefectos,istr_parametros)
	END IF
END IF
end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_carefectos
integer taborder = 50
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_carefectos
integer x = 1422
integer y = 120
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_carefectos
integer width = 2971
end type

type pb_calculadora from u_calculadora within wi_mant_carefectos
integer x = 1010
integer y = 172
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return

Integer registros,var_orden,var_orden1,var_anyo

var_anyo  = dec(em_anyo.text)
var_orden = f_orden_carparam(codigo_empresa,var_anyo)

//Select count(*) Into :registros From carefectos
//Where  carefectos.empresa = :codigo_empresa
//and    carefectos.anyo    = :var_anyo;
//
//IF registros=0 THEN
// sle_valor.text="1" 
//ELSE
// Select max(convert(int,carefectos.orden)+1) Into :var_orden From carefectos
// Where  carefectos.empresa = :codigo_empresa
// and    carefectos.anyo    = :var_anyo;
//END IF
//
//Select count(*) Into :registros From carhistorico
//Where  carhistorico.empresa = :codigo_empresa
//and    carhistorico.anyo    = :var_anyo;
//
//IF registros=0 THEN
// sle_valor.text="1" 
//ELSE
// Select max(convert(int,carhistorico.orden)+1) Into :var_orden1
// From   carhistorico
// Where  carhistorico.empresa = :codigo_empresa
// and    carhistorico.anyo    = :var_anyo;
//END IF
//
//sle_valor.text=string(max(var_orden,var_orden1))

sle_valor.text = string(var_orden)

dw_1.TriggerEvent("Clicked")
end event

type em_anyo from u_em_campo within wi_mant_carefectos
integer x = 210
integer y = 172
integer width = 233
integer taborder = 20
string facename = "Courier"
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = "~r"
end type

event getfocus;call super::getfocus;pb_calculadora.visible=FALSE
dw_1.reset()

IF istr_parametros.i_nargumentos>1 THEN
	  em_anyo.text=istr_parametros.s_argumentos[2]
     sle_valor.text=istr_parametros.s_argumentos[3]
 	  istr_parametros.i_nargumentos=0
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
  			This.TriggerEvent("Modificado")
			Parent.TriggerEvent("ue_recuperar")
			f_activar_campo(sle_valor)
			return
     END IF     
	  
ELSE
     Sle_valor.text = ""
END IF


end event

event rbuttondown;call super::rbuttondown;return
end event

event tecla_enter;call super::tecla_enter;return
end event

type st_ntelefonos from statictext within wi_mant_carefectos
integer x = 462
integer y = 184
integer width = 242
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Orden:"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within wi_mant_carefectos
integer x = 1655
integer y = 148
integer width = 1253
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_imprimir within wi_mant_carefectos
integer x = 1175
integer y = 168
integer taborder = 10
end type

event clicked;long orden[1 to 1]

//IF recibo.checked = TRUE Then
	dw_listado1.DataObject = "report_emision_cobros_recibos"
//ELSE
//	dw_listado1.DataObject = "report_emision_cobros_timbres"
//END IF
dw_listado1.SetTransObject(SQLCA)

orden[1] = dec(sle_valor.text)
dw_listado1.Retrieve(codigo_empresa,dec(em_anyo.text),orden)
f_imprimir_datawindow(dw_listado1)

f_activar_campo(sle_valor)
end event

type dw_listado1 from datawindow within wi_mant_carefectos
boolean visible = false
integer x = 215
integer y = 52
integer width = 325
integer height = 88
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_emision_cobros_recibos"
boolean livescroll = true
end type

type cb_1 from commandbutton within wi_mant_carefectos
boolean visible = false
integer x = 2089
integer y = 1260
integer width = 562
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crear fecha orignial"
end type

event clicked;string sel
datastore datos
long i, anyo, orden
datetime fvto
sel = " select anyo, orden, fvto "+&
		" from carefectos "
		
f_cargar_cursor_nuevo (sel, datos)

for i = 1 to datos.rowcount()
	anyo = datos.object.anyo[i]
	orden = datos.object.orden[i]
	fvto = datos.object.fvto[i]
	
	update carefectos set fvto_original = :fvto
	where empresa = :codigo_empresa and anyo = :anyo and orden = :orden;
next


destroy datos
		
		
		
end event

