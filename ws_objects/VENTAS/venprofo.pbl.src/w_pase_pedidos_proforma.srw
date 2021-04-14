$PBExportHeader$w_pase_pedidos_proforma.srw
forward
global type w_pase_pedidos_proforma from w_int_con_empresa
end type
type pb_1 from upb_salir within w_pase_pedidos_proforma
end type
type st_1 from statictext within w_pase_pedidos_proforma
end type
type em_cliente from u_em_campo within w_pase_pedidos_proforma
end type
type st_nomcliente from statictext within w_pase_pedidos_proforma
end type
type dw_consulta from u_datawindow_consultas within w_pase_pedidos_proforma
end type
type dw_detalle from u_datawindow_consultas within w_pase_pedidos_proforma
end type
type dw_temporal from datawindow within w_pase_pedidos_proforma
end type
type cb_desmarcatodo from u_boton within w_pase_pedidos_proforma
end type
type cb_1 from u_boton within w_pase_pedidos_proforma
end type
type cb_marcatodo from u_boton within w_pase_pedidos_proforma
end type
type gb_1 from groupbox within w_pase_pedidos_proforma
end type
type cb_2 from commandbutton within w_pase_pedidos_proforma
end type
type st_texto from statictext within w_pase_pedidos_proforma
end type
type dw_proformas from datawindow within w_pase_pedidos_proforma
end type
end forward

global type w_pase_pedidos_proforma from w_int_con_empresa
integer width = 2981
integer height = 1660
pb_1 pb_1
st_1 st_1
em_cliente em_cliente
st_nomcliente st_nomcliente
dw_consulta dw_consulta
dw_detalle dw_detalle
dw_temporal dw_temporal
cb_desmarcatodo cb_desmarcatodo
cb_1 cb_1
cb_marcatodo cb_marcatodo
gb_1 gb_1
cb_2 cb_2
st_texto st_texto
dw_proformas dw_proformas
end type
global w_pase_pedidos_proforma w_pase_pedidos_proforma

type variables
Dec{0} paso,nueva_ln_pedido,peso
Dec{0}  var_anyo_albaran,var_albaran,veces,var_albaran1,var_albaran2,control_lineas = 0
String  v_deposito
String observaciones = ""
dec{0} num_proforma,anyo_proforma
datetime fech_proforma
end variables

forward prototypes
public subroutine f_todo ()
public subroutine f_marcar_linea (integer t)
public subroutine f_control_marcar_linea (integer t)
public subroutine f_desmarcar_linea (integer t)
public subroutine f_desmarca_todo ()
public function decimal ultimo_numero ()
end prototypes

public subroutine f_todo ();Dec t,num,d
Dec{0}  var_pedido,var_linea,var_anyo
IF dw_detalle.RowCount() = 0 Then Return

FOR t = 1 To dw_detalle.RowCount()
	f_marcar_linea(t)	
NEXT

end subroutine

