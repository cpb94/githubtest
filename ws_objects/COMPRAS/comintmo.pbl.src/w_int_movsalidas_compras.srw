$PBExportHeader$w_int_movsalidas_compras.srw
forward
global type w_int_movsalidas_compras from w_int_con_empresa
end type
type st_fecha from statictext within w_int_movsalidas_compras
end type
type pb_1 from upb_salir within w_int_movsalidas_compras
end type
type st_tipomov from statictext within w_int_movsalidas_compras
end type
type st_nombre_tipomov from statictext within w_int_movsalidas_compras
end type
type st_documento from statictext within w_int_movsalidas_compras
end type
type st_cliente_etiqueta from statictext within w_int_movsalidas_compras
end type
type st_nombre_cliente from statictext within w_int_movsalidas_compras
end type
type em_fecha from u_em_campo within w_int_movsalidas_compras
end type
type sle_tipomov from u_em_campo within w_int_movsalidas_compras
end type
type cb_reubicar_insertar from u_boton within w_int_movsalidas_compras
end type
type cb_reubicar_procesar from u_boton within w_int_movsalidas_compras
end type
type cb_reubicar_salir from u_boton within w_int_movsalidas_compras
end type
type cb_reubicar_borrar from u_boton within w_int_movsalidas_compras
end type
type sle_cliente from u_em_campo within w_int_movsalidas_compras
end type
type dw_proceso from datawindow within w_int_movsalidas_compras
end type
type st_1 from statictext within w_int_movsalidas_compras
end type
type st_2 from statictext within w_int_movsalidas_compras
end type
type st_9 from statictext within w_int_movsalidas_compras
end type
type sle_observaciones from u_em_campo within w_int_movsalidas_compras
end type
type st_texto_cantidad from statictext within w_int_movsalidas_compras
end type
type em_cantidad from u_em_campo within w_int_movsalidas_compras
end type
type cb_1 from u_boton within w_int_movsalidas_compras
end type
type uo_mp from u_em_campo_2 within w_int_movsalidas_compras
end type
type uo_calidad from u_em_campo_2 within w_int_movsalidas_compras
end type
type pb_calculo from u_calculadora within w_int_movsalidas_compras
end type
type st_disponible from statictext within w_int_movsalidas_compras
end type
type pb_imprimir from upb_imprimir within w_int_movsalidas_compras
end type
type em_disponible from statictext within w_int_movsalidas_compras
end type
type st_tecla from statictext within w_int_movsalidas_compras
end type
type dw_consulta_reubicacion from datawindow within w_int_movsalidas_compras
end type
type dw_almlinubicahis from datawindow within w_int_movsalidas_compras
end type
type sle_numdoc from u_em_campo within w_int_movsalidas_compras
end type
type dw_listado from datawindow within w_int_movsalidas_compras
end type
type pb_borrar from upb_papelera within w_int_movsalidas_compras
end type
type dw_3 from datawindow within w_int_movsalidas_compras
end type
type dw_2 from datawindow within w_int_movsalidas_compras
end type
type dw_reubicacion from datawindow within w_int_movsalidas_compras
end type
type st_3 from statictext within w_int_movsalidas_compras
end type
end forward

global type w_int_movsalidas_compras from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2889
integer height = 1612
string icon = "Application!"
st_fecha st_fecha
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
st_1 st_1
st_2 st_2
st_9 st_9
sle_observaciones sle_observaciones
st_texto_cantidad st_texto_cantidad
em_cantidad em_cantidad
cb_1 cb_1
uo_mp uo_mp
uo_calidad uo_calidad
pb_calculo pb_calculo
st_disponible st_disponible
pb_imprimir pb_imprimir
em_disponible em_disponible
st_tecla st_tecla
dw_consulta_reubicacion dw_consulta_reubicacion
dw_almlinubicahis dw_almlinubicahis
sle_numdoc sle_numdoc
dw_listado dw_listado
pb_borrar pb_borrar
dw_3 dw_3
dw_2 dw_2
dw_reubicacion dw_reubicacion
st_3 st_3
end type
global w_int_movsalidas_compras w_int_movsalidas_compras

type variables
  integer contador
  integer v_fila,v_altura,anyo
  String v_almacen
  string   v_zona,v_familia,v_sector,var_externo
  decimal{4} v_cantidad
  string ante_codigo_articulo,ante_codigo_calidad,ante_tono
  int bienp = 0
 int continuar 
boolean control_tono,control_calibre
  

// Defino la estructura de la tablas a procesar
   str_comlinubicahis  ubihis
   str_comlinubica      ubi
   str_commovhis        mov


end variables

forward prototypes
public subroutine ver_movimientos ()
public subroutine f_proceso ()
end prototypes

public subroutine ver_movimientos ();dw_3.retrieve(codigo_empresa,year(date(em_fecha.text)),sle_tipomov.text,sle_numdoc.text)
end subroutine

public subroutine f_proceso ();long indice,indice2,retardo,indice1,total
real cantidad,disponible

string mp,var_descripcion

