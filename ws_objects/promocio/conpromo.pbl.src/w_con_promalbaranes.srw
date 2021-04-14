$PBExportHeader$w_con_promalbaranes.srw
forward
global type w_con_promalbaranes from wi_mvent_con_empresa
end type
type st_barra from statictext within w_con_promalbaranes
end type
type pb_salir from upb_salir within w_con_promalbaranes
end type
type dw_report from datawindow within w_con_promalbaranes
end type
type em_anyo from u_em_campo within w_con_promalbaranes
end type
type st_cliente from statictext within w_con_promalbaranes
end type
type pb_2 from upb_imprimir within w_con_promalbaranes
end type
type cb_imprimir from u_boton within w_con_promalbaranes
end type
type cb_lineas from u_boton within w_con_promalbaranes
end type
type cb_consulta from u_boton within w_con_promalbaranes
end type
type cb_pallets from u_boton within w_con_promalbaranes
end type
type uo_cliente from u_em_campo_2 within w_con_promalbaranes
end type
type uo_manejo from u_manejo_datawindow within w_con_promalbaranes
end type
type gb_1 from groupbox within w_con_promalbaranes
end type
type dw_lineas from datawindow within w_con_promalbaranes
end type
type dw_detalle from u_datawindow within w_con_promalbaranes
end type
type dw_proceso from datawindow within w_con_promalbaranes
end type
type dw_proceso2 from datawindow within w_con_promalbaranes
end type
type dw_procesoexp from datawindow within w_con_promalbaranes
end type
end forward

global type w_con_promalbaranes from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2962
integer height = 1764
event ue_listar pbm_custom12
st_barra st_barra
pb_salir pb_salir
dw_report dw_report
em_anyo em_anyo
st_cliente st_cliente
pb_2 pb_2
cb_imprimir cb_imprimir
cb_lineas cb_lineas
cb_consulta cb_consulta
cb_pallets cb_pallets
uo_cliente uo_cliente
uo_manejo uo_manejo
gb_1 gb_1
dw_lineas dw_lineas
dw_detalle dw_detalle
dw_proceso dw_proceso
dw_proceso2 dw_proceso2
dw_procesoexp dw_procesoexp
end type
global w_con_promalbaranes w_con_promalbaranes

type variables
string antecliente, consulta // S-> Sí N-> No
String modo
end variables

forward prototypes
public function boolean f_existen_lineas ()
public subroutine f_detalle ()
public subroutine f_salir_detalle ()
end prototypes

event ue_listar;call super::ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa,uo_cliente.em_campo.text)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end event

public function boolean f_existen_lineas ();dec{0} anyo,albaran,registros
anyo    = Dec(em_anyo.text)
albaran  = Dec(sle_valor.text)
registros = 0
Select  count(*) Into :registros From promlinalb
Where   promlinalb.empresa   = :codigo_empresa
And     promlinalb.anyo      = :anyo
And     promlinalb.albaran    = :albaran;
If IsNull(registros) Then registros = 0
If registros <> 0 then
	
	Return True
Else
	Return false
 
END IF


end function

public subroutine f_detalle ();Dec{0}  var_anyo,var_pedido


var_anyo = Dec(em_anyo.text)
var_pedido = Dec(sle_valor.text)
dw_detalle.visible= TRUE
f_mascara_columna(dw_detalle,"fila","###,###")
f_mascara_columna(dw_detalle,"altura","###,###")
f_mascara_columna(dw_detalle,"pallets","###,###")

cb_borrar.enabled    = FALSE
cb_consulta.enabled  = FALSE
cb_imprimir.enabled  = FALSE
cb_insertar.enabled  = FALSE
cb_lineas.enabled    = FALSE
cb_pallets.enabled   = FALSE
cb_salir.enabled     = FALSE
dw_1.enabled         = FALSE
em_anyo.enabled      = FALSE
sle_valor.enabled    = FALSE
dw_detalle.SetTransObject(SQLCA)
dw_detalle.Retrieve(codigo_empresa,var_anyo,var_pedido)




end subroutine

public subroutine f_salir_detalle ();cb_borrar.enabled    = TRUE
cb_consulta.enabled  = TRUE
cb_imprimir.enabled  = TRUE
cb_lineas.enabled    = TRUE
cb_pallets.enabled   = TRUE
cb_salir.enabled     = TRUE
dw_1.enabled         = TRUE
em_anyo.enabled      = TRUE
sle_valor.enabled    = TRUE
dw_detalle.visible= FALSE
modo= "NORMAL"
f_activar_campo(sle_valor)
end subroutine