public subroutine f_marcar_linea (integer t);Dec{4} num,d,var_cantidad,var_pallets,var_cajas,var_cantidadp,var_palletsp,var_cajasp,var_total_cajas,var_total_cajasp,var_lineales,var_precio,var_descuento,var_dtoesp
Dec{0}  var_pedido,var_linea,var_anyo
string var_referencia,var_tipopallet,var_situacion,var_tipolinea,var_clase
String var_descripcion

		var_anyo       = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_referencia = dw_detalle.GetItemString(t,"venliped_referencia")
		var_descripcion = dw_detalle.GetItemString(t,"venliped_descripcion")
		var_tipopallet = dw_detalle.GetItemString(t,"venliped_tipo_pallet")
		var_anyo       = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_pedido     = dw_detalle.GetItemNumber(t,"venliped_pedido")
		var_linea      = dw_detalle.GetItemNumber(t,"venliped_linea")
		var_precio     = dw_detalle.GetItemNumber(t,"venliped_precio")
		var_cantidad   = dw_detalle.GetItemNumber(t,"venliped_cantidad")
		var_pallets    = dw_detalle.GetItemNumber(t,"venliped_pallets")
		var_cajas      = dw_detalle.GetItemNumber(t,"venliped_cajas")		
		var_clase      = dw_detalle.GetItemString(t,"venliped_clase")		
		var_situacion  = dw_detalle.GetItemString(t,"venliped_situacion")
		var_tipolinea  = dw_detalle.GetItemString(t,"venliped_tipolinea")
		var_lineales   = dw_detalle.GetItemNumber(t,"venliped_metros_lineales")		
		var_total_cajas= dw_detalle.GetItemNumber(t,"venliped_total_cajas")		
		var_descuento  = dw_detalle.GetItemNumber(t,"venliped_descuento")		
		var_dtoesp     = dw_detalle.GetItemNumber(t,"venliped_dtoesp")		
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num = 0 Then
			Select cantidad,pallets,cajas,total_cajas
			Into   :var_cantidadp,:var_palletsp,:var_cajasp,:var_total_cajasp
			From   venliped
			Where  venliped.empresa = :codigo_empresa
			And    venliped.anyo    = :var_anyo
			And    venliped.pedido  = :var_pedido
			And    venliped.linea   = :var_linea;
			IF var_cantidadp<var_cantidad Then
				f_mensaje("Error en introduccion de datos","La cantidad no puede superar al pedido")
				dw_detalle.SetItem(t,"venliped_cantidad",var_cantidadp)
				dw_detalle.SetItem(t,"venliped_pallets",var_palletsp)
				dw_detalle.SetItem(t,"venliped_cajas",var_cajasp)
				dw_detalle.SetItem(t,"venliped_total_cajas",var_total_cajasp)
				return
			END IF
			dw_detalle.SetColumn("marcado")
			dw_detalle.SetItem(t,"marcado","X")
			d= dw_temporal.RowCOunt() +1
			dw_temporal.InsertRow(d)
			dw_temporal.SetItem(d,"pedido",var_pedido)
			dw_temporal.SetItem(d,"anyo",var_anyo)
			dw_temporal.SetItem(d,"clase",var_clase)
			dw_temporal.SetItem(d,"linea",var_linea)
			dw_temporal.SetItem(d,"situacion",var_situacion)
			dw_temporal.SetItem(d,"precio",var_precio)
			dw_temporal.SetItem(d,"tipolinea",var_tipolinea)
			dw_temporal.SetItem(d,"lineales",var_lineales)
			dw_temporal.SetItem(d,"cantidad",var_cantidad)
			dw_temporal.SetItem(d,"pallets",var_pallets)
			dw_temporal.SetItem(d,"cajas",var_cajas)
			dw_temporal.SetItem(d,"total_cajas",var_total_cajas)
			dw_temporal.SetItem(d,"referencia",var_referencia)
			dw_temporal.SetItem(d,"tipo_pallet",var_tipopallet)
			dw_temporal.SetItem(d,"descripcion",var_descripcion)
			dw_temporal.SetItem(d,"descuento",var_descuento)
			dw_temporal.SetItem(d,"dtoesp",var_dtoesp)
		END IF




end subroutine

public subroutine f_control_marcar_linea (integer t);Dec num,d
Dec{0}  var_pedido,var_linea,var_anyo
dw_detalle.AcceptText()

IF dw_detalle.GetItemString(t,"marcado")= "" Then
	f_marcar_linea(t)
  ELSE
	f_desmarcar_linea(t)
END IF



end subroutine

public subroutine f_desmarcar_linea (integer t);Dec num,d,var_cantidad,var_pallets,var_cajas,var_total_cajas
Dec{0}  var_pedido,var_linea,var_anyo

		var_anyo   = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_pedido = dw_detalle.GetItemNumber(t,"venliped_pedido")
		var_linea  = dw_detalle.GetItemNumber(t,"venliped_linea")
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num <> 0 Then
			Select cantidad,pallets,cajas,total_cajas
			Into   :var_cantidad,:var_pallets,:var_cajas,:var_total_cajas
			From   venliped
			Where  venliped.empresa = :codigo_empresa
			And    venliped.anyo    = :var_anyo
			And    venliped.pedido  = :var_pedido
			And    venliped.linea   = :var_linea;
			dw_temporal.DeleteRow(num)
			dw_detalle.SetItem(t,"marcado","")
			dw_detalle.SetItem(t,"venliped_cantidad",var_cantidad)
			dw_detalle.SetItem(t,"venliped_pallets",var_pallets)
			dw_detalle.SetItem(t,"venliped_cajas",var_cajas)
			dw_detalle.SetItem(t,"venliped_total_cajas",var_total_cajas)
		END IF




