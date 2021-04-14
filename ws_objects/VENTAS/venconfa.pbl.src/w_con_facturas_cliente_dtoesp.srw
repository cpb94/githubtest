$PBExportHeader$w_con_facturas_cliente_dtoesp.srw
forward
global type w_con_facturas_cliente_dtoesp from w_int_con_empresa
end type
type gb_fecha from groupbox within w_con_facturas_cliente_dtoesp
end type
type gb_2 from groupbox within w_con_facturas_cliente_dtoesp
end type
type pb_1 from upb_salir within w_con_facturas_cliente_dtoesp
end type
type pb_2 from upb_imprimir within w_con_facturas_cliente_dtoesp
end type
type dw_listado from datawindow within w_con_facturas_cliente_dtoesp
end type
type dw_detalle from u_datawindow_consultas within w_con_facturas_cliente_dtoesp
end type
type cb_1 from u_boton within w_con_facturas_cliente_dtoesp
end type
type uo_cliente from u_em_campo_2 within w_con_facturas_cliente_dtoesp
end type
type gb_1 from groupbox within w_con_facturas_cliente_dtoesp
end type
type st_3 from statictext within w_con_facturas_cliente_dtoesp
end type
type em_fecha from u_em_campo within w_con_facturas_cliente_dtoesp
end type
type st_2 from statictext within w_con_facturas_cliente_dtoesp
end type
type em_serie from u_em_campo within w_con_facturas_cliente_dtoesp
end type
type st_4 from statictext within w_con_facturas_cliente_dtoesp
end type
type st_nombre_serie from statictext within w_con_facturas_cliente_dtoesp
end type
type em_factura from u_em_campo within w_con_facturas_cliente_dtoesp
end type
type em_anyo from u_em_campo within w_con_facturas_cliente_dtoesp
end type
type em_fechadesde from u_em_campo within w_con_facturas_cliente_dtoesp
end type
type st_1 from statictext within w_con_facturas_cliente_dtoesp
end type
type em_fechahasta from u_em_campo within w_con_facturas_cliente_dtoesp
end type
type uo_manejo from u_manejo_datawindow within w_con_facturas_cliente_dtoesp
end type
end forward

global type w_con_facturas_cliente_dtoesp from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 2930
integer height = 2172
gb_fecha gb_fecha
gb_2 gb_2
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
dw_detalle dw_detalle
cb_1 cb_1
uo_cliente uo_cliente
gb_1 gb_1
st_3 st_3
em_fecha em_fecha
st_2 st_2
em_serie em_serie
st_4 st_4
st_nombre_serie st_nombre_serie
em_factura em_factura
em_anyo em_anyo
em_fechadesde em_fechadesde
st_1 st_1
em_fechahasta em_fechahasta
uo_manejo uo_manejo
end type
global w_con_facturas_cliente_dtoesp w_con_facturas_cliente_dtoesp

type variables
DateTime  fecha
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_procesar ()
public subroutine f_leer (datawindow data)
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,datetime(em_fechadesde.text),datetime(em_fechahasta.text))
end subroutine

public subroutine f_procesar ();Dec r,r1,linea,registros,numero,vez
Dec vfactura,vanyo,vpendiente
String vcliente,vmoneda,ante_cliente,factura
Str_venfac  fac
Str_venlifac  linfac
DateTime vffactura
Dec bien = 0
r1 = dw_detalle.RowCount()
linea = 0