total = (istr_parametros.i_nargumentos - 1)
istr_parametros.i_nargumentos  = 0
		continuar = 0
		//////////////////////////////
		sle_tipomov.setfocus()
		sle_tipomov.text = "209"
		sle_tipomov.triggerevent("modificado")
		do
		loop until continuar = 1
		continuar = 0
		pb_calculo.triggerevent(clicked!)
		do
		loop until continuar = 1
		continuar = 0
		sle_observaciones.text = "Salida Automatica Generada desde Entrada de Formulación"
		for indice = 1 to total
			mp = trim(istr_parametros.s_argumentos[indice * 2])
			uo_mp.em_codigo.setfocus()
			uo_mp.em_codigo.text = mp
			uo_mp.triggerevent("modificado")
			do
			loop until continuar = 1
			continuar = 0
			cantidad = real(istr_parametros.s_argumentos[(indice * 2) +1])/1000
			cantidad = cantidad / f_equivalencia_kg_mp (codigo_empresa , mp)
			if (cantidad - round (cantidad,0)) > 0.4 then 
				cantidad = (round (cantidad,0)) + 1
			else
				cantidad = round (cantidad,0)
			end if
			if cantidad = 0 then cantidad = 1
			if dw_2.rowcount() >0 then
				if dw_2.getitemnumber(1,"total_existencias") >= cantidad then
					do
						dw_2.setrow(indice2)
						if dw_2.getitemnumber(1,"existencias") >= cantidad then
							dw_2.TriggerEvent(RowFocusChanged!)
							do
							loop until continuar = 1
							continuar = 0
							em_cantidad.setfocus()
							em_cantidad.text = string(cantidad)
							cantidad = 0
						else
							dw_2.TriggerEvent(RowFocusChanged!)
							do
							loop until continuar = 1
							continuar = 0
							em_cantidad.setfocus()
							em_cantidad.text = string(dw_2.getitemnumber(1,"existencias"))
							cantidad = cantidad - dw_2.getitemnumber(1,"existencias")
						end if
						cb_1.triggerevent(clicked!)
						do
						loop until continuar = 1
						continuar = 0
					loop until cantidad = 0
				end if
			end if
		next


end subroutine

event ue_f6;call super::ue_f6;//IF pb_imprimir.visible = FALSE  Then   Return
em_disponible.TriggerEvent(clicked!)
end event

on ue_f5;call w_int_con_empresa::ue_f5;IF pb_calculo.visible = FALSE  Then   Return
pb_calculo.TriggerEvent(clicked!)
end on

event open;call super::open;string mp,var_descripcion
long indice
real cantidad,disponible

istr_parametros.s_titulo_ventana="Introduccion Movimientos Salida almacen de compras"
This.title=istr_parametros.s_titulo_ventana
em_fecha.text=string(today())

// preparo datawindow ubicaciones
dw_2.settransobject(SQLCA)
dw_3.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_almlinubicahis.SetTransObject(SQLCA)

IF istr_parametros.i_nargumentos > 1 THEN
	for indice= 1 to (istr_parametros.i_nargumentos - 1)
		mp = trim(istr_parametros.s_argumentos[indice * 2])
		cantidad = real(istr_parametros.s_argumentos[(indice * 2) +1])/1000
		cantidad = cantidad / f_equivalencia_kg_mp (codigo_empresa,mp)
		disponible = f_existencias_mp (codigo_empresa,mp)		
		if disponible < cantidad then
			select descripcion
			Into   :var_descripcion
			from   venmprima
			Where  venmprima.empresa  =  :codigo_empresa
			And    venmprima.codigo   =  :mp;
			bienp = 1
			messagebox("Error en proceso automatico:","No puede generar la salida automatica~npor falta de stock del Articulo:~n"+var_descripcion)
		end if
	next
else	
	bienp = 1
end if


end event

on w_int_movsalidas_compras.create
int iCurrent
call super::create
this.st_fecha=create st_fecha
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
this.st_1=create st_1
this.st_2=create st_2
this.st_9=create st_9
this.sle_observaciones=create sle_observaciones
this.st_texto_cantidad=create st_texto_cantidad
this.em_cantidad=create em_cantidad
this.cb_1=create cb_1
this.uo_mp=create uo_mp
this.uo_calidad=create uo_calidad
this.pb_calculo=create pb_calculo
this.st_disponible=create st_disponible
this.pb_imprimir=create pb_imprimir
this.em_disponible=create em_disponible
this.st_tecla=create st_tecla
this.dw_consulta_reubicacion=create dw_consulta_reubicacion
this.dw_almlinubicahis=create dw_almlinubicahis
this.sle_numdoc=create sle_numdoc
this.dw_listado=create dw_listado
this.pb_borrar=create pb_borrar
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_reubicacion=create dw_reubicacion
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_fecha
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_tipomov
this.Control[iCurrent+4]=this.st_nombre_tipomov
this.Control[iCurrent+5]=this.st_documento
this.Control[iCurrent+6]=this.st_cliente_etiqueta
this.Control[iCurrent+7]=this.st_nombre_cliente
this.Control[iCurrent+8]=this.em_fecha
this.Control[iCurrent+9]=this.sle_tipomov
this.Control[iCurrent+10]=this.cb_reubicar_insertar
this.Control[iCurrent+11]=this.cb_reubicar_procesar
this.Control[iCurrent+12]=this.cb_reubicar_salir
this.Control[iCurrent+13]=this.cb_reubicar_borrar
this.Control[iCurrent+14]=this.sle_cliente
this.Control[iCurrent+15]=this.dw_proceso
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.st_9
this.Control[iCurrent+19]=this.sle_observaciones
this.Control[iCurrent+20]=this.st_texto_cantidad
this.Control[iCurrent+21]=this.em_cantidad
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.uo_mp
this.Control[iCurrent+24]=this.uo_calidad
this.Control[iCurrent+25]=this.pb_calculo
this.Control[iCurrent+26]=this.st_disponible
this.Control[iCurrent+27]=this.pb_imprimir
this.Control[iCurrent+28]=this.em_disponible
this.Control[iCurrent+29]=this.st_tecla
this.Control[iCurrent+30]=this.dw_consulta_reubicacion
this.Control[iCurrent+31]=this.dw_almlinubicahis
this.Control[iCurrent+32]=this.sle_numdoc
this.Control[iCurrent+33]=this.dw_listado
this.Control[iCurrent+34]=this.pb_borrar
this.Control[iCurrent+35]=this.dw_3
this.Control[iCurrent+36]=this.dw_2
this.Control[iCurrent+37]=this.dw_reubicacion
this.Control[iCurrent+38]=this.st_3
end on