end subroutine

public subroutine f_desmarca_todo ();Dec t,num,d
Dec{0}  var_pedido,var_linea,var_anyo
IF dw_detalle.RowCount() = 0 Then Return

FOR t = 1 To dw_detalle.RowCount()
	f_desmarcar_linea(t)	
NEXT

end subroutine

public function decimal ultimo_numero ();dec{0} n_proforma
Integer registros,numero,anyo
String  var_empresa

anyo = year(today())

  SELECT venparamprofor.empresa,venparamprofor.proforma
    INTO :var_empresa,:registros  
    FROM venparamprofor  
   WHERE venparamprofor.empresa = :codigo_empresa  
     And venparamprofor.anyo    = :anyo;
      If Sqlca.Sqlcode=100 Then
         INSERT INTO venparamprofor  
              (empresa,anyo,proforma)  
         VALUES (:codigo_empresa,:anyo,:registros );
         COMMIT;
   END IF
   IF IsNull(registros) Then registros=0
   registros=registros + 1
   n_proforma= registros

   Select count(*) Into :numero From venproformas
   Where   venproformas.empresa   = :codigo_empresa
   And     venproformas.anyo       = :anyo
   And     venproformas.proforma   = :n_proforma;
   If IsNull(numero) Then numero=0
   If numero<>0 Then
       Select max((venproformas.proforma)+1)
       Into   :n_proforma
       From   venproformas
       Where  venproformas.empresa = :codigo_empresa
       And    venproformas.anyo    = :anyo;
   End If
   UPDATE venparamprofor
   SET    proforma = :n_proforma
   WHERE  venparamprofor.empresa = :codigo_empresa
   And    venparamprofor.anyo    = :anyo;
   
	COMMIT;

Return n_proforma

end function

event open;call super::open;istr_parametros.s_titulo_ventana="Pase de pedidos a proformas"
This.title=istr_parametros.s_titulo_ventana
paso = 1
dw_consulta.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_proformas.SetTransObject(SQLCA)

f_mascara_columna(dw_detalle,"venliped_cantidad",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"venliped_cajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"venliped_pallets",f_mascara_decimales(0))
f_activar_campo(em_cliente)

end event

on w_pase_pedidos_proforma.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.em_cliente=create em_cliente
this.st_nomcliente=create st_nomcliente
this.dw_consulta=create dw_consulta
this.dw_detalle=create dw_detalle
this.dw_temporal=create dw_temporal
this.cb_desmarcatodo=create cb_desmarcatodo
this.cb_1=create cb_1
this.cb_marcatodo=create cb_marcatodo
this.gb_1=create gb_1
this.cb_2=create cb_2
this.st_texto=create st_texto
this.dw_proformas=create dw_proformas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_cliente
this.Control[iCurrent+4]=this.st_nomcliente
this.Control[iCurrent+5]=this.dw_consulta
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.dw_temporal
this.Control[iCurrent+8]=this.cb_desmarcatodo
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_marcatodo
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.st_texto
this.Control[iCurrent+14]=this.dw_proformas
end on

on w_pase_pedidos_proforma.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.em_cliente)
destroy(this.st_nomcliente)
destroy(this.dw_consulta)
destroy(this.dw_detalle)
destroy(this.dw_temporal)
destroy(this.cb_desmarcatodo)
destroy(this.cb_1)
destroy(this.cb_marcatodo)
destroy(this.gb_1)
destroy(this.cb_2)
destroy(this.st_texto)
destroy(this.dw_proformas)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;	f_pagina_arriba(dw_consulta)

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_pase_pedidos_proforma
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_pase_pedidos_proforma
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_cliente)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_pase_pedidos_proforma
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_pase_pedidos_proforma
integer x = 2715
integer y = 8
integer width = 119
integer height = 108
integer taborder = 0
string picturename = "exit!"
end type

