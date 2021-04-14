$PBExportHeader$wi_mant_clientes2.srw
$PBExportComments$Mant. clientes.(Alta del clientes)Datos. generales, ventas, domiciliaciones, correspondencia, envio etc...
forward
global type wi_mant_clientes2 from wc_mantenimientos_tab
end type
type dw_domiciliaciones from datawindow within pagina_2
end type
type dw_envios from datawindow within pagina_3
end type
type dw_correspondencia from datawindow within pagina_4
end type
type r_22 from rectangle within pagina_6
end type
type pagina9 from userobject within apartados
end type
type uo_empresa_destino from u_empresa_destino within pagina9
end type
type dw_2 from datawindow within pagina9
end type
type pagina9 from userobject within apartados
uo_empresa_destino uo_empresa_destino
dw_2 dw_2
end type
type gb_1 from groupbox within wi_mant_clientes2
end type
type st_2 from statictext within wi_mant_clientes2
end type
type pb_1 from upb_carpeta within wi_mant_clientes2
end type
type st_3 from statictext within wi_mant_clientes2
end type
type st_4 from statictext within wi_mant_clientes2
end type
type pb_2 from upb_carpeta within wi_mant_clientes2
end type
type pb_calculadora from u_calculadora within wi_mant_clientes2
end type
type st_f2 from statictext within wi_mant_clientes2
end type
end forward

global type wi_mant_clientes2 from wc_mantenimientos_tab
integer x = 78
integer y = 48
integer width = 5609
integer height = 2340
gb_1 gb_1
st_2 st_2
pb_1 pb_1
st_3 st_3
st_4 st_4
pb_2 pb_2
pb_calculadora pb_calculadora
st_f2 st_f2
end type
global wi_mant_clientes2 wi_mant_clientes2

type variables
String var_domi,var_envio,var_correspondencia
u_pipe i_upipe
Boolean traspaso = false, inserto = false

end variables

event ue_valores;call super::ue_valores;pag1 = TRUE	
pag2 = TRUE
pag3 = TRUE
pag4 = TRUE
pag5 = TRUE
pag6 = TRUE
pag7 = TRUE
pag8 = TRUE

prin_pag1 = TRUE
prin_pag2 = TRUE
prin_pag3 = TRUE
prin_pag4 = TRUE
prin_pag5 = TRUE
end event

on wi_mant_clientes2.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_2=create st_2
this.pb_1=create pb_1
this.st_3=create st_3
this.st_4=create st_4
this.pb_2=create pb_2
this.pb_calculadora=create pb_calculadora
this.st_f2=create st_f2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.pb_calculadora
this.Control[iCurrent+8]=this.st_f2
end on

on wi_mant_clientes2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.pb_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.pb_2)
destroy(this.pb_calculadora)
destroy(this.st_f2)
end on

event ue_recuperar;// ***
inserto = true

// Valores Para Funcion de bloqueo
var_domi   = f_domiciliacion_venclientes(codigo_empresa,sle_valor.text)
var_envio  = f_envio_venclientes(codigo_empresa,sle_valor.text)
var_correspondencia  = f_correspondencia_venclientes(codigo_empresa,sle_valor.text)
titulo        =  This.title

longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  1
criterio[2]   =  "C"+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]+criterio[3]

tabla[1]         = "genter"

dw_pag1.Retrieve(codigo_empresa,"C",sle_valor.text)
dw_pag2.Retrieve(codigo_empresa,sle_valor.text,var_domi)
apartados.pagina_2.dw_domiciliaciones.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_3.dw_pagina3.Retrieve(codigo_empresa,sle_valor.text,var_envio)
apartados.pagina_3.dw_envios.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_4.dw_pagina4.Retrieve(codigo_empresa,sle_valor.text,var_correspondencia)
apartados.pagina_4.dw_correspondencia.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_5.dw_pagina5.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_6.dw_pagina6.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_7.dw_pagina7.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_8.dw_pagina8.Retrieve(codigo_empresa,sle_valor.text)

apartados.pagina_2.dw_domiciliaciones.InsertRow(1)
apartados.pagina_2.dw_domiciliaciones.SetItem(1,"codigo","")
apartados.pagina_2.dw_domiciliaciones.SetItem(1,"nombrebanco","NINGUNA")


apartados.pagina_3.dw_envios.InsertRow(1)
apartados.pagina_3.dw_envios.SetItem(1,"codigo","")
apartados.pagina_3.dw_envios.SetItem(1,"descripcion","NINGUNA")


apartados.pagina_4.dw_correspondencia.InsertRow(1)
apartados.pagina_4.dw_correspondencia.SetItem(1,"codigo","")
apartados.pagina_4.dw_correspondencia.SetItem(1,"descripcion","NINGUNA")


CALL Super::ue_recuperar

inserto = false
end event

event ue_inserta_fila;call super::ue_inserta_fila;apartados.pagina_1.dw_pagina1.SetItem(1,"empresa",codigo_empresa)
apartados.pagina_1.dw_pagina1.SetItem(1,"tipoter","C")
apartados.pagina_1.dw_pagina1.SetItem(1,"codigo",sle_valor.text)

IF insercion = "S"  Then
	apartados.pagina_7.dw_pagina7.SetItem(1,"agrupa","N")
	apartados.pagina_7.dw_pagina7.SetItem(1,"agrupa_referencia","S")
	apartados.pagina_7.dw_pagina7.SetItem(1,"agrupa_exp","S")
//	apartados.pagina_1.dw_pagina1.SetItem(1,"cuenta",f_compone_cta_cliente(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text))
	apartados.pagina_7.dw_pagina7.SetItem(1,"incremento","N")
	apartados.pagina_7.dw_pagina7.SetItem(1,"deposito","N")
	apartados.pagina_7.dw_pagina7.SetItem(1,"textopais1","S")
	apartados.pagina_7.dw_pagina7.SetItem(1,"textopais2","S")
	apartados.pagina_7.dw_pagina7.SetItem(1,"textopais3","S")
	apartados.pagina_7.dw_pagina7.SetItem(1,"direnvio","N")
	apartados.pagina_6.dw_pagina6.SetItem(1,"separar_bultos","N")
	apartados.pagina_6.dw_pagina6.SetItem(1,"separar_incompletos","N")
	apartados.pagina_5.dw_pagina5.SetItem(1,"calculo_dtoesp","N")
	apartados.pagina_7.dw_pagina7.SetItem(1,"valorar_alb","N")
	apartados.pagina_7.dw_pagina7.SetItem(1,"bloqueada_expedicion",0)
	apartados.pagina_7.dw_pagina7.SetItem(1,"bloqueados_pedidos",0)
	
	apartados.pagina_1.dw_pagina1.SetItem(1,"visible_expo","1")
	

	Select Max(convert(int,codigo)) +1 Into :var_domi 
	From   vendomiciliacion 
	Where  vendomiciliacion.empresa = :codigo_empresa
	And    vendomiciliacion.cliente = :sle_valor.text; 
	If IsNull(var_domi)  or Trim(var_domi)  = ""   Then  var_domi = "1"
	apartados.pagina_2.dw_pagina2.SetItem(1,"empresa",codigo_empresa)
	apartados.pagina_2.dw_pagina2.SetItem(1,"cliente",sle_valor.text)
	apartados.pagina_2.dw_pagina2.SetItem(1,"codigo",var_domi)

	Select Max(convert(int,codigo)) +1 Into :var_envio
	From   venenvio 
	Where  venenvio.empresa = :codigo_empresa
	And    venenvio.cliente = :sle_valor.text; 
	If IsNull(var_envio)  or Trim(var_envio)  = ""  then var_envio = "1"
	apartados.pagina_3.dw_pagina3.SetItem(1,"empresa",codigo_empresa)
	apartados.pagina_3.dw_pagina3.SetItem(1,"cliente",sle_valor.text)
	apartados.pagina_3.dw_pagina3.SetItem(1,"codigo",var_envio)

	Select Max(convert(int,codigo)) +1 Into :var_correspondencia
	From   vencorrespondencia 
	Where  vencorrespondencia.empresa = :codigo_empresa
	And    vencorrespondencia.cliente = :sle_valor.text; 
	If IsNull(var_correspondencia)  or Trim(var_correspondencia)  = ""  Then var_correspondencia = "1"
	apartados.pagina_4.dw_pagina4.SetItem(1,"empresa",codigo_empresa)
	apartados.pagina_4.dw_pagina4.SetItem(1,"cliente",sle_valor.text)
	apartados.pagina_4.dw_pagina4.SetItem(1,"codigo",var_correspondencia)
end if


apartados.pagina_5.dw_pagina5.SetItem(1,"empresa",codigo_empresa)
apartados.pagina_5.dw_pagina5.SetItem(1,"codigo",sle_valor.text)

apartados.pagina_6.dw_pagina6.SetItem(1,"empresa",codigo_empresa)
apartados.pagina_6.dw_pagina6.SetItem(1,"codigo",sle_valor.text)

apartados.pagina_7.dw_pagina7.SetItem(1,"empresa",codigo_empresa)
apartados.pagina_7.dw_pagina7.SetItem(1,"codigo",sle_valor.text)

apartados.pagina_8.dw_pagina8.SetItem(1,"empresa",codigo_empresa)
apartados.pagina_8.dw_pagina8.SetItem(1,"codigo",sle_valor.text)


end event

event open;call super::open;titulo= "Mantenimiento de clientes"
This.title = titulo
apartados.pagina_2.dw_domiciliaciones.SetTransObject(SQLCA)
apartados.pagina_3.dw_envios.SetTransObject(SQLCA)
apartados.pagina_4.dw_correspondencia.SetTransObject(SQLCA)

f_mascara_columna(apartados.pagina_5.dw_pagina5,"dtoesp1","###.00")
f_mascara_columna(apartados.pagina_5.dw_pagina5,"dtoesp2","###.00")
f_mascara_columna(apartados.pagina_5.dw_pagina5,"dtoesp3","###.00")
f_mascara_columna(apartados.pagina_5.dw_pagina5,"dtoesp4","###.00")
f_mascara_columna(apartados.pagina_5.dw_pagina5,"dtopp","###.00")