on w_int_movsalidas_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_fecha)
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
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_9)
destroy(this.sle_observaciones)
destroy(this.st_texto_cantidad)
destroy(this.em_cantidad)
destroy(this.cb_1)
destroy(this.uo_mp)
destroy(this.uo_calidad)
destroy(this.pb_calculo)
destroy(this.st_disponible)
destroy(this.pb_imprimir)
destroy(this.em_disponible)
destroy(this.st_tecla)
destroy(this.dw_consulta_reubicacion)
destroy(this.dw_almlinubicahis)
destroy(this.sle_numdoc)
destroy(this.dw_listado)
destroy(this.pb_borrar)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_reubicacion)
destroy(this.st_3)
end on

event activate;call super::activate;w_int_movsalidas_compras = ventanas_activas[id_ventana_activa].ventana
IF istr_parametros.i_nargumentos > 1 THEN
	if bienp = 0 then
		f_proceso()
		pb_imprimir.triggerevent(clicked!)
	else
		istr_parametros.i_nargumentos = 0
	end if
END IF

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_movsalidas_compras
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_movsalidas_compras
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_movsalidas_compras
integer x = 9
integer y = 8
integer width = 2501
integer height = 96
integer textsize = -11
end type

type st_fecha from statictext within w_int_movsalidas_compras
integer x = 82
integer y = 172
integer width = 247
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
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_movsalidas_compras
integer x = 2400
integer y = 148
integer width = 119
integer height = 100
integer taborder = 0
alignment htextalign = right!
end type

type st_tipomov from statictext within w_int_movsalidas_compras
integer x = 37
integer y = 264
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

type st_nombre_tipomov from statictext within w_int_movsalidas_compras
integer x = 649
integer y = 268
integer width = 951
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

type st_documento from statictext within w_int_movsalidas_compras
integer x = 704
integer y = 168
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

type st_cliente_etiqueta from statictext within w_int_movsalidas_compras
boolean visible = false
integer x = 1637
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

type st_nombre_cliente from statictext within w_int_movsalidas_compras
boolean visible = false
integer x = 2025
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

type em_fecha from u_em_campo within w_int_movsalidas_compras
integer x = 357
integer y = 164
integer width = 283
integer taborder = 20
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

on modified;call u_em_campo::modified;ver_movimientos()

end on

type sle_tipomov from u_em_campo within w_int_movsalidas_compras
integer x = 352
integer y = 260
integer width = 288
integer taborder = 30
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de tipos de movimientos de compras"
ue_datawindow = "dw_ayuda_comtipomov"
ue_filtro     = "interno = 'N' and codigo_real = 'S'"
end event

event modificado;call super::modificado;st_nombre_tipomov.text=f_nombre_comtipomov(codigo_empresa,sle_tipomov.text)
IF f_interno_comtipomov(codigo_empresa,sle_tipomov.text)= "S" Or&
    f_codigo_real_comtipomov(codigo_empresa,sle_tipomov.text)<> "S"  Then
    sle_tipomov.text="" 
    st_nombre_tipomov.text = ""
END IF

ver_movimientos()

// Para Entradas de compras saco el cliente

string tipo
tipo = f_tipo_comtipomov(codigo_empresa,sle_tipomov.text) 
IF tipo = "C"  or tipo = "P" THEN
   st_nombre_cliente.visible  = TRUE
   if tipo="P" then st_cliente_etiqueta.text = "Proveedor"
	sle_cliente.visible        = TRUE
   st_cliente_etiqueta.visible= TRUE

 ELSE
   st_nombre_cliente.visible  = FALSE
   sle_cliente.visible        = FALSE
   st_cliente_etiqueta.visible= FALSE
END IF

continuar = 1



end event

on rbuttondown;call u_em_campo::rbuttondown;if TRIM(st_nombre_tipomov.text)="" THEN
		istr_parametros.s_titulo_ventana = "Ayuda seleccion de tipos de movimientos"
		istr_parametros.s_nom_datawindow = "dw_ayuda_almtipomov_salidas"
      f_buscar(sle_tipomov,istr_parametros)
end if
end on