type st_1 from statictext within w_pase_pedidos_proforma
integer x = 87
integer y = 132
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cliente from u_em_campo within w_pase_pedidos_proforma
integer x = 338
integer y = 120
integer width = 411
integer taborder = 10
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
end type

event modificado;call super::modificado;st_nomcliente.text=f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
IF Trim(st_nomcliente.text)="" THEN 
 IF Trim(st_nomcliente.text)<>"" Then f_activar_campo(em_cliente)
 em_cliente.text=""
END IF
dw_consulta.Retrieve(codigo_empresa,em_cliente.text)
dw_temporal.Reset()

end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 		



end event

type st_nomcliente from statictext within w_pase_pedidos_proforma
integer x = 763
integer y = 124
integer width = 1458
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_consulta from u_datawindow_consultas within w_pase_pedidos_proforma
integer y = 224
integer width = 325
integer height = 1064
integer taborder = 0
string dataobject = "dw_pase_pedidos_proforma1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;IF This.GetRow() = 0 Then Return
	Dec anyo,pedido
anyo    = This.GetItemNumber(currentrow,"anyo")
pedido  = This.GetItemNumber(currentrow,"pedido")
dw_detalle.Retrieve(codigo_empresa,anyo,pedido)

end event

event retrieveend;call super::retrieveend;Dec anyo,pedido
IF RowCOunt() = 0 Then Return
anyo    = This.GetItemNumber(1,"anyo")
pedido  = This.GetItemNumber(1,"pedido")
IF This.RowCOUNT() <> 0 Then
	dw_detalle.Retrieve(codigo_empresa,anyo,pedido)
	SetRow(1)
END IF
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

type dw_detalle from u_datawindow_consultas within w_pase_pedidos_proforma
integer x = 320
integer y = 224
integer width = 2555
integer height = 1064
integer taborder = 20
string dataobject = "dw_pase_pedidos_proforma2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;IF row = 0 Then Return
f_control_marcar_linea(row)
end event

event retrieveend;call super::retrieveend;Integer t,n
Dec{0}  var_pedido,var_linea,var_anyo,var_cantidad,var_pallets,var_cajas,var_total_cajas
IF RowCount() = 0 Then return
For t = 1 To RowCount()
	var_anyo  = GetItemNumber(t,"venliped_anyo")
	var_pedido = GetItemNumber(t,"venliped_pedido")
	var_linea = GetItemNumber(t,"venliped_linea")
	n =  dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
	IF n<> 0 Then
		SetItem(t,"marcado","X")
		var_cantidad = dw_temporal.GetItemNumber(n,"cantidad")
		var_pallets  = dw_temporal.GetItemNumber(n,"pallets")
		var_cajas    = dw_temporal.GetItemNumber(n,"cajas")
		var_total_cajas    = dw_temporal.GetItemNumber(n,"total_cajas")
		SetItem(t,"venliped_cantidad", var_cantidad)
		SetItem(t,"venliped_pallets",  var_pallets)
		SetItem(t,"venliped_cajas",    var_cajas)
		SetItem(t,"venliped_total_cajas",  var_total_cajas)
	END IF
NEXT




end event

event key;call super::key;Int row
Long posi,posi_aux
String var_tipolin

