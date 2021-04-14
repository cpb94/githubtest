$PBExportHeader$w_int_movtraspasos_compras.srw
forward
global type w_int_movtraspasos_compras from w_int_con_empresa
end type
type st_11 from statictext within w_int_movtraspasos_compras
end type
type st_texto_cantidad from statictext within w_int_movtraspasos_compras
end type
type st_1 from statictext within w_int_movtraspasos_compras
end type
type st_9 from statictext within w_int_movtraspasos_compras
end type
type pb_1 from upb_salir within w_int_movtraspasos_compras
end type
type em_fecha from u_em_campo within w_int_movtraspasos_compras
end type
type em_cantidad from u_em_campo within w_int_movtraspasos_compras
end type
type sle_observaciones from u_em_campo within w_int_movtraspasos_compras
end type
type cb_1 from u_boton within w_int_movtraspasos_compras
end type
type cb_borrar from u_boton within w_int_movtraspasos_compras
end type
type cb_4 from u_boton within w_int_movtraspasos_compras
end type
type cb_3 from u_boton within w_int_movtraspasos_compras
end type
type uo_articulo from u_em_campo_2 within w_int_movtraspasos_compras
end type
type cb_2 from u_boton within w_int_movtraspasos_compras
end type
type dw_listado from datawindow within w_int_movtraspasos_compras
end type
type pb_listado from upb_imprimir within w_int_movtraspasos_compras
end type
type dw_pedidos from datawindow within w_int_movtraspasos_compras
end type
type dw_ordenes from datawindow within w_int_movtraspasos_compras
end type
type dw_proceso1 from datawindow within w_int_movtraspasos_compras
end type
type dw_1 from u_datawindow_consultas within w_int_movtraspasos_compras
end type
type dw_detalle from datawindow within w_int_movtraspasos_compras
end type
type dw_2 from datawindow within w_int_movtraspasos_compras
end type
type st_listado from statictext within w_int_movtraspasos_compras
end type
type dw_proceso2 from datawindow within w_int_movtraspasos_compras
end type
type dw_proceso from datawindow within w_int_movtraspasos_compras
end type
type dw_3 from datawindow within w_int_movtraspasos_compras
end type
end forward

global type w_int_movtraspasos_compras from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2290
integer height = 1624
string menuname = ""
boolean resizable = true
st_11 st_11
st_texto_cantidad st_texto_cantidad
st_1 st_1
st_9 st_9
pb_1 pb_1
em_fecha em_fecha
em_cantidad em_cantidad
sle_observaciones sle_observaciones
cb_1 cb_1
cb_borrar cb_borrar
cb_4 cb_4
cb_3 cb_3
uo_articulo uo_articulo
cb_2 cb_2
dw_listado dw_listado
pb_listado pb_listado
dw_pedidos dw_pedidos
dw_ordenes dw_ordenes
dw_proceso1 dw_proceso1
dw_1 dw_1
dw_detalle dw_detalle
dw_2 dw_2
st_listado st_listado
dw_proceso2 dw_proceso2
dw_proceso dw_proceso
dw_3 dw_3
end type
global w_int_movtraspasos_compras w_int_movtraspasos_compras

type variables
//str_parametros  istr_parametros
  integer contador,v_fila,v_altura,anyo
  string v_almacen,v_zona,v_familia,v_sector,v_caja
  decimal{4} v_cantidad,disp_int
  string ante_codigo_articulo,ante_codigo_calidad,ante_tono

Boolean  control_tono,control_calibre

// Defino la estructura de la tablas a procesar
   str_comlinubicahis  ubihis
   str_comlinubica      ubi
   str_commovhis        movhis
   


end variables

forward prototypes
public subroutine f_control_ubicacion ()
public subroutine f_listado_incidencias (string empresa, string articulo, string calidad, string tono, integer calibre, string tipo_pallet, string caja)
end prototypes

public subroutine f_control_ubicacion ();decimal{2} var_cantidad,total_cantidad,cur_existencias
string  var_referencia,var_ubicacion
String  cur_empresa
Integer cur_pedido,cur_linea,salir
String  cur_ubicacion,cur_referencia,cur_tipo_pallet,cur_caja
string tipo_pal,caja
Integer registros,x1

total_cantidad=0

var_ubicacion=f_componer_ubicacion(dw_2.GetItemString(dw_2.GetRow(),"almacen"),&
                                   dw_2.GetItemString(dw_2.GetRow(),"zona"),&
                                   dw_2.GetItemNumber(dw_2.GetRow(),"fila"),&
                                   dw_2.GetItemNumber(dw_2.GetRow(),"altura"))

//var_referencia=f_componer_ref(uo_articulo.em_codigo.text,&
//                              uo_calidad.em_codigo.text,&
//                              Trim(em_tono.text),&
//                              Integer(em_calibre.text))

registros = dw_proceso.retrieve(codigo_empresa,var_ubicacion,uo_articulo.em_codigo.text)

IF registros<>0 THEN
  	For x1 = 1 To registros
      	cur_linea       =  dw_proceso.GetItemNumber(x1,"linea")
      	cur_existencias =  dw_proceso.GetItemNumber(x1,"existencias")

        	total_cantidad = cur_existencias + total_cantidad
  	NEXT
End If
end subroutine

