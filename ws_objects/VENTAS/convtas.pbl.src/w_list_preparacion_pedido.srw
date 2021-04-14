$PBExportHeader$w_list_preparacion_pedido.srw
forward
global type w_list_preparacion_pedido from w_int_con_empresa
end type
type pb_1 from upb_salir within w_list_preparacion_pedido
end type
type pb_imprimir from upb_imprimir within w_list_preparacion_pedido
end type
type st_cliente from statictext within w_list_preparacion_pedido
end type
type st_pedido from statictext within w_list_preparacion_pedido
end type
type em_pedido from u_em_campo within w_list_preparacion_pedido
end type
type st_anyo from statictext within w_list_preparacion_pedido
end type
type em_anyo from u_em_campo within w_list_preparacion_pedido
end type
type uo_cliente from u_em_campo_2 within w_list_preparacion_pedido
end type
type sle_1 from singlelineedit within w_list_preparacion_pedido
end type
type dw_detalle from datawindow within w_list_preparacion_pedido
end type
type dw_consulta from datawindow within w_list_preparacion_pedido
end type
end forward

global type w_list_preparacion_pedido from w_int_con_empresa
integer width = 2912
integer height = 2084
string menuname = ""
boolean resizable = true
pb_1 pb_1
pb_imprimir pb_imprimir
st_cliente st_cliente
st_pedido st_pedido
em_pedido em_pedido
st_anyo st_anyo
em_anyo em_anyo
uo_cliente uo_cliente
sle_1 sle_1
dw_detalle dw_detalle
dw_consulta dw_consulta
end type
global w_list_preparacion_pedido w_list_preparacion_pedido

type variables
string filtro
DateTime hora
String cerrar,operario
Dec cont = 0
// Datos para inserter lineas
Dec registros,registro,var_orden,contador,var_tono,&
        var_calibre,var_pallets,var_unidades,var_cajas,var_total_cajas,&
        var_anyo,var_linea,var_suborden
Dec{0} var_pedido,linea,numero_pico
String var_articulo,var_formato,var_tipo_pallet,var_tipo_unidad,var_situacion,&
       var_calidad,var_cliente,var_pais,var_provincia,var_empresa,&
       var_sector,var_observaciones,var_transportista,var_usuario,var_referencia,&
       var_ubicaciones,situacion,var_tipo_pallet_preparacion
Dec{2} var_cantidad,var_metros,var_peso
String var_agrupado
DateTime var_fentrega
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Listado preparación pedido"
cerrar = "N"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_consulta.SetTransObject(SQLCA)
em_anyo.text=istr_parametros.s_argumentos[2]	
em_pedido.text=istr_parametros.s_argumentos[3]	
IF len(em_pedido.text) <> 0 and len(em_anyo.text)<>0 Then
	cerrar = "S"
	this.triggerEvent(activate!)
	pb_imprimir.triggerEvent(Clicked!)
	RETURN
END IF

f_activar_campo(uo_cliente.em_campo)
end event

event ue_listar; DateTime fecha
 Integer veces
 fecha  = dateTime(Today(),Now())
 Dec{0} periodo,pedido
 periodo = Dec(em_anyo.text)
 pedido = Dec(em_pedido.text)
 
IF dw_detalle.print(TRUE) = 1 Then
   Select venped.veces Into :veces From venped
    WHERE (venped.empresa = :codigo_empresa) AND  
          (venped.anyo    = :periodo)        AND  
          (venped.pedido  = :pedido);
			 If IsNull(veces ) Then veces = 0
			 veces = veces + 1
	  UPDATE venped  
     SET flistado = :fecha,   
         veces = :veces  
   WHERE ( venped.empresa = :codigo_empresa ) AND  
         ( venped.anyo = :periodo ) AND  
         ( venped.pedido = :pedido )   ;
			DELETE From report_preparacion_pedidos
			Where usuario = :var_usuario
			And   hora    = :hora;
			COMMIT;
END IF
	
	

end event

on w_list_preparacion_pedido.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.st_cliente=create st_cliente
this.st_pedido=create st_pedido
this.em_pedido=create em_pedido
this.st_anyo=create st_anyo
this.em_anyo=create em_anyo
this.uo_cliente=create uo_cliente
this.sle_1=create sle_1
this.dw_detalle=create dw_detalle
this.dw_consulta=create dw_consulta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.st_cliente
this.Control[iCurrent+4]=this.st_pedido
this.Control[iCurrent+5]=this.em_pedido
this.Control[iCurrent+6]=this.st_anyo
this.Control[iCurrent+7]=this.em_anyo
this.Control[iCurrent+8]=this.uo_cliente
this.Control[iCurrent+9]=this.sle_1
this.Control[iCurrent+10]=this.dw_detalle
this.Control[iCurrent+11]=this.dw_consulta
end on

on w_list_preparacion_pedido.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.st_cliente)
destroy(this.st_pedido)
destroy(this.em_pedido)
destroy(this.st_anyo)
destroy(this.em_anyo)
destroy(this.uo_cliente)
destroy(this.sle_1)
destroy(this.dw_detalle)
destroy(this.dw_consulta)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_list_preparacion_pedido
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_list_preparacion_pedido
end type

