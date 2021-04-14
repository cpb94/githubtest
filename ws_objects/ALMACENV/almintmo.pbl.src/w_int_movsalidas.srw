$PBExportHeader$w_int_movsalidas.srw
$PBExportComments$Proceso introduccion manual de salidas.
forward
global type w_int_movsalidas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_movsalidas
end type
type st_tipomov from statictext within w_int_movsalidas
end type
type st_nombre_tipomov from statictext within w_int_movsalidas
end type
type st_documento from statictext within w_int_movsalidas
end type
type st_cliente_etiqueta from statictext within w_int_movsalidas
end type
type st_nombre_cliente from statictext within w_int_movsalidas
end type
type em_fecha from u_em_campo within w_int_movsalidas
end type
type sle_tipomov from u_em_campo within w_int_movsalidas
end type
type cb_reubicar_insertar from u_boton within w_int_movsalidas
end type
type cb_reubicar_procesar from u_boton within w_int_movsalidas
end type
type cb_reubicar_salir from u_boton within w_int_movsalidas
end type
type cb_reubicar_borrar from u_boton within w_int_movsalidas
end type
type sle_cliente from u_em_campo within w_int_movsalidas
end type
type dw_proceso from datawindow within w_int_movsalidas
end type
type dw_procesos from datawindow within w_int_movsalidas
end type
type st_1 from statictext within w_int_movsalidas
end type
type st_2 from statictext within w_int_movsalidas
end type
type st_3 from statictext within w_int_movsalidas
end type
type em_tono from u_em_campo within w_int_movsalidas
end type
type em_calibre from u_em_campo within w_int_movsalidas
end type
type st_4 from statictext within w_int_movsalidas
end type
type st_9 from statictext within w_int_movsalidas
end type
type sle_observaciones from u_em_campo within w_int_movsalidas
end type
type st_texto_cantidad from statictext within w_int_movsalidas
end type
type em_cantidad from u_em_campo within w_int_movsalidas
end type
type cb_1 from u_boton within w_int_movsalidas
end type
type uo_articulo from u_em_campo_2 within w_int_movsalidas
end type
type uo_calidad from u_em_campo_2 within w_int_movsalidas
end type
type pb_calculo from u_calculadora within w_int_movsalidas
end type
type st_texto_cajas from statictext within w_int_movsalidas
end type
type st_texto_pallet from statictext within w_int_movsalidas
end type
type em_cajas from u_em_campo within w_int_movsalidas
end type
type em_pallet from u_em_campo within w_int_movsalidas
end type
type st_disponible from statictext within w_int_movsalidas
end type
type pb_imprimir from upb_imprimir within w_int_movsalidas
end type
type em_disponible from statictext within w_int_movsalidas
end type
type st_tecla from statictext within w_int_movsalidas
end type
type dw_consulta_reubicacion from datawindow within w_int_movsalidas
end type
type sle_numdoc from u_em_campo within w_int_movsalidas
end type
type st_5 from statictext within w_int_movsalidas
end type
type dw_listado from datawindow within w_int_movsalidas
end type
type pb_borrar from upb_papelera within w_int_movsalidas
end type
type dw_2 from datawindow within w_int_movsalidas
end type
type dw_tipos_caja from datawindow within w_int_movsalidas
end type
type gb_1 from groupbox within w_int_movsalidas
end type
type st_formato from statictext within w_int_movsalidas
end type
type dw_reubicacion from datawindow within w_int_movsalidas
end type
type dw_3 from datawindow within w_int_movsalidas
end type
type dw_almlinubicahis from datawindow within w_int_movsalidas
end type
type st_6 from statictext within w_int_movsalidas
end type
type pb_2 from picturebutton within w_int_movsalidas
end type
type st_fecha from statictext within w_int_movsalidas
end type
type st_7 from statictext within w_int_movsalidas
end type
end forward

global type w_int_movsalidas from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 3973
integer height = 2520
pb_1 pb_1
st_tipomov st_tipomov
st_nombre_tipomov st_nombre_tipomov
st_documento st_documento
st_cliente_etiqueta st_cliente_etiqueta
st_nombre_cliente st_nombre_cliente
em_fecha em_fecha
sle_tipomov sle_tipomov
cb_reubicar_insertar cb_reubicar_insertar
cb_reubicar_procesar cb_reubicar_procesar
cb_reubicar_salir cb_reubicar_salir
cb_reubicar_borrar cb_reubicar_borrar
sle_cliente sle_cliente
dw_proceso dw_proceso
dw_procesos dw_procesos
st_1 st_1
st_2 st_2
st_3 st_3
em_tono em_tono
em_calibre em_calibre
st_4 st_4
st_9 st_9
sle_observaciones sle_observaciones
st_texto_cantidad st_texto_cantidad
em_cantidad em_cantidad
cb_1 cb_1
uo_articulo uo_articulo
uo_calidad uo_calidad
pb_calculo pb_calculo
st_texto_cajas st_texto_cajas
st_texto_pallet st_texto_pallet
em_cajas em_cajas
em_pallet em_pallet
st_disponible st_disponible
pb_imprimir pb_imprimir
em_disponible em_disponible
st_tecla st_tecla
dw_consulta_reubicacion dw_consulta_reubicacion
sle_numdoc sle_numdoc
st_5 st_5
dw_listado dw_listado
pb_borrar pb_borrar
dw_2 dw_2
dw_tipos_caja dw_tipos_caja
gb_1 gb_1
st_formato st_formato
dw_reubicacion dw_reubicacion
dw_3 dw_3
dw_almlinubicahis dw_almlinubicahis
st_6 st_6
pb_2 pb_2
st_fecha st_fecha
st_7 st_7
end type
global w_int_movsalidas w_int_movsalidas

type variables
  integer contador
  integer v_fila,v_altura,anyo
  String v_almacen
  string   v_zona,v_familia,v_sector,var_externo
  decimal{4} v_cantidad
  string ante_codigo_articulo,ante_codigo_calidad,ante_tono

boolean control_tono,control_calibre
  

// Defino la estructura de la tablas a procesar
   str_almlinubicahis  ubihis
   str_almlinubica      ubi
   str_almmovhis        mov


end variables

forward prototypes
public function boolean f_control_disponible_ubicacion ()
public subroutine f_control_tono_calibre ()
public function long ver_movimientos ()
end prototypes

public function boolean f_control_disponible_ubicacion ();decimal{4} var_cantidad,total_cantidad,cur_existencias
string var_referencia,var_ubicacion,cur_empresa
Integer cur_pedido,cur_linea,salir
String  cur_ubicacion,cur_referencia

total_cantidad=0
var_ubicacion=f_componer_ubicacion(dw_2.GetItemString(dw_2.GetRow(),"almacen"),&
                                   dw_2.GetItemString(dw_2.GetRow(),"zona"),&
                                   dw_2.GetItemNumber(dw_2.GetRow(),"fila"),&
                                   dw_2.GetItemNumber(dw_2.GetRow(),"altura"))
                                     
  var_referencia=f_componer_ref(uo_articulo.em_codigo.text,&
                                uo_calidad.em_codigo.text,&
                                Trim(em_tono.text),&
                                Integer(em_calibre.text))



 Integer registros
 registros=dw_proceso.Retrieve(codigo_empresa,var_ubicacion,var_referencia)
 IF registros<>0 THEN
  FOR x= 1 TO registros
    cur_existencias = dw_proceso.GetItemNumber(x,"existencias")
    cur_pedido      = dw_proceso.GetItemNumber(x,"pedido")
    IF IsNull(cur_pedido) or trim(string(cur_pedido))="" THEN
       total_cantidad=cur_existencias + total_cantidad
    END IF
  NEXT
 END IF

IF Dec(em_cantidad.text) > total_cantidad THEN
 MessageBox("No Hay Stock suficiente en esta ubicacion","La cantidad no puede superar a " + string(total_cantidad),Exclamation!, OK!,1)
 em_cantidad.text=String(total_cantidad)
 Return false
END IF

IF Dec(em_cantidad.text) > Dec(em_disponible.text) THEN
 MessageBox("No Hay Disponible suficiente","La cantidad no puede superar a " + string(em_disponible.text),Exclamation!, OK!,1)
 em_cantidad.text=String(em_disponible)
 Return false
END IF

REturn TRUE
end function

public subroutine f_control_tono_calibre (); control_tono    =  TRUE
 control_calibre =  TRUE

 IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_tono   =  FALSE
 	em_tono.text       =  ""
END IF
IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_calibre =  FALSE
   em_calibre.text    =  "0"
 END IF  

end subroutine

public function long ver_movimientos ();Long resultado

resultado = dw_3.retrieve(codigo_empresa,year(date(em_fecha.text)),sle_tipomov.text,sle_numdoc.text)

return resultado
end function

event ue_f6;call super::ue_f6;//IF pb_imprimir.visible = FALSE  Then   Return
em_disponible.TriggerEvent(clicked!)
end event

on ue_f5;call w_int_con_empresa::ue_f5;IF pb_calculo.visible = FALSE  Then   Return
pb_calculo.TriggerEvent(clicked!)
end on

event open;call super::open;
istr_parametros.s_titulo_ventana="Introduccion Movimientos Salida almacen"
This.title=istr_parametros.s_titulo_ventana
em_fecha.text=string(today())

// preparo datawindow ubicaciones
dw_2.settransobject(SQLCA)

dw_3.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_almlinubicahis.SetTransObject(SQLCA)
dw_tipos_caja.SetTransObject(SQLCA)





end event