f_mascara_columna(apartados.pagina_5.dw_pagina5,"comision1","###.00")
f_mascara_columna(apartados.pagina_5.dw_pagina5,"comision11","###.00")
f_mascara_columna(apartados.pagina_5.dw_pagina5,"comision2","###.00")
f_mascara_columna(apartados.pagina_5.dw_pagina5,"comision22","###.00")
f_mascara_columna(apartados.pagina_5.dw_pagina5,"comision31","###.00")
f_mascara_columna(apartados.pagina_5.dw_pagina5,"comision32","###.00")


i_upipe = CREATE u_pipe
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;apartados.pagina_2.dw_domiciliaciones.enabled = FALSE
apartados.pagina_2.dw_domiciliaciones.visible = FALSE

apartados.pagina_3.dw_envios.enabled = FALSE
apartados.pagina_3.dw_envios.visible = FALSE

apartados.pagina_4.dw_correspondencia.enabled = FALSE
apartados.pagina_4.dw_correspondencia.visible = FALSE

apartados.pagina9.uo_empresa_destino.visible = false
end event

event ue_activa_claves;call super::ue_activa_claves;apartados.pagina_2.dw_domiciliaciones.enabled = TRUE
apartados.pagina_2.dw_domiciliaciones.visible = TRUE

apartados.pagina_3.dw_envios.enabled = TRUE
apartados.pagina_3.dw_envios.visible = TRUE

apartados.pagina_4.dw_correspondencia.enabled = TRUE
apartados.pagina_4.dw_correspondencia.visible = TRUE

apartados.pagina9.uo_empresa_destino.visible = true

end event

event ue_pase_valores;call super::ue_pase_valores;String var_zona,var_grupo,var_serie,var_comentario,var_transportista,&
	tarifa,var_incremento,tipoiva,agrupa,periodo,deposito,pallets_enteros,&
	agrupa_referencia,agrupa_expedicion,var_conversion,var_vercali,var_grupofac,var_codigo_lab, var_separar_bultos, var_separar_incompletos
Integer  mes1desde,mes2desde,mes3desde,mes1hasta,mes2hasta,mes3hasta,dia1desde,dia2desde,dia3desde,dia1hasta,dia2hasta,dia3hasta
Dec var_cantidad_incremento, var_prev_rappel, var_coste_pieza, var_coste_anyo, var_por_coste_transporte
string cuenta_impagados, valorar_alb, var_texto_etiqueta, var_obs_etiqueta ,var_comentario_introduccion_pedidos
Int bloqueada_expedicion, bloqueados_pedidos, mostrar_peso_linea

apartados.pagina_5.dw_pagina5.SetItem(1,"correspondencia",var_correspondencia)
apartados.pagina_5.dw_pagina5.SetItem(1,"envio",var_envio)
apartados.pagina_5.dw_pagina5.SetItem(1,"domiciliacion",var_domi)

var_zona 				= apartados.pagina_6.dw_pagina6.getItemString(1,"zona")
var_grupo 				= apartados.pagina_6.dw_pagina6.getItemString(1,"grupo")
var_grupofac 			= apartados.pagina_6.dw_pagina6.getItemString(1,"grupofac")
var_codigo_lab 		= apartados.pagina_6.dw_pagina6.getItemString(1,"codigo_lab")
var_serie 				= apartados.pagina_6.dw_pagina6.getItemString(1,"serie")
var_separar_bultos	= apartados.pagina_6.dw_pagina6.getItemString(1,"separar_bultos")
var_separar_incompletos 	= apartados.pagina_6.dw_pagina6.getItemString(1,"separar_incompletos")
var_texto_etiqueta	= apartados.pagina_6.dw_pagina6.getItemString(1,"texto_etiqueta")
var_coste_pieza		= apartados.pagina_6.dw_pagina6.getItemNumber(1,"coste_pieza")
var_coste_anyo			= apartados.pagina_6.dw_pagina6.getItemNumber(1,"coste_anyo")
var_por_coste_transporte = apartados.pagina_6.dw_pagina6.getItemNumber(1,"por_coste_transporte")
var_obs_etiqueta		= apartados.pagina_6.dw_pagina6.getItemString(1,"obs_etiqueta")
var_prev_rappel		= apartados.pagina_5.dw_pagina5.getItemnumber(1,"prev_rappel")
var_comentario 		= apartados.pagina_8.dw_pagina8.getItemString(1,"comentario")
var_comentario_introduccion_pedidos = apartados.pagina_8.dw_pagina8.getItemString(1,"comentario_introduccion_pedidos")
var_transportista 	= apartados.pagina_7.dw_pagina7.getItemString(1,"transportista")

tarifa    				= apartados.pagina_7.dw_pagina7.getItemString(1,"tarifa")
tipoiva   				= apartados.pagina_7.dw_pagina7.getItemString(1,"tipoiva")
agrupa    				= apartados.pagina_7.dw_pagina7.getItemString(1,"agrupa")
agrupa_referencia  	= apartados.pagina_7.dw_pagina7.getItemString(1,"agrupa_referencia")
agrupa_expedicion  	= apartados.pagina_7.dw_pagina7.getItemString(1,"agrupa_exp")
periodo   				= apartados.pagina_7.dw_pagina7.getItemString(1,"periodo_fac")
dia1desde 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"dia1desde")
dia2desde 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"dia2desde")
dia3desde 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"dia3desde")
dia1hasta 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"dia1hasta")
dia2hasta 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"dia2hasta")
dia3hasta 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"dia3hasta")
mes1desde 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"mes1desde")
mes2desde				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"mes2desde")
mes3desde 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"mes3desde")
mes1hasta 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"mes1hasta")
mes2hasta 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"mes2hasta")
mes3hasta 				= apartados.pagina_7.dw_pagina7.getItemnumber(1,"mes3hasta")
var_conversion   		= apartados.pagina_7.dw_pagina7.getItemString(1,"conversion_tono")
var_vercali      		= apartados.pagina_7.dw_pagina7.getItemString(1,"ver_calibre")
var_incremento   		= apartados.pagina_7.dw_pagina7.getItemString(1,"incremento")
var_cantidad_incremento = apartados.pagina_7.dw_pagina7.getItemNumber(1,"cantidad_incremento")
deposito         		= apartados.pagina_7.dw_pagina7.getItemString(1,"deposito")
pallets_enteros  		= apartados.pagina_7.dw_pagina7.getItemString(1,"pallets_enteros")
//cuenta_impagados 		= apartados.pagina_7.dw_pagina7.getItemString(1,"cuenta_impagados")
valorar_alb				= apartados.pagina_7.dw_pagina7.getItemString(1,"valorar_alb")

bloqueada_expedicion				= apartados.pagina_7.dw_pagina7.getItemNumber(1,"bloqueada_expedicion")
bloqueados_pedidos				= apartados.pagina_7.dw_pagina7.getItemNumber(1,"bloqueados_pedidos")
mostrar_peso_linea				= apartados.pagina_7.dw_pagina7.getItemNumber(1,"mostrar_peso_linea")

apartados.pagina_5.dw_pagina5.SetItem(1,"tipoiva",tipoiva)
apartados.pagina_5.dw_pagina5.SetItem(1,"agrupa",agrupa)
apartados.pagina_5.dw_pagina5.SetItem(1,"agrupa_referencia",agrupa_referencia)
apartados.pagina_5.dw_pagina5.SetItem(1,"agrupa_exp",agrupa_expedicion)
apartados.pagina_5.dw_pagina5.SetItem(1,"deposito",deposito)
apartados.pagina_5.dw_pagina5.SetItem(1,"pallets_enteros",pallets_enteros)
apartados.pagina_5.dw_pagina5.SetItem(1,"periodo_fac",periodo)
apartados.pagina_5.dw_pagina5.SetItem(1,"tarifa",tarifa)
apartados.pagina_5.dw_pagina5.SetItem(1,"zona",var_zona)
apartados.pagina_5.dw_pagina5.SetItem(1,"grupo",var_grupo)
apartados.pagina_5.dw_pagina5.SetItem(1,"grupofac",var_grupofac)
apartados.pagina_5.dw_pagina5.SetItem(1,"codigo_lab",var_codigo_lab)
apartados.pagina_5.dw_pagina5.SetItem(1,"serie",var_serie)
apartados.pagina_5.dw_pagina5.SetItem(1,"comentario",var_comentario)
apartados.pagina_5.dw_pagina5.SetItem(1,"comentario_introduccion_pedidos",var_comentario_introduccion_pedidos)
apartados.pagina_5.dw_pagina5.SetItem(1,"transportista",var_transportista)
apartados.pagina_5.dw_pagina5.SetItem(1,"mes1desde",mes1desde)
apartados.pagina_5.dw_pagina5.SetItem(1,"mes2desde",mes2desde)
apartados.pagina_5.dw_pagina5.SetItem(1,"mes3desde",mes3desde)
apartados.pagina_5.dw_pagina5.SetItem(1,"mes1hasta",mes1hasta)
apartados.pagina_5.dw_pagina5.SetItem(1,"mes2hasta",mes2hasta)
apartados.pagina_5.dw_pagina5.SetItem(1,"mes3hasta",mes3hasta)
apartados.pagina_5.dw_pagina5.SetItem(1,"dia1desde",dia1desde)
apartados.pagina_5.dw_pagina5.SetItem(1,"dia2desde",dia2desde)
apartados.pagina_5.dw_pagina5.SetItem(1,"dia3desde",dia3desde)
apartados.pagina_5.dw_pagina5.SetItem(1,"dia1hasta",dia1hasta)
apartados.pagina_5.dw_pagina5.SetItem(1,"dia2hasta",dia2hasta)
apartados.pagina_5.dw_pagina5.SetItem(1,"dia3hasta",dia3hasta)
apartados.pagina_5.dw_pagina5.SetItem(1,"incremento",var_incremento)
apartados.pagina_5.dw_pagina5.SetItem(1,"cantidad_incremento",var_cantidad_incremento)
apartados.pagina_5.dw_pagina5.SetItem(1,"conversion_tono",var_conversion)
apartados.pagina_5.dw_pagina5.SetItem(1,"ver_calibre",var_vercali)
//apartados.pagina_5.dw_pagina5.SetItem(1,"cuenta_impagados",cuenta_impagados)
apartados.pagina_5.dw_pagina5.SetItem(1,"valorar_alb",valorar_alb)