type st_empresa from w_int_con_empresa`st_empresa within w_list_preparacion_pedido
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_list_preparacion_pedido
integer x = 2642
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_imprimir from upb_imprimir within w_list_preparacion_pedido
integer x = 2331
integer y = 152
integer taborder = 50
end type

event clicked;String impresora,cadena
Dec periodo,pedido,r
DatetIme fecha
Dec veces
fecha = DatetIme(Today())

SELECT ven_usuimpre.impresora_preparacion INTO :impresora  FROM ven_usuimpre
Where empresa = :codigo_empresa
And   usuario = :nombre_usuario;
sle_1.text = dw_detalle.Describe("Datawindow.Printer")

//IF sle_1.text <> impresora Then
//  MessageBox("Selecciona la impresora predeterminada","La impresora debe de ser" + impresora,Exclamation!,OK!,1)
//  printSetup()
//ELse
	periodo = Dec(em_anyo.text)
	pedido = Dec(em_pedido.text)
	IF dw_detalle.Retrieve(codigo_empresa,periodo,pedido)=0 THEN
		f_mensaje("¡ A t e n c i ó n !","El pedido no tiene lineas")
		IF cerrar="S" then pb_1.TriggerEvent(Clicked!)
		Return
	end if	
	
	FOr r = 1 To dw_detalle.RowCOunt()
	 var_referencia  = dw_detalle.GetItemString(r,"referencia")
	 var_tipo_pallet = dw_detalle.GetItemString(r,"tipo_pallet")
	 var_linea       = dw_detalle.GetItemNumber(r,"linea")
	 var_ubicaciones = ""
	 IF dw_detalle.GetItemString(r,"situacion")= "P" Then   
 		 var_ubicaciones= f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,var_tipo_pallet,periodo,pedido,var_linea)
 	 END IF
	  IF dw_detalle.GetItemString(r,"situacion")="C" or dw_detalle.GetItemString(r,"situacion")="F" Then   
	 	 var_ubicaciones= f_ubicaciones_referencia_tipo_pallet3(codigo_empresa,var_referencia,var_tipo_pallet,6,"S")
		END IF
	    dw_detalle.SetItem(r,"ubicacion_preparado",var_ubicaciones)		
	Next
//	dw_detalle.GroupCalc( )
IF F_IMPRIMIR_DATAWINDOW(dw_detalle) THEN //dw_detalle.print(TRUE) = 1 Then
   Select venped.veces Into :veces From venped
    WHERE (venped.empresa = :codigo_empresa) AND  
          (venped.anyo    = :periodo)        AND  
          (venped.pedido  = :pedido);
			 If IsNull(veces ) Then veces = 0
			 veces = veces + 1
	  UPDATE venped  
     SET flistado = :fecha,   
         veces    = :veces  
   WHERE ( venped.empresa = :codigo_empresa ) AND  
         ( venped.anyo    = :periodo ) AND  
         ( venped.pedido  = :pedido );
			COMMIT;
END IF

//END IF

IF cerrar = "S" Then 
	pb_1.TriggerEvent(Clicked!)
	Return
END IF
dw_consulta.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end event

type st_cliente from statictext within w_list_preparacion_pedido
integer x = 9
integer y = 172
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_pedido from statictext within w_list_preparacion_pedido
integer x = 2011
integer y = 152
integer width = 59
integer height = 92
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_pedido from u_em_campo within w_list_preparacion_pedido
integer x = 2062
integer y = 156
integer height = 88
integer taborder = 40
boolean bringtotop = true
end type

type st_anyo from statictext within w_list_preparacion_pedido
integer x = 1522
integer y = 168
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pedido"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_list_preparacion_pedido
integer x = 1774
integer y = 160
integer width = 233
integer taborder = 30
boolean bringtotop = true
end type

type uo_cliente from u_em_campo_2 within w_list_preparacion_pedido
integer x = 261
integer y = 160
integer width = 1248
integer height = 96
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
END IF
dw_consulta.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)

 
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type sle_1 from singlelineedit within w_list_preparacion_pedido
integer x = 1317
integer y = 260
integer width = 1422
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
boolean displayonly = true
end type

type dw_detalle from datawindow within w_list_preparacion_pedido
boolean visible = false
integer y = 268
integer width = 2757
integer height = 1096
string dataobject = "report_list_preparacion_pedido"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_consulta from datawindow within w_list_preparacion_pedido
integer x = 288
integer y = 348
integer width = 2208
integer height = 1500
string dataobject = "dw_list_preparacion_pedido1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row=0 Then
  f_activar_campo(uo_cliente.em_campo)
  Return
END IF

em_anyo.text     =   String(GetItemNumber(Row,"anyo"))
em_pedido.text   =   String(GetItemNumber(Row,"pedido"))
f_activar_campo(em_pedido)
end event