public subroutine f_listado_incidencias (string empresa, string articulo, string calidad, string tono, integer calibre, string tipo_pallet, string caja);IF IsNull(disp_int) Then disp_int = 0
IF disp_int >=0 Then Return
Integer re,re1,cont,j
String cliente,var_ubicaciones,var_referencia,situacion
Dec{0}  pedido,orden,linea
Dec cantidad
DateTime  fpedido,forden
var_referencia  = f_componer_ref(articulo,calidad,tono,calibre)
cont = 0
re1 = dw_pedidos.Retrieve(empresa,articulo,calidad,tono,calibre,tipo_pallet,caja)
IF re1 <> 0 Then
	For re =1 To re1
		cont    = cont +1
		fpedido = dw_pedidos.GetItemDateTime(re,"fpedido")
		pedido  = dw_pedidos.GetItemNumber(re,"pedido")
		anyo    = dw_pedidos.GetItemNumber(re,"anyo")
		linea   = dw_pedidos.GetItemNumber(re,"linea")
		cantidad = dw_pedidos.GetItemNumber(re,"cantidad")
		cliente = dw_pedidos.GetItemString(re,"cliente")
		IF  dw_pedidos.GetItemString(re,"situacion") <> "P" Then
			 var_ubicaciones= f_ubicaciones_referencia_tipo_pallet(codigo_empresa,var_referencia,tipo_pallet,2,"S")
		ELSE
			var_ubicaciones= f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,tipo_pallet,anyo,pedido,linea)
		END IF
		dw_listado.InsertRow(cont)
		dw_listado.SetItem(cont,"empresa",empresa)
		dw_listado.SetItem(cont,"articulo",articulo)
		dw_listado.SetItem(cont,"calidad",calidad)
		dw_listado.SetItem(cont,"tono",tono)
		dw_listado.SetItem(cont,"calibre",calibre)
		dw_listado.SetItem(cont,"tipo_pallet",tipo_pallet)
		dw_listado.SetItem(cont,"caja",caja)
		dw_listado.SetItem(cont,"cliente",cliente)
		dw_listado.SetItem(cont,"pedido",pedido)
		dw_listado.SetItem(cont,"cantidad",cantidad)
		dw_listado.SetItem(cont,"fpedido",fpedido)
		dw_listado.SetItem(cont,"ubicacion",var_ubicaciones)
	Next
END IF


re1 = dw_ordenes.Retrieve(empresa,articulo,calidad,tono,calibre,tipo_pallet,caja)
IF re1 <> 0 Then
	For re =1 To re1
		cont = cont +1
		fpedido = dw_ordenes.GetItemDateTime(re,"fecha_ped")
		cliente = dw_ordenes.GetItemstring(re,"cliente")
		orden = dw_ordenes.GetItemNumber(re,"orden")
		forden = dw_ordenes.GetItemDateTime(re,"forden")
		pedido = dw_ordenes.GetItemNumber(re,"pedido")
		anyo = dw_ordenes.GetItemNumber(re,"anyo_ped")
		linea = dw_ordenes.GetItemNumber(re,"linea_ped")
		cantidad = dw_ordenes.GetItemNumber(re,"cantidad")
		IF dw_ordenes.GetItemString(re,"situacion_pedido")<>"P" Then
			 var_ubicaciones= f_ubicaciones_referencia_tipo_pallet(codigo_empresa,var_referencia,tipo_pallet,2,"S")
		ELSE
			var_ubicaciones= f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,tipo_pallet,anyo,pedido,linea)
		END IF
		dw_listado.InsertRow(cont)
		dw_listado.SetItem(cont,"empresa",empresa)
		dw_listado.SetItem(cont,"articulo",articulo)
		dw_listado.SetItem(cont,"calidad",calidad)
		dw_listado.SetItem(cont,"tono",tono)
		dw_listado.SetItem(cont,"calibre",calibre)
		dw_listado.SetItem(cont,"tipo_pallet",tipo_pallet)
		dw_listado.SetItem(cont,"caja",caja)
		dw_listado.SetItem(cont,"pedido",pedido)
		dw_listado.SetItem(cont,"cantidad",cantidad)
		dw_listado.SetItem(cont,"fpedido",fpedido)
		dw_listado.SetItem(cont,"orden",orden)
		dw_listado.SetItem(cont,"forden",forden)
		dw_listado.SetItem(cont,"cliente",cliente)
		dw_listado.SetItem(cont,"ubicacion",var_ubicaciones)
	Next
END IF
IF dw_listado.RowCount()<> 0 Then
	
	pb_listado.visible = TRUE
	st_listado.visible = TRUE
END IF
end subroutine

event open;call super::open;datetime fecha

istr_parametros.s_titulo_ventana="Introduccion Movimientos traspasos almacen de Compras"
This.title=istr_parametros.s_titulo_ventana
dw_1.visible=false
em_fecha.text=String(today())
dw_listado.SetTransObject(SQLCA)
dw_proceso1.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
// preparo datawindow ubicaciones
dw_2.settransobject(SQLCA)
//dw_2.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator


dw_3.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)

fecha = Datetime(Date(em_fecha.text))
dw_3.retrieve(codigo_empresa,fecha)

dw_pedidos.SetTransObject(SQLCA)
dw_ordenes.SetTransObject(SQLCA)
f_activar_campo(uo_articulo.em_campo)
end event

on w_int_movtraspasos_compras.create
int iCurrent
call super::create
this.st_11=create st_11
this.st_texto_cantidad=create st_texto_cantidad
this.st_1=create st_1
this.st_9=create st_9
this.pb_1=create pb_1
this.em_fecha=create em_fecha
this.em_cantidad=create em_cantidad
this.sle_observaciones=create sle_observaciones
this.cb_1=create cb_1
this.cb_borrar=create cb_borrar
this.cb_4=create cb_4
this.cb_3=create cb_3
this.uo_articulo=create uo_articulo
this.cb_2=create cb_2
this.dw_listado=create dw_listado
this.pb_listado=create pb_listado
this.dw_pedidos=create dw_pedidos
this.dw_ordenes=create dw_ordenes
this.dw_proceso1=create dw_proceso1
this.dw_1=create dw_1
this.dw_detalle=create dw_detalle
this.dw_2=create dw_2
this.st_listado=create st_listado
this.dw_proceso2=create dw_proceso2
this.dw_proceso=create dw_proceso
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_11
this.Control[iCurrent+2]=this.st_texto_cantidad
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_9
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.em_fecha
this.Control[iCurrent+7]=this.em_cantidad
this.Control[iCurrent+8]=this.sle_observaciones
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_borrar
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.uo_articulo
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.dw_listado
this.Control[iCurrent+16]=this.pb_listado
this.Control[iCurrent+17]=this.dw_pedidos
this.Control[iCurrent+18]=this.dw_ordenes
this.Control[iCurrent+19]=this.dw_proceso1
this.Control[iCurrent+20]=this.dw_1
this.Control[iCurrent+21]=this.dw_detalle
this.Control[iCurrent+22]=this.dw_2
this.Control[iCurrent+23]=this.st_listado
this.Control[iCurrent+24]=this.dw_proceso2
this.Control[iCurrent+25]=this.dw_proceso
this.Control[iCurrent+26]=this.dw_3
end on