apartados.pagina_5.dw_pagina5.SetItem(1,"bloqueada_expedicion", bloqueada_expedicion)
apartados.pagina_5.dw_pagina5.SetItem(1,"bloqueados_pedidos", bloqueados_pedidos)
apartados.pagina_5.dw_pagina5.SetItem(1,"mostrar_peso_linea", mostrar_peso_linea)


// David 08-06-04
apartados.pagina_5.dw_pagina5.SetItem(1,"separar_bultos",var_separar_bultos)
apartados.pagina_5.dw_pagina5.SetItem(1,"separar_incompletos",var_separar_incompletos)
// David 20-04-06
apartados.pagina_5.dw_pagina5.SetItem(1,"texto_etiqueta",var_texto_etiqueta)
apartados.pagina_5.dw_pagina5.SetItem(1,"coste_pieza",var_coste_pieza)
apartados.pagina_5.dw_pagina5.SetItem(1,"coste_anyo",var_coste_anyo)
apartados.pagina_5.dw_pagina5.SetItem(1,"por_coste_transporte", var_por_coste_transporte)
apartados.pagina_5.dw_pagina5.SetItem(1,"obs_etiqueta",var_obs_etiqueta)
apartados.pagina_5.dw_pagina5.SetItem(1,"prev_rappel",var_prev_rappel)

dw_pag5.SetItem(1,"textopais1",dw_pag7.getItemString(1,"textopais1"))
dw_pag5.SetItem(1,"textopais2",dw_pag7.getItemString(1,"textopais2"))
dw_pag5.SetItem(1,"textopais3",dw_pag7.getItemString(1,"textopais3"))
dw_pag5.SetItem(1,"direnvio",dw_pag7.getItemString(1,"direnvio"))

dw_pag5.SetItem(1,"riesgo_asumible_empresa",dw_pag6.getItemnumber(1,"riesgo_asumible_empresa"))
end event

event ue_f2;call super::ue_f2;pb_calculadora.triggerevent(CLICKED!)
end event

event activate;call super::activate;wi_mant_clientes2 = ventanas_activas[id_ventana_activa].ventana
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within wi_mant_clientes2
integer x = 5285
integer y = 188
integer width = 265
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within wi_mant_clientes2
integer x = 5015
integer y = 188
integer width = 265
integer height = 76
integer taborder = 0
string text = "&Borrar"
end type

event cb_borrar::clicked;Integer cont,cont2, resp
Boolean movim = false
String cod

// Comprobación de integridad referencial. Miramos que el cliente
// no tenga pedidos, albaranes, facturas, ni apuntes contables, ni modelos
cod = sle_valor.text

select count(*)
  into :cont
  from venped
 where venped.cliente = :cod;
 
 select count(*)
  into :cont2
  from modelo_cliente
 where modelo_cliente.cliente = :cod;

if IsNull (cont) then cont = 0
if IsNull (cont2) then cont2 = 0

if cont > 0 or cont2 > 0 then
	movim = true
else
	select count(*)
  into :cont
  from venalb
  where venalb.cliente = :cod;
	if IsNull (cont) then cont = 0

	if cont > 0 then
		movim = true
	else
		select count(*)
	  into :cont
	  from venfac
	  where venfac.cliente = :cod;
		if IsNull (cont) then cont = 0
	
		if cont > 0 then
			movim = true
		else
			String cuen
			cuen = dw_pag1.GetItemString(dw_pag1.GetRow(),"cuenta")
			
			select count(*)
		  into :cont
		  from contaapun
		  where contaapun.cuenta = :cuen;
			if IsNull (cont) then cont = 0
			if cont > 0 then
				movim = true
			else
				movim = false
			end if		

		end if
	end if
end if

if movim then
	f_mensaje ("Borrado del Cliente","El cliente no puede ser dado de baja porque tiene movimientos en alguna empresa. Si quiere inutilizarlo márquelo como inactivo")
else
	resp = MessageBox("Borrado del Cliente","El cliente será dado de baja en todas las empresas. ¿ Desea continuar ?",Question!,YesNo!,2)
	if resp = 2 then return
	// Lo borramos también de todas las empresas
	DELETE FROM genter
	WHERE genter.tipoter = "C"
	  AND genter.codigo = :cod
	USING sqlca;
	  
	DELETE FROM venclientes
	WHERE venclientes.codigo = :cod
	USING sqlca;	  
	  
	DELETE FROM venenvio
	WHERE venenvio.cliente = :cod
	USING sqlca;	  

	DELETE FROM vendomiciliacion
	WHERE vendomiciliacion.cliente = :cod
	USING sqlca;

	DELETE FROM vencorrespondencia
	WHERE vencorrespondencia.cliente = :cod
	USING sqlca;	  

	DELETE FROM contaplan
	WHERE contaplan.cuenta = :cuen
	USING sqlca;	  
	
	DELETE FROM calibreclientes
	WHERE empresa = :codigo_empresa
	and cliente = :cod
	USING sqlca;	  
	
	if not wc_bloquear() then
		COMMIT using sqlca;
	else
		ROLLBACK using sqlca;
	end if
   sle_valor.text = ""
   Parent.TriggerEvent("ue_desbloquear")
   cb_insertar.Enabled = FALSE
	cb_borrar.Enabled = FALSE
   Parent.TriggerEvent("ue_recuperar")

end if
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within wi_mant_clientes2
integer x = 4745
integer y = 188
integer width = 265
integer height = 76
integer taborder = 0
end type

event cb_insertar::clicked;decimal ejercicio

IF cb_Insertar.enabled=TRUE THEN
	apartados.pagina_1.dw_pagina1.Accepttext()
	apartados.pagina_6.dw_pagina6.Accepttext()
	
	String  var_idioma,var_moneda,var_cif,tipopais,var_serie,var_provincia,var_pais, var_separar_bultos, var_texto_etiqueta, var_obs_etiqueta, var_separar_incompletos
	String  var_agente1,var_nombre_banco,control_banco,var_bancocobro
	String  var_tarifa,var_tipoiva,var_tipopallet,var_periodofac
	datawindow dato
	Integer contador,numero
	String  campo,var_razon,var_nombre_corres,var_nombre_envio,var_grupo,var_grupofac
	String  variable,nombre_cuenta,cuenta
	Integer digitos, var_nivel
	String  var_codpago,var_cliente_lab
	dec var_prev_rappel, var_coste_pieza, var_coste_anyo, var_por_coste_transporte
	
	var_nombre_banco    = apartados.pagina_2.dw_pagina2.GetItemString(1,'nombrebanco')
	var_nombre_envio    = apartados.pagina_3.dw_pagina3.GetItemString(1,'descripcion')
	var_nombre_corres   = apartados.pagina_4.dw_pagina4.GetItemString(1,'descripcion')
	
	var_idioma    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'idioma')	
	var_moneda    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'moneda')	
	var_razon     = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'razon')	
	var_provincia = apartados.pagina_1.dw_pagina1.getitemstring(apartados.pagina_1.dw_pagina1.GetRow(),"provincia")
	var_pais      = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'pais')	
	var_cif       = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'cif')	
	var_serie     = apartados.pagina_6.dw_pagina6.GetItemString(apartados.pagina_6.dw_pagina6.GetRow(),'serie')	
	var_grupo     = apartados.pagina_6.dw_pagina6.GetItemString(apartados.pagina_6.dw_pagina6.GetRow(),'grupo')	
	var_grupofac  = apartados.pagina_6.dw_pagina6.GetItemString(apartados.pagina_6.dw_pagina6.GetRow(),'grupofac')	
	var_separar_bultos  = apartados.pagina_6.dw_pagina6.GetItemString(apartados.pagina_6.dw_pagina6.GetRow(),'separar_bultos')	
	var_separar_incompletos  = apartados.pagina_6.dw_pagina6.GetItemString(apartados.pagina_6.dw_pagina6.GetRow(),'separar_incompletos')	
	var_texto_etiqueta  = apartados.pagina_6.dw_pagina6.GetItemString(apartados.pagina_6.dw_pagina6.GetRow(),'texto_etiqueta')
	var_prev_rappel  = apartados.pagina_5.dw_pagina5.GetItemNumber(apartados.pagina_5.dw_pagina5.GetRow(),'prev_rappel')
	var_obs_etiqueta  = apartados.pagina_6.dw_pagina6.GetItemString(apartados.pagina_6.dw_pagina6.GetRow(),'obs_etiqueta')
	var_coste_pieza = apartados.pagina_6.dw_pagina6.GetItemnumber(apartados.pagina_6.dw_pagina6.GetRow(),'coste_pieza')
	var_coste_anyo = apartados.pagina_6.dw_pagina6.GetItemnumber(apartados.pagina_6.dw_pagina6.GetRow(),'coste_anyo')
	var_por_coste_transporte = apartados.pagina_6.dw_pagina6.GetItemnumber(apartados.pagina_6.dw_pagina6.GetRow(),'por_coste_transporte')