event ue_cursor_abajo;call super::ue_cursor_abajo;IF consulta = "S" Then f_cursor_abajo(dw_lineas)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(em_anyo.text))
 criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]+criterio[3]
 tabla        = "promalb"
 dw_1.Retrieve(codigo_empresa,Integer(em_anyo.text),Dec(sle_valor.text))
 
 cb_pallets.enabled  = TRUE
 
 CALL Super::ue_recuperar



end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"anyo",Integer(em_anyo.text))
dw_1.setitem(dw_1.getrow(),"pedido",Integer(sle_valor.text))
dw_1.setitem(dw_1.getrow(),"falta",Datetime(Today()))
dw_1.setitem(dw_1.getrow(),"falbaran",Datetime(Today()))
dw_1.setitem(dw_1.getrow(),"usuario",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"usuario_pedido",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"tipo","1")
dw_1.setitem(dw_1.getrow(),"reposicion","N")

dw_1.setitem(dw_1.getrow(),"peso_expositor",0)
dw_1.setitem(dw_1.getrow(),"coste_expositor",0)
dw_1.setitem(dw_1.getrow(),"venta_expositor",0)

dw_1.setitem(dw_1.getrow(),"peso_paneles",0)
dw_1.setitem(dw_1.getrow(),"coste_paneles",0)
dw_1.setitem(dw_1.getrow(),"venta_paneles",0)

dw_1.setitem(dw_1.getrow(),"peso_material",0)
dw_1.setitem(dw_1.getrow(),"coste_material",0)
dw_1.setitem(dw_1.getrow(),"venta_material",0)

dw_1.setitem(dw_1.getrow(),"situacion","C")
dw_1.setitem(dw_1.getrow(),"control_libre","")

cb_pallets.enabled = FALSE




end event

event ue_activa_claves;call super::ue_activa_claves;
// Activamos los campos clave añadidos

sle_valor.enabled      = TRUE
em_anyo.enabled        = TRUE
cb_lineas.enabled      = TRUE
cb_consulta.enabled    = TRUE
cb_lineas.enabled      = TRUE
cb_consulta.enabled    = TRUE
cb_imprimir.enabled    = TRUE

end event

event open;call super::open;istr_parametros.s_titulo_ventana =   "Introducción de albaranes promoción"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana
em_anyo.text                     =   String(Year(Today()))
dw_lineas.SetTransObject(SQLCA)
dw_report.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
dw_procesoexp.SetTransObject(SQLCA)
dw_lineas.SetRowFocusIndicator(Hand!)
consulta = "N"
f_activar_campo(sle_valor)
cb_pallets.enabled = FALSE
modo = "NORMAL"
end event

on ue_f6;call wi_mvent_con_empresa::ue_f6;IF cb_imprimir.visible =FALSE Then Return
cb_imprimir.TriggerEvent(Clicked!)
end on

on ue_f4;call wi_mvent_con_empresa::ue_f4;IF cb_consulta.visible =FALSE Then Return
cb_consulta.TriggerEvent(Clicked!)

end on

on ue_f5;call wi_mvent_con_empresa::ue_f5;IF cb_lineas.visible =FALSE Then Return
cb_lineas.TriggerEvent(Clicked!)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;
		// Activamos los campos clave añadidos


sle_valor.enabled      = FALSE
em_anyo.enabled        = FALSE
cb_lineas.enabled      = FALSE
cb_consulta.enabled    = FALSE
cb_lineas.enabled      = FALSE
cb_consulta.enabled    = FALSE
cb_imprimir.enabled    = FALSE

end event