on w_int_movsalidas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_tipomov=create st_tipomov
this.st_nombre_tipomov=create st_nombre_tipomov
this.st_documento=create st_documento
this.st_cliente_etiqueta=create st_cliente_etiqueta
this.st_nombre_cliente=create st_nombre_cliente
this.em_fecha=create em_fecha
this.sle_tipomov=create sle_tipomov
this.cb_reubicar_insertar=create cb_reubicar_insertar
this.cb_reubicar_procesar=create cb_reubicar_procesar
this.cb_reubicar_salir=create cb_reubicar_salir
this.cb_reubicar_borrar=create cb_reubicar_borrar
this.sle_cliente=create sle_cliente
this.dw_proceso=create dw_proceso
this.dw_procesos=create dw_procesos
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.st_4=create st_4
this.st_9=create st_9
this.sle_observaciones=create sle_observaciones
this.st_texto_cantidad=create st_texto_cantidad
this.em_cantidad=create em_cantidad
this.cb_1=create cb_1
this.uo_articulo=create uo_articulo
this.uo_calidad=create uo_calidad
this.pb_calculo=create pb_calculo
this.st_texto_cajas=create st_texto_cajas
this.st_texto_pallet=create st_texto_pallet
this.em_cajas=create em_cajas
this.em_pallet=create em_pallet
this.st_disponible=create st_disponible
this.pb_imprimir=create pb_imprimir
this.em_disponible=create em_disponible
this.st_tecla=create st_tecla
this.dw_consulta_reubicacion=create dw_consulta_reubicacion
this.sle_numdoc=create sle_numdoc
this.st_5=create st_5
this.dw_listado=create dw_listado
this.pb_borrar=create pb_borrar
this.dw_2=create dw_2
this.dw_tipos_caja=create dw_tipos_caja
this.gb_1=create gb_1
this.st_formato=create st_formato
this.dw_reubicacion=create dw_reubicacion
this.dw_3=create dw_3
this.dw_almlinubicahis=create dw_almlinubicahis
this.st_6=create st_6
this.pb_2=create pb_2
this.st_fecha=create st_fecha
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_tipomov
this.Control[iCurrent+3]=this.st_nombre_tipomov
this.Control[iCurrent+4]=this.st_documento
this.Control[iCurrent+5]=this.st_cliente_etiqueta
this.Control[iCurrent+6]=this.st_nombre_cliente
this.Control[iCurrent+7]=this.em_fecha
this.Control[iCurrent+8]=this.sle_tipomov
this.Control[iCurrent+9]=this.cb_reubicar_insertar
this.Control[iCurrent+10]=this.cb_reubicar_procesar
this.Control[iCurrent+11]=this.cb_reubicar_salir
this.Control[iCurrent+12]=this.cb_reubicar_borrar
this.Control[iCurrent+13]=this.sle_cliente
this.Control[iCurrent+14]=this.dw_proceso
this.Control[iCurrent+15]=this.dw_procesos
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.st_3
this.Control[iCurrent+19]=this.em_tono
this.Control[iCurrent+20]=this.em_calibre
this.Control[iCurrent+21]=this.st_4
this.Control[iCurrent+22]=this.st_9
this.Control[iCurrent+23]=this.sle_observaciones
this.Control[iCurrent+24]=this.st_texto_cantidad
this.Control[iCurrent+25]=this.em_cantidad
this.Control[iCurrent+26]=this.cb_1
this.Control[iCurrent+27]=this.uo_articulo
this.Control[iCurrent+28]=this.uo_calidad
this.Control[iCurrent+29]=this.pb_calculo
this.Control[iCurrent+30]=this.st_texto_cajas
this.Control[iCurrent+31]=this.st_texto_pallet
this.Control[iCurrent+32]=this.em_cajas
this.Control[iCurrent+33]=this.em_pallet
this.Control[iCurrent+34]=this.st_disponible
this.Control[iCurrent+35]=this.pb_imprimir
this.Control[iCurrent+36]=this.em_disponible
this.Control[iCurrent+37]=this.st_tecla
this.Control[iCurrent+38]=this.dw_consulta_reubicacion
this.Control[iCurrent+39]=this.sle_numdoc
this.Control[iCurrent+40]=this.st_5
this.Control[iCurrent+41]=this.dw_listado
this.Control[iCurrent+42]=this.pb_borrar
this.Control[iCurrent+43]=this.dw_2
this.Control[iCurrent+44]=this.dw_tipos_caja
this.Control[iCurrent+45]=this.gb_1
this.Control[iCurrent+46]=this.st_formato
this.Control[iCurrent+47]=this.dw_reubicacion
this.Control[iCurrent+48]=this.dw_3
this.Control[iCurrent+49]=this.dw_almlinubicahis
this.Control[iCurrent+50]=this.st_6
this.Control[iCurrent+51]=this.pb_2
this.Control[iCurrent+52]=this.st_fecha
this.Control[iCurrent+53]=this.st_7
end on

on w_int_movsalidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_tipomov)
destroy(this.st_nombre_tipomov)
destroy(this.st_documento)
destroy(this.st_cliente_etiqueta)
destroy(this.st_nombre_cliente)
destroy(this.em_fecha)
destroy(this.sle_tipomov)
destroy(this.cb_reubicar_insertar)
destroy(this.cb_reubicar_procesar)
destroy(this.cb_reubicar_salir)
destroy(this.cb_reubicar_borrar)
destroy(this.sle_cliente)
destroy(this.dw_proceso)
destroy(this.dw_procesos)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.st_4)
destroy(this.st_9)
destroy(this.sle_observaciones)
destroy(this.st_texto_cantidad)
destroy(this.em_cantidad)
destroy(this.cb_1)
destroy(this.uo_articulo)
destroy(this.uo_calidad)
destroy(this.pb_calculo)
destroy(this.st_texto_cajas)
destroy(this.st_texto_pallet)
destroy(this.em_cajas)
destroy(this.em_pallet)
destroy(this.st_disponible)
destroy(this.pb_imprimir)
destroy(this.em_disponible)
destroy(this.st_tecla)
destroy(this.dw_consulta_reubicacion)
destroy(this.sle_numdoc)
destroy(this.st_5)
destroy(this.dw_listado)
destroy(this.pb_borrar)
destroy(this.dw_2)
destroy(this.dw_tipos_caja)
destroy(this.gb_1)
destroy(this.st_formato)
destroy(this.dw_reubicacion)
destroy(this.dw_3)
destroy(this.dw_almlinubicahis)
destroy(this.st_6)
destroy(this.pb_2)
destroy(this.st_fecha)
destroy(this.st_7)
end on

event ue_f4;call super::ue_f4;IF pb_2.visible = FALSE  Then   Return
pb_2.TriggerEvent(clicked!)
end event

event activate;call super::activate;w_int_movsalidas = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_movsalidas
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_movsalidas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_movsalidas
integer x = 18
integer y = 16
integer width = 3685
integer height = 96
end type

type pb_1 from upb_salir within w_int_movsalidas
integer x = 3735
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
alignment htextalign = right!
end type

type st_tipomov from statictext within w_int_movsalidas
integer x = 37
integer y = 288
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo Mvto"
boolean focusrectangle = false
end type

type st_nombre_tipomov from statictext within w_int_movsalidas
integer x = 649
integer y = 284
integer width = 974
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 134217752
boolean enabled = false
boolean focusrectangle = false
end type

type st_documento from statictext within w_int_movsalidas
integer x = 704
integer y = 184
integer width = 425
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Documento"
boolean focusrectangle = false
end type

type st_cliente_etiqueta from statictext within w_int_movsalidas
boolean visible = false
integer x = 1861
integer y = 180
integer width = 379
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

type st_nombre_cliente from statictext within w_int_movsalidas
boolean visible = false
integer x = 2249
integer y = 264
integer width = 850
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_movsalidas
integer x = 261
integer y = 180
integer width = 384
integer taborder = 20
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

on modified;call u_em_campo::modified;ver_movimientos()

end on

type sle_tipomov from u_em_campo within w_int_movsalidas
integer x = 352
integer y = 284
integer width = 288
integer taborder = 30
end type

on getfocus;call u_em_campo::getfocus;ue_titulo     = "Ayuda seleccion de tipos de movimientos"
ue_datawindow = "dw_ayuda_almtipomov_salidas"
ue_filtro     = "interno = 'N'"
end on

event modificado;call super::modificado;st_nombre_tipomov.text=f_nombre_almtipomov_salida(codigo_empresa,sle_tipomov.text)
IF f_interno_almtipomov(codigo_empresa,sle_tipomov.text)= "S" Or&
    f_codigo_real_almtipomov(codigo_empresa,sle_tipomov.text)<> "S"  Then
    sle_tipomov.text="" 
    st_nombre_tipomov.text = ""
END IF

ver_movimientos()

// Para Entradas de compras saco el cliente

string tipo
tipo = f_tipo_almtipomov(codigo_empresa,sle_tipomov.text) 
IF tipo = "C"  or tipo = "P" THEN
   st_nombre_cliente.visible  = TRUE
   if tipo="P" then st_cliente_etiqueta.text = "Proveedor"
	sle_cliente.visible        = TRUE
   st_cliente_etiqueta.visible= TRUE

   // recojo el cliente en caso de compras
 
   integer registros
   string v_cliente
   registros = dw_3.RowCount()
   IF registros >0 THEN
      v_cliente = dw_3.GetItemString(1,"codtercero")
      sle_cliente.text = v_cliente
      st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
   END IF
 ELSE
   st_nombre_cliente.visible  = FALSE
   sle_cliente.visible        = FALSE
   st_cliente_etiqueta.visible= FALSE
END IF



end event

on rbuttondown;call u_em_campo::rbuttondown;if TRIM(st_nombre_tipomov.text)="" THEN
		istr_parametros.s_titulo_ventana = "Ayuda seleccion de tipos de movimientos"
		istr_parametros.s_nom_datawindow = "dw_ayuda_almtipomov_salidas"
      f_buscar(sle_tipomov,istr_parametros)
end if
end on

type cb_reubicar_insertar from u_boton within w_int_movsalidas
boolean visible = false
integer x = 9
integer y = 812
integer width = 425
integer height = 84
integer taborder = 170
string text = "&Insertar"
end type