row = GetRow()
if key = KeyTab! Then
	 string     cadena,var_articulo,var_tipo_pallet,var_caja
	 Dec{0}     var_pallets,var_cajas,var_total_cajas
	 Dec{2}     var_cantidad
	 AccepTtext()
	 var_pallets     =  GetItemNumber(row,"venliped_pallets")
	 var_cajas       =  GetItemNumber(row,"venliped_cajas")
	 var_cantidad    =  GetItemNumber(row,"venliped_cantidad")
	 var_articulo    =  GetItemString(row,"venliped_articulo")
	 var_tipo_pallet =  GetItemString(row,"venliped_tipo_pallet")
	 var_caja        =  GetItemString(row,"venliped_caja")
	 var_tipolin       =  GetItemString(row,"venliped_tipolinea")
	
	IF GetColumnName() = "venliped_cantidad" Then 
		var_pallets = 0
		var_cajas   = 0
	END IF
 	cadena=f_calculo_unidades_tipolin(codigo_empresa,var_articulo,&
                            var_tipo_pallet,&
									 var_caja,&
                            var_pallets,&
                            var_cajas,&
                            var_cantidad, var_tipolin)
 	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		var_pallets     = dec(trim(Mid(cadena,1,posi - 1)))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
		var_cajas         = dec(trim(Mid(cadena,posi_aux,posi - posi_aux)))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		var_total_cajas   = dec(trim(Mid(cadena,posi_aux,posi - posi_aux)))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		var_cantidad      = dec(trim(Mid(cadena,posi_aux,posi - posi_aux)))
		posi_aux = posi + 1
	end if
	 
	SetItem(row,"venliped_pallets",var_pallets)
	SetItem(row,"venliped_cajas",var_cajas)
	SetItem(row,"venliped_total_cajas",var_total_cajas)
	SetItem(row,"venliped_cantidad",var_cantidad)
END IF
end event

event clicked;call super::clicked;if row=0 then return
string marcado
marcado = this.GetItemString(row,"marcado")

if marcado = "X" then
	This.SetTabOrder("venliped_pallets",0)	
	This.SetTabOrder("venliped_cajas",0)
	This.SetTabOrder("venliped_cantidad",0)	
else
	This.SetTabOrder("venliped_pallets",1)	
	This.SetTabOrder("venliped_cajas",2)
	This.SetTabOrder("venliped_cantidad",3)	
End if	
	
end event

type dw_temporal from datawindow within w_pase_pedidos_proforma
boolean visible = false
integer x = 430
integer y = 896
integer width = 494
integer height = 360
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_pase_pedidos_proforma3"
boolean livescroll = true
end type

type cb_desmarcatodo from u_boton within w_pase_pedidos_proforma
event clicked pbm_bnclicked
integer x = 1765
integer y = 1328
integer width = 347
integer height = 68
integer taborder = 0
string text = "&Desmarca"
end type

event clicked;call super::clicked;f_desmarca_todo()
end event

type cb_1 from u_boton within w_pase_pedidos_proforma
integer x = 2427
integer y = 1328
integer width = 389
integer height = 68
integer taborder = 0
string text = "&Continuar"
end type