For r = 1 To r1
IF dw_detalle.GetItemString(r,"marca") = "S" Then
	linea = linea +1
	vfactura     = dw_detalle.GetItemNumber(r,"factura")
	vffactura    = dw_detalle.GetItemDateTime(r,"ffactura")
	vanyo        = dw_detalle.GetItemNumber(r,"anyo")
	
	Update venfac Set marcada = "S"
	Where  empresa = :codigo_empresa
	And    anyo    = :vanyo
	ANd    factura = :vfactura;
	
	vcliente     = dw_detalle.GetItemString(r,"venfac_cliente")
	vmoneda      = dw_detalle.GetItemString(r,"divisa")
	vpendiente   = dw_detalle.GetItemNumber(r,"pendiente")
	
	  SELECT venfac.empresa,   
         venfac.anyo_albaran,   
         venfac.albaran,   
         venfac.falbaran,   
         venfac.fentrega,   
         venfac.falta,   
         venfac.cliente,   
         venfac.flistado,   
         venfac.observaciones,   
         venfac.codpago,   
         venfac.tipoiva,   
         venfac.iva,   
         venfac.numpedcli,   
         venfac.idioma,   
         venfac.divisa,   
         venfac.cambio,   
         venfac.tarifa,   
         venfac.ftarifa,   
         venfac.fbloqueo,   
         venfac.transportista,   
         venfac.serie,   
         venfac.zona,   
         venfac.envio,   
         venfac.correspondencia,   
         venfac.domiciliacion,   
         venfac.forma_envio,   
         venfac.cod_entrega,   
         venfac.usuario,   
         venfac.tipo_portes,   
         venfac.periodo_fac,   
         venfac.usuario_pedido,   
         venfac.textopie2,   
         venfac.condicion,   
         venfac.banco_de_cobro,   
         venfac.porcentaje_aduana,   
         venfac.anyo_pedido_origen,   
         venfac.pedido_origen,   
         venfac.fcarga,   
         venfac.anyo,   
         venfac.agrupa,   
         venfac.ffactura,   
         venfac.actualizada,   
         venfac.libre,   
         venfac.pais,   
         venfac.tipo_recargo,   
         venfac.recargo,   
         venfac.cartera,   
         venfac.precartera,   
         venfac.destino1,   
         venfac.destino2,   
         venfac.destino3,   
         venfac.provincia,   
         venfac.dtoesp,   
         venfac.marcada,   
         venfac.textopie1,   
         venfac.calculo_dto
			
    INTO :fac.empresa,   
         :fac.anyo_albaran,   
         :fac.albaran,   
         :fac.falbaran,   
         :fac.fentrega,   
         :fac.falta,   
         :fac.cliente,   
         :fac.flistado,   
         :fac.observaciones,   
         :fac.codpago,   
         :fac.tipoiva,   
         :fac.iva,   
         :fac.numpedcli,   
         :fac.idioma,   
         :fac.divisa,   
         :fac.cambio,   
         :fac.tarifa,   
         :fac.ftarifa,   
         :fac.fbloqueo,   
         :fac.transportista,   
         :fac.serie,   
         :fac.zona,   
         :fac.envio,   
         :fac.correspondencia,   
         :fac.domiciliacion,   
         :fac.forma_envio,   
         :fac.cod_entrega,   
         :fac.usuario,   
         :fac.tipo_portes,   
         :fac.periodo_fac,   
         :fac.usuario_pedido,   
         :fac.textopie2,   
         :fac.condicion,   
         :fac.banco_de_cobro,   
         :fac.porcentaje_aduana,   
         :fac.anyo_pedido_origen,   
         :fac.pedido_origen,   
         :fac.fcarga,   
         :fac.anyo,   
         :fac.agrupa,   
         :fac.ffactura,   
         :fac.actualizada,   
         :fac.libre,   
         :fac.pais,   
         :fac.tipo_recargo,   
         :fac.recargo,   
         :fac.cartera,   
         :fac.precartera,   
         :fac.destino1,   
         :fac.destino2,   
         :fac.destino3,   
         :fac.provincia,   
         :fac.dtoesp,   
         :fac.marcada,   
         :fac.textopie1,   
         :fac.calculo_dto  
    FROM  venfac  
   WHERE  venfac.empresa = :codigo_empresa
	AND    venfac.anyo    = :vanyo
	AND    venfac.factura = :vfactura;
	
	fac.empresa    = codigo_empresa
	fac.anyo       = vanyo
	linfac.empresa = fac.empresa
	linfac.anyo    = fac.anyo
	linfac.anyo_albaran = fac.anyo_albaran
	linfac.serie     = fac.serie
	linfac.falbaran  = fac.falbaran
	linfac.fentrega  = fac.fentrega
	linfac.cliente   = fac.cliente
	linfac.provincia = fac.provincia
	linfac.pais      = fac.pais
	linfac.zona      = fac.zona
	linfac.usuario   = nombre_usuario
	linfac.transportista = fac.transportista
	linfac.tipolinea     = "15"
	linfac.descripcion   = "ABONO FRA:  " + String(vfactura,f_mascara_decimales(0)) + " Del "+ string(vffactura,"dd-mm-yy")
	linfac.linea_factura = linea 
	linfac.cantidad = 1
	vpendiente      = vpendiente - Dec(STring(((vpendiente * fac.iva) /100),f_mascara_moneda(fac.divisa)))
	linfac.precio   = vpendiente * (-1)
	fac.ffactura    = fecha
	linfac.ffactura = fecha
	IF r = 1 or fac.cliente <> ante_cliente Then	
	
	//-------------------//
	//	Insertar cabecera//
	//------------------//
 	   
	   if vez=0 then
			 vez=1
		    registros = dec(em_factura.text) 	 
		  Else
			 Select factura Into :registros From  venparamfac
          Where venparamfac.empresa = :codigo_empresa
          And venparamfac.anyo    = :fac.anyo
        	 and venparamfac.serie   = :fac.serie;
	   End if
	
	   IF IsNUll(registros) Then registros = 0
		
				
		Select Count(*) Into :numero From venfac
		Where empresa = :codigo_empresa
		And   anyo    = :fac.anyo
		And   factura = :registros +1 ;
		IF Isnull(numero) Then numero =0
		
		IF numero <> 0 Then
       Select max((venfac.factura))  Into   :registros  From   venfac
       Where  venfac.empresa = :codigo_empresa
       And    venfac.anyo    = :fac.anyo
		 And    venfac.serie    = :fac.serie ;
      	UPDATE venparamfac
            SET factura = :registros
			 Where venparamfac.empresa = :codigo_empresa
			   And venparamfac.anyo   = :fac.anyo
				And venparamfac.serie  = :fac.serie;
				IF sqlca.sqlcode <> 0 Then bien = 1
		END IF
		fac.factura = registros+1
      	UPDATE venparamfac
            SET factura = :fac.factura
			 Where venparamfac.empresa = :codigo_empresa
			   And venparamfac.anyo   = :fac.anyo
				And venparamfac.serie  = :fac.serie;
				IF sqlca.sqlcode <> 0 Then bien = 1
	fac.marcada = "N"		
	fac.generar_recibos = "S"		
	IF Not f_insert_venfac(fac) Then 
		bien = 1
		f_mensaje("insertar cabecera",sqlca.sqlerrtext)
	END IF
	//--------------------------------------
	// fin insertar cabecara
	//-------------------------------------
	END IF
	linfac.factura = fac.factura
	factura = STring(fac.factura,"#########")
	