//	var_cliente_lab = apartados.pagina_6.dw_pagina6.GetItemString(apartados.pagina_6.dw_pagina6.GetRow(),'codigo_lab')	
	var_agente1   = apartados.pagina_5.dw_pagina5.GetItemString(apartados.pagina_5.dw_pagina5.GetRow(),'agente1')	

	var_bancocobro= apartados.pagina_5.dw_pagina5.GetItemString(apartados.pagina_5.dw_pagina5.GetRow(),'banco_de_cobro')	
	var_tipopallet= apartados.pagina_5.dw_pagina5.GetItemString(apartados.pagina_5.dw_pagina5.GetRow(),'tipo_pallet')	
	var_tarifa    = apartados.pagina_7.dw_pagina7.GetItemString(apartados.pagina_7.dw_pagina7.GetRow(),'tarifa')	
	var_tipoiva   = apartados.pagina_7.dw_pagina7.GetItemString(apartados.pagina_7.dw_pagina7.GetRow(),'tipoiva')	
	var_periodofac= apartados.pagina_7.dw_pagina7.GetItemString(apartados.pagina_7.dw_pagina7.GetRow(),'periodo_fac')	
	var_codpago   = apartados.pagina_5.dw_pagina5.GetItemString(apartados.pagina_5.dw_pagina5.GetRow(),'cod_pago')	

	if Trim(var_codpago)<>"" then
		control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))
		if control_banco = "S" and Trim(var_bancocobro)="" then
		  campo="banco_de_cobro"
		  dato = apartados.pagina_5.dw_pagina5
		  numero = 5
		End if
	End If
	if Trim(var_tipopallet)="" or IsNull(var_tipopallet) then
		  campo="tipo_pallet"
		  dato = apartados.pagina_5.dw_pagina5
		  numero = 5
	End If
	if Trim(var_tipoiva)="" or IsNull(var_tipoiva) then
		  campo="tipoiva"
		  dato = apartados.pagina_7.dw_pagina7
		  numero = 7
	else
		if (var_provincia = "35" or var_provincia = "38" or var_provincia = "51" or var_provincia = "52") and var_tipoiva <> "12" and var_pais = "11" then
			messagebox("Atención","El tipo de IVA de ser 12 - VENTAS CANARIAS, CEUTA y MELILLA")		
			campo="tipoiva"
 		   dato = apartados.pagina_7.dw_pagina7
		   numero = 7
		end if
	End If
	if Trim(var_tarifa)="" or IsNull(var_tarifa) then
		  campo="tarifa"
		  dato = apartados.pagina_7.dw_pagina7
		  numero = 7
	End If
	if Trim(var_periodofac)="" or IsNull(var_periodofac) then
		  campo="periodo_fac"
		  dato = apartados.pagina_7.dw_pagina7
		  numero = 7
	End If
	if Trim(var_grupo)="" or IsNull(var_grupo) then
		  campo="grupo"
		  dato = apartados.pagina_6.dw_pagina6
		  numero = 6
	End If
	if Trim(var_grupofac)="" or IsNull(var_grupofac) then
		  campo="grupofac"
		  dato = apartados.pagina_6.dw_pagina6
		  numero = 6
	End If
	if Trim(var_separar_bultos)="" or IsNull(var_separar_bultos) then
		  campo="separar_bultos"
		  dato = apartados.pagina_6.dw_pagina6
		  numero = 6
	End If