event clicked;if dw_temporal.rowcount()<>0 then
      
   dw_temporal.Sort()
	Dec t,var_anyo,var_pedido,var_linea,var_precio,var_cantidad,var_dtoesp,var_dtocomer,var_lineales,var_descuento
	Integer  var_ejercicio,bien,ultima
	String var_referencia,var_codigo,var_tipopallet,var_tipoter
	String var_clase,var_sector,var_calidad,var_descripcion
	String var_situacion,var_tipolinea,var_control_alm,var_tono
	int var_calibre,var_cajas,var_totalcajas,var_pallets,tt
	str_venproformas profor
	str_venliproformas linprofor
	bien = 0

   
	         // Grabamos la cabecera proforma
				
				var_ejercicio       = f_ejercicio_activo(codigo_empresa)
				if num_proforma = 0 then 
					  profor.proforma  = ultimo_numero()
					  profor.anyo         = year(today())
					  profor.fproforma    = datetime(today())
				   else
					  profor.proforma  = num_proforma
					  profor.anyo      = anyo_proforma
					  profor.fproforma = fech_proforma
				end if
				
				profor.tipo_cliente = "S"
				
				SELECT venclientes.zona,venclientes.serie,venclientes.agente1,   
						 venclientes.agente2,venclientes.agente3,venclientes.comision1, venclientes.comision2,   venclientes.comision31,
						 venclientes.cod_pago,venclientes.dtopp,venclientes.dtoesp1,   
						 venclientes.dtoesp2, venclientes.tipoiva,
						 venclientes.forma_envio, venclientes.tipo_portes,   
						 venclientes.cod_entrega, venclientes.periodo_fac,   
						 venclientes.explicaciondto1, venclientes.explicaciondto2,   
						 venclientes.tarifa,   
						 venclientes.comision11,      venclientes.comision22,   venclientes.comision31, 
						 venclientes.dtoesp3,         venclientes.dtoesp4,   
						 venclientes.explicaciondto3, venclientes.explicaciondto4,   
						 venclientes.tipodto1,        venclientes.tipodto2,   
						 venclientes.tipodto3,        venclientes.tipodto4,   
						 venclientes.empresa,         venclientes.codigo  ,
						 venclientes.cod_entrega,     venclientes.calculo_dto  ,
						 venclientes.banco_de_cobro,  venclientes.envio,
						 venclientes.correspondencia,venclientes.domiciliacion,venclientes.transportista
				INTO   :profor.zona, :profor.serie, :profor.agente1, :profor.agente2,:profor.agente3,:profor.comision1,   
						 :profor.comision2,:profor.comision31,:profor.codpago,:profor.dtopp,:profor.dtoesp1,
						 :profor.dtoesp2,:profor.tipoiva, :profor.forma_envio,   
						 :profor.tipo_portes,:profor.cod_entrega,:profor.periodo_fac,
						 :profor.explicaciondto1,:profor.explicaciondto2,   
						 :profor.tarifa,:profor.comision11,:profor.comision22,:profor.comision31,:profor.dtoesp3,   
						 :profor.dtoesp4,:profor.explicaciondto3,:profor.explicaciondto4,
						 :profor.tipodto1,:profor.tipodto2,:profor.tipodto3,:profor.tipodto4,   
						 :profor.empresa,:profor.cliente ,:profor.cod_entrega,
						 :profor.calculo_dto,:profor.banco_de_cobro,
						 :profor.envio,:profor.correspondencia,
						 :profor.domiciliacion,:profor.transportista
				FROM   venclientes  
				WHERE  ( venclientes.empresa = :codigo_empresa ) AND  
						 ( venclientes.codigo  = :em_cliente.text )   
				ORDER BY venclientes.empresa ASC,venclientes.codigo ASC  ;
	
				Select  genter.idioma,genter.moneda
				Into    :profor.idioma,:profor.divisa
				From genter
				Where   genter.empresa = :codigo_empresa 
						 And     genter.tipoter = 'C'
						 And     genter.codigo  = :em_cliente.text;
	
				SELECT contaiva.iva  INTO :profor.iva  
				FROM contaiva  
				WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
						( contaiva.empresa = :codigo_empresa ) AND  
						( contaiva.tipoiva = :profor.tipoiva )   ;
	
					
				profor.textopie1 = f_nombre_vencondentrega(codigo_empresa,profor.cod_entrega)
				profor.textopie2 = f_nombre_vencondentrega_idioma(codigo_empresa,profor.cod_entrega,profor.idioma)
				profor.usuario_proforma   = nombre_usuario
				profor.activa = "S"
		  
				if num_proforma = 0 then
  				   IF NOT f_insertar_venproformas(profor) Then bien=1
				End if
				  
	// Graba las lineas seleccionadas
	
	ultima =  0
	Select max(venliproformas.linea) Into :ultima From venliproformas
	Where  venliproformas.empresa   =   :codigo_empresa
	And    venliproformas.anyo      =   :profor.anyo
	And    venliproformas.proforma  =   :profor.proforma;
	IF ISNull(ultima) Then ultima=0
	
	tt = dw_temporal.Rowcount()
	for t=1 to tt
     		f_mensaje_proceso("Procesando",t,tt)
			var_anyo        = dw_temporal.GetItemNumber(t,"anyo")
			var_pedido      = dw_temporal.GetItemNumber(t,"pedido")
			var_linea       = dw_temporal.GetItemNumber(t,"linea")
			var_precio      = dw_temporal.GetItemNumber(t,"precio")
			var_cajas       = dw_temporal.GetItemNumber(t,"cajas")
			var_clase       = dw_temporal.GetItemSTring(t,"clase")
			var_totalcajas  = dw_temporal.GetItemNumber(t,"total_cajas")
			var_pallets     = dw_temporal.GetItemNumber(t,"pallets")
			var_cantidad    = dw_temporal.GetItemNumber(t,"cantidad")
		   var_referencia  = dw_temporal.GetItemString(t,"referencia")
			var_dtoesp      = dw_temporal.GetItemNumber(t,"dtoesp")
			var_dtocomer    = dw_temporal.GetItemNumber(t,"dtocomer")
			var_descripcion = dw_temporal.GetItemString(t,"descripcion")
			var_codigo      = f_articulo_referencia(var_referencia)
			var_calidad     = f_calidad_referencia(var_referencia)
			var_tono        = Trim(f_tono_referencia(var_referencia))
			var_calibre     = integer(f_calibre_referencia(var_referencia))
			var_tipopallet  = dw_temporal.GetItemString(t,"tipo_pallet")
			var_situacion   = dw_temporal.GetItemString(t,"situacion")
			var_tipolinea   = dw_temporal.GetItemString(t,"tipolinea")
			var_lineales    = dw_temporal.GetItemNumber(t,"lineales")
			var_descuento   = dw_temporal.GetItemNumber(t,"descuento")
			
			ultima = ultima +1
			
			
				linprofor.empresa   = profor.empresa
				linprofor.anyo      = profor.anyo
				linprofor.proforma  = profor.proforma
				linprofor.fproforma = profor.fproforma
				linprofor.cliente   = profor.cliente
				linprofor.tipoiva   = profor.tipoiva
				linprofor.iva       = profor.iva
				linprofor.divisa    = profor.divisa
				linprofor.serie     = profor.serie
				linprofor.zona      = profor.zona
				linprofor.agente1   = profor.agente1
				linprofor.agente2   = profor.agente2
				linprofor.agente3   = profor.agente3
				linprofor.comision11= profor.comision1
				linprofor.comision12= profor.comision11
				linprofor.comision21= profor.comision2
				linprofor.comision22= profor.comision22
				linprofor.comision31= profor.comision31
				linprofor.comision32= profor.comision32
				linprofor.linea     = ultima
				
				linprofor.articulo  = var_codigo
				linprofor.clase     = var_clase
				
				SELECT articulos.familia,articulos.formato,articulos.sector,
				       articulos.modelo,articulos.unidad,articulos.pesopieza
				INTO   :linprofor.familia,:linprofor.formato,:linprofor.sector,
						 :linprofor.modelo,:linprofor.tipo_unidad,:linprofor.peso    
				FROM articulos  
				WHERE (articulos.empresa = :codigo_empresa )
				AND   (articulos.codigo = :linprofor.articulo )   
				ORDER BY articulos.empresa ASC,articulos.codigo ASC;


           linprofor.calidad         = var_calidad
           linprofor.tonochar        = ""
           linprofor.calibre         = 0
			   linprofor.precio       	 = var_precio
			  linprofor.precio_aduana   = 0
			  linprofor.precio_estand   = f_precio_articulo(linprofor.empresa,linprofor.cliente,linprofor.articulo,linprofor.calidad,f_tarifa_venproformas(linprofor.empresa,linprofor.anyo,linprofor.proforma))
			  linprofor.cantidad        = var_cantidad
			  linprofor.pallets         = var_pallets
			  linprofor.total_cajas     = var_totalcajas
			  linprofor.cajas           = var_cajas
           linprofor.dtocomer        = var_dtocomer
           linprofor.dtoesp          = var_dtoesp
           linprofor.descripcion     = var_descripcion
			  linprofor.descuento = var_descuento

			  SELECT familias.linea INTO :linprofor.linfab FROM familias  
				WHERE ( familias.empresa = :codigo_empresa ) AND  
						( familias.codigo  = :linprofor.familia )   ;

				SELECT genter.pais,genter.provincia  
				INTO   :linprofor.pais,:linprofor.provincia  
				FROM   genter  
				WHERE (genter.empresa = :codigo_empresa)
				AND   (genter.tipoter = 'C' )
				AND   (genter.codigo = :linprofor.cliente )   
				ORDER BY genter.empresa ASC,genter.tipoter ASC,genter.codigo ASC  ;

					linprofor.tipolinea       = var_tipolinea
					linprofor.texto1          = var_descripcion
					linprofor.texto2          = ""
					linprofor.texto3          = ""
					linprofor.referencia      = var_referencia
					linprofor.montajeartcal   = f_componer_artcal(linprofor.articulo,linprofor.calidad)
					linprofor.situacion       = var_situacion
					linprofor.metros_lineales = var_lineales
					linprofor.falta           = Datetime(today())
					linprofor.usuario         = nombre_usuario
					linprofor.tipo_pallet     = var_tipopallet
					linprofor.deposito        = "N"


                 SELECT ventipolin.control_almacen  
					 INTO :var_control_alm
					 FROM ventipolin  
					WHERE ( ventipolin.empresa = :codigo_empresa ) AND  
							( ventipolin.codigo = :var_tipolinea )   ;

               IF var_control_alm = "N" Then 
					    SetNull(linprofor.articulo)
					    SetNull(linprofor.formato)
					    SetNull(linprofor.modelo)
					    SetNull(linprofor.calidad)
					    SetNull(linprofor.tonochar)
					    SetNull(linprofor.calibre)
					    SetNull(linprofor.pallets)
					    SetNull(linprofor.total_cajas)
					    SetNull(linprofor.cajas)
					    SetNull(linprofor.linfab)
					    SetNull(linprofor.referencia)
					    SetNull(linprofor.montajeartcal)
					    SetNull(linprofor.tipo_pallet)
					    linprofor.tipo_unidad = "0"
				  END IF
     if not f_insertar_venliproformas(linprofor) then bien = 1

    next
	 
	IF bien = 0 Then
		COMMIT;
		f_actualizar_venproforma(codigo_empresa,profor.anyo,profor.proforma)
      f_mensaje("Fin del proceso","Proceso realizado correctamente. Proforma Nº "+string(profor.proforma,"###,###"))	
      dw_temporal.reset()
		st_texto.text = ""
		em_cliente.text = ""
		em_cliente.TriggerEvent("modificado")
		dw_detalle.reset()
		f_activar_campo(em_cliente)
   ELSE
		ROLLBACK;
		f_mensaje("Error en proceso de datos","No se actualiza" + sqlca.sqlerrtext)
	END IF