//	Delete From carefectos
//	Where  carefectos.empresa  = :codigo_empresa
//	And    carefectos.anyofra  = :linfac.anyo
//	And    carefectos.factura  = :factura
//	ANd    carefectos.situacion Not In("4");
//	
//	IF sqlca.sqlcode <> 0 Then bien = 1

	IF Not f_insertar_venlifac(linfac) Then 
		bien = 1
		f_mensaje("insertar linea",sqlca.sqlerrtext)
	ELSE
		IF Not f_actualizar_linea_venfac(linfac.empresa,linfac.anyo,linfac.factura,linfac.linea_factura) Then 
			bien = 1
			f_mensaje("actualizar linea ",sqlca.sqlerrtext)
	END IF

	END IF
	

	IF Not f_actualizar_venfactura(fac.empresa,fac.anyo,fac.factura) Then 
		bien = 1
		f_mensaje("actualizar cabecera",sqlca.sqlerrtext)
	END IF
	
	f_mensaje_proceso("Procesando",r,r1)
	ante_cliente = fac.cliente
END IF
Next

IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso",sqlca.sqlerrtext)
END IF
f_leer(dw_detalle)
end subroutine

public subroutine f_leer (datawindow data);

f_mascara_columna(data,"t1",f_mascara_decimales(2))
f_mascara_columna(data,"t2",f_mascara_decimales(2))
f_mascara_columna(data,"t3",f_mascara_decimales(2))