//
//	if Trim(var_cliente_lab)="" or IsNull(var_cliente_lab) then
//		  campo="codigo_lab"
//		  dato = apartados.pagina_6.dw_pagina6
//		  numero = 6
//	End If
	IF IsNull(var_serie) or Trim(String(var_serie))="" THEN  
		  campo="serie"
		  dato = apartados.pagina_6.dw_pagina6
		  numero = 6
	ELSE
		IF var_serie <> "1" and var_serie <> "2" and var_serie <> "3" then
			campo=""
			dato = apartados.pagina_6.dw_pagina6
		  numero = 6
		End if
	End If
	IF IsNull(var_agente1) or Trim(String(var_agente1))="" THEN  
		  campo="agente1"
		  dato = apartados.pagina_5.dw_pagina5
		  numero=5
	End If
	IF IsNull(var_codpago) or Trim(String(var_codpago))="" THEN  
		  campo="cod_pago"
		  dato = apartados.pagina_5.dw_pagina5
		  numero = 5
	End If
	
	IF IsNull(var_idioma) or Trim(String(var_idioma))="" THEN
		  campo="idioma"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End if
	IF IsNull(var_razon) or Trim(String(var_razon))="" THEN  
		  campo="razon"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End if
	IF IsNull(var_moneda) or Trim(String(var_moneda))="" THEN  
		  campo="moneda"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End if
	IF IsNull(var_pais) or Trim(String(var_pais))="" THEN
		  campo="pais"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End if
	IF IsNull(var_cif) or Trim(String(var_cif))="" THEN  
		tipopais = f_tipo_pais(var_pais)
		Choose case tipopais
			Case "N","C"
			  campo="cif"
			  dato = apartados.pagina_1.dw_pagina1
			  numero = 1	  
		End Choose			 
	End if	
	
	var_provincia = apartados.pagina_1.dw_pagina1.getitemstring(1,"provincia")
	if Trim(var_provincia)="" or IsNull(var_provincia) then
		  campo="provincia"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End If
		
	IF Trim(campo)<>"" THEN
	  MessageBox(" "+campo+": Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
	  apartados.SelectTab(numero)
	  dato.setfocus()
	  dato.SetColumn(campo)
	  Return
	END IF
	IF IsNull(var_nombre_banco)  Then var_nombre_banco  = ""
	IF IsNull(var_nombre_envio)  Then var_nombre_envio  = ""
	IF IsNull(var_nombre_corres) Then var_nombre_corres = ""
	IF trim(var_nombre_banco)= "" Then
		pag_act2= FALSE
		var_domi=""
	END IF
	IF trim(var_nombre_envio)= "" Then
		pag_act3= FALSE
		var_envio = ""
	END IF
	IF trim(var_nombre_corres)= "" Then
		pag_act4= FALSE
		var_correspondencia= ""
	END IF
	
	ejercicio = year(today())
	// control de cuenta contable
	apartados.pagina_1.dw_pagina1.acceptText()
		
	cuenta = dw_pag1.GetItemString(1,"cuenta")
	
	if len(trim(cuenta))<>0 then		
		digitos       = f_digitos_contaparam(codigo_empresa,ejercicio)																
		if len(trim(cuenta))<>digitos then
			 f_mensaje("Error en cuenta","Número de digitos erróneo.")
			 apartados.SelectTab(1)
			 apartados.pagina_1.dw_pagina1.setfocus()
			 apartados.pagina_1.dw_pagina1.SetColumn("cuenta")
			 Return
		End if		 
		
		// comprueba si esta la cuenta contable en plan de cuentas
      		
		nombre_cuenta = dw_pag1.Getitemstring(1,"razon")
		var_nivel     = f_ultimonivel_contaparam(codigo_empresa,ejercicio)

		if trim(cuenta)<>"" then
		
			 SELECT contaplan.titulo
			 INTO :variable
			 FROM contaplan  
			WHERE ( contaplan.ejercicio = :ejercicio) AND  
					( contaplan.empresa = :codigo_empresa ) AND  
					( contaplan.cuenta = :cuenta )   ;
					
			if SQLCA.SQLCode=100 then
				MessageBox("Error", "Cuenta no existente")	
				//NO INSERTAMOS CUENTA - Pedro Museros 03/12/2014
				/*
				INSERT INTO contaplan  
							  (ejercicio, 
								empresa, 
								cuenta,
								titulo,
								analitica,
								tipocta,
								directos,   
								nivel,   
								coste)
					 VALUES (:ejercicio, 
								:codigo_empresa, 
								:cuenta,
								:nombre_cuenta,
								"N",
								"3",
								"S",   
								:var_nivel,   
								null);
					*/
			elseif SQLCA.SQLCode=0 then
				//La cuenta existe - OK
				
			else
				MessageBox("Error", "Cuenta no existente")	
			End if
		End if	
	end if
	// Cuenta de impagados
	cuenta = dw_pag7.GetItemString(1,"cuenta_impagados")
	if len(trim(cuenta))<>0 then		
		digitos       = f_digitos_contaparam(codigo_empresa,ejercicio)
																
		if len(trim(cuenta))<>digitos then
			 f_mensaje("Error en cuenta de impagados","Número de digitos erróneo.")
			 apartados.SelectTab(7)
			 apartados.pagina_7.dw_pagina7.setfocus()
			 apartados.pagina_7.dw_pagina7.SetColumn("cuenta_impagados")
			 Return
		End if		 
		
		// comprueba si esta la cuenta contable en plan de cuentas
      		
		nombre_cuenta = "E.C.I "+dw_pag1.Getitemstring(1,"razon")
		var_nivel     = f_ultimonivel_contaparam(codigo_empresa,ejercicio)

		if trim(cuenta)<>"" then
		
			 SELECT contaplan.titulo
			 INTO :variable
			 FROM contaplan  
			WHERE ( contaplan.ejercicio = :ejercicio) AND  
					( contaplan.empresa = :codigo_empresa ) AND  
					( contaplan.cuenta = :cuenta )   ;
					
			if SQLCA.SQLCode=100 then
				//NO INSERTAMOS CUENTA - Pedro Museros 03/12/2014
				MessageBox("Error", "Cuenta impagados no existente")			
				/*
				INSERT INTO contaplan  
							  (ejercicio, 
								empresa, 
								cuenta,
								titulo,
								analitica,
								tipocta,
								directos,   
								nivel,   
								coste)
					 VALUES (:ejercicio, 
								:codigo_empresa, 
								:cuenta,
								:nombre_cuenta,
								'N',
								"4",
								"S",   
								:var_nivel,   
								null);
				*/
			elseif SQLCA.SQLCode=0 then
				//La cuenta existe - OK				
			else
						MessageBox("Error", "Cuenta impagados no existente")			
			End if
		End if	
	end if

	// Cuenta de Dudoso cobro
/*	
	cuenta=f_compone_cta_dudoso_cobro(codigo_empresa,ejercicio,sle_valor.text,var_pais,var_provincia)
	nombre_cuenta = "DUDOSO COBRO "+dw_pag1.Getitemstring(1,"razon")
	var_nivel     = f_ultimonivel_contaparam(codigo_empresa,ejercicio)
	
	if trim(cuenta)<>"" then
	
		 SELECT contaplan.titulo
		 INTO :variable
		 FROM contaplan  
		WHERE ( contaplan.ejercicio = :ejercicio) AND  
				( contaplan.empresa = :codigo_empresa ) AND  
				( contaplan.cuenta = :cuenta )   ;
				
		if SQLCA.SQLCode=100 then
			
			INSERT INTO contaplan  
						  (ejercicio, 
							empresa, 
							cuenta,
							titulo,
							analitica,
							tipocta,
							directos,   
							nivel,   
							coste)
				 VALUES (:ejercicio, 
							:codigo_empresa, 
							:cuenta,
							:nombre_cuenta,
							'N',
							"4",
							"S",   
							:var_nivel,   
							null);
		End if
	End if	
*/
	if f_remesable_carforpag(codigo_empresa,var_codpago)='S' then
		
		cuenta=f_compone_cta_ECC(codigo_empresa,ejercicio,sle_valor.text,var_pais,var_provincia)
		nombre_cuenta = "E.C.C "+dw_pag1.Getitemstring(1,"razon")
		var_nivel     = f_ultimonivel_contaparam(codigo_empresa,ejercicio)
		
		if trim(cuenta)<>"" then
		
			 SELECT contaplan.titulo
			 INTO :variable
			 FROM contaplan  
			WHERE ( contaplan.ejercicio = :ejercicio) AND  
					( contaplan.empresa = :codigo_empresa ) AND  
					( contaplan.cuenta = :cuenta )   ;
					
			if SQLCA.SQLCode=100 then
				//NO INSERTAMOS CUENTA - Pedro Museros 03/12/2014
				MessageBox("Error", "Cuenta E.C.C No existente")	
				/*
				INSERT INTO contaplan  
							  (ejercicio, 
								empresa, 
								cuenta,
								titulo,
								analitica,
								tipocta,
								directos,   
								nivel,   
								coste)
					 VALUES (:ejercicio, 
								:codigo_empresa, 
								:cuenta,
								:nombre_cuenta,
								'N',
								"3",
								"S",   
								:var_nivel,   
								null);
				*/
			elseif SQLCA.SQLCode=0 then
				//La cuenta existe - OK
			else
				MessageBox("Error", "Cuenta E.C.C No existente")	
			End if
		End if	
		
		cuenta=f_compone_cta_ECD(codigo_empresa,ejercicio,sle_valor.text,var_pais,var_provincia)
		nombre_cuenta = "E.C.D "+dw_pag1.Getitemstring(1,"razon")
		var_nivel     = f_ultimonivel_contaparam(codigo_empresa,ejercicio)
		
		if trim(cuenta)<>"" then
		
			 SELECT contaplan.titulo
			 INTO :variable
			 FROM contaplan  
			WHERE ( contaplan.ejercicio = :ejercicio) AND  
					( contaplan.empresa = :codigo_empresa ) AND  
					( contaplan.cuenta = :cuenta )   ;
					
			if SQLCA.SQLCode=100 then
				//NO INSERTAMOS CUENTA - Pedro Museros 03/12/2014
				MessageBox("Error", "Cuenta E.C.D No existente")	
				/*
				INSERT INTO contaplan  
							  (ejercicio, 
								empresa, 
								cuenta,
								titulo,
								analitica,
								tipocta,
								directos,   
								nivel,   
								coste)
					 VALUES (:ejercicio, 
								:codigo_empresa, 
								:cuenta,
								:nombre_cuenta,
								'N',
								"3",
								"S",   
								:var_nivel,   
								null);
				*/
			elseif SQLCA.SQLCode=0 then
				//La cuenta existe - OK
			else
				MessageBox("Error", "Cuenta E.C.D No existente")	
			End if
		End if			

		cuenta=f_compone_cta_ECGC(codigo_empresa,ejercicio,sle_valor.text,var_pais,var_provincia)
		nombre_cuenta = "E.C.G.C "+dw_pag1.Getitemstring(1,"razon")
		var_nivel     = f_ultimonivel_contaparam(codigo_empresa,ejercicio)
		
		if trim(cuenta)<>"" then
		
			 SELECT contaplan.titulo
			 INTO :variable
			 FROM contaplan  
			WHERE ( contaplan.ejercicio = :ejercicio) AND  
					( contaplan.empresa = :codigo_empresa ) AND  
					( contaplan.cuenta = :cuenta )   ;
					
			if SQLCA.SQLCode=100 then
				//NO INSERTAMOS CUENTA - Pedro Museros 03/12/2014
				MessageBox("Error", "Cuenta E.C.G.C No existente")			
				/*
				INSERT INTO contaplan  
							  (ejercicio, 
								empresa, 
								cuenta,
								titulo,
								analitica,
								tipocta,
								directos,   
								nivel,   
								coste)
					 VALUES (:ejercicio, 
								:codigo_empresa, 
								:cuenta,
								:nombre_cuenta,
								'N',
								"3",
								"S",   
								:var_nivel,   
								null);
				*/
			elseif SQLCA.SQLCode=0 then
				//La cuenta existe - OK
			else
					MessageBox("Error", "Cuenta E.C.G.C No existente")			
			End if
		End if			
	end if
End if

if  cb_Insertar.enabled=TRUE and insercion ="S" then 
	traspaso = true
else
	traspaso = false
end if


CALL Super::Clicked

//// Si se está insertando, hacemos el traspaso automáticamente a la
//// otra empresa
//String sele, v_empr
//Datastore ds
//Integer registros, reg
//if traspaso then
//	f_mensaje("Alta de un Cliente","Se van a traspasar los datos de este cliente automáticamente a la/s otra/s empresa/s")
//	sele = " SELECT empresa FROM empresas WHERE empresas.empresa <> '"+codigo_empresa+"'"
//	ds = f_cargar_cursor(sele)
//	registros = ds.RowCount()
//	for reg = 1 to registros
//		v_empr = ds.GetItemString(reg, "empresa")
//		apartados.pagina9.uo_empresa_destino.uo_empresa.em_codigo.text = v_empr
//		apartados.pagina9.uo_empresa_destino.uo_empresa.em_campo.text = f_nombre_empresa(v_empr)
//		apartados.pagina9.uo_empresa_destino.triggerEvent("ue_procesar")
//	next
//	
//	Destroy ds
//else
//	if not inserto then
//		f_mensaje("Guardar cambios del cliente",&
//			"Los cambios realizados en los datos de este cliente no se traspasarán a otra/s empresa/s a menos que se realice un Traspaso")
//	end if
//end if

pag_act2  = TRUE
pag_act3  = TRUE
pag_act4  = TRUE

end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within wi_mant_clientes2
integer x = 4974
integer y = 48
integer taborder = 30
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within wi_mant_clientes2
integer x = 50
integer y = 36
integer width = 2501
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 24011603
long backcolor = 12632256
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within wi_mant_clientes2
integer x = 261
integer y = 172
integer width = 274
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 	

dw_pag2.Retrieve(codigo_empresa,sle_valor.text,var_domi)
apartados.pagina_2.dw_domiciliaciones.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_3.dw_pagina3.Retrieve(codigo_empresa,sle_valor.text,var_envio)
apartados.pagina_3.dw_envios.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_4.dw_pagina4.Retrieve(codigo_empresa,sle_valor.text,var_correspondencia)
apartados.pagina_4.dw_correspondencia.Retrieve(codigo_empresa,sle_valor.text)


IF istr_parametros.i_nargumentos>1 THEN
	
	  sle_valor.text=istr_parametros.s_argumentos[2]
 	  istr_parametros.i_nargumentos=0
       	  
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
			This.TriggerEvent("modificado")
			Parent.TriggerEvent("ue_recuperar")
     END IF  
  
	  		
END IF


end event

event sle_valor::modificado;call super::modificado;st_2.text = f_nombre_cliente(codigo_empresa,"C",sle_valor.text)
end event

type st_1 from wc_mantenimientos_tab`st_1 within wi_mant_clientes2
integer x = 14
integer y = 176
string text = "Código:"
alignment alignment = right!
end type

type apartados from wc_mantenimientos_tab`apartados within wi_mant_clientes2
integer x = 37
integer y = 304
integer width = 5545
integer height = 1852
integer textsize = -9
fontcharset fontcharset = ansi!
boolean multiline = true
pagina9 pagina9
end type

on apartados.create
this.pagina9=create pagina9
call super::create
this.Control[]={this.pagina_1,&
this.pagina_2,&
this.pagina_3,&
this.pagina_4,&
this.pagina_5,&
this.pagina_6,&
this.pagina_7,&
this.pagina_8,&
this.pagina9}
end on

on apartados.destroy
call super::destroy
destroy(this.pagina9)
end on

event apartados::selectionchanged;call super::selectionchanged;if newindex=9 then
	apartados.pagina9.uo_empresa_destino.visible=true
end if
end event

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer y = 108
integer width = 5509
integer height = 1728
string text = "General"
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 105
integer y = 116
integer width = 2601
integer height = 1220
string dataobject = "dw_venclientes1"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina1::clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2
Long esta_abierta

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
   /*
	lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(this,This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)
	*/
	esta_abierta = f_menu_ventana_esta_abierta("wi_mant_provincias")
	//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
	if esta_abierta = -1 then
		lstr_param.s_argumentos[1] = f_valor_columna(this,This.GetRow(),"pais")
		lstr_param.s_argumentos[2] = f_valor_columna(this,This.GetRow(),"provincia")
		lstr_param.i_nargumentos = 2
		lstr_param.nombre_ventana = "wi_mant_clientes2"
		lstr_param.resultado = ''
		Openwithparm(wi_mant_provincias, lstr_param)
	else
		ventanas_activas[esta_abierta].ventana.BringToTop = true
	end if
CASE 'pb_codpostal'
   /*
	lstr_param.i_nargumentos  = 3
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(this,This.GetRow(),"cod_postal")
   OpenWithParm(wi_mant_codpostales,lstr_param)
	*/
	esta_abierta = f_menu_ventana_esta_abierta("wi_mant_codpostales")
	//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
	if esta_abierta = -1 then
		lstr_param.s_argumentos[1] = f_valor_columna(this,This.GetRow(),"pais")
		lstr_param.s_argumentos[2] = f_valor_columna(this,This.GetRow(),"cod_postal")
		lstr_param.i_nargumentos = 2
		lstr_param.nombre_ventana = "wi_mant_clientes2"
		lstr_param.resultado = ''
		Openwithparm(wi_mant_codpostales, lstr_param)
	else
		ventanas_activas[esta_abierta].ventana.BringToTop = true
	end if
CASE 'pb_idioma'
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"idioma")
   OpenWithParm(wi_mant_idiomas,lstr_param)  