on w_con_promalbaranes.create
int iCurrent
call super::create
this.st_barra=create st_barra
this.pb_salir=create pb_salir
this.dw_report=create dw_report
this.em_anyo=create em_anyo
this.st_cliente=create st_cliente
this.pb_2=create pb_2
this.cb_imprimir=create cb_imprimir
this.cb_lineas=create cb_lineas
this.cb_consulta=create cb_consulta
this.cb_pallets=create cb_pallets
this.uo_cliente=create uo_cliente
this.uo_manejo=create uo_manejo
this.gb_1=create gb_1
this.dw_lineas=create dw_lineas
this.dw_detalle=create dw_detalle
this.dw_proceso=create dw_proceso
this.dw_proceso2=create dw_proceso2
this.dw_procesoexp=create dw_procesoexp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_barra
this.Control[iCurrent+2]=this.pb_salir
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.em_anyo
this.Control[iCurrent+5]=this.st_cliente
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.cb_imprimir
this.Control[iCurrent+8]=this.cb_lineas
this.Control[iCurrent+9]=this.cb_consulta
this.Control[iCurrent+10]=this.cb_pallets
this.Control[iCurrent+11]=this.uo_cliente
this.Control[iCurrent+12]=this.uo_manejo
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.dw_lineas
this.Control[iCurrent+15]=this.dw_detalle
this.Control[iCurrent+16]=this.dw_proceso
this.Control[iCurrent+17]=this.dw_proceso2
this.Control[iCurrent+18]=this.dw_procesoexp
end on

on w_con_promalbaranes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_barra)
destroy(this.pb_salir)
destroy(this.dw_report)
destroy(this.em_anyo)
destroy(this.st_cliente)
destroy(this.pb_2)
destroy(this.cb_imprimir)
destroy(this.cb_lineas)
destroy(this.cb_consulta)
destroy(this.cb_pallets)
destroy(this.uo_cliente)
destroy(this.uo_manejo)
destroy(this.gb_1)
destroy(this.dw_lineas)
destroy(this.dw_detalle)
destroy(this.dw_proceso)
destroy(this.dw_proceso2)
destroy(this.dw_procesoexp)
end on

on ue_pagina_arriba;call wi_mvent_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_pagina_abajo;call wi_mvent_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;IF consulta = "S" Then f_cursor_arriba(dw_lineas)
end event

event ue_borra_fila;Dec{0} var_pedido
Integer var_anyo
Integer bien
var_anyo = Dec(em_anyo.text)
var_pedido = Dec(sle_valor.text)

bien = 0


Delete from promlinped
Where  promlinped.empresa = :codigo_empresa
And    promlinped.anyo    = :var_anyo
And    promlinped.pedido  = :var_pedido;
If Sqlca.SqlCode<>0 Then bien = 1


Delete from promlindetallped
Where  promlindetallped.empresa = :codigo_empresa
And    promlindetallped.anyo    = :var_anyo
And    promlindetallped.pedido  = :var_pedido;
If Sqlca.SqlCode<>0 Then bien = 1


If bien <> 0 Then
	ROLLBACK;
	f_mensaje("Error en insercion de datos"," LA operacion no se actualiza")
	Return
End IF
Call Super::ue_borra_fila
end event

event ue_f7;call super::ue_f7;IF cb_imprimir.visible =FALSE Then Return
cb_pallets.TriggerEvent(Clicked!)
end event

event activate;call super::activate;w_con_promalbaranes.triggerEvent("ue_listar")
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_con_promalbaranes
integer x = 14
integer y = 280
integer width = 2853
integer height = 1148
string dataobject = "dw_con_promalb1"
boolean livescroll = false
end type

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
  CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente") + "'"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente") + "'"
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
  CASE "transportista"
      bus_datawindow = "dw_ayuda_ventransportistas"
     	bus_titulo     = "VENTANA SELECCION DE TANSPORTISTAS"
   CASE "tipo_expositor"
      bus_datawindow = "dw_ayuda_promexpositores"
     	bus_titulo     = "VENTANA SELECCION DE TIPOS DE EXPOSITOR"
   CASE "expositor"
      bus_datawindow = "dw_ayuda_promcabexpositores"
     	bus_titulo     = "VENTANA SELECCION DE EXPOSITORES"
     IF trim(dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")) <> "" Then		  
	      bus_filtro="tipo = '" + dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")+"'"
 	  END IF
  
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key


END IF


end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
		
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMA"
	CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente") + "'"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente") + "'"
	CASE "transportista"
      bus_datawindow = "dw_ayuda_ventransportistas"
     	bus_titulo     = "VENTANA SELECCION DE TANSPORTISTAS"
	CASE "tipo_expositor"
      bus_datawindow = "dw_ayuda_promexpositores"
     	bus_titulo     = "VENTANA SELECCION DE TIPOS DE EXPOSITOR"
   CASE "expositor"
      bus_datawindow = "dw_ayuda_promcabexpositores"
     	bus_titulo     = "VENTANA SELECCION DE EXPOSITORES"
      IF trim(dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")) <> "" Then		  
	      bus_filtro="tipo = '" + dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")+"'"
 	   END IF
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;IF consulta ="S" Then Return
IF modo <> "NORMAL" Then Return

datawindow var_datawindow
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_distribuifores"

CHOOSE CASE f_objeto_datawindow(dw_1)

CASE "pb_envio"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"envio")
 OpenWithParm(wi_mant_venenvio,lstr_param)

CASE "pb_correspondencia"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"correspondencia")
 OpenWithParm(wi_mant_vencorrespondencia,lstr_param)
 
 CASE "pb_expositor"
 lstr_param.i_nargumentos    = 2
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"expositor")
 OpenWithParm(wi_mant_promcabexpositores,lstr_param)
 
 CASE "pb_tipo_expositor"
 lstr_param.i_nargumentos    = 2
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_expositor")
 OpenWithParm(wi_mant_promexpositores,lstr_param)
 CASE "pb_transpotista"
 lstr_param.i_nargumentos    = 2
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
 OpenWithParm(wi_mant_ventransportistas,lstr_param)
 