f_mascara_columna(data,"pendiente",f_mascara_decimales(2))
f_mascara_columna(data,"impdto",f_mascara_decimales(2))
f_mascara_columna(data,"total",f_mascara_decimales(2))


String cli1,cli2
Dec r,v_anyo,pdte,dtoesp,total
STring v_factura,divisa

IF Trim(uo_cliente.em_codigo.text) <> "" Then
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
ELSE
	cli1 = "."
	cli2 = "Z"
END IF
data.SetRedraw(False)
data.Retrieve(codigo_empresa,cli1,cli2,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
For r = 1 To data.RowCOunt()
	data.SetItem(r,"nombre_cliente",f_razon_genter(codigo_empresa,"C",data.GetItemSTring(r,"venfac_cliente")))
	v_anyo = data.GetItemNumber(r,"anyo")
	total = data.GetItemNumber(r,"venfac_total_fac")
	divisa = data.GetItemString(r,"divisa")
	dtoesp = data.GetItemNumber(r,"venfac_dtoesp")
	v_factura = STring(data.GetItemNumber(r,"factura"))
	
	Select Sum(divisas) 
	Into   :pdte 
	From   carefectos
	Where  carefectos.empresa = :codigo_empresa
	And    carefectos.anyofra  = :v_anyo
	And    carefectos.factura  = :v_factura
	ANd    carefectos.situacion Not In("4","3","9");
	
	IF IsNull(pdte) Then pdte = 0 
	data.SetItem(r,"pendiente",pdte)
	data.SetItem(r,"impdto",Dec(STring(((total * dtoesp)/100),f_mascara_moneda(divisa))))
	data.SetItem(r,"marca","S")
NExt
data.SetFilter("venfac_total_fac <> pendiente")
data.Filter()
data.SetRedraw(True)


end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de facturas por cliente Dto Cobro factura"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
em_fechadesde.text=string(datetime(date(year(today()),01,01)))
em_fechahasta.text=string(datetime(today()))
em_fecha.text=string(datetime(today()))

em_anyo.text  = string(year(today()))
em_serie.text = "2"
st_nombre_serie.text = f_nombre_venseries(codigo_empresa,em_serie.text)

IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then
    em_serie.text=""
    f_activar_campo(em_serie)
    return
 End if
END IF


dec{0} n_factura,var_anyo
Integer registros,numero
String  var_empresa,var_serie

var_anyo  = Integer(em_anyo.text)
var_serie = em_serie.text

   Select factura Into :registros From  venparamfac
	 Where venparamfac.empresa = :codigo_empresa
	  And venparamfac.anyo   = :var_anyo
		And venparamfac.serie  = :var_serie;
		IF IsNUll(registros) Then registros = 0
		Select Count(*) Into :numero From venfac
		Where empresa = :codigo_empresa
		And   anyo    = :var_anyo
		And   factura = :registros +1 ;
		IF Isnull(numero) Then numero =0
		IF numero <> 0 Then
       Select max((venfac.factura))  Into   :registros  From   venfac
       Where  venfac.empresa = :codigo_empresa
       And    venfac.anyo    = :var_anyo
		 And    venfac.serie    = :var_serie ;
      	UPDATE venparamfac
            SET factura = :registros
			 Where venparamfac.empresa = :codigo_empresa
			   And venparamfac.anyo   = :var_anyo
				And venparamfac.serie  = :var_serie;
				COMMIT;
		END IF

	em_factura.text = STring(registros) 


end event

on w_con_facturas_cliente_dtoesp.create
int iCurrent
call super::create
this.gb_fecha=create gb_fecha
this.gb_2=create gb_2
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.dw_detalle=create dw_detalle
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.st_3=create st_3
this.em_fecha=create em_fecha
this.st_2=create st_2
this.em_serie=create em_serie
this.st_4=create st_4
this.st_nombre_serie=create st_nombre_serie
this.em_factura=create em_factura
this.em_anyo=create em_anyo
this.em_fechadesde=create em_fechadesde
this.st_1=create st_1
this.em_fechahasta=create em_fechahasta
this.uo_manejo=create uo_manejo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_fecha
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.uo_cliente
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.em_fecha
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.em_serie
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_nombre_serie
this.Control[iCurrent+16]=this.em_factura
this.Control[iCurrent+17]=this.em_anyo
this.Control[iCurrent+18]=this.em_fechadesde
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.em_fechahasta
this.Control[iCurrent+21]=this.uo_manejo
end on

on w_con_facturas_cliente_dtoesp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_fecha)
destroy(this.gb_2)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.dw_detalle)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.st_3)
destroy(this.em_fecha)
destroy(this.st_2)
destroy(this.em_serie)
destroy(this.st_4)
destroy(this.st_nombre_serie)
destroy(this.em_factura)
destroy(this.em_anyo)
destroy(this.em_fechadesde)
destroy(this.st_1)
destroy(this.em_fechahasta)
destroy(this.uo_manejo)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_facturas_cliente_dtoesp
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_facturas_cliente_dtoesp
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_facturas_cliente_dtoesp
integer x = 9
integer y = 8
integer width = 2427
integer height = 96
end type