CASE 'pb_moneda'
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  
CASE 'pb_email'
	if sle_valor.text <> "" then
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_venclientes_email")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = sle_valor.text
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "wi_mant_clientes2"
			lstr_param.resultado = ''
			Openwithparm(wtc_mant_venclientes_email, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
	end if
END CHOOSE
end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE this.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'cod_postal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
	IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
	  SELECT  codpostales.provincia,codpostales.ciudad  
	    INTO  :var_provincia,:var_localidad  
	    FROM  codpostales  
	   WHERE (codpostales.pais      = :var_pais ) AND  
	         (codpostales.codpostal = :var_postal);
	   This.SetItem(This.getrow(),"provincia",var_provincia)
	   This.SetItem(This.getrow(),"localidad",var_localidad)   
	END IF
	
END CHOOSE

STring  pro,cif
Dec nu

if This.Rowcount() = 0 Then Return




cif=  This.Object.cif[1]
pro = sle_valor.text
IF Trim(cif) <> "" Then
	nu = 0
	Select Count(*) Into :nu from genter
	Where   empresa = :codigo_empresa
	And     tipoter = 'C'
	and     codigo <> :pro
	and     cif   = :cif;
	IF nu <> 0 Then 
		f_mensaje("Control de altas","Este NIF Esta duplicado")
	END IF

END IF
end event

event dw_pagina1::key;
 bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE	
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"'"
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
		valor_empresa = FALSE
   CASE "cod_postal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
   CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
		valor_empresa = FALSE
   CASE "moneda"
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
		valor_empresa = FALSE
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 IF bus_campo = "provincia" then
   String prefijo,cod_pais,cod_provincia

   prefijo       = GetItemString(This.GetRow(),"prefijo_provincia")
   cod_pais      = GetItemString(This.GetRow(),"pais")
   cod_provincia = GetItemString(This.GetRow(),"provincia")

   if Trim(prefijo)="" or IsNull(prefijo) then
	      SELECT provincias.prefijo
         INTO :prefijo
         FROM provincias  
         WHERE (provincias.pais      = :cod_pais) AND  
               (provincias.provincia = :cod_provincia) USING SQLCA;
         IF SQLCA.SQLCode<>0 THEN
               prefijo=""
         END IF
         This.SetItem(This.getrow(),"prefijo_provincia",prefijo)   
   END IF
  END IF

END IF

end event

event dw_pagina1::rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
		valor_empresa = FALSE
   CASE "cod_postal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
   CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
		valor_empresa = FALSE
   CASE "moneda"
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
		valor_empresa = FALSE
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina1::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(This,"pais")
       f_valores_numericos(This,"provincia")
       f_valores_numericos(This,"idioma")
       f_valores_numericos(This,"moneda")
//       f_valores_numericos(This,"cod_postal")
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_pagina1::itemchanged;string pais,provincia
////Cuenta contable
if dwo.name='provincia' then
	pais=apartados.pagina_1.dw_pagina1.getitemstring(1,"pais")
	if not isnull(pais) and not isnull(data) then
		//Pedro Museros - 03/12/2014
		//apartados.pagina_1.dw_pagina1.SetItem(1,"cuenta",f_compone_cta_cliente(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text,pais,data))
		//apartados.pagina_7.dw_pagina7.SetItem(1,"cuenta_impagados",f_compone_cta_impagados(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text,pais,data))
	end if
end if

if dwo.name='pais' then
	provincia=apartados.pagina_1.dw_pagina1.getitemstring(1,"provincia")
	if not isnull(data) and not isnull(provincia) then
		//Pedro Museros - 03/12/2014
		//apartados.pagina_1.dw_pagina1.SetItem(1,"cuenta",f_compone_cta_cliente(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text,data,provincia))
		//apartados.pagina_7.dw_pagina7.SetItem(1,"cuenta_impagados",f_compone_cta_impagados(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text,data,provincia))
	end if	
end if

String cuenta

if row > 0 then
	if dwo.name = "cuenta" then
		cuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa, data )  
		if not isnull(cuenta) and cuenta <> ""  then
			//OK
		else
			MessageBox("Error", "La cuenta no existe")
			dwo.Primary[row] = ''
			return 2
		end if
	end if
end if
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer y = 108
integer width = 5509
integer height = 1728
string text = "S/Banco"
dw_domiciliaciones dw_domiciliaciones
end type

on pagina_2.create
this.dw_domiciliaciones=create dw_domiciliaciones
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_domiciliaciones
end on

on pagina_2.destroy
call super::destroy
destroy(this.dw_domiciliaciones)
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 5
integer y = 116
integer width = 1874
integer height = 1172
string dataobject = "dw_venclientes2"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina2::clicked;if isnull(row) or row=0 then return
call super::clicked

str_parametros lstr_param
lstr_param.i_nargumentos    = 2
CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param) 
CASE 'pb_codpostal'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"codpostal")
   OpenWithParm(wi_mant_codpostales,lstr_param)
 
END CHOOSE



end event

event dw_pagina2::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE This.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"localidad",var_localidad)   
END IF
END CHOOSE


end event

event dw_pagina2::key;
 valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"'"
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
		valor_empresa = FALSE
   CASE "codpostal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
   
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key



end event

event dw_pagina2::rbuttondown;call super::rbuttondown;valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
		valor_empresa = FALSE
   CASE "codpostal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
  
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina2::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(this,"pais")
       f_valores_numericos(This,"provincia")
//---------------------------------------------//
//---------------------------------------------//
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer y = 108
integer width = 5509
integer height = 1728
string text = "D/Envio"
dw_envios dw_envios
end type

on pagina_3.create
this.dw_envios=create dw_envios
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_envios
end on

on pagina_3.destroy
call super::destroy
destroy(this.dw_envios)
end on

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 69
integer y = 140
integer width = 2318
integer height = 1044
string dataobject = "dw_venclientes4"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina3::clicked;if isnull(row) or row=0 then return
call super::clicked

str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)  
CASE 'pb_codpostal'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"codpostal")
   OpenWithParm(wi_mant_codpostales,lstr_param) 
 
END CHOOSE



end event

event dw_pagina3::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE This.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"localidad",var_localidad)   
END IF
END CHOOSE


end event

event dw_pagina3::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"'"
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
		valor_empresa = FALSE
   CASE "codpostal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
   
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key



end event

event dw_pagina3::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
		valor_empresa = FALSE
   CASE "codpostal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
  
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina3::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(This,"pais")
       f_valores_numericos(this,"provincia")
//---------------------------------------------//
//---------------------------------------------//
end event

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer y = 108
integer width = 5509
integer height = 1728
string text = "D/Corresp"
dw_correspondencia dw_correspondencia
end type

on pagina_4.create
this.dw_correspondencia=create dw_correspondencia
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_correspondencia
end on

on pagina_4.destroy
call super::destroy
destroy(this.dw_correspondencia)
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 110
integer y = 120
integer width = 1605
integer height = 920
string dataobject = "dw_venclientes6"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina4::clicked;if isnull(row) or row=0 then return
call super::clicked

str_parametros lstr_param
lstr_param.i_nargumentos    = 2
CHOOSE CASE f_objeto_datawindow(This)
CASE 'pb_pais'
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)
CASE 'pb_codpostal'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"codpostal")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
END CHOOSE

end event

event dw_pagina4::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "pais"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provincia"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"'"
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "codpostal"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key



end event

event dw_pagina4::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE This.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"localidad",var_localidad)   
END IF
END CHOOSE


end event

event dw_pagina4::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "codpostal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer y = 108
integer width = 5509
integer height = 1728
string text = "Facturación"
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
integer x = 18
integer y = 68
integer width = 5431
integer height = 1656
string dataobject = "dw_venclientes8"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina5::rbuttondown;bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "tipo_pallet"
 		bus_datawindow = "dw_ayuda_almclasepallet"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PALLET"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
	CASE "director_comercial"
  		bus_datawindow = "dw_ayuda_director_comercial"
 		bus_titulo = "VENTANA SELECCION DIRECTORES COMERCIALES" 
	CASE "comercial"
  		bus_datawindow = "dw_ayuda_comercial"
 		bus_titulo = "VENTANA SELECCION COMERCIAL"		
	CASE "codigo_adv"
  		bus_datawindow = "dw_ayuda_ven_adv"
 		bus_titulo = "VENTANA SELECCION ADV"		
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina5::clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2
String cuenta

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_agente1"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente1")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_agente2"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_agente3"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_cod_pago"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cod_pago")
   OpenWithParm(wi_mant_carforpag,lstr_param)
CASE "pb_cod_entrega"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cod_entrega")
   OpenWithParm(wi_mant_vencondentrega,lstr_param)
CASE "pb_cuenta_ecc"
	lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
	lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"cuenta_ecc")
	OpenWithParm(wi_mant_contaplan,lstr_param)  	
CASE "pb_cuenta_ecd"
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"cuenta_ecd")
	OpenWithParm(wi_mant_contaplan,lstr_param)  	
CASE "pb_cuenta_ecgc"
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"cuenta_ecgc")
	OpenWithParm(wi_mant_contaplan,lstr_param)  	
CASE "pb_cuenta_impagados"
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"cuenta_impagados")
	OpenWithParm(wi_mant_contaplan,lstr_param)
CASE "pb_director_comercial"
   lstr_param.s_argumentos[1]=f_valor_columna(This,This.GetRow(),"director_comercial")
	OpenWithParm(wtc_mant_director_comercial,lstr_param)  	
CASE "pb_adv"
   lstr_param.s_argumentos[1]=f_valor_columna(This,This.GetRow(),"codigo_adv")
	OpenWithParm(wtc_mant_adv,lstr_param)  	
CASE "pb_comercial"
   lstr_param.s_argumentos[1]=f_valor_columna(This,This.GetRow(),"comercial")
	OpenWithParm(wtc_mant_comercial,lstr_param)  		
END CHOOSE





end event

event dw_pagina5::key; bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE	
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "tipo_pallet"
 		bus_datawindow = "dw_ayuda_almclasepallet"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PALLET"
  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "pb_banco_cobro"
  		bus_datawindow = "dw_ayuda_carbancos"
 		bus_titulo = "VENTANA SELECCION BANCOS EMPRESA"
	CASE "director_comercial"
  		bus_datawindow = "dw_ayuda_director_comercial"
 		bus_titulo = "VENTANA SELECCION DIRECTORES COMERCIALES" 
		bus_filtro = " activo = '1' "
	CASE "comercial"
  		bus_datawindow = "dw_ayuda_comercial"
 		bus_titulo = "VENTANA SELECCION COMERCIAL"	 
		bus_filtro = "activo = '1' "		 		
	CASE "codigo_adv"
  		bus_datawindow = "dw_ayuda_ven_adv"
 		bus_titulo = "VENTANA SELECCION ADV"		
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key


end event

event dw_pagina5::valores_numericos;//f_valores_numericos(This,"cod_pago")
f_valores_numericos(This,"agente1")
f_valores_numericos(This,"agente2")
f_valores_numericos(This,"agente3")
end event