on w_int_movtraspasos_compras.destroy
call super::destroy
destroy(this.st_11)
destroy(this.st_texto_cantidad)
destroy(this.st_1)
destroy(this.st_9)
destroy(this.pb_1)
destroy(this.em_fecha)
destroy(this.em_cantidad)
destroy(this.sle_observaciones)
destroy(this.cb_1)
destroy(this.cb_borrar)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.uo_articulo)
destroy(this.cb_2)
destroy(this.dw_listado)
destroy(this.pb_listado)
destroy(this.dw_pedidos)
destroy(this.dw_ordenes)
destroy(this.dw_proceso1)
destroy(this.dw_1)
destroy(this.dw_detalle)
destroy(this.dw_2)
destroy(this.st_listado)
destroy(this.dw_proceso2)
destroy(this.dw_proceso)
destroy(this.dw_3)
end on

event activate;call super::activate;w_int_movtraspasos_compras = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_movtraspasos_compras
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_movtraspasos_compras
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_movtraspasos_compras
integer x = 9
integer y = 24
integer width = 2007
integer height = 88
integer textsize = -11
end type

type st_11 from statictext within w_int_movtraspasos_compras
integer x = 14
integer y = 168
integer width = 206
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_movtraspasos_compras
integer x = 1893
integer y = 268
integer width = 297
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_int_movtraspasos_compras
integer x = 9
integer y = 268
integer width = 864
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_movtraspasos_compras
integer x = 27
integer y = 788
integer width = 425
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
string text = "Observaciones"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_movtraspasos_compras
integer x = 2057
integer y = 28
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
alignment htextalign = right!
end type

event clicked;IF dw_listado.RowCOunt() <> 0 Then
	f_mensaje("No se puede salir","Listar Incidencias")
	Return
END IF
Call Super::Clicked
end event

type em_fecha from u_em_campo within w_int_movtraspasos_compras
integer x = 256
integer y = 168
integer width = 384
integer taborder = 40
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

on modified;call u_em_campo::modified;dw_3.retrieve(codigo_empresa,datetime(date(em_fecha.text)))
end on

type em_cantidad from u_em_campo within w_int_movtraspasos_compras
integer x = 1893
integer y = 344
integer width = 293
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type sle_observaciones from u_em_campo within w_int_movtraspasos_compras
integer x = 485
integer y = 784
integer width = 1691
integer taborder = 130
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type cb_1 from u_boton within w_int_movtraspasos_compras
integer x = 1947
integer y = 472
integer width = 224
integer height = 128
integer taborder = 150
string text = "&Ok"
end type

event clicked;//CONTROLES DE VALORES

Dec{2} total_cantidad,var_conjunto
String cadena
long posi,posi_aux
string mensaje
dw_1.reset()
IF dw_2.GetRow()=0 then return

total_cantidad   = dw_2.GetItemNumber(dw_2.GetRow(),"existencias")
IF dec(em_cantidad.text)>total_cantidad THEN
   f_activar_campo(em_cantidad)
   MessageBox("No Puedo Procesar","No hay suficiente stock en la ubicación.",exclamation!, OK!,1)
   Return
END IF

