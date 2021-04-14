$PBExportHeader$w_int_cobro_seglinventas_cartera.srw
forward
global type w_int_cobro_seglinventas_cartera from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_cobro_seglinventas_cartera
end type
type dw_detalle from u_datawindow_consultas within w_int_cobro_seglinventas_cartera
end type
end forward

global type w_int_cobro_seglinventas_cartera from w_int_con_empresa
integer width = 2939
integer height = 1692
pb_1 pb_1
dw_detalle dw_detalle
end type
global w_int_cobro_seglinventas_cartera w_int_cobro_seglinventas_cartera

type variables
string filtro,moneda,var_tipo


end variables

forward prototypes
public subroutine f_procesar ()
public subroutine f_control ()
end prototypes

public subroutine f_procesar ();String var_fac,var_empresa,var_fra
Dec r,r1,var_anyofac,var_recibo,dev,cobrado,imp,var_anyo,var_orden,bien
Dec  var_cambiofra
DateTime   var_fdev,var_fcobro,var_ffra,var_fvto,var_fnoti
String var_cliente,var_moneda,var_cuenta,var_declarada,var_companyia,var_forma_pago,var_situacion

bien = 0
IF messageBox("Proceso de cancelacion cobros","Desea Cancelar los recibos",Question!,YesNo!)= 2 Then
	Return
END IF


r1 = dw_detalle.RowCount()

For r = 1 To r1 
	var_anyofac = Year(Date(dw_detalle.GetItemDateTime(r,"ffra")))
	var_fac     = dw_detalle.GetItemString(r,"fra")
	var_recibo  = dw_detalle.GetItemNumber(r,"recibo")
	var_anyo    = dw_detalle.GetItemNumber(r,"anyo")
	var_orden   = dw_detalle.GetItemNumber(r,"orden")
	imp         = dw_detalle.GetItemNumber(r,"importe")
	cobrado     = dw_detalle.GetItemNumber(r,"cobrado")
	dev         = dw_detalle.GetItemNumber(r,"dev")
	IF cobrado + dev <> 0 Then
		var_fcobro  = f_fecha_cobrado_factura_carhistorico(var_empresa,var_anyofac,var_fac,var_recibo)
		SetNull(var_fdev)
			IF dev <> 0 Then
				var_fdev = f_fecha_devuelto_factura_carefectos(var_empresa,var_anyofac,var_fac,var_recibo)
			END IF
		IF imp > cobrado + dev Then					
			UPDATE seglinventas  
			SET importe = :imp - (:cobrado + :dev)
			WHERE (seglinventas.empresa = :codigo_empresa )
			AND   (seglinventas.anyo    = :var_anyo )
			AND   (seglinventas.orden   = :var_orden );
			iF SQLCA.SQLCODE <> 0 Then 
				bien = 1
				f_mensaje("Error",sqlca.sqlerrtext)
			END IF
		ELSE
			DELETE seglinventas  
			WHERE (seglinventas.empresa = :codigo_empresa )
			AND   (seglinventas.anyo    = :var_anyo )
			AND   (seglinventas.orden   = :var_orden );
			iF SQLCA.SQLCODE <> 0 Then 
				bien = 1
				f_mensaje("Error",sqlca.sqlerrtext)
			END IF
		END IF
	END IF
	Select Max(orden) Into :var_orden From seglinventas
	Where  seglinventas.empresa = :codigo_empresa
	And    seglinventas.anyo    = :var_anyo;
	IF dev <> 0 Then
	
	IF IsNull(var_orden) Then var_orden = 0
	var_orden     = var_orden + 1
	var_fra       = f_valor_columna(dw_detalle,r,"fra")
	var_recibo    = Dec(f_valor_columna(dw_detalle,r,"recibo")  )
	var_ffra      = dw_detalle.GetItemdateTime(r,"ffra")  
	var_cliente   = f_valor_columna(dw_detalle,r,"cliente")  
	var_fvto      = dw_detalle.GetItemDateTime(r,"fvto")  
	var_fnoti      = dw_detalle.GetItemDateTime(r,"f_notificacion")  
	var_moneda    = f_valor_columna(dw_detalle,r,"moneda")  
	var_cambiofra = Dec(f_valor_columna(dw_detalle,r,"cambiofra"))  
	var_declarada ="S"
	var_cuenta= f_valor_columna(dw_detalle,r,"cuenta")  
	var_companyia= f_valor_columna(dw_detalle,r,"companyia")  
	var_forma_pago= f_valor_columna(dw_detalle,r,"forma_pago")  
	var_situacion= "2"
	INSERT INTO seglinventas  
	( empresa,anyo,orden,fra,recibo,ffra,cliente,fcobro,   
	fvto,importe,moneda,cambiofra,declarado,f_notificacion,   
	cuenta,companyia,forma_pago,situacion,fdev,impdev)  
	VALUES ( :codigo_empresa,:var_anyo, :var_orden, :var_fra,   
	:var_recibo,  :var_ffra,  :var_cliente, null,   
	:var_fvto,    :dev, :var_moneda,  :var_cambiofra,   
	:var_declarada,  :var_fnoti,  :var_cuenta, :var_companyia,   
	:var_forma_pago, :var_situacion,  :var_fdev,0);
	iF SQLCA.SQLCODE <> 0 Then 
	f_mensaje("Error",sqlca.sqlerrtext)
	bien = 1
	END IF
	
	END IF
	IF cobrado <> 0 Then
	var_orden     = var_orden + 1
	var_fra       = f_valor_columna(dw_detalle,r,"fra")
	var_recibo    = Dec(f_valor_columna(dw_detalle,r,"recibo")  )
	var_ffra      = dw_detalle.GetItemdateTime(r,"ffra")  
	var_cliente   = f_valor_columna(dw_detalle,r,"cliente")  
	var_fvto      = dw_detalle.GetItemDateTime(r,"fvto")  
	var_moneda    = f_valor_columna(dw_detalle,r,"moneda")  
	var_cambiofra = Dec(f_valor_columna(dw_detalle,r,"cambiofra"))  
	var_declarada ="S"
	
	var_cuenta= f_valor_columna(dw_detalle,r,"cuenta")  
	var_companyia= f_valor_columna(dw_detalle,r,"companyia")  
	var_forma_pago= f_valor_columna(dw_detalle,r,"forma_pago")  
	var_situacion= "4"
			INSERT INTO seglinventas  
			( empresa,anyo,orden,fra,recibo,ffra,cliente,fcobro,   
			fvto,importe,moneda,cambiofra,declarado,f_notificacion,   
			cuenta,companyia,forma_pago,situacion,fdev,impdev)  
			VALUES ( :codigo_empresa,:var_anyo, :var_orden, :var_fra,   
			:var_recibo,  :var_ffra,  :var_cliente, null,   
			:var_fvto,    :cobrado, :var_moneda,  :var_cambiofra,   
			:var_declarada,  :var_fnoti,  :var_cuenta, :var_companyia,   
			:var_forma_pago, :var_situacion,  :var_fdev,     :dev )  ;
	iF SQLCA.SQLCODE <> 0 Then 
	f_mensaje("Error",sqlca.sqlerrtext)
	bien = 1
	END IF
	
	
	END IF
	f_mensaje_proceso("Procesando",r,r1)