event dw_pagina5::itemfocuschanged;call super::itemfocuschanged;string control_banco, var_codpago
dec descu1,descu2,descu3,descu4
string tipd1,tipd2,tipd3,tipd4
string comision_fija1,comision_fija2,comision_fija3

var_codpago   = f_valor_columna(This,This.GetRow(),'cod_pago')
control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))
//This.SetTabOrder("banco_de_cobro",310)
if control_banco = "N" then
//	This.SetTabOrder("banco_de_cobro",0)
END IF


descu1  = dec(f_valor_columna(This,This.GetRow(),'dtoesp1'))
descu2  = dec(f_valor_columna(This,This.GetRow(),'dtoesp2'))
descu3  = dec(f_valor_columna(This,This.GetRow(),'dtoesp3'))
descu4  = dec(f_valor_columna(This,This.GetRow(),'dtoesp4'))

tipd1  = f_valor_columna(This,This.GetRow(),'tipodto1')
tipd2  = f_valor_columna(This,This.GetRow(),'tipodto2')
tipd3  = f_valor_columna(This,This.GetRow(),'tipodto3')
tipd4  = f_valor_columna(This,This.GetRow(),'tipodto4')

if descu1<>0 and tipd1 = "" then 
	apartados.pagina_5.dw_pagina5.SetItem(1,"tipodto1","P")
End if
if descu2<>0 and tipd2 = "" then 
	apartados.pagina_5.dw_pagina5.SetItem(1,"tipodto2","P")
End if
if descu3<>0 and tipd3 = "" then 
	apartados.pagina_5.dw_pagina5.SetItem(1,"tipodto3","P")
End if
if descu4<>0 and tipd4 = "" then 
	apartados.pagina_5.dw_pagina5.SetItem(1,"tipodto4","P")
End if

if descu1=0 and tipd1 <> "" then 
	apartados.pagina_5.dw_pagina5.SetItem(1,"tipodto1","")
End if
if descu2=0 and tipd2 <> "" then 
	apartados.pagina_5.dw_pagina5.SetItem(1,"tipodto2","")
End if
if descu3=0 and tipd3 <> "" then 
	apartados.pagina_5.dw_pagina5.SetItem(1,"tipodto3","")
End if
if descu4=0 and tipd4 <> "" then 
	apartados.pagina_5.dw_pagina5.SetItem(1,"tipodto4","")
End if


Dec com11,com12,com21,com22,com31,com32
String age


IF GetColumnName() ="comision1" Then
	age = GetItemSTring(GetRow(),"agente1")
//	Select comision1,comision2 Into :com11,:com12 From venagentes
//	Where  venagentes.empresa = :codigo_empresa
//	And    venagentes.agente  = :age;
	comision_fija1 = f_comision_fija_agente(codigo_empresa,age)
	com11          = f_comision1_cliente_agente(codigo_empresa,age)
	com12          = f_comision2_cliente_agente(codigo_empresa,age)
	SetItem(1,"comision_fija1",comision_fija1)
	SetItem(1,"comision1",com11)
	SetItem(1,"comision11",com12)
END IF
IF GetColumnName() ="comision2" Then
	age = GetItemSTring(GetRow(),"agente2")
//	Select comision1,comision2 Into :com21,:com22 From venagentes
//	Where  venagentes.empresa = :codigo_empresa
//	And    venagentes.agente  = :age;
	comision_fija2 = f_comision_fija_agente(codigo_empresa,age)
	com21          = f_comision1_cliente_agente(codigo_empresa,age)
	com22          = f_comision2_cliente_agente(codigo_empresa,age)
	SetItem(1,"comision_fija2",comision_fija2)	
	SetItem(1,"comision2",com21)
	SetItem(1,"comision22",com22)
END IF

IF GetColumnName() ="comision31" Then
	age = GetItemSTring(GetRow(),"agente3")
//	Select comision1,comision2 Into :com31,:com32 From venagentes
//	Where  venagentes.empresa = :codigo_empresa
//	And    venagentes.agente  = :age;
	comision_fija3 = f_comision_fija_agente(codigo_empresa,age)
	com31          = f_comision1_cliente_agente(codigo_empresa,age)
	com32          = f_comision2_cliente_agente(codigo_empresa,age)
	SetItem(1,"comision_fija3",comision_fija3)
	SetItem(1,"comision31",com31)
	SetItem(1,"comision32",com32)
END IF
accepttext()
		

end event

event dw_pagina5::itemchanged;call super::itemchanged;String cuenta

if row > 0 then
	if dwo.name = "cuenta_ecc" then
		cuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa, data )  
		if not isnull(cuenta) and cuenta <> ""  then
			//OK
		else
			MessageBox("Error", "La cuenta no existe")
			dwo.Primary[row] = ''
			return 2
		end if
	elseif dwo.name = "cuenta_ecd" then
		cuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa, data )  
		if not isnull(cuenta) and cuenta <> ""  then
			//OK
		else
			MessageBox("Error", "La cuenta no existe")
			dwo.Primary[row] = ''
			return 2
		end if
	elseif dwo.name = "director_comercial" then
		
		select descripcion into :cuenta from director_comercial where empresa = :codigo_empresa and codigo = :data;
		
		if not isnull(cuenta) and cuenta <> ""  then
			//OK
		else
			MessageBox("Error", "El director comercial no existe")
			dwo.Primary[row] = ''
			return 2
		end if
	elseif dwo.name = "comercial" then
		
		select descripcion into :cuenta from comercial where empresa = :codigo_empresa and codigo = :data;
		
		if not isnull(cuenta) and cuenta <> ""  then
			//OK
		else
			MessageBox("Error", "El comercial no existe")
			dwo.Primary[row] = ''
			return 2
		end if	
	elseif dwo.name = "cuenta_ecgc" then
		cuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa, data )  
		if not isnull(cuenta) and cuenta <> ""  then
			//OK
		else
			MessageBox("Error", "La cuenta no existe")
			dwo.Primary[row] = ''
			return 2
		end if
	elseif dwo.name = "cuenta_impagados" then
		cuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa, data )  
		if not isnull(cuenta) and cuenta <> ""  then
			//OK
		else
			MessageBox("Error", "La cuenta no existe")
			dwo.Primary[row] = ''
			return 2
		end if
	end if
end if
end event

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
event create ( )
event destroy ( )
integer y = 108
integer width = 5509
integer height = 1728
string text = "Varios"
r_22 r_22
end type

on pagina_6.create
this.r_22=create r_22
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_22
end on

on pagina_6.destroy
call super::destroy
destroy(this.r_22)
end on

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
integer x = 50
integer y = 72
integer width = 2706
integer height = 1300
string dataobject = "dw_venclientes9"
boolean border = true
end type

event dw_pagina6::rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
	CASE "grupofac"
 		bus_datawindow = "dw_ayuda_vengruposfac"
		bus_titulo = "VENTANA SELECCION DE GRUPOS DE FACTURACIÓN"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
	CASE "codigo_lab"
 		bus_datawindow = "dw_ayuda_venclientes_lab"
		bus_titulo = "VENTANA SELECCION DE CLIENTES DE LABORATORIO"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina6::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_zona"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"zona")
   OpenWithParm(wi_mant_venzonas,lstr_param)  
CASE "pb_grupo"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"grupo")
   OpenWithParm(wi_mant_vengrupos,lstr_param)
CASE "pb_grupofac"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"grupofac")
   OpenWithParm(wi_mant_vengruposfac,lstr_param)
CASE "pb_serie"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"serie")
   OpenWithParm(wi_mant_venseries,lstr_param)  
//CASE "pb_cliente_lab"
//   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"codigo_lab")
//   OpenWithParm(wi_mant_venclientes_lab,lstr_param)  
END CHOOSE





end event

event dw_pagina6::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	 valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
	CASE "grupofac"
 		bus_datawindow = "dw_ayuda_vengruposfac"
		bus_titulo = "VENTANA SELECCION DE GRUPOS DE FACTURACIÓN"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
	CASE "codigo_lab"
 		bus_datawindow = "dw_ayuda_venclientes_lab"
		bus_titulo = "VENTANA SELECCION DE CLIENTES DE LABORATORIO"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_pagina6::itemchanged;call super::itemchanged;if row > 0 then
	if dwo.name = "separar_bultos" then
		if data = 'S' then
			this.object.separar_incompletos[row] = 'N'
			this.object.separar_incompletos.visible = false
			this.object.t_separar_incompletos.visible = false
		else
			this.object.separar_incompletos.visible = true
			this.object.t_separar_incompletos.visible = true
		end if	
	end if
end if
end event

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer y = 108
integer width = 5509
integer height = 1728
string text = "Expediciones"
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer x = 55
integer y = 112
integer width = 2683
integer height = 1252
string dataobject = "dw_venclientes10"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina7::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa) ,"#####")
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "cuenta_impagados"
      bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"		
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key


end event

event dw_pagina7::clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_transportista"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)
CASE "pb_tarifa"
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"tarifa")
   OpenWithParm(wi_mant_ventarifas,lstr_param)
CASE "pb_tipoiva"
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"tipoiva")
	OpenWithParm(wi_mant_contaiva,lstr_param)  
CASE "pb_cuenta_impagados"
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"cuenta_impagados")
	OpenWithParm(wi_mant_contaplan,lstr_param)  	
END CHOOSE





end event

event dw_pagina7::rbuttondown; valor_empresa = TRUE	
bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
 		bus_filtro = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa) ,"#####")
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "cuenta_impagados"
      bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"				
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina7::itemfocuschanged;call super::itemfocuschanged;
IF dw_pag7.GetItemSTring(1,"deposito")= "S" Then
	dw_pag7.SetItem(1,"pallets_enteros","S")
ELSE
	dw_pag7.SetItem(1,"pallets_enteros","")
END IF


end event

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer y = 108
integer width = 5509
integer height = 1728
string text = "Comentarios"
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
integer x = 0
integer y = 0
integer width = 5518
integer height = 1424
string dataobject = "dw_venclientes11"
boolean border = true
boolean livescroll = false
end type