type cb_reubicar_insertar from u_boton within w_int_movsalidas_compras
boolean visible = false
integer x = 9
integer y = 812
integer width = 425
integer height = 84
integer taborder = 130
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
       mensaje = "Esta entrada ha de ubicarse en el mismo almacen "
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

type cb_reubicar_procesar from u_boton within w_int_movsalidas_compras
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
  MessageBox("No Puedo Procesar","La cantidad no coincide",Exclamation!, OK!,1)
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
 ubihis.mp		      = mov.mp
 ubihis.calidad      = mov.calidad
 ubihis.fecha        = DateTime(today(),Now())
 ubihis.f_alta       = DateTime(today(),Now())
// ***???
 ubihis.tipomov      = "201" 
 ubihis.familia      = mov.familia
 ubihis.tipo_unidad  = mov.tipo_unidad

ubi.empresa    =  ubihis.empresa
ubi.almacen    =  ubihis.almacen
ubi.mp		   =  ubihis.mp
ubi.familia    =  ubihis.familia
ubi.calidad    =  ubihis.calidad
ubi.tipo_unidad=  ubihis.tipo_unidad
ubi.f_alta     =  DateTime(today(),now())

//-------------------------------------------------------------------

 titulo        =  Parent.title
 IF NOT f_bloquear_almacen_compras(titulo) THEN
  contador_orden = f_comparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))
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
IF Not f_insert_comlinubicahis(ubihis) Then bien=1   
//-----------------------------------------------------------------------
// Variables para cargar el cursor
//-----------------------------------------------------------------------
      dec cur_pedido,cur_linea,cur_anyo
      String  cur_empresa,cur_almacen
      decimal{2}  cur_existencias
      string      cur_referencia,cur_ubicacion,cur_observaciones,cur_tipo_pallet
//-----------------------------------------------------------
// Busco si hay linea este articulo sin reservar
//-----------------------------------------------------------
dec x1,registros
registros= dw_proceso.Retrieve(ubi.empresa,ubi.ubicacion,ubi.mp,ubi.calidad)

 // Variable de controles 0-> no grabado 1-> si grabado
 dec grabado,salir
 grabado=0
 salir  =0
IF registros<>0 Then
For x1= 1 to registros
  cur_linea         = dw_proceso.GetItemNumber(x1,"linea")
  cur_existencias   = dw_proceso.GetItemNumber(x1,"existencias")
  cur_observaciones = dw_proceso.GetItemString(x1,"observaciones")
  IF IsNUll(cur_existencias) Then cur_existencias =0
   ubi.existencias=ubi.existencias + cur_existencias
   grabado = 1
   UPDATE comlinubica  
   SET existencias   = :ubi.existencias,   
   f_alta            = :ubi.f_alta
   WHERE ( comlinubica.empresa   = :ubi.empresa ) AND  
         ( comlinubica.ubicacion = :ubi.ubicacion ) AND  
         ( comlinubica.linea     = :cur_linea ) USING SQLCA;
   IF SQLCA.SQLCode<>0 THEN    bien=1
   EXIT
NEXT
END IF

// Insercion nueva linea de ubicacion
IF grabado=0 THEN
 SELECT    max(comlinubica.linea)  
    INTO   :cur_linea  
    FROM   comlinubica  
   WHERE  comlinubica.empresa   = :ubi.empresa 
	AND    comlinubica.ubicacion = :ubi.ubicacion;   
   IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN cur_linea = 0 
    cur_linea       = cur_linea+1
    ubi.linea       = cur_linea
    ubi.almacen     = ubihis.almacen
    ubi.zona        = ubihis.zona
    ubi.fila        = ubihis.fila
    ubi.altura      = ubihis.altura
    ubi.mp		     = ubihis.mp
    ubi.familia     = ubihis.familia
    ubi.calidad     = ubihis.calidad
    ubi.existencias = ubihis.cantidade

    ubi.tipo_unidad  = ubihis.tipo_unidad
    ubi.f_alta       = Datetime(today(),now())
    SetNull(ubi.observaciones)
	 IF Not f_insert_comlinubica(ubi) THEN bien=1
END IF

//-----------------------Fin Grabación Lineas de Ubicacion--------------

// el contador incrementa uno para cada linea
contador_orden = contador_orden + 1 