END CHOOSE


		
end event

event dw_1::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
   f_valores_numericos(dw_1,"cliente")
   f_valores_numericos(dw_1,"agente1")
   f_valores_numericos(dw_1,"agente2")
   f_valores_numericos(dw_1,"agente3")
   f_valores_numericos(dw_1,"envio")
   f_valores_numericos(dw_1,"correspondencia")
   f_valores_numericos(dw_1,"expositor")
   f_valores_numericos(dw_1,"tipo_expositor")
//---------------------------------------------//
//---------------------------------------------//
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_con_promalbaranes
integer x = 9
integer y = 180
integer width = 261
integer height = 68
string text = "Albaran:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_con_promalbaranes
integer x = 2043
integer y = 176
integer width = 256
integer height = 72
end type

event cb_insertar::clicked;IF insercion = "S" Then Return
CALL Super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_con_promalbaranes
integer x = 2304
integer y = 176
integer width = 261
integer height = 72
end type

event cb_borrar::clicked;Dec{0}   var_anyo,var_albaran,numero,var_orden
Integer reg,reg1,bien,reg2,reg3,var_linea
str_promlinped lin
str_promlindetallped detall
bien = 0 


IF messageBox("Proceso de anulado de una albaran","¿Desea volcar el albaran en situacion de pedido",Question!,YesNo!) = 1 then
	lin.empresa  = codigo_empresa
   var_anyo     = Dec(em_anyo.text)
   var_albaran  = Dec(sle_valor.text)
	  SELECT promalb.anyo_pedido,promalb.pedido  
    INTO :lin.anyo,:lin.pedido  
    FROM promalb  
   WHERE promalb.empresa = :lin.empresa
	AND   promalb.anyo    = :var_anyo
	AND   promalb.albaran = :var_albaran ;

	reg1 = dw_proceso.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
	IF reg1 <> 0 Then
	For reg = 1 to reg1
			Select count(*) Into :numero From promped
			Where  promped.empresa  = :codigo_empresa
			And    promped.anyo     = :lin.anyo
			And    promped.pedido   = :lin.pedido;
			IF IsNull(numero) Then numero = 0 
			IF numero = 0 Then
				f_mensaje("Error en proceso "," EL pedido " + String(lin.pedido) +" no existe error en volcado")
				bien = 1
			END IF
			lin.linea= Dec(f_valor_columna(dw_proceso,reg,"linea_pedido"))
			UPDATE  promlinped 
			Set situacion = "P" 
			Where empresa = :codigo_empresa
			And   anyo    = :lin.anyo
			And pedido    = :lin.pedido
			And  linea     = :lin.linea ;
			IF SQLCA.SQLCODE <> 0 Then bien = 1
	Next
   END IF
	UPDATE  promped 
	Set     promped.situacion = "P" 
	Where   promped.empresa = :codigo_empresa
	And     promped.anyo    = :lin.anyo
	And     promped.pedido    = :lin.pedido;
	IF SQLCA.SQLCODE <> 0 Then bien = 1
			
	reg1 = dw_procesoexp.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
	IF reg1 <> 0 Then
		FOR reg = 1 To reg1
			var_orden   = Dec(f_valor_columna(dw_procesoexp,reg,"orden_pedido"))
			UPDATE  prompedexp 
			Set situacion   = "P" 
			Where empresa   = :codigo_empresa
			And   anyo      = :lin.anyo
			And   pedido    = :lin.pedido
			And   orden     = :var_orden;
			IF SQLCA.SQLCODE <> 0 Then bien = 1
		Next
	END IF
        
	Delete from promalb
	Where  promalb.empresa = :codigo_empresa
	And    promalb.anyo    = :var_anyo
	And    promalb.albaran = :var_albaran;
	IF SQLCA.SQLCODE <> 0 Then bien = 1
	
	Delete from promalbexp
	Where  promalbexp.empresa = :codigo_empresa
	And    promalbexp.anyo    = :var_anyo
	And    promalbexp.albaran = :var_albaran;
	IF SQLCA.SQLCODE <> 0 Then bien = 1
	
	Delete from promlinalb
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    albaran = :var_albaran;
	IF SQLCA.SQLCODE <> 0 Then bien = 1
	
	Delete from promlindetallalb
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    albaran = :var_albaran;
	IF SQLCA.SQLCODE <> 0 Then bien = 1
	
   IF bien = 0 Then
	   COMMIT;
    ELSE
	   f_mensaje("Error en base de datos","El proceso no se actualiza")
	   ROLLBACK;
   END IF