end if




end event

type cb_marcatodo from u_boton within w_pase_pedidos_proforma
event clicked pbm_bnclicked
integer x = 2117
integer y = 1328
integer width = 311
integer height = 68
integer taborder = 0
string text = "&Marca"
end type

event clicked;call super::clicked;f_todo()
end event

type gb_1 from groupbox within w_pase_pedidos_proforma
integer x = 1166
integer y = 1296
integer width = 1664
integer height = 112
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_2 from commandbutton within w_pase_pedidos_proforma
integer x = 1175
integer y = 1328
integer width = 590
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Seleccionar Proforma"
end type

event clicked;dw_proformas.visible=True
dw_proformas.retrieve(codigo_empresa,em_cliente.text)


end event

type st_texto from statictext within w_pase_pedidos_proforma
integer x = 14
integer y = 1320
integer width = 850
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_proformas from datawindow within w_pase_pedidos_proforma
boolean visible = false
integer x = 347
integer y = 452
integer width = 1070
integer height = 832
integer taborder = 30
string dataobject = "dw_pase_proformas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if row=0 then return
num_proforma  = this.GetItemNumber(row,"proforma")
anyo_proforma = This.GetItemNumber(row,"anyo")
fech_proforma = this.GetItemdatetime(row,"fproforma")
st_texto.text = "Nº Proforma "+string(num_proforma,"###,###")
dw_proformas.visible = False
end event

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	Reset()
	visible = FALSE
	num_proforma  = 0
	anyo_proforma = 0
	st_texto.text = ""
END IF
end event