NEXT
   UPDATE commovhis  
   SET     situacion = 'A',
	        origen    = :mov.origen
   WHERE  commovhis.empresa = :codigo_empresa 
	AND    commovhis.almacen = :mov.almacen 
	AND    commovhis.anyo    = :mov.anyo
	AND    commovhis.nummov  = :mov.nummov;
      IF SQLCA.SQLCODE <> 0 Then 
          bien = 1
      END IF

 IF NOT f_actualiza_numorden_compras(ubihis.empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
      bien=1
 END IF


 titulo        =  Parent.title
 longitud      =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
 anyo          =  Year(Date(em_fecha.text))
 longitud      =  len(trim(string(anyo)))
 criterio[2]   =  trim(string(anyo))+space(20-longitud)
 seleccion     =  criterio[1]+criterio[2]
 tabla         =  "comparam" 

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
  f_desbloquear_almacen_compras(titulo)
  COMMIT;

ELSE
 pb_1.enabled=TRUE
 Return
END IF
pb_1.enabled=TRUE

cb_reubicar_salir.TriggerEvent(Clicked!)
end event

type cb_reubicar_salir from u_boton within w_int_movsalidas_compras
boolean visible = false
integer x = 855
integer y = 812
integer width = 421
integer height = 84
integer taborder = 110
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;  //------------------------//
  // Activarn de campos//
  //------------------------//


dw_2.visible                     = TRUE
dw_3.enabled                     = TRUE

em_cantidad.visible              = TRUE

pb_1.visible                     = TRUE
pb_calculo.visible               = TRUE
uo_mp.visible              = TRUE
uo_calidad.visible               = TRUE
sle_observaciones.visible        = TRUE
st_1.visible                     = TRUE
st_texto_cantidad.visible        = TRUE
st_2.visible                     = TRUE

st_9.visible                     = TRUE
cb_1.visible                     = TRUE

em_fecha.enabled             = TRUE
uo_mp.enabled         		  = TRUE
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
uo_mp.em_campo.Setfocus()
end event

type cb_reubicar_borrar from u_boton within w_int_movsalidas_compras
boolean visible = false
integer x = 434
integer y = 812
integer width = 421
integer height = 84
integer taborder = 90
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

type sle_cliente from u_em_campo within w_int_movsalidas_compras
boolean visible = false
integer x = 1637
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

type dw_proceso from datawindow within w_int_movsalidas_compras
boolean visible = false
integer x = 5
integer y = 144
integer width = 654
integer height = 168
integer taborder = 160
boolean bringtotop = true
string dataobject = "dw_proceso_comlinubica"
boolean livescroll = true
end type

type st_1 from statictext within w_int_movsalidas_compras
integer x = 9
integer y = 364
integer width = 951
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Materia Prima"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_movsalidas_compras
integer x = 965
integer y = 364
integer width = 91
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_movsalidas_compras
integer x = 18
integer y = 828
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

type sle_observaciones from u_em_campo within w_int_movsalidas_compras
integer x = 471
integer y = 820
integer width = 1737
integer taborder = 140
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type st_texto_cantidad from statictext within w_int_movsalidas_compras
integer x = 2098
integer y = 364
integer width = 421
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad from u_em_campo within w_int_movsalidas_compras
integer x = 2094
integer y = 440
integer width = 425
integer taborder = 120
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###.00"
end type

type cb_1 from u_boton within w_int_movsalidas_compras
integer x = 2249
integer y = 536
integer width = 270
integer height = 84
integer taborder = 150
string text = "&Ok"
end type

event clicked;//CONTROLES DE VALORES


string mensaje
Dec{2}  var_conjunto

IF trim(em_fecha.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
	continuar = 1
   RETURN
END IF

IF trim(sle_tipomov.text)=""  or IsNull(sle_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
	continuar = 1
   RETURN
END IF

st_nombre_tipomov.text=f_nombre_comtipomov(codigo_empresa,sle_tipomov.text)

IF trim(st_nombre_tipomov.text)="" or IsNull(st_nombre_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento no existe"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
	continuar = 1
   RETURN
END IF

IF trim(sle_numdoc.text)="" THEN
   mensaje="Introduzca el Numero de Dmto"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_numdoc.Setfocus()
	continuar = 1
   RETURN
END IF

IF trim(uo_mp.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_mp.em_campo.Setfocus()
	continuar = 1
   RETURN
END IF

IF trim(uo_calidad.em_campo.text)="" THEN
	mensaje="Introduzca la calidad"
	MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
	uo_calidad.em_campo.Setfocus()
	continuar = 1
	RETURN 
END IF

IF dw_2.GetRow() =0 Then
   mensaje="Marcar Una Ubicacion"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   dw_2.SetFocus()
	continuar = 1
   RETURN
END IF

// control bloqueo promocion
string v_ubicacion
dec v_linea
v_ubicacion = dw_2.GetItemString(dw_2.getRow(),"ubicacion")
v_linea     = dw_2.GetItemNumber(dw_2.getRow(),"linea")


// controlo las existencias disponibles

IF Dec(em_cantidad.text) > dw_2.GetItemNumber(dw_2.GetRow(),"existencias") then
	f_mensaje("Advertencia","No existen existencias suficientes")
	f_activar_campo(em_cantidad)
	continuar = 1
	Return
END IF

IF Dec(em_cantidad.text)=0 or trim(em_cantidad.text)="" THEN
	mensaje="Introduzca nº total de cantidad"
	MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
	em_cantidad.SetFocus()
	continuar = 1
	RETURN
END IF


IF Not f_bloquear_almacen_compras(w_int_movsalidas_compras.title) Then
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
 ubihis.mp		       = uo_mp.em_codigo.text
 ubihis.calidad       = uo_calidad.em_codigo.text
 ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
 ubihis.f_alta        = Datetime(today(),now())
 ubihis.observaciones = sle_observaciones.text
 ubihis.tipomov       = sle_tipomov.text
  
 SELECT  venmprima.familia, venmprima.tipo_unidad  
    INTO :ubihis.familia,:ubihis.tipo_unidad  
    FROM venmprima  
   WHERE (venmprima.empresa = :ubihis.empresa ) AND  
         (venmprima.codigo  = :ubihis.mp ) ;

   IF SQLCA.SQLCode<>0 THEN 
		f_mensaje("selección de datos de la mp","Error: "+sqlca.sqlerrtext)
		bien=1
	END IF

ubi.empresa     =  ubihis.empresa
ubi.almacen     =  ubihis.almacen
ubi.mp		    =  ubihis.mp
ubi.familia     =  ubihis.familia
ubi.calidad     =  ubihis.calidad
ubi.tipo_unidad  =  ubihis.tipo_unidad
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
mov.origen           = "4" //***?????
mov.mp		         = ubihis.mp
mov.fechmov          = ubihis.fecha
mov.tipomov          = ubihis.tipomov
mov.cantidade        = ubihis.cantidade
mov.cantidads        = ubihis.cantidads

mov.codtercero       = sle_cliente.text
mov.numdoc           = sle_numdoc.text
mov.situacion        = "N"
mov.observaciones    = ubihis.observaciones
mov.familia        = ubihis.familia
mov.calidad        = ubihis.calidad
mov.tipo_unidad    = ubihis.tipo_unidad
mov.f_alta         = DateTime(today(),now())
//-------------------------------------------------------------------
v_almacen = dw_2.GetItemString(dw_2.GetRow(),"almacen")
  
  ubihis.orden   = f_comparam_numorden(codigo_empresa,Year(date(em_fecha.text)))
  ubihis.nummov  = f_comparam_nummov(codigo_empresa,Year(Date(em_fecha.text)))
  mov.nummov=ubihis.nummov    
// Variables para cargar el cursor

      dec cur_pedido,cur_linea,cur_anyo
      String  cur_empresa,cur_almacen

      decimal{4}  cur_existencias,cantidad_pendiente,cantidad_borrada
      string  cur_referencia,cur_ubicacion,cur_tipo_pallet,cur_caja


   // Primero actualizo la salida global //
  //-------------------------------------//
  // En el historico de ubicaciones
  	IF NOT f_insert_comlinubicahis(ubihis) Then  
		bien=1
		f_mensaje("Insertar en comlinubicahis","Error: "+sqlca.sqlerrtext)
	END IF
   IF NOT f_actualiza_numorden_compras(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
     bien=1
	  f_mensaje("Función f_actualiza_numorden_compras","Error: "+sqlca.sqlerrtext)
   END IF
//----------------------------------------------
// Borro en las ubicaciones correspondientes
//----------------------------------------------

dec Registros,x1=0
registros = dw_proceso.retrieve(ubi.empresa,ubi.ubicacion,ubi.mp,ubi.calidad)
cantidad_borrada=0


If registros<>0 Then

 For x1 = 1 To Registros
    cur_linea         =  dw_proceso.GetItemNumber(x1,"linea")
    cur_existencias   =  dw_proceso.GetItemNumber(x1,"existencias")
 
      cantidad_pendiente = Dec(em_cantidad.text) - cantidad_borrada
      IF cantidad_pendiente = 0 THEN   EXIT
      IF cantidad_pendiente>= cur_existencias THEN 
         cantidad_borrada=cantidad_borrada + cur_existencias
         DELETE FROM comlinubica
         WHERE ( comlinubica.empresa   = :ubi.empresa ) AND  
               ( comlinubica.ubicacion = :ubi.ubicacion ) AND  
               ( comlinubica.linea     = :cur_linea ) USING SQLCA   ;
         IF SQLCA.SQLCode<>0 THEN 
				bien=1
				f_mensaje("Borrando de comlinubica","Error: "+sqlca.sqlerrtext)
			END IF
      ELSE
         cur_existencias = cur_existencias - cantidad_pendiente
         cantidad_borrada = cantidad_borrada + cantidad_pendiente
         UPDATE comlinubica  
         SET existencias = :cur_existencias  
         WHERE (comlinubica.empresa   = :ubi.empresa ) AND  
               (comlinubica.ubicacion = :ubi.ubicacion ) AND  
               (comlinubica.linea     = :cur_linea )USING SQLCA;
         IF SQLCA.SQLCode<>0 THEN 
				bien=1
				f_mensaje("Actualizando comlinubica","Error: "+sqlca.sqlerrtext)
			END IF
	 END IF

NEXT
END IF

IF cantidad_borrada <> Dec(em_cantidad.text) THEN  
	bien=1
	messagebox(" ERROR "," cantidad_borrada <> Dec(em_cantidad.text) ")
END IF


// Grabo el movimiento en el historico
  IF NOT f_insert_commovhis(mov) Then 
		bien=1
		f_mensaje("Función f_insert_commovhis","Error: "+sqlca.sqlerrtext)
	END IF
  IF NOT f_actualiza_nummov_compras(mov.empresa,mov.anyo,mov.nummov) THEN  
		bien=1
		f_mensaje("Función f_actualiza_nummov_compras","Error: "+sqlca.sqlerrtext)
	END IF
  CHOOSE CASE bien
	CASE 1
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	CASE 0
     COMMIT USING SQLCA;
   CASE ELSE
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso , case else","Error en proceso no se actualiza",Exclamation!, OK!,1)
  END CHOOSE
  f_desbloquear_almacen_compras(w_int_movsalidas_compras.title)
pb_1.enabled=TRUE
ver_movimientos()
em_cantidad.text=""
uo_mp.em_campo.text=""
uo_calidad.em_campo.text=""
uo_mp.em_codigo.text=""
em_disponible.text = ""
dw_2.retrieve(codigo_empresa,"")
uo_mp.em_campo.SetFocus()
END IF
continuar = 1
end event

type uo_mp from u_em_campo_2 within w_int_movsalidas_compras
integer x = 14
integer y = 440
integer width = 951
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_descripcion

select descripcion,tipo_unidad
Into   :var_descripcion,:var_tipo_unidad
from   venmprima
Where  venmprima.empresa  =  :codigo_empresa
And    venmprima.codigo   =  :uo_mp.em_codigo.text;

uo_mp.em_campo.text = var_descripcion
IF Trim(uo_mp.em_campo.text)="" THEN 
 IF Trim(uo_mp.em_codigo.text)<>"" Then 
	 uo_mp.em_campo.text=""
	 uo_mp.em_codigo.text=""
	 uo_mp.em_campo.SetFocus()
	 continuar = 1
	 Return
 End if
END IF


// Visualiza las lineas de ubicación a nivel de materia prima

   If trim(uo_mp.em_campo.text)<>"" Then
      STRING is_filtro = ""
      dw_2.SetFilter(is_filtro)
      dw_2.Filter()  
      dw_2.retrieve(codigo_empresa,uo_mp.em_codigo.text)
   End If

   st_texto_cantidad.text = f_nombre_unidad_com(var_tipo_unidad)
	em_cantidad.Setmask(NumericMask!,f_mascara_unidad_com(var_tipo_unidad))
	f_mascara_columna(dw_2,"existencias",f_mascara_unidad_com(var_tipo_unidad))

   
continuar = 1
end event

event getfocus;call super::getfocus;ante_codigo_articulo = uo_mp.em_codigo.text

ue_titulo     = "Ayuda seleccion de materias primas"
ue_datawindow = "dw_ayuda_venmprima"
ue_filtro     = ""
end event

on uo_mp.destroy
call u_em_campo_2::destroy
end on

type uo_calidad from u_em_campo_2 within w_int_movsalidas_compras
integer x = 965
integer y = 440
integer width = 91
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text)<>"" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text=""
 uo_calidad.em_codigo.text=""
END IF

// Visualiza las lineas de ubicación a nivel de articulo-calidad

if ante_codigo_calidad<>uo_calidad.em_codigo.text Then

   if trim(uo_calidad.em_campo.text)<>"" Then
      STRING is_filtro = ""
      if trim(uo_mp.em_codigo.text)<>"" then
       	is_filtro = " calidad = '" + uo_calidad.em_codigo.text + "'"
	      dw_2.SetFilter(is_filtro)
         dw_2.Filter()
         dw_2.retrieve(codigo_empresa,uo_mp.em_codigo.text)
      End If
    End If
End if
end event

on getfocus;call u_em_campo_2::getfocus;ante_codigo_calidad = uo_calidad.em_codigo.text

ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type pb_calculo from u_calculadora within w_int_movsalidas_compras
integer x = 1403
integer y = 164
integer taborder = 0
end type

event clicked;String alm_empresa,alm_tipomov
Dec alm_anyo,alm_numdoc

alm_empresa    =  codigo_empresa
alm_anyo       =  Year(Date(em_fecha.text))
alm_tipomov    =  sle_tipomov.text
alm_numdoc     =  Dec(sle_numdoc.text)

SELECT max(convert(dec,commovhis.numdoc))INTO :alm_numdoc  
FROM    commovhis
WHERE  commovhis.empresa = :alm_empresa 
AND    commovhis.anyo    = :alm_anyo 
AND    commovhis.tipomov = :alm_tipomov ;
IF SQLCA.SQLCode<>0 THEN  alm_numdoc=0
IF IsNull(alm_numdoc)   Then alm_numdoc = 0
alm_numdoc      = alm_numdoc + 1
sle_numdoc.text = string(alm_numdoc,"###########")
ver_movimientos()
sle_numdoc.SetFocus()

continuar = 1
end event

type st_disponible from statictext within w_int_movsalidas_compras
fontcharset fontcharset = ansi!
string facename = "System"
end type

type pb_imprimir from upb_imprimir within w_int_movsalidas_compras
integer x = 1518
integer y = 164
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;sle_numdoc.SetFocus()
IF Trim(sle_numdoc.text) = "" THEN Return
str_parametros pa
dw_listado.retrieve(codigo_empresa,year(date(String(em_fecha.text))),sle_tipomov.text,sle_numdoc.text)
pa.s_listado = dw_listado.DataObject
OpenWithParm(w_impresoras_v2,dw_listado)


end event

type em_disponible from statictext within w_int_movsalidas_compras
integer x = 2107
integer y = 728
integer width = 425
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

type st_tecla from statictext within w_int_movsalidas_compras
integer x = 1399
integer y = 112
integer width = 110
integer height = 52
integer textsize = -7
integer weight = 400
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

type dw_consulta_reubicacion from datawindow within w_int_movsalidas_compras
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

type dw_almlinubicahis from datawindow within w_int_movsalidas_compras
boolean visible = false
integer x = 165
integer y = 992
integer width = 1143
integer height = 496
integer taborder = 180
boolean titlebar = true
string title = "Detalle ubicación de la linea "
string dataobject = "dw_int_movsalidas4"
boolean controlmenu = true
boolean vscrollbar = true
end type

type sle_numdoc from u_em_campo within w_int_movsalidas_compras
integer x = 1129
integer y = 160
integer width = 238
integer taborder = 40
string mask = "#######"
string displaydata = "~r"
end type

event modificado;call super::modificado;ver_movimientos()

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

type dw_listado from datawindow within w_int_movsalidas_compras
boolean visible = false
integer x = 654
integer width = 494
integer height = 156
integer taborder = 170
boolean bringtotop = true
string dataobject = "report_int_movsalidas_compras"
boolean livescroll = true
end type

type pb_borrar from upb_papelera within w_int_movsalidas_compras
boolean visible = false
integer x = 2670
integer y = 772
integer width = 155
integer height = 136
integer taborder = 190
boolean bringtotop = true
boolean originalsize = false
string picturename = "\bmp\delete.bmp"
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
   MessageBox("No Se Puede borrar la linea","No existen referencias en el historico",exclamation!, Ok!,1)
   Return
END IF
  //------------------------//
  // Desactivacion de campos//
  //------------------------//

pb_borrar.visible                = FALSE       
dw_2.visible                     = FALSE
dw_3.enabled                     = FALSE

em_cantidad.visible              = FALSE

pb_1.visible                     = FALSE
pb_borrar.visible                = FALSE
pb_calculo.visible               = FALSE
uo_mp.visible             			= FALSE
uo_calidad.visible              = FALSE
sle_observaciones.visible        = FALSE
dw_almlinubicahis.visible        = FALSE
st_1.visible                     = FALSE
st_texto_cantidad.visible        = FALSE
st_2.visible                     = FALSE
st_9.visible                     = FALSE
cb_1.visible                     = FALSE

em_fecha.enabled             = FALSE
uo_mp.enabled         		  = FALSE
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
  mov.mp		      =  dw_3.GetItemString(dw_3.getrow(),"mp")
  mov.codtercero  =  dw_3.GetItemString(dw_3.getrow(),"codtercero")
  mov.numdoc      =  dw_3.GetItemString(dw_3.getrow(),"numdoc")
  mov.tipomov     =  dw_3.GetItemString(dw_3.getrow(),"tipomov")
  mov.familia     =  dw_3.GetItemString(dw_3.getrow(),"familia")
  mov.calidad     =  dw_3.GetItemString(dw_3.getrow(),"calidad")
  mov.tipo_unidad =  dw_3.GetItemString(dw_3.getrow(),"tipo_unidad")
  mov.nummov      =  dw_3.GetItemNumber(dw_3.getrow(),"nummov")
  v_cantidad      =  dw_3.GetItemNumber(dw_3.getrow(),"cantidads")

  mov.cantidads = v_cantidad* (-1)
  mov.cantidade = 0


  dw_consulta_reubicacion.SetTransObject(SQLCA)
  dw_reubicacion.SetTransObject(SQLCA)
  dw_consulta_reubicacion.retrieve(codigo_empresa,mov.mp,mov.calidad)
  
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

type dw_3 from datawindow within w_int_movsalidas_compras
integer x = 18
integer y = 912
integer width = 2523
integer height = 524
string dataobject = "dw_int_movsalidascompras3"
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

event retrieveend;if this.rowcount() > 0 then
	this.scrolltorow(this.rowcount())
end if
end event

type dw_2 from datawindow within w_int_movsalidas_compras
event key pbm_dwnkey
integer x = 1061
integer y = 364
integer width = 1033
integer height = 432
integer taborder = 100
string dataobject = "dw_int_movsalidascompras1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;String referencia,tipo_pallet
integer registros
long linea
date fecha
dec{3} stock

IF this.getRow()<>0 THEN
 linea     = dw_2.GetRow() 
 
 IF linea<>0 THEN
    registros = dw_2.RowCount()
    IF registros>0 THEN
      em_cantidad.text=String(GetItemNumber(GetRow(),"existencias"))
    End If
    This.SelectRow(0,FALSE)
    This.SelectRow(getRow(),TRUE)
      uo_calidad.em_codigo.text =  GetItemString(dw_2.getRow(),"calidad")
		uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)

//      em_disponible.text = String(f_existencias_mp_calidad(codigo_empresa,uo_mp.em_codigo.text,uo_calidad.em_codigo.text))
    
      
		fecha = date (em_fecha.text)
		
//		messagebox("", string(fecha, "dd-mm-yy"))
		select sum(cantidade) - sum(cantidads)
		into :stock
		from commovhis
		where empresa = :codigo_Empresa
		and   fechmov <= :fecha
		and situacion <> 'A' 
		and mp = :uo_mp.em_codigo.text
		and calidad = :uo_calidad.em_codigo.text;
		em_disponible.text = string(stock)
		
  End If
End IF
continuar = 1 


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

type dw_reubicacion from datawindow within w_int_movsalidas_compras
event key pbm_dwnkey
boolean visible = false
integer x = 5
integer y = 364
integer width = 1696
integer height = 444
string dataobject = "dw_int_movsalidascompras2"
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

type st_3 from statictext within w_int_movsalidas_compras
integer x = 2107
integer y = 660
integer width = 425
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 268435456
string text = "Disp. a Fecha"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