Next

IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en base de datos","La operacion no se contabiliza")
END IF
f_control()




end subroutine

public subroutine f_control ();Dec r,r1,cobrado,var_recibo,var_anyofac,dev,imp,cobrado_seg,dev_seg
String var_fac,var_empresa
dw_detalle.Reset()
r1          = dw_detalle.Retrieve(codigo_empresa)	
var_empresa = codigo_empresa

For r = 1 To r1 
	var_anyofac = Year(Date(dw_detalle.GetItemDateTime(r,"ffra")))
	var_fac     = dw_detalle.GetItemString(r,"seglinventas_fra")
	var_recibo  = dw_detalle.GetItemNumber(r,"recibo")
	imp  = dw_detalle.GetItemNumber(r,"importe")
	cobrado = 0
	dev = 0
	IF dw_detalle.GetItemString(r,"situacion") = "1" Then
		cobrado     = f_cobrado_factura_carhistorico(var_empresa,var_anyofac,var_fac,var_recibo)
		cobrado_seg = f_cobrado_factura_seglinventas(var_empresa,var_anyofac,Dec(var_fac),var_recibo)
		cobrado     =  cobrado  -  cobrado_seg

		IF cobrado <> imp Then 
			dev     = f_devuelto_factura_carefectos(var_empresa,var_anyofac,var_fac,var_recibo)
			dev_seg = f_devuelto_factura_seglinventas(var_empresa,var_anyofac,Dec(var_fac),var_recibo)
			dev = dev - dev_seg
		END IF
		IF cobrado <> 0 Then	dw_detalle.SetItem(r,"cobrado",cobrado)
		IF dev     <> 0 Then	dw_detalle.SetItem(r,"dev",dev)
	END IF
	f_mensaje_proceso("Procesando",r,r1)
Next




end subroutine

event ue_listar;//
//dw_report  = dw_listado_detalle
//dw_report.SetTransObject(SQLCA)
//dw_report.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)	
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Cancelación Cobros Asegurados Automático"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
f_control()
end event

on w_int_cobro_seglinventas_cartera.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_detalle
end on

on w_int_cobro_seglinventas_cartera.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_detalle)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_cobro_seglinventas_cartera
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_cobro_seglinventas_cartera
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_cobro_seglinventas_cartera
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_cobro_seglinventas_cartera
integer x = 2702
integer y = 4
integer width = 128
integer height = 108
integer taborder = 0
string picturename = "exit!"
end type

type dw_detalle from u_datawindow_consultas within w_int_cobro_seglinventas_cartera
integer x = 18
integer y = 124
integer width = 2839
integer height = 1312
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_int_cobro_seglinventas_cartera"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param

IF row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=string(This.GetItemNumber(row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(row,"orden"))
  OpenWithParm(wi_mant_seglinventas,lstr_param) 
End if

end event

event clicked;call super::clicked;IF f_objeto_datawindow(dw_detalle) = "procesar" Then
		f_procesar()
END IF
end event