type gb_fecha from groupbox within w_con_facturas_cliente_dtoesp
integer x = 27
integer y = 96
integer width = 809
integer height = 196
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type gb_2 from groupbox within w_con_facturas_cliente_dtoesp
integer x = 1193
integer y = 100
integer width = 1061
integer height = 388
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type pb_1 from upb_salir within w_con_facturas_cliente_dtoesp
integer x = 2729
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_facturas_cliente_dtoesp
integer x = 2734
integer y = 388
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;f_leer(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type dw_listado from datawindow within w_con_facturas_cliente_dtoesp
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 90
boolean bringtotop = true
string dataobject = "report_con_facturas_cliente_dtoesp"
boolean livescroll = true
end type

type dw_detalle from u_datawindow_consultas within w_con_facturas_cliente_dtoesp
integer x = 9
integer y = 512
integer width = 2853
integer height = 1432
integer taborder = 0
string dataobject = "dw_con_facturas_cliente_dtoesp"
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF rowCount() = 0 Then Return
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"factura"))
  OpenWithParm(w_int_venfac,lstr_param) 
End If
end event

event retrieveend;call super::retrieveend;//
//IF rowcount = 0 Then Return
//SetRow(1)
//dec v_factura,v_anyo
//v_factura=dw_detalle.getItemNumber(1,"factura")
//v_anyo=dw_detalle.getItemNumber(1,"anyo")
//dw_1.reset()
//dw_1.retrieve(codigo_empresa,v_anyo,v_factura)
//
end event

event clicked;call super::clicked;IF f_objeto_datawindow(dw_detalle) = "procesar" Then
	IF MessageBox("Proceso generacion factura Descuento","¿Confirmacio de proceso?",Question!,YesNo!,2) = 1 Then 
		f_procesar()
	END IF
END IF
end event

type cb_1 from u_boton within w_con_facturas_cliente_dtoesp
integer x = 2309
integer y = 216
integer width = 338
integer height = 96
integer taborder = 80
string text = "&Continuar"
end type

event clicked;call super::clicked;fecha = DateTime(Date(em_fecha.text))
f_leer(dw_detalle)
end event

type uo_cliente from u_em_campo_2 within w_con_facturas_cliente_dtoesp
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 55
integer y = 364
integer width = 1070
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;dw_detalle.Reset()
uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_1 from groupbox within w_con_facturas_cliente_dtoesp
integer x = 23
integer y = 292
integer width = 1115
integer height = 192
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type st_3 from statictext within w_con_facturas_cliente_dtoesp
integer x = 1216
integer y = 160
integer width = 192
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Serie"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_con_facturas_cliente_dtoesp
integer x = 1614
integer y = 380
integer width = 325
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_2 from statictext within w_con_facturas_cliente_dtoesp
integer x = 1216
integer y = 384
integer width = 389
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha factura"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_serie from u_em_campo within w_con_facturas_cliente_dtoesp
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1413
integer y = 156
integer taborder = 40
boolean bringtotop = true
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE SERIES"
		ue_datawindow = "dw_ayuda_venseries"
		ue_filtro     = ""
  


 
        