END IF
f_activar_campo(em_anyo)


end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_con_promalbaranes
integer x = 526
integer y = 172
integer width = 265
integer taborder = 50
maskdatatype maskdatatype = numericmask!
string mask = "######"
end type

event sle_valor::getfocus;call super::getfocus;if Trim(em_anyo.text)="" or  IsNull(em_anyo.text)   then
        f_activar_campo(em_anyo)	
        RETURN
end iF


ue_titulo     = ""
ue_datawindow = ""
ue_filtro     = ""
isle_campo    = this
IF istr_parametros.i_nargumentos>1 THEN
	  em_anyo.text=istr_parametros.s_argumentos[2]
     sle_valor.text=istr_parametros.s_argumentos[3]
 	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
			dw_1.retrieve(codigo_empresa,Integer(em_anyo.text),Dec(sle_valor.text))         	
   		cb_pallets.enabled = FALSE
	   	f_activar_campo(sle_valor)     
     END IF     
	  istr_parametros.i_nargumentos=0
//ELSE
//     Sle_valor.text = ""
END IF

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_con_promalbaranes
integer x = 2569
integer y = 176
integer width = 270
integer height = 72
string text = "&Salir "
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_con_promalbaranes
integer taborder = 60
end type

event control_tabulador::getfocus;IF consulta = "S" Then 
	f_activar_campo(uo_cliente.em_campo)
Else
	CALL Super::getfocus
END IF
end event

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_con_promalbaranes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_con_promalbaranes
integer x = 23
integer width = 2679
integer height = 84
end type

type st_barra from statictext within w_con_promalbaranes
integer x = 480
integer y = 164
integer width = 46
integer height = 92
boolean bringtotop = true
integer textsize = -14
integer weight = 400
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

type pb_salir from upb_salir within w_con_promalbaranes
integer x = 2738
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

event clicked;IF consulta ="S" THEN
	gb_1.visible             = TRUE
	cb_salir.visible        = TRUE
	cb_insertar.visible     = TRUE
	cb_pallets.visible      = TRUE
	cb_borrar.visible       = TRUE
	cb_imprimir.visible     = TRUE
	cb_consulta.enabled     = TRUE
	cb_consulta.visible     = TRUE
	dw_1.enabled            = TRUE
	dw_1.visible            = TRUE
	sle_valor.enabled       = TRUE
	sle_valor.visible       = TRUE
	em_anyo.enabled         = TRUE
	em_anyo.visible         = TRUE
	st_barra.visible        = TRUE
	cb_lineas.enabled       = TRUE
	cb_lineas.visible       = TRUE
	st_1.visible            = TRUE
	
	
	
	
	uo_cliente.enabled    = FALSE
	uo_cliente.visible    = FALSE
	st_cliente.visible    = FALSE
	dw_lineas.enabled     = FALSE
	dw_lineas.visible     = FALSE
	uo_manejo.visible     = FALSE
	pb_2.visible          = FALSE
	
	
	
	
	  consulta="N"
	  IF trim(em_anyo.text) = "" Then
		f_activar_campo(em_anyo)
	  ELSE
		f_activar_campo(sle_valor)
	  END IF
	  Return
	ELSE
	  CALL Super::clicked