type dw_domiciliaciones from datawindow within pagina_2
integer x = 1883
integer y = 116
integer width = 955
integer height = 524
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_venclientes3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;f_activar_campo(sle_valor)
IF f_objeto_datawindow(This) <> "carpeta" Then Return
str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[1]="w_ficha_venclientes"
lstr_param.i_nargumentos    = 3
lstr_param.s_argumentos[2]=sle_valor.text
row = This.GetRow()
if row<>0 then 
	  lstr_param.s_argumentos[3]=f_valor_columna(This,row,"codigo")
else
	lstr_param.s_argumentos[3]=""
End if	
 OpenWithParm(wi_mant_vendomiciliacion,lstr_param)  








end event

event doubleclicked;f_activar_campo(sle_valor)

IF row= 0 Then Return 
 var_domi=	GetItemString(row,"codigo")
 
 apartados.pagina_2.dw_pagina2.Retrieve(codigo_empresa,sle_valor.text,var_domi)

 UPDATE venclientes  
     SET venclientes.domiciliacion = :var_domi  
   WHERE ( venclientes.empresa = :codigo_empresa ) AND  
         ( venclientes.codigo  = :sle_valor.text )   ;

 COMMIT;
end event

type dw_envios from datawindow within pagina_3
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
integer x = 2405
integer y = 140
integer width = 1650
integer height = 1428
integer taborder = 12
boolean bringtotop = true
string dataobject = "dw_venclientes5"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;f_activar_campo(sle_valor)
IF f_objeto_datawindow(This) <> "carpeta" Then Return
str_parametros lstr_param
lstr_param.i_nargumentos   = 3
lstr_param.s_argumentos[1] = "w_ficha_venclientes"
lstr_param.i_nargumentos   = 3
lstr_param.s_argumentos[2] = sle_valor.text
row = This.GetRow()
if row<>0 then 
	lstr_param.s_argumentos[3] = GetItemString(row,"codigo")
else
	lstr_param.s_argumentos[3] = ""
End if	
 OpenWithParm(wi_mant_venenvio,lstr_param)  








end event

event doubleclicked;f_activar_campo(sle_valor)
IF row = 0 Then Return 

if this.object.activo[row] <> 'S' then
	messagebox("¡Error!","No se puede seleccionar una dirección no activa.")
	return
end if

var_envio = GetItemString(row,"codigo")
apartados.pagina_3.dw_pagina3.Retrieve(codigo_empresa,sle_valor.text,var_envio)
 
UPDATE venclientes  
SET    envio = :var_envio
WHERE ( venclientes.empresa = :codigo_empresa ) 
AND   ( venclientes.codigo = :sle_valor.text )   ;

COMMIT;
end event

type dw_correspondencia from datawindow within pagina_4
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
integer x = 1765
integer y = 140
integer width = 919
integer height = 524
integer taborder = 13
boolean bringtotop = true
string dataobject = "dw_venclientes7"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;f_activar_campo(sle_valor)
IF f_objeto_datawindow(This) <> "carpeta" Then Return
str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[1]="w_ficha_venclientes"
lstr_param.i_nargumentos    = 3
lstr_param.s_argumentos[2]=sle_valor.text
row = This.GetRow()
if row<>0 then 
	  lstr_param.s_argumentos[3]=f_valor_columna(this,row,"codigo")
else
	lstr_param.s_argumentos[3]=""
End if	
 OpenWithParm(wi_mant_vencorrespondencia,lstr_param) 








end event

event doubleclicked;f_activar_campo(sle_valor)
IF row= 0 Then Return 
 var_correspondencia = GetItemString(row,"codigo")
 apartados.pagina_4.dw_pagina4.Retrieve(codigo_empresa,sle_valor.text,var_correspondencia)
   UPDATE venclientes  
     SET correspondencia = :var_correspondencia
   WHERE ( venclientes.empresa = :codigo_empresa ) AND  
         ( venclientes.codigo = :sle_valor.text )   ;

 COMMIT;
end event

type r_22 from rectangle within pagina_6
integer linethickness = 4
long fillcolor = 8421376
integer x = 1669
integer y = 13428
integer width = 1472
integer height = 808
end type

type pagina9 from userobject within apartados
boolean visible = false
integer x = 18
integer y = 108
integer width = 5509
integer height = 1728
boolean enabled = false
long backcolor = 12632256
string text = "Traspaso"
long tabbackcolor = 12632256
long picturemaskcolor = 553648127
uo_empresa_destino uo_empresa_destino
dw_2 dw_2
end type

on pagina9.create
this.uo_empresa_destino=create uo_empresa_destino
this.dw_2=create dw_2
this.Control[]={this.uo_empresa_destino,&
this.dw_2}
end on

on pagina9.destroy
destroy(this.uo_empresa_destino)
destroy(this.dw_2)
end on

type uo_empresa_destino from u_empresa_destino within pagina9
integer x = 133
integer y = 100
integer width = 1385
integer height = 232
integer taborder = 11
boolean bringtotop = true
long backcolor = 79741120
borderstyle borderstyle = styleraised!
end type

on uo_empresa_destino.destroy
call u_empresa_destino::destroy
end on

event ue_procesar;call super::ue_procesar;Boolean fallo = false

String v_empresa_dest
Integer num

if not f_conectar_pipeline() then 
	f_mensaje("error","no puedo conectar")
	return
end if

v_empresa_dest = uo_empresa_destino.uo_empresa.em_codigo.text
// Paso los datos de genter
i_upipe.DataObject="paso_genter"
num=i_upipe.Start(trans,trans2,dw_2,trim(codigo_empresa),trim(v_empresa_dest),"C",sle_valor.text) 
if num<0 then
	// Error en el pipeline.
	fallo=true
	f_mensaje("Copia de Datos generales","Error en el paso de datos número: "+String(num))
end if

// Paso los datos de venclientes
i_upipe.DataObject="paso_venclientes"
num=i_upipe.Start(trans,trans2,dw_2,trim(codigo_empresa),trim(v_empresa_dest),sle_valor.text) 
if num<0 then
	// Error en el pipeline.
	fallo=true
	f_mensaje("Copia de Datos del cliente","Error en el paso de datos número: "+String(num))
end if

// Paso los datos de las domiciliaciones
i_upipe.DataObject="paso_vendomiciliacion"
num=i_upipe.Start(trans,trans2,dw_2,trim(codigo_empresa),trim(v_empresa_dest),sle_valor.text) 
if num<0 then
	// Error en el pipeline.
	fallo=true
	f_mensaje("Copia de los Datos de las domiciliaciones","Error en el paso de datos número: "+String(num))
end if

// Paso los datos de las direcciones de envio 
i_upipe.DataObject="paso_venenvio"
num=i_upipe.Start(trans,trans2,dw_2,trim(codigo_empresa),trim(v_empresa_dest),sle_valor.text) 
if num<0 then
	// Error en el pipeline.
	fallo=true
	f_mensaje("Copia de los Datos de las direcciones de envío","Error en el paso de datos número: "+String(num))
end if

// Paso los datos de las direcciones de correspondencia
i_upipe.DataObject="paso_vencorrespondencia"
num=i_upipe.Start(trans,trans2,dw_2,trim(codigo_empresa),trim(v_empresa_dest),sle_valor.text) 
if num<0 then
	// Error en el pipeline.
	fallo=true
	f_mensaje("Copia de los Datos de las direcciones de correspondencia","Error en el paso de datos número: "+String(num))
end if

// Paso los datos de la cuenta contable
i_upipe.DataObject="paso_contaplan"

num=i_upipe.Start(trans,trans2,dw_2,trim(codigo_empresa),trim(v_empresa_dest),apartados.pagina_1.dw_pagina1.GetItemString(1,"cuenta")) 
if num<0 then
	// Error en el pipeline.
	fallo=true
	f_mensaje("Copia de los Datos de la cuenta contable","Error en el paso de datos número: "+String(num))
end if

IF fallo then 
	ROLLBACK using trans2;
	f_mensaje("","El traspaso de los datos no se actualiza")
else
	COMMIT using trans2;
end if
end event

type dw_2 from datawindow within pagina9
boolean visible = false
integer x = 1719
integer y = 136
integer width = 494
integer height = 360
integer taborder = 21
boolean bringtotop = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within wi_mant_clientes2
integer x = 4727
integer y = 152
integer width = 837
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_2 from statictext within wi_mant_clientes2
integer x = 663
integer y = 172
integer width = 1842
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type pb_1 from upb_carpeta within wi_mant_clientes2
integer x = 5349
integer y = 60
integer width = 105
integer height = 92
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[2]= sle_valor.text
lstr_param.s_argumentos[3]= "C"
f_activar_campo(sle_valor)
OpenWithParm(wi_mant_telefonos,lstr_param) 

end event

type st_3 from statictext within wi_mant_clientes2
integer x = 5339
integer y = 16
integer width = 128
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cont."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within wi_mant_clientes2
integer x = 5454
integer y = 16
integer width = 123
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Seg."
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_2 from upb_carpeta within wi_mant_clientes2
event clicked pbm_bnclicked
integer x = 5463
integer y = 60
integer height = 92
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;String companyia,cliente,cuenta
str_parametros lstr_param
lstr_param.i_nargumentos=3
cliente = sle_valor.text

  SELECT venriesgoclientes.companyia,venriesgoclientes.cuenta
  INTO :companyia  ,:cuenta
    FROM venriesgoclientes  
   WHERE ( venriesgoclientes.empresa = :codigo_empresa ) AND  
         ( venriesgoclientes.cliente = :cliente );

lstr_param.s_argumentos[2]=companyia
lstr_param.s_argumentos[3]=cuenta
f_activar_campo(sle_valor)
OpenWithParm(wi_mant_venriesgosclientes,lstr_param) 

end event

type pb_calculadora from u_calculadora within wi_mant_clientes2
integer x = 544
integer y = 164
integer taborder = 20
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return

dec{0} n_pedido
Dec{0} registros,numero,anyo
String  var_empresa

registros = 0

select max(convert(integer,codigo))
into :registros
from genter
where empresa=:codigo_empresa and
		tipoter='C';
		
if isnull(registros) then registros=0

registros++

sle_valor.text=String(registros)
dw_pag1.TriggerEvent(clicked!)
end event

type st_f2 from statictext within wi_mant_clientes2
integer x = 558
integer y = 120
integer width = 91
integer height = 40
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "F2"
alignment alignment = center!
boolean focusrectangle = false
end type