IF trim(em_fecha.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
   RETURN
END IF

IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF

IF dw_2.GetRow() =0  THEN
   mensaje="Marcar Una Ubicacion"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   dw_2.SetFocus()
   RETURN
END IF

// controlo las existencias disponibles
f_control_ubicacion()

IF Dec(em_cantidad.text)=0 or trim(em_cantidad.text)="" THEN
   	mensaje="Introduzca la cantidad a traspasar"
   	MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   	em_cantidad.SetFocus()
   	RETURN
END IF

dw_1.visible      = TRUE
cb_2.visible      = TRUE
cb_3.visible      = TRUE
cb_4.visible      = TRUE
cb_borrar.visible = TRUE
dw_1.retrieve()

contador=dw_1.Rowcount()
contador=contador+1

dw_1.insertRow(contador)

dw_1.setitem(Contador,"cantidad",dec(em_cantidad.text))
dw_1.setitem(contador,"empresa",codigo_empresa)
dw_1.setitem(contador,"tipo_unidad",f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
dw_1.setitem(contador,"articulo",uo_articulo.em_codigo.text)
dw_1.SetFocus()
cb_1.enabled              = FALSE
// desactivar claves

em_fecha.enabled          = FALSE
uo_articulo.enabled       = FALSE
em_cantidad.enabled       = FALSE
sle_observaciones.enabled = FALSE
dw_3.visible              = FALSE
dw_2.enabled              = FALSE

end event

type cb_borrar from u_boton within w_int_movtraspasos_compras
boolean visible = false
integer x = 1509
integer y = 1096
integer width = 475
integer height = 84
integer taborder = 160
boolean bringtotop = true
string text = "&Borrar"
end type

event clicked;
integer fila
fila=dw_1.getrow()
IF contador=fila THEN
  IF contador<>1 THEN  contador=contador - 1
END IF
IF fila<>0 THEN
 dw_1.DeleteRow(dw_1.getRow())
// dw_1.setrowfocusIndicator(Hand!)
 dw_1.SetColumn("almacen")
 dw_1.setRow(contador)
 dw_1.setfocus()
END IF


end event

type cb_4 from u_boton within w_int_movtraspasos_compras
boolean visible = false
integer x = 1509
integer y = 1288
integer width = 475
integer height = 84
integer taborder = 180
boolean bringtotop = true
string text = "&Procesar"
end type

event clicked;// Contador de movimiento y orden de lineas de ubicacion
dec contador_nummov,contador_orden 
// Valor de controles funcionamiento
dec bien=0
dec{2} numero,controles,x2,total_cantidad
string mensaje,nombre,campo,otro,v_calidad
dec y2,longitudes
long x21

IF Trim(sle_observaciones.text) = "" Then SetNull(sle_observaciones.text)
IF len(sle_observaciones.text) <> 30 and  len(sle_observaciones.text) <> 0 THEN
  	longitudes=len(Trim(sle_observaciones.text))
  	y2=(30-longitudes)-1
  	sle_observaciones.text=Trim(sle_observaciones.text) +  Space(y2) +"-"
END IF

controles  = 0
contador = dw_1.Rowcount()
IF contador=0 THEN
 	MessageBox("No Puedo Procesar","No hay lineas de Ubicación",Exclamation!, OK!,1)
 	Return
END IF
dw_1.Accepttext()

FOR x2=1 TO contador
 	v_almacen    = dw_1.GetItemString(x2,"almacen")	
 	v_zona       = dw_1.GetItemString(x2,"zona")	
 	v_fila       = dw_1.GetItemNumber(x2,"fila")	
 	v_altura     = dw_1.GetItemNumber(x2,"altura")	
 	v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
 	v_calidad    = dw_1.GetItemString (x2,"calidad")
 	v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	

	// Control de campos obligatorios
	IF (trim(string(v_almacen))="" or IsNull(v_almacen)) and controles=0 THEN
 		controles=1
 		campo="almacen"
 		mensaje=" Introduzca el Almacén "
	END IF
	IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
 		controles=1
 		campo="zona"
 		mensaje=" Introduzca la zona "
	END IF
	IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
 		controles=1
 		campo="fila"
 		mensaje= "Introduzca la fila de la ubicación"
	END IF
	IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
 		controles=1
 		campo="altura"
 		mensaje= "Introduzca la altura de la ubicación"
	END IF
	IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
 		controles=1
 		campo="cantidad"
 		mensaje= "Introduzca la cantidad"
	END IF

	IF (trim(v_calidad)=""  or IsNull(v_calidad)) and controles=0 THEN
 		controles=1
 		campo="calidad"
 		mensaje= "Introduzca la calidad"
	end if

	nombre = f_nombre_comalmacen(codigo_empresa,v_almacen)
	IF (trim(nombre)="") and controles=0 THEN
  		mensaje="El almacén no existe "
  		controles=1
  		campo="almacen"
	END IF

	nombre = f_nombre_zona_compras(codigo_empresa,v_almacen,v_zona)
	IF (trim(nombre)="") and controles=0 THEN
   		mensaje="La zona no existe"
   		controles=1
   		campo="zona"
	END IF
 	IF (Not(f_ubi_exist_compras(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
    		mensaje= "La ubicación no está contemplada en el mapa de ubicaciones"
    		controles=1
    		campo="almacen"
 	END IF

	IF controles=1 THEN
  		MessageBox("Campo obligatorio en línea"+string(x2),mensaje,Exclamation!, OK!,1)
  		dw_1.SetColumn(campo)
  		dw_1.setRow(x2)
  		dw_1.setfocus()
 		Return
	END IF
NEXT

total_cantidad   = dw_1.GetItemNumber(1,"total_cantidad")
IF total_cantidad <> dec(em_cantidad.text) THEN
  	MessageBox("No Puedo Procesar"," Las unidades introducidas no coinciden con el total",Exclamation!, OK!,1)
  	dw_1.SetColumn("cantidad")
  	dw_1.setRow(x2)
  	dw_1.setfocus()
  	Return
END IF
pb_1.enabled=FALSE

IF Not f_bloquear_almacen_compras(w_int_movtraspasos_compras.title) Then
	//---------------------------------------------------------------------
	// Despues de todos los controles empezamos el proceso de inserción
	//---------------------------------------------------------------------

	//------------------------------------------------------------------------
	// Valores fijos para todos los casos
	//------------------------------------------------------------------------

	ubihis.usuario       = nombre_usuario
	ubihis.empresa       = codigo_empresa
	ubihis.anyo          = year(date(String(em_fecha.text)))
	ubihis.almacen       = dw_2.GetItemString(dw_2.GetRow(),"almacen")
	ubihis.mp      		= uo_articulo.em_codigo.text
	ubihis.calidad 		= dw_2.GetItemString(dw_2.GetRow(),"calidad")
	ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
	ubihis.f_alta        = DateTime(today(),now())
	ubihis.observaciones = sle_observaciones.text
	SetNull(ubihis.nummov)

	SELECT	venmprima.familia,   
				venmprima.tipo_unidad  
	INTO	:ubihis.familia,
			:ubihis.tipo_unidad  
	FROM venmprima  
	WHERE (venmprima.empresa = :ubihis.empresa )
	AND   (venmprima.codigo = :ubihis.mp );
	
	IF SQLCA.SQLCode<>0 THEN bien=1
	
	if bien=1 then f_mensaje("Debug","1 "+ubihis.empresa + " "+ubihis.mp)

	ubihis.tipomov  = "2"
	ubi.empresa     = ubihis.empresa
	ubi.almacen     = ubihis.almacen
	ubi.mp    = ubihis.mp
	ubi.familia     = ubihis.familia
	ubi.calidad     = ubihis.calidad
	ubi.tipo_unidad =  ubihis.tipo_unidad
	ubi.f_alta      =  DateTime(today(),now())
	ubihis.zona     = dw_2.GetItemString(dw_2.GetRow(),"zona")
	ubihis.fila     = dw_2.GetItemNumber(dw_2.GetRow(),"fila")
	ubihis.altura   = dw_2.GetItemNumber(dw_2.GetRow(),"altura")
	ubihis.cantidads = Dec(em_cantidad.text)
	ubihis.cantidade = 0
	
	ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
																 ubihis.fila,ubihis.altura)
	ubi.zona            = ubihis.zona
	ubi.fila            = ubihis.fila
	ubi.altura          = ubihis.altura
	ubi.existencias     = ubihis.cantidade
	ubi.ubicacion       = ubihis.ubicacion
	//-------------------------------------------------------------------
	ubihis.orden   = f_comparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))

	// Variables para cargar el cursor
	dec cur_empresa,cur_almacen, cur_linea,cur_anyo
	decimal{2}  cur_existencias,cantidad_pendiente,cantidad_borrada
	string  cur_ubicacion,cur_observaciones, var_observaciones,cur_calidad

	//-----------------------------------------------------------------------
	// Tambien Inserto en el Historico de Movimientos ( la Salida Global)
	//-----------------------------------------------------------------------
	 movhis.empresa      =  ubihis.empresa  
	 movhis.almacen      =  ubihis.almacen
	 movhis.anyo         =  ubihis.anyo
	 movhis.origen       =  "4"
	 movhis.mp     =  ubihis.mp
	 movhis.fechmov      =  ubihis.fecha
	 movhis.tipomov      =  ubihis.tipomov
	 movhis.cantidade    =  0
	 movhis.cantidads    =  ubihis.cantidads
	 movhis.precio       =  0
	 SetNull(movhis.codtercero)
	 SetNull(movhis.numdoc)
	 movhis.situacion    =  "N"
	 movhis.observaciones=  sle_observaciones.text
	 movhis.familia      =  ubihis.familia
	 movhis.calidad      =  ubihis.calidad
	 movhis.tipo_unidad  =  ubihis.tipo_unidad
	 movhis.f_alta       =  ubihis.f_alta
	 movhis.usuario      =  ubihis.usuario
	 movhis.nummov = f_comparam_nummov(movhis.empresa,Year(Date(em_fecha.text)))

	 // Grabar el movimiento en el historico por el total de existencias
	IF NOT f_insert_commovhis(movhis) Then
		MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
		bien=1
	END IF

	IF NOT f_actualiza_nummov(movhis.empresa,Year(Date(em_fecha.text)),movhis.nummov) THEN
		bien=1
		if bien=1 then f_mensaje("Debug","2")
	END IF
	ubihis.nummov = movhis.nummov
	//--------------------------------------------------------------------//
	//                   la salida global               //
	//--------------------------------------------------------------------//
	// En el historico de ubicaciones
	IF NOT f_insert_comlinubicahis(ubihis) THEN   bien=1
	if bien=1 then f_mensaje("Debug","3")
	IF NOT f_actualiza_numorden_compras(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
		 bien=1
		 if bien=1 then f_mensaje("Debug","4")
	END IF
	
	//------------------- Fin insercion movhis salida global  ----------------\\
	
	//----------------------------------------------
	// Borro en las ubicaciones correspondientes
	//----------------------------------------------

	dec registros,x1
	registros=dw_proceso.Retrieve(ubi.empresa,ubi.ubicacion, ubihis.mp)
	cantidad_borrada = 0
	IF registros<>0 THEN	
		FOR x1=1 To registros
			cur_linea         =  dw_proceso.GetItemNumber(x1,"linea")
			cur_existencias   =  dw_proceso.GetItemNumber(x1,"existencias")
			cantidad_pendiente=Dec(em_cantidad.text) - cantidad_borrada
			IF cantidad_pendiente = 0 THEN   EXIT
			IF cantidad_pendiente >= cur_existencias THEN 
				cantidad_borrada=cantidad_borrada + cur_existencias
				DELETE FROM comlinubica  
				WHERE 	( comlinubica.empresa   = :ubi.empresa ) AND  
				 			( comlinubica.ubicacion = :ubi.ubicacion ) AND  
							( comlinubica.linea     = :cur_linea ) USING SQLCA;
				IF SQLCA.SQLCode<>0 THEN bien=1
				if bien=1 then f_mensaje("Debug","5")
			ELSE
				cur_existencias=cur_existencias - cantidad_pendiente
				cantidad_borrada=cantidad_borrada + cantidad_pendiente
				UPDATE comlinubica  
				SET existencias   = :cur_existencias
				WHERE 	( comlinubica.empresa = :ubi.empresa ) AND  
							( comlinubica.ubicacion = :ubi.ubicacion ) AND  
							( comlinubica.linea = :cur_linea )USING SQLCA;
				IF SQLCA.SQLCode<>0 THEN bien=1
				if bien=1 then f_mensaje("Debug","6")
			END IF
		NEXT
	END IF
	IF cantidad_borrada <> Dec(em_cantidad.text) THEN  bien=1
	if bien = 1 then f_mensaje("Debug","7")
	//--------------------------------------------------------------------//



 ///////////////////// ///////////////////// DESDE AQUI  ///////////////////// ///////////////////// 
	
	

	
	string bloqueado,v_artdestino
	// -----------------------------------------------------------------------
	// Inserto una entrada por cada linea de la datawindow
	// -----------------------------------------------------------------------
	ubihis.tipomov="1"
	contador = dw_1.Rowcount()
	  
	FOR x1=1 TO contador
		v_artdestino      = dw_1.GetItemString(x1,"articulo")
		ubihis.almacen    = dw_1.GetItemString(x1,"almacen")
		movhis.almacen    = dw_1.GetItemString(x1,"almacen")
		ubi.almacen       = dw_1.GetItemString(x1,"almacen")
		ubihis.mp   = v_artdestino
		ubi.mp      = v_artdestino
		ubihis.zona       = dw_1.GetItemString(x1,"zona")	
		ubihis.fila       = dw_1.GetItemNumber(x1,"fila")	
		ubihis.altura     = dw_1.GetItemNumber(x1,"altura")
		ubihis.calidad    = dw_1.GetItemString(x1,"calidad")
		//***********
		 IF IsNull(ubihis.altura) Then ubihis.altura = 0

		ubihis.cantidade  = dw_1.GetItemDecimal(x1,"cantidad")	
		ubihis.orden      = f_almparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))
		ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona, ubihis.fila,ubihis.altura)
		ubihis.cantidads    = 0
		ubi.zona            = ubihis.zona
		ubi.fila            = ubihis.fila
		ubi.altura          = ubihis.altura
		ubi.existencias     = ubihis.cantidade
		ubi.ubicacion       = ubihis.ubicacion
		ubi.calidad         = ubihis.calidad
		//-----------------------------------------------------------------------
		// Tambien Inserto en el Historico de Movimientos ( las entradas)
		//-----------------------------------------------------------------------
		movhis.empresa      =  ubihis.empresa  
	 
		IF (x1=1) or (movhis.almacen <> ubihis.almacen)  or (movhis.mp <> ubihis.mp) Then
			otro ="S"
		ELSE
			otro = "N"
		END IF
		movhis.almacen      =  ubihis.almacen
		movhis.anyo         =  ubihis.anyo
		movhis.origen       =  "3"
		movhis.mp     =  ubihis.mp
		movhis.fechmov      =  ubihis.fecha
		movhis.tipomov      =  ubihis.tipomov
		movhis.cantidade    =  ubihis.cantidade
		movhis.cantidads    =  0
		movhis.precio       =  0
		SetNull(movhis.codtercero)
		SetNull(movhis.numdoc)
		movhis.situacion    =  "N"
		movhis.observaciones=  sle_observaciones.text
		
		string v_familia_mp
		select familia 
		into :v_familia_mp
		from venmprima
		where empresa = :codigo_empresa
		and codigo = :ubihis.mp;
		
		

		movhis.familia      =  v_familia_mp
		movhis.calidad      =  ubihis.calidad
		movhis.tipo_unidad  =  ubihis.tipo_unidad
		movhis.f_alta       =  ubihis.f_alta
		movhis.usuario      =  ubihis.usuario
		IF otro ="S" Then
			movhis.nummov = f_comparam_nummov(movhis.empresa,Year(Date(em_fecha.text)))
			// Grabar el movimiento en el histórico por el total de existencias
			IF NOT f_insert_commovhis(movhis) Then
				MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
				bien=1
			 END IF
		ELSE
			UPDATE almmovhis  
			SET almmovhis.cantidade = almmovhis.cantidade + :movhis.cantidade  
			WHERE 	( almmovhis.empresa = :movhis.empresa ) AND  
						( almmovhis.almacen = :movhis.almacen ) AND  
						( almmovhis.anyo = :movhis.anyo ) AND  
						( almmovhis.nummov = :movhis.nummov )   ;
			IF SQLCA.SQLCode<>0 THEN
				MessageBox("Error en proceso","Modificando almmovhis",Exclamation!, OK!,1)
				bien=1
			END IF
		END IF
		IF NOT f_actualiza_nummov(movhis.empresa,Year(Date(em_fecha.text)),movhis.nummov) THEN
			bien=1
			if bien=1 then f_mensaje("Debug","8")
		END IF
	
		ubihis.nummov = movhis.nummov
		
		//------------------------------------------------------------------
		// Inserto en el historico de lineas de ubicacion por movimiento
		//------------------------------------------------------------------
		IF NOT f_insert_comlinubicahis(ubihis)  Then bien=1
		if bien=1 then f_mensaje("Debug","9")
		
		
		
		// Busco si hay lineas este articulo sin reservar
		//------------------------------------------------------
		dec grabado
		// Variable de controles 0-> no grabado 1-> si grabado
		grabado=0
		registros = 0
		registros = dw_proceso.retrieve(ubi.empresa,ubi.ubicacion,ubi.mp)
		IF registros <> 0 THEN
			FOR x21= 1 To registros	
				cur_linea        = dw_proceso.GetItemNumber(x21,"linea")
				cur_existencias  = dw_proceso.GetItemNumber(x21,"existencias")