END IF
end event

type dw_report from datawindow within w_con_promalbaranes
boolean visible = false
integer width = 622
integer height = 144
boolean bringtotop = true
string dataobject = "report_list_promalbaranes"
boolean livescroll = true
end type

type em_anyo from u_em_campo within w_con_promalbaranes
integer x = 270
integer y = 172
integer width = 210
integer taborder = 20
string facename = "Courier"
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

event getfocus;call super::getfocus;dw_1.reset()

ue_titulo     = ""
ue_datawindow = ""
ue_filtro     = ""		
isle_campo    = this




end event

type st_cliente from statictext within w_con_promalbaranes
boolean visible = false
integer y = 180
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_2 from upb_imprimir within w_con_promalbaranes
boolean visible = false
integer x = 2752
integer y = 168
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

on clicked;call upb_imprimir::clicked;w_int_venped.triggerEvent("ue_listar")

end on

type cb_imprimir from u_boton within w_con_promalbaranes
integer x = 1454
integer y = 176
integer width = 302
integer height = 72
integer taborder = 0
boolean bringtotop = true
string text = "F6 Imprime"
end type

event clicked;call super::clicked;IF Trim(sle_valor.text) = "" THEN Return
str_parametros pa
Dec{0} var_anyo,var_albaran
var_anyo   = Dec(em_anyo.text)
var_albaran = Dec(sle_valor.text)
dw_report.Retrieve(codigo_empresa,var_anyo,var_albaran)
f_imprimir_datawindow(dw_report)
f_activar_campo(sle_valor)




end event

type cb_lineas from u_boton within w_con_promalbaranes
integer x = 1170
integer y = 176
integer width = 283
integer height = 72
integer taborder = 0
boolean bringtotop = true
string text = "F5 Lineas"
end type

event clicked;call super::clicked;Integer anyo
Dec albaran

anyo    = Integer(em_anyo.text)
albaran  = Dec(sle_valor.text)

Select promalb.pedido Into :albaran from promalb
where  promalb.empresa = :codigo_empresa
and    promalb.anyo    = :anyo
and    promalb.albaran  = :albaran;
IF SQLCA.SQLCODE = 100 Then
   MessageBox("Codigo del albaran no existe","Introduzca el albaran",Exclamation!, OK!,1)
   f_activar_campo(sle_valor)
   Return
END IF



 str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
  lstr_param.s_argumentos[4]=dw_1.GetItemString(1,"tipo_cliente")
 f_activar_campo(sle_valor)
 OpenWithParm(w_con_promlinalb,lstr_param)

end event

type cb_consulta from u_boton within w_con_promalbaranes
integer x = 841
integer y = 176
integer width = 329
integer height = 72
integer taborder = 0
boolean bringtotop = true
string text = "F4 Consulta"
end type

event clicked;call super::clicked;gb_1.visible            = FALSE
cb_consulta.enabled     = FALSE
cb_consulta.visible     = FALSE
cb_lineas.enabled       = FALSE
cb_lineas.visible       = FALSE
cb_salir.visible        = FALSE
cb_imprimir.visible     = FALSE
cb_insertar.visible     = FALSE
cb_borrar.visible       = FALSE
cb_pallets.visible      = FALSE

dw_1.enabled            = FALSE
dw_1.visible            = FALSE
sle_valor.enabled       = FALSE
sle_valor.visible       = FALSE
em_anyo.enabled         = FALSE
em_anyo.visible         = FALSE

st_barra.visible        = FALSE

st_1.visible            = FALSE


uo_cliente.visible    = TRUE
uo_cliente.enabled    = TRUE
st_cliente.visible    = TRUE
dw_lineas.visible     = TRUE
dw_lineas.enabled     = TRUE
uo_manejo.visible     = TRUE
pb_2.visible          = TRUE


consulta="S"
f_activar_campo(uo_cliente.em_campo)
end event