end event

event modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,em_serie.text)

IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then
    em_serie.text=""
    f_activar_campo(em_serie)
    return
 End if
END IF


dec{0} n_factura,var_anyo
Integer registros,numero
String  var_empresa,var_serie

var_anyo  = Integer(em_anyo.text)
var_serie = em_serie.text

   Select factura Into :registros From  venparamfac
	 Where venparamfac.empresa = :codigo_empresa
	  And venparamfac.anyo   = :var_anyo
		And venparamfac.serie  = :var_serie;
		IF IsNUll(registros) Then registros = 0
		Select Count(*) Into :numero From venfac
		Where empresa = :codigo_empresa
		And   anyo    = :var_anyo
		And   factura = :registros +1 ;
		IF Isnull(numero) Then numero =0
		IF numero <> 0 Then
       Select max((venfac.factura))  Into   :registros  From   venfac
       Where  venfac.empresa = :codigo_empresa
       And    venfac.anyo    = :var_anyo
		 And    venfac.serie    = :var_serie ;
      	UPDATE venparamfac
            SET factura = :registros
			 Where venparamfac.empresa = :codigo_empresa
			   And venparamfac.anyo   = :var_anyo
				And venparamfac.serie  = :var_serie;
				COMMIT;
		END IF

	em_factura.text = STring(registros) 

 



end event

type st_4 from statictext within w_con_facturas_cliente_dtoesp
integer x = 1307
integer y = 276
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Nº Factura"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_serie from statictext within w_con_facturas_cliente_dtoesp
integer x = 1669
integer y = 156
integer width = 558
integer height = 88
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

type em_factura from u_em_campo within w_con_facturas_cliente_dtoesp
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1879
integer y = 268
integer width = 325
integer taborder = 60
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######0"
string displaydata = "~b"
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

type em_anyo from u_em_campo within w_con_facturas_cliente_dtoesp
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1614
integer y = 268
integer taborder = 50
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
 Return
END IF

dec{0} n_factura,var_anyo
Integer registros,numero
String  var_empresa,var_serie

var_anyo  = Integer(em_anyo.text)
var_serie = em_serie.text

   Select factura Into :registros From  venparamfac
	 Where venparamfac.empresa = :codigo_empresa
	  And venparamfac.anyo   = :var_anyo
		And venparamfac.serie  = :var_serie;
		IF IsNUll(registros) Then registros = 0
		Select Count(*) Into :numero From venfac
		Where empresa = :codigo_empresa
		And   anyo    = :var_anyo
		And   factura = :registros +1 ;
		IF Isnull(numero) Then numero =0
		IF numero <> 0 Then
       Select max((venfac.factura))  Into   :registros  From   venfac
       Where  venfac.empresa = :codigo_empresa
       And    venfac.anyo    = :var_anyo
		 And    venfac.serie    = :var_serie ;
      	UPDATE venparamfac
            SET factura = :registros
			 Where venparamfac.empresa = :codigo_empresa
			   And venparamfac.anyo   = :var_anyo
				And venparamfac.serie  = :var_serie;
				COMMIT;
		END IF

	em_factura.text = STring(registros) 





 



end event

type em_fechadesde from u_em_campo within w_con_facturas_cliente_dtoesp
integer x = 73
integer y = 172
integer width = 297
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_1 from statictext within w_con_facturas_cliente_dtoesp
integer x = 389
integer y = 172
integer width = 64
integer height = 84
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_facturas_cliente_dtoesp
integer x = 475
integer y = 172
integer width = 297
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type uo_manejo from u_manejo_datawindow within w_con_facturas_cliente_dtoesp
integer x = 2258
integer y = 344
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