//				ubi.observaciones= dw_proceso.GetItemString(x21,"observaciones")
				cur_calidad  = dw_proceso.GetItemString(x21,"calidad")
				//¿Deberiamos controlar la calidad?\\
				grabado = 1
				ubi.existencias    = ubi.existencias + cur_existencias
				var_observaciones =  ubi.observaciones + String(today(),"dd/mm/yy") + "-" + sle_observaciones.text
				UPDATE comlinubica  
				SET existencias   = :ubi.existencias,   
				f_alta            = :ubi.f_alta,
				observaciones     = :var_observaciones
				WHERE 	(comlinubica.empresa    = :ubi.empresa ) AND  
							(comlinubica.ubicacion  = :ubi.ubicacion ) AND  
							(comlinubica.linea      = :cur_linea ) USING SQLCA;
				IF SQLCA.SQLCode<>0 THEN   bien=1
				if bien=1 then f_mensaje("Debug","10")
			NEXT
		END IF
		IF grabado=0 THEN
			cur_linea=0
			SELECT  max(comlinubica.linea)  INTO   :cur_linea FROM comlinubica
			WHERE  comlinubica.empresa   = :ubi.empresa 
			AND    comlinubica.ubicacion = :ubi.ubicacion ;   
			
			IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN    cur_linea = 0 
			cur_linea = cur_linea + 1
			ubi.linea = cur_linea
			ubi.observaciones =  String(today(),"dd/mm/yy") + "-" + sle_observaciones.text
			IF NOT f_insert_comlinubica(ubi) Then bien=1
			if bien=1 then f_mensaje("Debug","11")
		END IF
		//-----------------------Fin Grabación Lineas de Ubicacion--------------
	
		IF NOT f_actualiza_numorden_compras(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
			 bien=1
			 if bien=1 then f_mensaje("Debug","12")
		END IF
	NEXT
	CHOOSE CASE bien
	CASE 1
		ROLLBACK USING SQLCA;
		MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	CASE 0
		COMMIT USING SQLCA;
	CASE ELSE
		ROLLBACK USING SQLCA;
		MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	END CHOOSE
	f_desbloquear_almacen_compras(w_int_movtraspasos_compras.title)
	
	pb_1.enabled=TRUE
	
	//f_listado_incidencias(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,Trim(em_tono.text),Dec(em_calibre.text),dw_2.GetItemString(dw_2.Getrow(),"tipo_pallet"),dw_2.GetItemString(dw_2.Getrow(),"caja"))
	cb_3.TriggerEvent(Clicked!)
	
END IF

end event

type cb_3 from u_boton within w_int_movtraspasos_compras
boolean visible = false
integer x = 1509
integer y = 1192
integer width = 475
integer height = 84
integer taborder = 170
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;em_fecha.enabled        = TRUE
em_cantidad.enabled     = TRUE
uo_articulo.enabled     = TRUE
dw_2.enabled            = TRUE
dw_3.visible            = TRUE
dw_3.retrieve(codigo_empresa,DateTime(Date(String(em_fecha.text))))

sle_observaciones.enabled = TRUE
cb_1.enabled              = TRUE
dw_1.visible              = FALSE
cb_2.visible              = FALSE
cb_3.visible              = FALSE
cb_4.visible              = FALSE
cb_borrar.visible         = FALSE

em_cantidad.text=""
uo_articulo.em_campo.text=""
sle_observaciones.text=""

uo_articulo.em_codigo.text=""
dw_2.reset()
f_activar_campo(uo_articulo.em_campo)
end event

type uo_articulo from u_em_campo_2 within w_int_movtraspasos_compras
integer x = 9
integer y = 348
integer width = 855
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_descripcion

Select descripcion,familia,tipo_unidad
Into  :var_descripcion,:v_familia,:var_tipo_unidad
From venmprima
Where venmprima.empresa = :codigo_empresa
And   venmprima.codigo  = :uo_articulo.em_codigo.text;

uo_articulo.em_campo.text = var_descripcion

IF Trim(uo_articulo.em_campo.text)="" THEN 
 	IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 	uo_articulo.em_campo.text=""
 	uo_articulo.em_codigo.text=""
END IF

// Visualiza las lineas de ubicación a nivel de articulo

//if ante_codigo_articulo <> uo_articulo.em_codigo.text Then
dw_2.reset()
SetNull(sle_observaciones.text)
if trim(uo_articulo.em_campo.text)<>"" Then
	STRING is_filtro = ""
  	dw_2.SetFilter(is_filtro)
    dw_2.Filter()  
    dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
End If
st_texto_cantidad.text=f_nombre_unidad_com(var_tipo_unidad)
em_cantidad.Setmask(DecimalMask!,f_mascara_unidad_com(var_tipo_unidad))
f_mascara_columna(dw_2,"existencias",f_mascara_unidad_com(var_tipo_unidad))




end event

event getfocus;call super::getfocus;ante_codigo_articulo = uo_articulo.em_codigo.text

ue_titulo     = "Ayuda de Articulos de Compras"
//ue_datawindow = "dw_ayuda_articulos"
ue_datawindow = "dw_ayuda_venmprima"
ue_filtro     = ""
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type cb_2 from u_boton within w_int_movtraspasos_compras
boolean visible = false
integer x = 1509
integer y = 1000
integer width = 475
integer height = 84
integer taborder = 190
boolean bringtotop = true
string text = "&Insertar"
end type

event clicked;integer numero,controles
Dec{2} total_pendiente,total_cantidad
String ante_almacen
string mensaje,nombre,campo

controles = 0
contador = dw_1.Rowcount()
dw_1.Accepttext()
IF contador <> 0 THEN
 	v_almacen = dw_1.GetItemString(contador,"almacen")	
 	v_zona     	= dw_1.GetItemString(contador,"zona")	
 	v_fila     		= dw_1.GetItemNumber(contador,"fila")	
 	v_altura   	= dw_1.GetItemNumber(contador,"altura")

 	v_cantidad = dw_1.GetItemDecimal(contador,"cantidad")	
// 	dw_1.SetItem(contador,"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,dw_2.GetItemString(dw_2.GetRow(),"caja"),v_cantidad))
// 	v_cantidad = dw_1.GetItemDecimal(contador,"cantidad")	

 
 	IF (trim(string(v_almacen))="" or IsNull(v_almacen)) and controles=0 THEN
  		controles=1
  		campo="almacen"
  		mensaje=" Introduzca el almacen " 
 	END IF
 	IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
  		controles=1
  		campo="zona"
  		mensaje=" Introduzca la zona "
 	END IF
 	IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
  		controles=1
  		campo="fila"
  		mensaje= "Introduzca la fila de la ubicacion"
 	END IF
 	IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
  		controles=1
  		campo="altura"
  		mensaje= "Introduzca la altura de la ubicacion"
 	END IF
 	IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
  		controles=1
  		campo="cantidad"
  		mensaje= "Introduzca la cantidad"
 	END IF

 	nombre = f_nombre_comalmacen(codigo_empresa,v_almacen)
 	IF (trim(nombre)="") and controles=0 THEN
   		mensaje="El almacen no existe "
   		controles=1
   		campo="almacen"
 	END IF

 	nombre=f_nombre_zona_compras(codigo_empresa,v_almacen,v_zona)
 	IF (trim(nombre)="") and controles=0 THEN
    		mensaje="La zona no existe"
    		controles=1
    		campo="zona"
 	END IF
 	IF (Not(f_ubi_exist_compras(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
		mensaje= "La ubicacion no esta contemplada en el mapa de ubicaciones"
		controles=1
		campo="almacen"
	END IF

	 IF controles=1 THEN
  		MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
		dw_1.SetColumn(campo)
		dw_1.setRow(contador)
		dw_1.setfocus()
		Return
 	END IF
END IF

contador=contador+1
dw_1.InsertRow(contador)

total_cantidad   = dw_1.GetItemNumber(1,"total_cantidad")
total_pendiente = dec(em_cantidad.text)-total_cantidad
dw_1.setitem(Contador,"cantidad",total_pendiente)
dw_1.setitem(contador,"empresa",codigo_empresa)
dw_1.setitem(1,"tipo_unidad",f_codigo_mp_unidad(codigo_empresa,uo_articulo.em_codigo.text))
dw_1.setitem(contador,"articulo",uo_articulo.em_codigo.text)

IF contador > 1 THEN
    dw_1.setitem(contador,"almacen",v_almacen)
END  IF

//dw_1.setrowfocusIndicator(Hand!)
IF contador=1 THEN
  	dw_1.SetColumn("almacen")
ELSE
	dw_1.SetColumn("zona")
END IF

dw_1.setRow(contador)
dw_1.setfocus()


//////////////////////////////////////////// hasta aquí ///////////////////////////////////////////////////////
													return
//////////////////////////////////////////// hasta aquí ///////////////////////////////////////////////////////
end event

type dw_listado from datawindow within w_int_movtraspasos_compras
boolean visible = false
integer x = 978
integer y = 156
integer width = 270
integer height = 84
boolean bringtotop = true
string dataobject = "dw_int_movtraspasos5_compras"
boolean livescroll = true
end type

type pb_listado from upb_imprimir within w_int_movtraspasos_compras
boolean visible = false
integer x = 640
integer y = 168
integer width = 105
integer height = 88
integer taborder = 20
boolean originalsize = false
end type

event clicked;String impresora,cadena,imp
Integer j
DateTime fecha
SetNull(fecha)
SELECT ven_usuimpre.impresora_preparacion INTO :impresora FROM ven_usuimpre
Where empresa = :codigo_empresa
And   usuario = :nombre_usuario;
imp=dw_listado.Describe("Datawindow.Printer")
/*IF imp <> impresora Then
  MessageBox("Selecciona la impresora predeterminada","La impresora debe de ser" + impresora,Exclamation!,OK!,1)
  printSetup()
ELSE  */
	dw_listado.SetRedraw(FALSE)
	dw_listado.SetRedraw(TRUE)
	IF dw_listado.RowCOunt() < 11 Then
		FOr j = 1 To 10
		dw_listado.InsertRow(dw_listado.RowCOunt()+1)
		dw_listado.SetItem(dw_listado.RowCOunt(),"empresa",codigo_empresa)
		dw_listado.SetItem(dw_listado.RowCOunt(),"fpedido",fecha)
	Next
	END IF
	IF dw_listado.Print(TRUE)= 1 Then
		dw_listado.Reset()
		st_listado.visible = FALSE
		pb_listado.visible = FALSE
	END IF
	
//END IF


end event

type dw_pedidos from datawindow within w_int_movtraspasos_compras
boolean visible = false
integer x = 1253
integer y = 156
integer width = 270
integer height = 84
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_proceso_venliped_art_cal_to_c_tpc"
boolean livescroll = true
end type

type dw_ordenes from datawindow within w_int_movtraspasos_compras
boolean visible = false
integer x = 1541
integer y = 156
integer width = 270
integer height = 84
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_proceso_almlincargas_art_cal_to_c_tpc"
boolean livescroll = true
end type

type dw_proceso1 from datawindow within w_int_movtraspasos_compras
boolean visible = false
integer x = 677
integer y = 8
integer width = 494
integer height = 96
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_proceso_almubimapa_con_reserva_compra"
boolean livescroll = true
end type

type dw_1 from u_datawindow_consultas within w_int_movtraspasos_compras
integer x = 302
integer y = 916
integer width = 1198
integer height = 540
integer taborder = 10
string dataobject = "dw_int_movtraspasos2_compras"
borderstyle borderstyle = stylelowered!
end type

event key;bus_campo= GetColumnName()
bus_filtro=  ""
 CHOOSE CASE bus_campo
	CASE "almacen"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
		bus_datawindow   =  "dw_ayuda_comalmacenes"
   CASE "zona"
     bus_titulo       = "VENTANA SELECCION DE TIPO DE ZONA "
 	  bus_datawindow   =  "dw_ayuda_comubizonas"
     bus_filtro            = "almacen='" + This.GetItemString(This.GetRow(),"almacen") + "'"
	CASE "articulo"
		bus_titulo     = "VENTANA SELECCION DE ARTÍCULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = ""
	CASE "calidad"
		bus_titulo     = "VENTANA SELECCION DE CALIDADES"
		bus_datawindow = "dw_ayuda_calidades"
		bus_filtro   =""  
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 
// IF key = KeyTab! Then
//   // Redondeo a cantidad 
//   	Dec{2} var_cantidad
//   	var_cantidad = dw_1.GetItemNumber(dw_1.GetRow(),"cantidad")
//   	dw_1.SetItem(dw_1.GetRow(),"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,dw_2.GetItemString(dw_2.GetRow(),"caja"),var_cantidad))
//END IF
//	
Call Super::Key
end event

event rbuttondown;bus_campo= GetColumnName()
bus_filtro=  ""
CHOOSE CASE bus_campo
	CASE "almacen"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
		bus_datawindow   =  "dw_ayuda_comalmacenes"
   CASE "zona"
     bus_titulo       = "VENTANA SELECCION DE TIPO DE ZONA "
 	  bus_datawindow   =  "dw_ayuda_comubizonas"
     bus_filtro            = "almacen='" + This.GetItemString(This.GetRow(),"almacen") + "'"
	CASE "articulo"
		bus_titulo     = "VENTANA SELECCION DE ARTÍCULOS"
		bus_datawindow = "dw_ayuda_venmprima"
		bus_filtro     = ""          
	CASE "calidad"
		bus_titulo     = "VENTANA SELECCION DE CALIDADES"
		bus_datawindow = "dw_ayuda_calidades"
		bus_filtro     = ""          
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 Call Super::rbuttondown
end event

type dw_detalle from datawindow within w_int_movtraspasos_compras
boolean visible = false
integer x = 5
integer y = 436
integer width = 1339
integer height = 404
integer taborder = 140
boolean titlebar = true
string title = "Detalle movimiento de traspaso"
string dataobject = "dw_int_movtraspasos4_compras"
boolean controlmenu = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_2 from datawindow within w_int_movtraspasos_compras
event key pbm_dwnkey
integer x = 878
integer y = 268
integer width = 1010
integer height = 488
integer taborder = 60
string dataobject = "dw_int_movtraspasos1_compras"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;integer registros
long linea

IF this.getRow()<>0 THEN
 	linea     = dw_2.GetRow() 
 
 	IF linea<>0 THEN
   		registros = dw_2.RowCount()
    		This.SelectRow(0,FALSE)
    		This.SelectRow(getRow(),TRUE)
  
      	sle_observaciones.text    =  GetItemString(dw_2.GetRow(),"observaciones")
  	End If
End IF
 


end event

on getfocus;
This.TriggerEvent(RowFocusChanged!)

end on

type st_listado from statictext within w_int_movtraspasos_compras
boolean visible = false
integer x = 55
integer y = 36
integer width = 512
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Listado Incidencias"
boolean focusrectangle = false
end type

type dw_proceso2 from datawindow within w_int_movtraspasos_compras
boolean visible = false
integer x = 1399
integer y = 24
integer width = 672
integer height = 180
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica_referencia_compra"
boolean livescroll = true
end type

type dw_proceso from datawindow within w_int_movtraspasos_compras
boolean visible = false
integer x = 105
integer y = 444
integer width = 658
integer height = 332
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica_compras"
boolean livescroll = true
end type

type dw_3 from datawindow within w_int_movtraspasos_compras
integer x = 64
integer y = 908
integer width = 2062
integer height = 548
string dataobject = "dw_int_movtraspasos3_compras"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

on retrieveend;dw_detalle.visible = FALSE
end on

event clicked;IF row<>0 THEN
 integer registros
 registros = dw_3.RowCount()
 IF registros>0 THEN
 This.SelectRow(0,FALSE)
 This.SelectRow(row,TRUE)
 
  ubihis.anyo    =  GetItemNumber(row,"anyo")
  ubihis.almacen =  GetItemString(row,"almacen")
  ubihis.nummov  =  GetItemNumber(row,"nummov")
  dw_detalle.visible = TRUE
  dw_detalle.retrieve(codigo_empresa,ubihis.anyo,ubihis.almacen,ubihis.nummov)
 END IF
END IF
end event