type cb_pallets from u_boton within w_con_promalbaranes
event clicked pbm_bnclicked
integer x = 1755
integer y = 176
integer width = 279
integer height = 72
integer taborder = 0
boolean bringtotop = true
string text = "F7 Pallets"
end type

event clicked;call super::clicked;modo ="PALLETS"
f_detalle()


end event

type uo_cliente from u_em_campo_2 within w_con_promalbaranes
event destroy ( )
boolean visible = false
integer x = 238
integer y = 160
integer width = 1111
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
END IF

dw_lineas.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end event

event getfocus;call super::getfocus;ue_titulo= "Ayuda selección clientes"
ue_datawindow= "dw_ayuda_clientes"
ue_filtro= ""

end event

type uo_manejo from u_manejo_datawindow within w_con_promalbaranes
boolean visible = false
integer x = 2277
integer y = 124
integer width = 613
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_lineas
f_activar_campo(uo_cliente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_1 from groupbox within w_con_promalbaranes
integer x = 827
integer y = 140
integer width = 2030
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_lineas from datawindow within w_con_promalbaranes
boolean visible = false
integer y = 276
integer width = 2871
integer height = 1152
string dataobject = "dw_con_promalb2"
borderstyle borderstyle = styleraised!
end type

event clicked;If consulta ="N" THEN Return
IF Row =0 Then
 f_activar_campo(uo_cliente.em_campo)
 Return
END IF

em_anyo.text    = String(This.GetItemNumber(Row,"anyo"))
sle_valor.text  = String(This.GetItemNumber(Row,"albaran"))


pb_salir.TriggerEvent(clicked!)
end event

type dw_detalle from u_datawindow within w_con_promalbaranes
boolean visible = false
integer x = 14
integer y = 276
integer width = 2857
integer height = 696
integer taborder = 0
boolean titlebar = true
string title = "DETALLE PALLETS ALBARANES PROMOCION"
string dataobject = "dw_con_promalb3"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;call super::clicked;IF f_objeto_datawindow(This) = "salir"  Then  f_salir_detalle()

end event

type dw_proceso from datawindow within w_con_promalbaranes
boolean visible = false
integer width = 494
integer height = 140
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_proceso_promlinalb"
boolean livescroll = true
end type

type dw_proceso2 from datawindow within w_con_promalbaranes
boolean visible = false
integer x = 407
integer y = 16
integer width = 494
integer height = 360
integer taborder = 70
string dataobject = "dw_proceso_promlindetallalb"
boolean livescroll = true
end type

type dw_procesoexp from datawindow within w_con_promalbaranes
boolean visible = false
integer x = 914
integer width = 494
integer height = 140
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_proceso_promalbexp"
boolean livescroll = true
end type

type pb_calculadora from u_calculadora within w_con_promalbaranes
int X=787
int Y=165
int TabOrder=0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
IF Trim(em_anyo.text)=""  THEN Return

dec{0} n_pedido
Dec{0} registros,numero,anyo
String  var_empresa

anyo = Integer(em_anyo.text)
registros = 0
  SELECT promcontador.empresa,promcontador.pedidos  
    INTO :var_empresa,:registros  
    FROM promcontador  
   WHERE promcontador.empresa = :codigo_empresa  
   And   promcontador.anyo    = :anyo ;
   If Sqlca.Sqlcode=100 Then
		IF IsNull(registros) Then registros = 0
       INSERT INTO promcontador (empresa,anyo,pedidos)  
       VALUES (:codigo_empresa,:anyo,:registros );
       COMMIT;
   END IF
   IF IsNull(registros) Then registros=0
   registros=registros + 1
   n_pedido= registros

   Select count(*) Into :numero From promped
   Where   promped.empresa  = :codigo_empresa
   And     promped.anyo     = :anyo
   And     promped.pedido   = :n_pedido;
   If IsNull(numero) Then numero=0
   If numero<>0 Then
       Select max((promped.pedido)+1)
       Into   :sle_valor.text
       From   promped
       Where  promped.empresa = :codigo_empresa
       And    promped.anyo    = :anyo;
       registros= Dec(sle_valor.text)
   End If
   UPDATE promcontador  
   SET    pedidos = :registros  
   WHERE  promcontador.empresa = :codigo_empresa
   And    promcontador.anyo    = :anyo;
   COMMIT;

   sle_valor.text=String(registros)
   dw_1.TriggerEvent("Clicked")
end event