event clicked;integer numero,controles
Dec{2} total_cantidad,total_pendiente
String ante_almacen
string mensaje,nombre,campo
dw_reubicacion.AcceptText()
controles=0
contador=dw_reubicacion.Rowcount()
dw_reubicacion.Accepttext()
IF contador<>0 THEN
 v_almacen  = dw_reubicacion.GetItemString(contador,"almacen")	
 v_zona     = dw_reubicacion.GetItemString(contador,"zona")	
 v_fila     = dw_reubicacion.GetItemNumber(contador,"fila")	
 v_altura   = dw_reubicacion.GetItemNumber(contador,"altura")	
 v_cantidad = dw_reubicacion.GetItemDecimal(contador,"cantidad")	
 dw_reubicacion.SetItem(dw_reubicacion.GetRow(),"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,dw_3.GetItemString(dw_3.GetRow(),"articulo"),dw_2.GetItemString(dw_2.GetRow(),"caja"),v_cantidad))
 v_cantidad = dw_reubicacion.GetItemDecimal(contador,"cantidad")	
 
 IF (trim(string(v_almacen))="" or IsNull(v_almacen)) and controles=0 THEN
  controles=1
  campo="almacen"
  mensaje=" Introduzca el almacen " 
 END IF

 IF contador>1 THEN
    ante_almacen  = dw_reubicacion.GetItemString(contador - 1,"almacen")	
    IF ante_almacen<> v_almacen THEN
       controles = 1
       campo   = "almacen"
       mensaje = "Esta entrada a de ubicarse en el mismo almacen "
    END IF
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

 nombre=f_nombre_almacen(codigo_empresa,v_almacen)
 IF (trim(nombre)="") and controles=0 THEN
   mensaje="El almacen no existe "
   controles=1
   campo="almacen"
 END IF

 nombre=f_nombre_zona(codigo_empresa,v_almacen,v_zona)
 IF (trim(nombre)="") and controles=0 THEN
    mensaje="La zona no existe"
    controles=1
    campo="zona"
 END IF
 IF (Not(f_ubi_exist(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
    mensaje= "La ubicacion no esta contemplada en el mapa de ubicaciones"
    controles=1
    campo="almacen"
 END IF

 IF controles=1 THEN
  MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
  dw_reubicacion.SetColumn(campo)
  dw_reubicacion.setRow(contador)
  dw_reubicacion.setfocus()
  Return
 END IF
END IF

contador=contador+1
dw_reubicacion.InsertRow(contador)

total_cantidad   = dw_reubicacion.GetItemNumber(1,"total_cantidad")
total_pendiente  = dw_3.GetItemNumber(dw_3.GetRow(),"cantidads")-total_cantidad
dw_reubicacion.setitem(Contador,"cantidad",total_pendiente)

dw_reubicacion.setitem(contador,"empresa",codigo_empresa)
dw_reubicacion.setitem(contador,"tipo_unidad",mov.tipo_unidad)
dw_reubicacion.setitem(contador,"almacen",mov.almacen)

dw_reubicacion.setrowfocusIndicator(Hand!)
dw_reubicacion.SetColumn("zona")
dw_reubicacion.setRow(contador)
dw_reubicacion.setfocus()





end event

type cb_reubicar_procesar from u_boton within w_int_movsalidas
boolean visible = false
integer x = 1275
integer y = 812
integer width = 425
integer height = 84
integer taborder = 70
boolean bringtotop = true
string text = "&Procesar"
end type

event clicked;dec numero,controles,x3
Dec{2} total_cantidad2,total_cantidad1
string mensaje,nombre,campo
dw_reubicacion.AcceptText()

controles  = 0
contador = dw_reubicacion.Rowcount()
IF contador=0 THEN
 MessageBox("No Puedo Procesar","No hay lineas de Ubicación",Exclamation!, OK!,1)
 Return
END IF
dw_reubicacion.Accepttext()

FOR x3=1 TO contador
 v_almacen    = dw_reubicacion.GetItemString(x3,"almacen")	
 v_zona       = dw_reubicacion.GetItemString(x3,"zona")	
 v_fila       = dw_reubicacion.GetItemNumber(x3,"fila")	
 v_altura     = dw_reubicacion.GetItemNumber(x3,"altura")	
 v_cantidad   = dw_reubicacion.GetItemDecimal(x3,"cantidad")	
 v_cantidad   = dw_reubicacion.GetItemDecimal(x3,"cantidad")	
 v_cantidad   = f_calculo_redondeo_cantidad(codigo_empresa,dw_3.GetItemString(dw_3.GetRow(),"articulo"),dw_3.GetItemString(dw_3.GetRow(),"almmovhis_caja"),v_cantidad)
 dw_reubicacion.SetItem(x3,"cantidad",v_cantidad)
 


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

nombre=f_nombre_almacen(codigo_empresa,v_almacen)
IF (trim(nombre)="") and controles=0 THEN
  mensaje="El almacen no existe "
  controles=1
  campo="almacen"
END IF

nombre=f_nombre_zona(codigo_empresa,v_almacen,v_zona)
IF (trim(nombre)="") and controles=0 THEN
   mensaje="La zona no existe"
   controles=1
   campo="zona"
END IF
 IF (Not(f_ubi_exist(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
    mensaje= "La ubicacion no esta contemplada en el mapa de ubicaciones"
    controles=1
    campo="almacen"
 END IF
total_cantidad1   = dw_reubicacion.GetItemNumber(1,"total_cantidad")
total_cantidad2   = dw_3.GetItemNumber(dw_3.getrow(),"cantidads")
IF total_cantidad1<>total_cantidad2 THEN
  MessageBox("No Puedo Procesar","El total de unidades/metros no coinciden",Exclamation!, OK!,1)
  controles=1
  campo = "cantidad"
END IF

IF controles=1 THEN
  MessageBox("Campo obligatorio en linea"+string(x3),mensaje,Exclamation!, OK!,1)
  dw_reubicacion.SetColumn(campo)
  dw_reubicacion.SetRow(x3)
  dw_reubicacion.SetFocus()
 Return
END IF
NEXT
pb_1.enabled=FALSE


//---------------------------------------------------------------------
// Despues de todos los controles empezamos el proceso de inserción
//---------------------------------------------------------------------
// Contador de movimiento y orden de lineas de  ubicacion
   dec contador_nummov,contador_orden 
// Valor de controles funcionamiento
   dec bien
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
 ubihis.usuario      = nombre_usuario
 mov.usuario         = nombre_usuario
 ubihis.empresa      = codigo_empresa
 ubihis.anyo         = mov.anyo
 ubihis.almacen      = mov.almacen
 ubihis.articulo     = mov.articulo
 ubihis.calidad      = mov.calidad
 ubihis.tonochar     = mov.tonochar
 ubihis.calibre      = mov.calibre
 ubihis.fecha        = DateTime(today(),Now())
 ubihis.f_alta       = DateTime(today(),Now())
 ubihis.tipomov      = "201" 
 ubihis.familia      = mov.familia
 ubihis.formato      = mov.formato
 ubihis.modelo       = mov.modelo
 ubihis.tipo_unidad  = mov.tipo_unidad
 ubihis.tipo_pallet  = mov.tipo_pallet
 ubihis.caja         = mov.caja
 ubihis.sector       = mov.sector
 ubihis.referencia   = f_componer_ref(ubihis.articulo,ubihis.calidad,&
                                      ubihis.tonochar,ubihis.calibre)

ubi.empresa    =  ubihis.empresa
ubi.almacen    =  ubihis.almacen
ubi.articulo   =  ubihis.articulo
ubi.familia    =  ubihis.familia
ubi.formato    =  ubihis.formato
ubi.modelo     =  ubihis.modelo
ubi.calidad    =  ubihis.calidad
ubi.tonochar   =  ubihis.tonochar
ubi.calibre    =  ubihis.calibre
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad=  ubihis.tipo_unidad
ubi.tipo_pallet=  ubihis.tipo_pallet
ubi.caja       =  ubihis.caja
ubi.sector     =  ubihis.sector
ubi.referencia =  ubihis.referencia
ubi.f_alta     =  DateTime(today(),now())

//-------------------------------------------------------------------

 titulo        =  Parent.title
 IF NOT f_bloquear_almacen(titulo) THEN
  contador_orden = f_almparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))
  ubihis.nummov  = mov.nummov
  contador = dw_reubicacion.Rowcount()
  FOR x3=1 TO contador
     ubihis.almacen    = dw_reubicacion.GetItemString(x3,"almacen")	
     ubihis.zona       = dw_reubicacion.GetItemString(x3,"zona")	
     ubihis.fila       = dw_reubicacion.GetItemNumber(x3,"fila")	
     ubihis.altura     = dw_reubicacion.GetItemNumber(x3,"altura")	
     ubihis.cantidade  = dw_reubicacion.GetItemDecimal(x3,"cantidad")	
     ubihis.cantidads  = 0
     ubihis.orden      = contador_orden
     ubihis.observaciones  = mov.observaciones
     ubihis.f_alta     = DateTime(today(),Now())
     ubihis.usuario    = nombre_usuario
     ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
                                           ubihis.fila,ubihis.altura)
     
     ubi.zona            = ubihis.zona
     ubi.fila            = ubihis.fila
     ubi.altura          = ubihis.altura
     ubi.existencias     = ubihis.cantidade
     ubi.ubicacion       = ubihis.ubicacion
//------------------------------------------------------------------
// Inserto en el historico de lineas de ubicacion por movimiento
//------------------------------------------------------------------
IF Not f_insert_almlinubicahis(ubihis) Then bien=1
    
//-----------------------------------------------------------------------
// Variables para cargar el cursor
//-----------------------------------------------------------------------
      dec cur_pedido,cur_linea,cur_anyo
      String  cur_empresa,cur_almacen,cur_caja
      decimal{2}  cur_existencias
      string      cur_referencia,cur_ubicacion,cur_observaciones,cur_tipo_pallet
//-----------------------------------------------------------
// Busco si hay linea este articulo sin reservar
//-----------------------------------------------------------
dec x1,registros
registros= dw_proceso.Retrieve(ubi.empresa,ubi.ubicacion,ubi.referencia)

 // Variable de controles 0-> no grabado 1-> si grabado
 dec grabado,salir
 grabado=0
 salir  =0
IF registros<>0 Then
For x1= 1 to registros
  cur_pedido        = dw_proceso.GetItemNumber(x1,"pedido")
  cur_linea         = dw_proceso.GetItemNumber(x1,"linea")
  cur_existencias   = dw_proceso.GetItemNumber(x1,"existencias")
  cur_observaciones = dw_proceso.GetItemString(x1,"observaciones")
  cur_tipo_pallet   = dw_proceso.GetItemString(x1,"tipo_pallet")
  cur_caja          = dw_proceso.GetItemString(x1,"caja")
  IF IsNUll(cur_existencias) Then cur_existencias =0
  IF (IsNull(cur_pedido) or trim(string(cur_pedido))="") and (cur_tipo_pallet = ubi.tipo_pallet) and (cur_caja = ubi.caja) THEN
   ubi.existencias=ubi.existencias + cur_existencias
   grabado = 1
   UPDATE almlinubica  
   SET existencias   = :ubi.existencias,   
   f_alta            = :ubi.f_alta
   WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
         ( almlinubica.ubicacion = :ubi.ubicacion ) AND  
         ( almlinubica.linea     = :cur_linea ) USING SQLCA;
   IF SQLCA.SQLCode<>0 THEN    bien=1
   EXIT
 END IF
NEXT
END IF

// Insercion nueva linea de ubicacion
IF grabado=0 THEN
 SELECT    max(almlinubica.linea)  
    INTO   :cur_linea  
    FROM   almlinubica  
   WHERE  almlinubica.empresa   = :ubi.empresa 
	AND    almlinubica.ubicacion = :ubi.ubicacion;   
   IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN cur_linea = 0 
    cur_linea       = cur_linea+1
    ubi.linea       = cur_linea
    ubi.almacen     = ubihis.almacen
    ubi.zona        = ubihis.zona
    ubi.fila        = ubihis.fila
    ubi.altura      = ubihis.altura
    ubi.articulo    = ubihis.articulo
    ubi.familia     = ubihis.familia
    ubi.formato     = ubihis.formato
    ubi.modelo      = ubihis.modelo
    ubi.calidad     = ubihis.calidad
    ubi.tonochar    = ubihis.tonochar
    ubi.calibre     = ubihis.calibre
    ubi.existencias = ubihis.cantidade

    SetNull(ubi.anyo)
    SetNull(ubi.pedido)
    SetNull(ubi.linped)
    ubi.cliente      = sle_cliente.text
    ubi.tipo_unidad  = ubihis.tipo_unidad
    ubi.referencia   = ubihis.referencia
    ubi.f_alta       = Datetime(today(),now())
    SetNull(ubi.observaciones)
	 IF Not f_insert_almlinubica(ubi) THEN bien=1
END IF

//-----------------------Fin Grabación Lineas de Ubicacion--------------

// el contador incrementa uno para cada linea
contador_orden = contador_orden + 1 

NEXT
   UPDATE almmovhis  
   SET     situacion = 'A',
	        origen    = :mov.origen
   WHERE  almmovhis.empresa = :codigo_empresa 
	AND    almmovhis.almacen = :mov.almacen 
	AND    almmovhis.anyo    = :mov.anyo
	AND    almmovhis.nummov  = :mov.nummov;
      IF SQLCA.SQLCODE <> 0 Then 
			
			messagebox ("", "A")
          bien = 1
      END IF

 IF NOT f_actualiza_numorden(ubihis.empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
      bien=1
 END IF


 titulo        =  Parent.title
 longitud      =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
 anyo          =  Year(Date(em_fecha.text))
 longitud      =  len(trim(string(anyo)))
 criterio[2]   =  trim(string(anyo))+space(20-longitud)
 seleccion     =  criterio[1]+criterio[2]
 tabla         =  "almparam" 

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
  f_desbloquear_almacen(titulo)
  COMMIT;

ELSE
 pb_1.enabled=TRUE
 Return
END IF
pb_1.enabled=TRUE

cb_reubicar_salir.TriggerEvent(Clicked!)
end event

type cb_reubicar_salir from u_boton within w_int_movsalidas
boolean visible = false
integer x = 855
integer y = 812
integer width = 421
integer height = 84
integer taborder = 150
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;  //------------------------//
  // Activarn de campos//
  //------------------------//


dw_2.visible                     = TRUE
dw_3.enabled                     = TRUE

em_calibre.visible               = TRUE
em_cantidad.visible              = TRUE

em_tono.visible                  = TRUE
pb_1.visible                     = TRUE
pb_calculo.visible               = TRUE
uo_articulo.visible              = TRUE
uo_calidad.visible               = TRUE
sle_observaciones.visible        = TRUE
st_1.visible                     = TRUE
st_texto_cantidad.visible        = TRUE
st_2.visible                     = TRUE
st_3.visible                     = TRUE
st_4.visible                     = TRUE

st_9.visible                     = TRUE
cb_1.visible                     = TRUE

em_fecha.enabled             = TRUE
uo_articulo.enabled         = TRUE
sle_cliente.enabled          = TRUE
sle_numdoc.enabled           = TRUE
sle_tipomov.enabled          = TRUE



dw_consulta_reubicacion.visible   = FALSE
dw_reubicacion.visible            = FALSE
cb_reubicar_borrar.visible        = FALSE
cb_reubicar_insertar.visible      = FALSE
cb_reubicar_procesar.visible      = FALSE
cb_reubicar_salir.visible         = FALSE

ver_movimientos()
uo_articulo.em_campo.Setfocus()
end event

type cb_reubicar_borrar from u_boton within w_int_movsalidas
boolean visible = false
integer x = 434
integer y = 812
integer width = 421
integer height = 84
integer taborder = 100
boolean bringtotop = true
string text = "&Borrar"
end type

on clicked;call u_boton::clicked;integer fila
fila=dw_reubicacion.getrow()
IF contador=fila THEN
  IF contador<>1 THEN
    contador=contador - 1
  END IF
END IF
IF fila<>0 THEN
 dw_reubicacion.DeleteRow(dw_reubicacion.getRow())
 dw_reubicacion.setrowfocusIndicator(Hand!)
 dw_reubicacion.SetColumn("almacen")
 dw_reubicacion.setRow(contador)
 dw_reubicacion.setfocus()
END IF


end on

type sle_cliente from u_em_campo within w_int_movsalidas
boolean visible = false
integer x = 1861
integer y = 260
integer width = 375
integer taborder = 50
end type

event modificado;call super::modificado;string tipo,mensa
tipo = f_tipo_almtipomov(codigo_empresa,sle_tipomov.text) 
IF tipo = "P"  THEN
   st_nombre_cliente.text=f_nombre_proveedor(codigo_empresa,sle_cliente.text)	
	mensa = "El proveedor no existe"
else
	st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
	mensa = "El cliente no existe"
End if

IF Trim(em_fecha.text)   = "" or IsNull(em_fecha.text) or &
   Trim(sle_numdoc.text) = "" or IsNull(sle_numdoc.text) or&
   Trim(sle_tipomov.text)= "" or IsNull(sle_tipomov.text) THEN
   sle_cliente.text   = ""
   Return
END IF



IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="C"	 THEN
   // controlo que los movimientos de compras ya introducidos a la factura
   // en curso pertenezcan al mismo codigo de cliente
   String  v_cliente
   Integer registros
   registros = dw_3.RowCount()
   IF registros >0 THEN
      v_cliente = dw_3.GetItemString(1,"codtercero")
     
      IF trim(sle_cliente.text)="" THEN
         sle_cliente.text=v_cliente
      END IF
      IF Trim(st_nombre_cliente.text)="" THEN
         MessageBox("Mensaje",mensa,Exclamation!,Ok!,1)
         sle_cliente.text= v_cliente
         st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
         sle_cliente.Setfocus()
         Return
      END IF
      IF v_cliente<>sle_cliente.text or IsNull(v_cliente) THEN
        integer opcion,bien,x1
        opcion=MessageBox("Todas las lineas deben de ser al mismo cliente","El cliente no coincide con los demas movimientos ¿Validar?",Question!,YesNo!,2)
        
        CHOOSE CASE opcion
	     CASE 1 
              bien=0
              titulo        =  Parent.title
              longitud      =  len(trim(codigo_empresa))
              criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
              anyo          =  year(today())
              longitud      =  len(trim(string(anyo)))
              criterio[2]   =  trim(string(anyo))+space(20-longitud)
              v_almacen     =  dw_3.GetItemString(1,"almacen")
              longitud      =  len(trim(v_almacen))
              criterio[3]   =  trim(v_almacen)+space(20-longitud)
              seleccion     =  criterio[1]+criterio[2]+criterio[3]
              tabla         =  "almparam"
           IF NOT f_bloquear(tabla,seleccion,titulo) THEN 
              FOR x1=1 TO registros
               mov.empresa =codigo_empresa
               mov.almacen = v_almacen
               mov.anyo    = anyo
               mov.nummov  = dw_3.GetItemNumber(x1,"nummov")
               UPDATE almmovhis  
               SET codtercero = :sle_cliente.text  
               WHERE (almmovhis.empresa = :mov.empresa ) AND  
                     (almmovhis.almacen = :mov.almacen ) AND  
                     (almmovhis.anyo    = :mov.anyo    ) AND  
                     (almmovhis.nummov  = :mov.nummov  ) USING SQLCA;
               IF SQLCA.SQLCode<>0 THEN bien=1
             NEXT
             IF bien=0 THEN
                COMMIT USING SQLCA;
             ELSE
                ROLLBACK USING SQLCA;
                MessageBox("Error en base de datos","Error el procesar datos",Exclamation!,Ok!,2)
             END IF
             f_desbloquear(tabla,seleccion,titulo)
             dw_3.retrieve(codigo_empresa,year(date(String(em_fecha.text))),integer(sle_tipomov.text),sle_numdoc.text)
          ELSE
             sle_cliente.text= v_cliente
             st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
          END IF
        CASE 2 
             sle_cliente.text= v_cliente
             st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
        END CHOOSE

      END IF
   END IF
END IF
end event

event getfocus;call super::getfocus;string tipo
tipo = f_tipo_almtipomov(codigo_empresa,sle_tipomov.text) 
IF tipo = "P" THEN
	ue_titulo     = "Ayuda seleccion de proveedores"
   ue_datawindow = "dw_ayuda_proveedores"
   ue_filtro     = ""
else
	ue_titulo     = "Ayuda seleccion de clientes"
   ue_datawindow = "dw_ayuda_clientes"
   ue_filtro     = ""
End if
end event

type dw_proceso from datawindow within w_int_movsalidas
boolean visible = false
integer x = 2514
integer y = 124
integer width = 151
integer height = 132
integer taborder = 210
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica"
boolean livescroll = true
end type

type dw_procesos from datawindow within w_int_movsalidas
boolean visible = false
integer x = 2327
integer y = 128
integer width = 146
integer height = 120
integer taborder = 200
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica"
boolean livescroll = true
end type

type st_1 from statictext within w_int_movsalidas
integer x = 9
integer y = 384
integer width = 357
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_movsalidas
integer x = 745
integer y = 384
integer width = 146
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_movsalidas
integer x = 896
integer y = 384
integer width = 128
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_tono from u_em_campo within w_int_movsalidas
integer x = 896
integer y = 460
integer width = 128
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string mask = "!!!!"
end type

on getfocus;call u_em_campo::getfocus;ante_tono = em_tono.text
end on

on modificado;call u_em_campo::modificado;// Visualiza las lineas de ubicación a nivel de articulo-calidad-tono

if ante_tono<>em_tono.text then
   if trim(em_tono.text)<>"" THEN
      STRING is_filtro = ""
      if trim(uo_articulo.em_codigo.text)<>"" then

      is_filtro = " calidad = '" + uo_calidad.em_codigo.text + "'"	
      is_filtro = is_filtro + " AND tono = " + em_tono.text  
  
      dw_2.SetFilter(is_filtro)
      dw_2.Filter()
      dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
    End If

  End If
End if
end on

type em_calibre from u_em_campo within w_int_movsalidas
integer x = 1029
integer y = 460
integer width = 96
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "0"
end type

type st_4 from statictext within w_int_movsalidas
integer x = 1029
integer y = 384
integer width = 96
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_movsalidas
integer x = 18
integer y = 1248
integer width = 439
integer height = 72
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

type sle_observaciones from u_em_campo within w_int_movsalidas
integer x = 471
integer y = 1240
integer width = 2578
integer taborder = 180
long backcolor = 33554431
boolean border = false
borderstyle borderstyle = stylebox!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type st_texto_cantidad from statictext within w_int_movsalidas
integer x = 3529
integer y = 380
integer width = 320
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_cantidad from u_em_campo within w_int_movsalidas
integer x = 3525
integer y = 456
integer width = 325
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;string cadena
long posi,posi_aux

em_pallet.text= ""
em_cajas.text = ""

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
								  dw_2.GetItemString(dw_2.getRow(),"caja"),&
                          integer(em_pallet.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_pallet.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if





end event

type cb_1 from u_boton within w_int_movsalidas
integer x = 3653
integer y = 556
integer width = 201
integer height = 116
integer taborder = 190
string text = "&Ok"
end type

event clicked;//CONTROLES DE VALORES
f_control_tono_calibre()


string mensaje
Dec{2}  var_conjunto
Date ahora, fecha
Long respuesta

if var_externo="N" then
	if MessageBox("Control tipo de almacen","El material no esta en un almacen de carga directa.¿Desea continuar?",Question!,YesNo!,2)=2 then 
	   em_cantidad.SetFocus()
		Return
   End if
End if

IF trim(em_fecha.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
   RETURN
END IF

ahora = Date(Today())
fecha = Date(em_fecha.text)

if ahora <> fecha then
	respuesta = MessageBox("Atención Fecha","La fecha indicada ("+em_fecha.text+") no coincide con la actual ("+String(ahora)+"). Aun así, ¿desea continuar?",Question!, YesNo!,2)
	if respuesta = 2 then
	   em_fecha.SetFocus()
		return
	end if
end if

IF trim(sle_tipomov.text)=""  or IsNull(sle_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
   RETURN
END IF

st_nombre_tipomov.text=f_nombre_almtipomov_salida(codigo_empresa,sle_tipomov.text)

IF trim(st_nombre_tipomov.text)="" or IsNull(st_nombre_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento no existe"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
   RETURN
END IF

IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="C" THEN
  st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
  IF trim(st_nombre_cliente.text)="" or IsNull(st_nombre_cliente.text) THEN
     mensaje="El cliente no existe."
     MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
     sle_cliente.Setfocus()
     RETURN
 END IF
END IF

IF trim(sle_numdoc.text)="" THEN
   mensaje="Introduzca el Numero de Dmto"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_numdoc.Setfocus()
   RETURN
END IF

IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF
IF v_sector = "S" THEN
  IF trim(uo_calidad.em_campo.text)="" THEN
		mensaje="Introduzca la calidad"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		uo_calidad.em_campo.Setfocus()
		RETURN 
  END IF
  IF control_tono=TRUE Then
	 IF trim(em_tono.text)="" THEN
		mensaje="Introduzca el tono"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		em_tono.SetFocus()
		RETURN
	 END IF
  END IF
  IF control_calibre=TRUE Then
	 IF trim(em_calibre.text)="" THEN
		mensaje="Introduzca el calibre"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		em_calibre.SetFocus()
		RETURN
	 END IF
  END IF
END IF

IF dw_2.GetRow() =0 Then
   mensaje="Marcar Una Ubicacion"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   dw_2.SetFocus()
   RETURN
END IF

// control bloqueo promocion
string v_ubicacion
dec v_linea
v_ubicacion = dw_2.GetItemString(dw_2.getRow(),"ubicacion")
v_linea     = dw_2.GetItemNumber(dw_2.getRow(),"linea")
if f_bloqueo_almlinubica_promocion(codigo_empresa,v_ubicacion,v_linea) then
   f_mensaje("!Atención¡","Material bloqueado modulo promocion")
	Return
End if

// control bloqueo material
if f_bloqueo_almlinubica(codigo_empresa,v_ubicacion,v_linea) then
   f_mensaje("!Atención¡","Material bloqueado" )
	Return
End if


IF v_sector = "S" THEN
 string codigo_articulo
 String codigo_calidad

 codigo_articulo=uo_articulo.em_codigo.text
 codigo_calidad= uo_calidad.em_codigo.text

  SELECT almartcal.calidad INTO :codigo_calidad    FROM almartcal  
   WHERE (almartcal.empresa  = :codigo_empresa)
   AND   (almartcal.articulo = :codigo_articulo)
   AND   (almartcal.calidad  = :codigo_calidad);

   IF SQLCA.SQLCode<>0 THEN
     MessageBox("Calidad no  valida","Esta calidad no esta definida para el artículo",Exclamation!, OK!,1)
     uo_calidad.em_campo.text        = ""
     uo_calidad.em_codigo.text = ""
     uo_calidad.em_campo.Setfocus()
     Return
   END IF
END IF

   // controlo las exitencias disponibles

// IF Not f_control_disponible_ubicacion() Then
	IF Dec(em_cantidad.text) > dw_2.GetItemNumber(dw_2.GetRow(),"existencias") then
		f_mensaje("Advertencia","No existen existencias suficientes")
      f_activar_campo(em_cantidad)
      Return
   END IF

   IF Dec(em_cantidad.text)=0 or trim(em_cantidad.text)="" THEN
   mensaje="Introduzca nº total de cantidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_cantidad.SetFocus()
   RETURN
END IF

// Control piezas por conjunto
var_conjunto= f_conjunto_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF var_conjunto<> 0 And Not IsNULL(var_conjunto) Then
 IF (Dec(String(Dec(em_cantidad.text)/var_conjunto,"##########")) * var_conjunto) <> Dec(em_cantidad.text) Then
  MessageBox("Cantidad no valida","Esta articulo va por conjuntos la cantidad a de ser multiplo de: " + String(var_conjunto),Exclamation!, OK!,1)
  f_activar_campo(em_cantidad)
  return
 END IF
END IF


IF Not f_bloquear_almacen(w_int_movsalidas.title) Then
//----------------------//
// Proceso de Insercion //
//----------------------//
//---------------------------------------------------------------------
// Despues de todos los controles empezamos el proceso de inserción
//---------------------------------------------------------------------
// Valor de control funcionamiento
   dec bien
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
 ubihis.usuario       = nombre_usuario
 ubihis.empresa       = codigo_empresa
 ubihis.anyo          = year(date(String(em_fecha.text)))
 ubihis.almacen       = dw_2.GetItemString(dw_2.getRow(),"almacen")
 ubihis.articulo      = uo_articulo.em_codigo.text
 ubihis.calidad       = uo_calidad.em_codigo.text
 ubihis.tonochar      = Trim(em_tono.text)
 ubihis.calibre       = dec(em_calibre.text)
 ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
 ubihis.f_alta        = Datetime(today(),now())
 ubihis.observaciones = sle_observaciones.text
 ubihis.tipomov       = sle_tipomov.text
 ubihis.tipo_pallet   = dw_2.GetItemString(dw_2.getRow(),"tipo_pallet")
 ubihis.caja          = dw_2.GetItemString(dw_2.getRow(),"caja")
 ubihis.sector        = v_sector
  
 SELECT  articulos.empresa,
 			articulos.familia,   
			articulos.subfamilia,   
         articulos.formato,
			articulos.subformato,
			articulos.modelo,
			articulos.unidad  
    INTO :ubihis.empresa,
	 		:ubihis.familia,
			:ubihis.subfamilia,
			:ubihis.formato,   
			:ubihis.subformato,   
         :ubihis.modelo,
			:ubihis.tipo_unidad  
    FROM articulos  
   WHERE (articulos.empresa = :ubihis.empresa ) AND  
         (articulos.codigo  = :ubihis.articulo ) ;

IF SQLCA.SQLCode<>0 THEN 
	bien=1
	messagebox("Error","EN SELECCION ARTICULO")
END IF
 
ubihis.referencia   = f_componer_ref(ubihis.articulo,&
                                     ubihis.calidad,&
												 ubihis.tonochar,&
                                     ubihis.calibre)

											 

ubi.empresa     =  ubihis.empresa
ubi.almacen     =  ubihis.almacen
ubi.articulo    =  ubihis.articulo
ubi.familia     =  ubihis.familia
ubi.subfamilia  =  ubihis.subfamilia
ubi.formato     =  ubihis.formato
ubi.subformato  =  ubihis.subformato
ubi.modelo      =  ubihis.modelo
ubi.calidad     =  ubihis.calidad
ubi.tonochar    =  ubihis.tonochar
ubi.calibre     =  ubihis.calibre
ubi.tipo_pallet =  ubihis.tipo_pallet
ubi.caja        =  ubihis.caja
ubi.sector      =  ubihis.sector
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad  =  ubihis.tipo_unidad
ubi.referencia   =  ubihis.referencia
ubi.f_alta       =  DateTime(today(),now())
ubihis.zona      =  dw_2.GetItemString(dw_2.GetRow(),"zona")
ubihis.fila      =  dw_2.GetItemNumber(dw_2.GetRow(),"fila")
ubihis.altura    =  dw_2.GetItemNumber(dw_2.GetRow(),"altura")
ubihis.cantidads = Dec(em_cantidad.text)
ubihis.cantidade = 0

ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
                                              ubihis.fila,ubihis.altura)
ubi.zona            = ubihis.zona
ubi.fila            = ubihis.fila
ubi.altura          = ubihis.altura
ubi.existencias     = ubihis.cantidads
ubi.ubicacion       = ubihis.ubicacion

mov.empresa          = ubihis.empresa
mov.almacen          = ubihis.almacen
mov.anyo             = ubihis.anyo
mov.origen           = "4"
mov.articulo         = ubihis.articulo
mov.fechmov          = ubihis.fecha
mov.tipomov          = ubihis.tipomov
mov.cantidade        = ubihis.cantidade
mov.cantidads        = ubihis.cantidads
//mov.precio           = ?????????????????
mov.codtercero       = sle_cliente.text
mov.numdoc           = sle_numdoc.text
mov.situacion        = "N"
mov.observaciones    = ubihis.observaciones
SetNull(mov.punteado)
mov.antexist=0      
mov.familia        = ubihis.familia
mov.subfamilia     = ubihis.subfamilia
mov.formato        = ubihis.formato
mov.subformato     = ubihis.subformato
mov.modelo         = ubihis.modelo
mov.calidad        = ubihis.calidad
mov.tonochar       = ubihis.tonochar
mov.calibre        = ubihis.calibre
mov.tipo_unidad    = ubihis.tipo_unidad
mov.tipo_pallet    = ubihis.tipo_pallet
mov.caja           = ubihis.caja
mov.referencia     = ubihis.referencia
mov.f_alta         = DateTime(today(),now())
mov.sector         = v_sector
mov.usuario        = nombre_usuario
//-------------------------------------------------------------------
v_almacen = dw_2.GetItemString(dw_2.GetRow(),"almacen")
  
  ubihis.orden   = f_almparam_numorden(codigo_empresa,Year(date(em_fecha.text)))
  ubihis.nummov  = f_almparam_nummov(codigo_empresa,Year(Date(em_fecha.text)))
  mov.nummov=ubihis.nummov    
// Variables para cargar el cursor

      dec cur_pedido,cur_linea,cur_anyo
      String  cur_empresa,cur_almacen

      decimal{4}  cur_existencias,cantidad_pendiente,cantidad_borrada
      string  cur_referencia,cur_ubicacion,cur_tipo_pallet,cur_caja


   // Primero actualizo la salida global //
  //-------------------------------------//
  // En el historico de ubicaciones
  	IF NOT f_insert_almlinubicahis(ubihis) Then 
		bien=1
		messagebox("Error","f_insert_almlinubicahis")
	END IF
	IF NOT f_actualiza_numorden(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
		messagebox("Error","f_actualiza_numorden")
		bien=1
	END IF
//----------------------------------------------
// Borro en las ubicaciones correspondientes
//----------------------------------------------

dec Registros,x1=0
registros = dw_proceso.retrieve(ubi.empresa,ubi.ubicacion,ubi.referencia,ubihis.caja)
cantidad_borrada=0

If registros<>0 Then
 For x1 = 1 To Registros
    cur_pedido        =  dw_proceso.GetItemNumber(x1,"pedido")
    cur_linea         =  dw_proceso.GetItemNumber(x1,"linea")
    cur_existencias   =  dw_proceso.GetItemNumber(x1,"existencias")
    cur_tipo_pallet   =  dw_proceso.GetItemString(x1,"tipo_pallet")
	 cur_caja          =  dw_proceso.GetItemString(x1,"caja")
 
   IF (IsNull(cur_pedido) or trim(string(cur_pedido))="") and (cur_tipo_pallet=ubi.tipo_pallet) and (cur_caja=ubi.caja) THEN
      cantidad_pendiente=Dec(em_cantidad.text) - cantidad_borrada
      IF cantidad_pendiente=0 THEN   EXIT
      IF cantidad_pendiente>= cur_existencias THEN 
         cantidad_borrada=cantidad_borrada + cur_existencias
         DELETE FROM almlinubica
         WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
               ( almlinubica.ubicacion = :ubi.ubicacion ) AND  
               ( almlinubica.linea     = :cur_linea ) USING SQLCA   ;
         IF SQLCA.SQLCode<>0 THEN 
				bien=1
				messagebox("Error","Borrando ubicaciones")
			end if
     ELSE
         cur_existencias=cur_existencias - cantidad_pendiente
         cantidad_borrada=cantidad_borrada + cantidad_pendiente
         UPDATE almlinubica  
         SET existencias = :cur_existencias  
         WHERE (almlinubica.empresa   = :ubi.empresa ) AND  
               (almlinubica.ubicacion = :ubi.ubicacion ) AND  
               (almlinubica.linea     = :cur_linea )USING SQLCA;
         IF SQLCA.SQLCode<>0 THEN 
				bien=1
				messagebox("Error","Actualizando ubicaciones")
			end if
   END IF
  END IF
NEXT
END IF


IF cantidad_borrada <> Dec(em_cantidad.text) THEN 
	messagebox("Error","No ha sido posible completar la salida de almacen")
	bien=1
END IF


// Grabo el movimiento en el historico
  IF NOT f_insert_almmovhis(mov) Then 
		bien=1
		messagebox("Error","f_insert_almmovhis")
  end if
  IF NOT f_actualiza_nummov(mov.empresa,mov.anyo,mov.nummov) THEN
		bien=1
		messagebox("Error","f_insert_almmovhis")
  end if
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
  f_desbloquear_almacen(w_int_movsalidas.title)
pb_1.enabled=TRUE
ver_movimientos()
em_calibre.text=""
em_cantidad.text=""
em_tono.text=""
em_pallet.text=""
em_cajas.text=""
uo_articulo.em_campo.text=""
uo_calidad.em_campo.text=""
uo_articulo.em_codigo.text=""
em_disponible.text = ""
dw_2.retrieve(codigo_empresa,"")
uo_articulo.em_campo.SetFocus()
END IF
end event

type uo_articulo from u_em_campo_2 within w_int_movsalidas
integer x = 9
integer y = 460
integer width = 731
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_descripcion,var_formato

select descripcion,familia,unidad,formato
Into   :var_descripcion,:v_familia,:var_tipo_unidad,:var_formato
from   articulos
Where  articulos.empresa  =  :codigo_empresa
And    articulos.codigo   =  :uo_articulo.em_codigo.text;

uo_articulo.em_campo.text = var_descripcion
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then 
	 uo_articulo.em_campo.text=""
	 uo_articulo.em_codigo.text=""
	 uo_articulo.em_campo.SetFocus()
	 Return
 End if
END IF


// Visualiza las lineas de ubicación a nivel de articulo

   If trim(uo_articulo.em_campo.text)<>"" Then
      STRING is_filtro = ""
      dw_2.SetFilter(is_filtro)
      dw_2.Filter()  
      dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
		dw_tipos_caja.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
   End If

   st_texto_cantidad.text=f_nombre_unidad(f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
	em_cantidad.Setmask(DecimalMask!,f_mascara_unidad(var_tipo_unidad))
	f_mascara_columna(dw_2,"existencias",f_mascara_unidad(var_tipo_unidad))
   v_sector  = f_sector_familia(codigo_empresa,v_familia)
	st_formato.text = f_nombre_formato(codigo_empresa,var_formato)
   

end event

event getfocus;call super::getfocus;ante_codigo_articulo = uo_articulo.em_codigo.text

ue_titulo     = "Ayuda seleccion de articulos"
//ue_datawindow = "dw_ayuda_articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type uo_calidad from u_em_campo_2 within w_int_movsalidas
integer x = 745
integer y = 460
integer width = 146
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on modificado;call u_em_campo_2::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text)<>"" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text=""
 uo_calidad.em_codigo.text=""
END IF

// Visualiza las lineas de ubicación a nivel de articulo-calidad

if ante_codigo_calidad<>uo_calidad.em_codigo.text Then

   if trim(uo_calidad.em_campo.text)<>"" Then
      STRING is_filtro = ""
      if trim(uo_articulo.em_codigo.text)<>"" then
       	is_filtro = " calidad = '" + uo_calidad.em_codigo.text + "'"
	      dw_2.SetFilter(is_filtro)
         dw_2.Filter()
         dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
      End If
    End If
End if
end on

on getfocus;call u_em_campo_2::getfocus;ante_codigo_calidad = uo_calidad.em_codigo.text

ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type pb_calculo from u_calculadora within w_int_movsalidas
integer x = 1399
integer y = 176
integer taborder = 0
end type

event clicked;String alm_empresa,alm_tipomov
Dec alm_anyo,alm_numdoc

alm_empresa    =  codigo_empresa
alm_anyo       =  Year(Date(em_fecha.text))
alm_tipomov    =  sle_tipomov.text
alm_numdoc     =  Dec(sle_numdoc.text)

if sle_tipomov.text = "" then
	MessageBox("Error", "Por favor, seleccione un tipo de movimiento")
	return
end if

SELECT max(convert(dec,almmovhis.numdoc))INTO :alm_numdoc  
FROM    almmovhis  
WHERE  almmovhis.empresa = :alm_empresa 
AND    almmovhis.anyo    = :alm_anyo 
AND    almmovhis.tipomov = :alm_tipomov 
AND    almmovhis.numdoc   between "0" and "999999999999999";
IF SQLCA.SQLCode<>0 THEN  alm_numdoc=0
IF IsNull(alm_numdoc)   Then alm_numdoc = 0
alm_numdoc      = alm_numdoc + 1
sle_numdoc.text = string(alm_numdoc,"###########")
ver_movimientos()
sle_numdoc.SetFocus()
end event

type st_texto_cajas from statictext within w_int_movsalidas
integer x = 3296
integer y = 380
integer width = 229
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_texto_pallet from statictext within w_int_movsalidas
integer x = 3063
integer y = 380
integer width = 229
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "Pal"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_cajas from u_em_campo within w_int_movsalidas
integer x = 3296
integer y = 456
integer width = 229
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event modificado;call super::modificado;string cadena
long posi,posi_aux

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
								  dw_2.GetItemString(dw_2.getRow(),"caja"),&
                          integer(em_pallet.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_pallet.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if




end event

type em_pallet from u_em_campo within w_int_movsalidas
integer x = 3063
integer y = 456
integer width = 229
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###0"
string displaydata = "Ä"
end type

event getfocus;call super::getfocus;//TriggerEvent("modificado")
//call super::getfocus

end event

event modificado;call super::modificado;string cadena
long posi,posi_aux

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
								  dw_2.GetItemString(dw_2.getRow(),"caja"),&
                          integer(em_pallet.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))

posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_pallet.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if



end event

type st_disponible from statictext within w_int_movsalidas
fontcharset fontcharset = ansi!
string facename = "System"
end type

type pb_imprimir from upb_imprimir within w_int_movsalidas
integer x = 1623
integer y = 176
integer width = 105
integer taborder = 0
boolean originalsize = false
end type

event clicked;sle_numdoc.SetFocus()
IF Trim(sle_numdoc.text) = "" THEN Return
str_parametros pa
dw_listado.retrieve(codigo_empresa,year(date(String(em_fecha.text))),sle_tipomov.text,sle_numdoc.text)
pa.s_listado  = dw_listado.DataObject
OpenWithParm(w_impresoras_v2,dw_listado)


end event

type em_disponible from statictext within w_int_movsalidas
integer x = 3067
integer y = 1140
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 12632256
boolean enabled = false
string text = "0"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type st_tecla from statictext within w_int_movsalidas
integer x = 1403
integer y = 112
integer width = 101
integer height = 60
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F5"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_consulta_reubicacion from datawindow within w_int_movsalidas
boolean visible = false
integer x = 1701
integer y = 364
integer width = 1125
integer height = 444
boolean bringtotop = true
string dataobject = "dw_int_movsalidas5"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if row=0 then return
If dw_reubicacion.GetRow() <> 1 Then Return
String e_almacen,e_zona,tp
Dec{0} e_fila,e_altura
IF dw_reubicacion.GetRow() <> 0 Then
	
	e_almacen = f_valor_columna(This,row,"almacen")
	e_zona    = f_valor_columna(This,row,"zona")
	e_fila    = Dec(f_valor_columna(This,row,"fila"))
	e_altura  = Dec(f_valor_columna(This,row,"altura"))
		
	f_asignar_columna(dw_reubicacion,dw_reubicacion.GetRow(),"almacen",e_almacen)
	f_asignar_columna(dw_reubicacion,dw_reubicacion.GetRow(),"zona",e_zona)
	f_asignar_columna(dw_reubicacion,dw_reubicacion.GetRow(),"fila",String(e_fila))
	f_asignar_columna(dw_reubicacion,dw_reubicacion.GetRow(),"altura",String(e_altura))
	dw_reubicacion.SetFocus()
	dw_reubicacion.SetRow(dw_reubicacion.GetRow())
	dw_reubicacion.SetColumn("almacen")
	
END IF


end event

on doubleclicked;  dw_almlinubicahis.visible=TRUE
end on

type sle_numdoc from u_em_campo within w_int_movsalidas
integer x = 1129
integer y = 176
integer width = 238
integer taborder = 40
string mask = "#######"
string displaydata = "~r"
end type

event modificado;call super::modificado;Long movimientos

movimientos = ver_movimientos()

if movimientos <= 0 then
	MessageBox("Error", "Número de documento no existente. ~nSi desea generar un nuevo número de documento, pulse F5. ~nSi desea recuperar el último número de documento generado, pulse F4.")
end if

// recojo el cliente en caso de compras
IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="C" THEN
   integer registros
   string v_cliente
   registros = dw_3.RowCount()
   IF registros >0 THEN
      v_cliente = dw_3.GetItemString(1,"codtercero")
      sle_cliente.text = v_cliente
      st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,'C',sle_cliente.text)
   END IF
END IF
end event

type st_5 from statictext within w_int_movsalidas
integer x = 3067
integer y = 1056
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 21004543
boolean enabled = false
string text = "Disponible"
alignment alignment = right!
boolean border = true
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_int_movsalidas
boolean visible = false
integer x = 2693
integer y = 128
integer width = 123
integer height = 108
integer taborder = 220
boolean bringtotop = true
string dataobject = "report_int_movsalidas"
boolean livescroll = true
end type

type pb_borrar from upb_papelera within w_int_movsalidas
boolean visible = false
integer x = 3145
integer y = 864
integer width = 155
integer height = 136
integer taborder = 240
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;IF dw_3.getrow()=0 THEN
   pb_borrar.visible=FALSE
   Return
END IF

integer opcion
opcion=MessageBox("Proceso de borrado de datos","¿Borrar la Salida seleccionada?",question!, YesNo!,2)
IF opcion=2 THEN  Return
integer registros,x1,bien
string  cod_ubicacion,referencia
bien=0
registros = dw_almlinubicahis.RowCount()
IF registros=0 THEN 
   MessageBox("No Se Puede borrar la linea","No existen referencias en el historiico",exclamation!, Ok!,1)
   Return
END IF
  //------------------------//
  // Desactivacion de campos//
  //------------------------//

pb_borrar.visible                = FALSE       
dw_2.visible                     = FALSE
dw_3.enabled                     = FALSE

em_cantidad.visible              = FALSE

em_tono.visible                  = FALSE
pb_1.visible                     = FALSE
pb_borrar.visible                = FALSE
pb_calculo.visible               = FALSE
uo_articulo.visible             = FALSE
uo_calidad.visible              = FALSE
sle_observaciones.visible        = FALSE
dw_almlinubicahis.visible        = FALSE
st_1.visible                     = FALSE
st_texto_cantidad.visible        = FALSE
st_2.visible                     = FALSE
st_3.visible                     = FALSE
st_4.visible                     = FALSE
st_9.visible                     = FALSE
cb_1.visible                     = FALSE

em_fecha.enabled             = FALSE
uo_articulo.enabled         = FALSE
sle_cliente.enabled          = FALSE
sle_numdoc.enabled           = FALSE
sle_tipomov.enabled          = FALSE



dw_consulta_reubicacion.visible  = TRUE
dw_reubicacion.visible           = TRUE
cb_reubicar_borrar.visible        =TRUE
cb_reubicar_insertar.visible      =TRUE
cb_reubicar_procesar.visible      =TRUE
cb_reubicar_salir.visible         =TRUE



//-----------------------------//
// Valores movimiento a anular //
//-----------------------------//

  mov.empresa     =  dw_3.GetItemString(dw_3.getrow(),"empresa")
  mov.anyo        =  dw_3.GetItemNumber(dw_3.getrow(),"anyo")
  mov.almacen     =  dw_3.GetItemString(dw_3.getrow(),"almacen")
  mov.origen      =  dw_3.GetItemString(dw_3.getrow(),"origen")
  mov.articulo    =  dw_3.GetItemString(dw_3.getrow(),"articulo")
  mov.codtercero  =  dw_3.GetItemString(dw_3.getrow(),"codtercero")
  mov.numdoc      =  dw_3.GetItemString(dw_3.getrow(),"numdoc")
  mov.tipomov     =  dw_3.GetItemString(dw_3.getrow(),"tipomov")
  mov.origen      =  dw_3.GetItemString(dw_3.getrow(),"origen")
  mov.familia     =  dw_3.GetItemString(dw_3.getrow(),"familia")
  mov.sector      =  dw_3.GetItemString(dw_3.getrow(),"sector")
  mov.formato     =  dw_3.GetItemString(dw_3.getrow(),"formato")
  mov.modelo      =  dw_3.GetItemString(dw_3.getrow(),"modelo")
  mov.calidad     =  dw_3.GetItemString(dw_3.getrow(),"calidad")
  mov.tonochar    =  dw_3.GetItemString(dw_3.getrow(),"tonochar")
  mov.calibre     =  dw_3.GetItemNumber(dw_3.getrow(),"calibre")
  mov.tipo_unidad =  dw_3.GetItemString(dw_3.getrow(),"tipo_unidad")
  mov.referencia  =  dw_3.GetItemString(dw_3.getrow(),"referencia")
  mov.nummov      =  dw_3.GetItemNumber(dw_3.getrow(),"nummov")
  mov.tipo_pallet =  dw_3.GetItemString(dw_3.getrow(),"tipo_pallet")
  mov.caja        =  dw_3.GetItemString(dw_3.getrow(),"almmovhis_caja")
  v_cantidad      =  dw_3.GetItemNumber(dw_3.getrow(),"cantidads")

  mov.cantidads=v_cantidad* (-1)
  mov.cantidade=0


  dw_consulta_reubicacion.SetTransObject(SQLCA)
  dw_reubicacion.SetTransObject(SQLCA)
  dw_consulta_reubicacion.retrieve(codigo_empresa,mov.referencia)
  
  dw_reubicacion.retrieve()
  registros = dw_almlinubicahis.RowCount()
   FOR x1 = 1 To registros
   v_cantidad = dw_almlinubicahis.GetItemNumber(x1,"cantidad")
   v_fila     = dw_almlinubicahis.GetItemNumber(x1,"fila")
   v_altura   = dw_almlinubicahis.GetItemNumber(x1,"altura")
   dw_reubicacion.insertRow(x1)
   dw_reubicacion.setitem(x1,"cantidad",v_cantidad)
   dw_reubicacion.setitem(x1,"almacen",dw_almlinubicahis.GetItemString(x1,"almacen"))
   dw_reubicacion.setitem(x1,"zona",dw_almlinubicahis.GetItemString(x1,"zona"))
   dw_reubicacion.setitem(x1,"fila",v_fila)
   dw_reubicacion.setitem(x1,"altura",v_altura)
   dw_reubicacion.setitem(x1,"empresa",codigo_empresa)
   dw_reubicacion.setitem(x1,"tipo_unidad",mov.tipo_unidad)
   dw_reubicacion.setitem(x1,"almacen",mov.almacen)
 NEXT
  dw_reubicacion.SetFocus()
  contador=x1



end event

type dw_2 from datawindow within w_int_movsalidas
event key pbm_dwnkey
integer x = 1129
integer y = 380
integer width = 1915
integer height = 840
integer taborder = 120
string dataobject = "dw_int_movsalidas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;String referencia,tipo_pallet
IF this.getRow()<>0 THEN
 integer registros
 long linea
 linea     = dw_2.GetRow() 
 
 IF linea<>0 THEN
    registros = dw_2.RowCount()
    IF registros>0 THEN
      em_cantidad.text=String(GetItemNumber(GetRow(),"existencias"))
		em_pallet.text= ""
      em_cajas.text = ""    
    End If
    This.SelectRow(0,FALSE)
    This.SelectRow(getRow(),TRUE)
      uo_calidad.em_codigo.text =  GetItemString(dw_2.getRow(),"calidad")
      em_tono.text              =  String(GetItemString(dw_2.getRow(),"tonochar"))
      em_calibre.text           =  String(GetItemNumber(dw_2.getRow(),"calibre"))
		var_externo               =  String(GetItemString(dw_2.getRow(),"externo"))
		uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)

      referencia = This.getItemString(This.GetRow(),"referencia")
      tipo_pallet = This.getItemString(This.GetRow(),"tipo_pallet")
      
      em_disponible.text = String(f_disponible_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet))
      
      
  End If
End IF
 


end event

on getfocus;This.TriggerEvent(RowFocusChanged!)
end on

event clicked;if row=0 then return
//str_parametros valores
//CHOOSE CASE f_objeto_datawindow(This) 
//   CASE 'observacion'
//    IF dw_2.getitemString(row,"observacion") = "*" Then
//      valores.s_argumentos[1]=dw_2.getitemString(row,"referencia")
//      valores.s_argumentos[2]=dw_2.getitemString(row,"tipo_pallet")
//      OpenWithParm(w_observaciones_almlinubica,valores)  
//    END IF
//   CASE 'marca'
//    IF dw_2.getitemString(row,"marca") = "*" Then
//      valores.s_argumentos[1]=dw_2.getitemString(row,"referencia")
//      valores.s_argumentos[2]=dw_2.getitemString(row,"tipo_pallet")
//      OpenWithParm(w_observaciones_almlinubica,valores)
//    END IF
//
//END CHOOSE

end event

type dw_tipos_caja from datawindow within w_int_movsalidas
integer x = 37
integer y = 900
integer width = 983
integer height = 300
boolean bringtotop = true
string dataobject = "dw_cajas_articulo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_int_movsalidas
integer x = 9
integer y = 848
integer width = 1047
integer height = 372
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Tipos de caja del artículo (Información)"
end type

type st_formato from statictext within w_int_movsalidas
integer x = 370
integer y = 384
integer width = 370
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_reubicacion from datawindow within w_int_movsalidas
event key pbm_dwnkey
boolean visible = false
integer x = 5
integer y = 364
integer width = 1696
integer height = 444
boolean bringtotop = true
string dataobject = "dw_int_movsalidas2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event key;str_parametros param
String bus_campo,bus_cadena
This.AcceptText()
param.b_empresa = TRUE
param.s_nom_datawindow   =  ""

IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 param.s_criterio_busqueda=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "almacen"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 
      param.s_filtro            = ""
CASE "zona"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE TIPO DE ZONA "
 		param.s_nom_datawindow   =  "dw_ayuda_almubizonas"
      param.s_filtro            = "almacen='" + &
                                   This.GetItemString(This.GetRow(),"almacen") + "'"
CASE "cantidad"
   // Redondeo a cantidad 
   Dec{2} var_cantidad
   var_cantidad = This.GetItemNumber(This.GetRow(),"cantidad")
   This.SetItem(This.GetRow(),"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,dw_3.GetItemString(dw_3.GetRow(),"articulo"),dw_2.GetItemString(dw_2.GetRow(),"caja"),var_cantidad))
	SetNull(bus_campo)
            
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

// Ventanas de ayuda campos relacion de las datawindows
  String bus_cadena_return
  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
  bus_cadena = This.GetItemString(This.GetRow(),This.GetColumnName())
  IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""

IF KeyDown(KeyEnter!) OR (KeyDown(KeyTab!) and Trim(bus_cadena)<>"") THEN
  param.s_criterio_busqueda  = bus_cadena
  OpenWithParm(w_busquedas,param)

  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
  ELSE
     bus_cadena=bus_cadena_return
  END IF
  This.SetItem(This.getrow(),This.GetColumn(),bus_cadena)
  SetColumn(This.GetColumn())
  This.SetRow(This.getrow())
  This.Setfocus()
END IF
END IF


end event

on rbuttondown; str_parametros param
 String bus_campo,bus_cadena
 
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "almacen"
      param.s_titulo_ayuda    = "VENTANA SELECCION DE TIPO DE ALMACENES"
 		param.s_nom_datawindow  = "dw_ayuda_almacenes"
   CASE "zona"
      param.s_titulo_ayuda   = "VENTANA SELECCION DE ZONAS"
      param.s_nom_datawindow = "dw_ayuda_almubizonas"
      param.s_filtro         = "almacen ='"+This.GetItemString(This.GetRow(),"almacen")+"'"
  	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

// Ventanas de ayuda campos relacion de las datawindows

  String bus_cadena_return

  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
  bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
  IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""
  
  OpenWithParm(w_busquedas,param)
  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
 
 IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
     IF Not IsNumber(bus_cadena) Then
        bus_cadena=bus_cadena_return
     END IF
   ELSE
     bus_cadena=bus_cadena_return
  END IF

  This.SetItem(This.getrow(),This.GetColumn(),bus_cadena)
  SetColumn(This.GetColumn())
  This.SetRow(This.getrow())
  This.Setfocus()

end on

type dw_3 from datawindow within w_int_movsalidas
integer y = 1340
integer width = 3886
integer height = 952
string dataobject = "dw_int_movsalidas3"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;dw_almlinubicahis.visible=TRUE

end event

event clicked;IF row<>0 THEN
 integer registros
 registros = dw_3.RowCount()
 pb_borrar.visible = TRUE
 IF registros>0 THEN
 This.SelectRow(0,FALSE)
 This.SelectRow(row,TRUE)
 
  ubihis.anyo    =  GetItemNumber(row,"anyo")
  ubihis.almacen =  GetItemString(row,"almacen")
  ubihis.nummov  =  GetItemNumber(row,"nummov")
  dw_almlinubicahis.retrieve(codigo_empresa,ubihis.anyo,ubihis.almacen,ubihis.nummov)
 END IF
END IF
end event

type dw_almlinubicahis from datawindow within w_int_movsalidas
boolean visible = false
integer x = 87
integer y = 1372
integer width = 1143
integer height = 496
integer taborder = 230
boolean titlebar = true
string title = "Detalle ubicación de la linea "
string dataobject = "dw_int_movsalidas4"
boolean controlmenu = true
boolean vscrollbar = true
end type

type st_6 from statictext within w_int_movsalidas
integer x = 1518
integer y = 112
integer width = 96
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F4"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_int_movsalidas
integer x = 1509
integer y = 176
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Insert!"
end type

event clicked;String alm_empresa,alm_tipomov
Dec alm_anyo,alm_numdoc

alm_empresa    =  codigo_empresa
alm_anyo       =  Year(Date(em_fecha.text))
alm_tipomov    =  sle_tipomov.text
alm_numdoc     =  Dec(sle_numdoc.text)

if sle_tipomov.text = "" then
	MessageBox("Error", "Por favor, seleccione un tipo de movimiento")
	return
end if

SELECT max(convert(dec,almmovhis.numdoc))INTO :alm_numdoc  
FROM    almmovhis  
WHERE  almmovhis.empresa = :alm_empresa 
AND    almmovhis.anyo    = :alm_anyo 
AND    almmovhis.tipomov = :alm_tipomov 
AND    almmovhis.numdoc   between "0" and "999999999999999";
IF SQLCA.SQLCode<>0 THEN  alm_numdoc=0
IF IsNull(alm_numdoc)   Then alm_numdoc = 0
alm_numdoc      = alm_numdoc
if alm_numdoc = 0 then
	MessageBox("Info","No hay ningún número de documento generado para el año y el tipo de movimiento seleccionado. Por favor, pulse F5 para generar un nuevo número de documento.")
	return
end if
sle_numdoc.text = string(alm_numdoc,"###########")
ver_movimientos()
sle_numdoc.SetFocus()
end event

type st_fecha from statictext within w_int_movsalidas
integer x = 41
integer y = 188
integer width = 201
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
boolean focusrectangle = false
end type

type st_7 from statictext within w_int_movsalidas
integer y = 120
integer width = 3849
integer height = 2252
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "NO USAR - OBSOLETO "
alignment alignment = center!
boolean focusrectangle = false
end type

