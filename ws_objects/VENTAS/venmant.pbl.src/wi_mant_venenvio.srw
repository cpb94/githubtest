$PBExportHeader$wi_mant_venenvio.srw
$PBExportComments$Mant. direcciones de envio mercancia.
forward
global type wi_mant_venenvio from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_venenvio
end type
type st_ntelefonos from statictext within wi_mant_venenvio
end type
type st_nomcliente from statictext within wi_mant_venenvio
end type
type em_cliente from u_em_campo within wi_mant_venenvio
end type
end forward

global type wi_mant_venenvio from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2752
integer height = 1568
pb_calculadora pb_calculadora
st_ntelefonos st_ntelefonos
st_nomcliente st_nomcliente
em_cliente em_cliente
end type
global wi_mant_venenvio wi_mant_venenvio

type variables
	// Tipo Tercero

string ic_tipoter
datawindowchild idwc_nompro
datawindowchild idwc_codpostal
datawindowchild idwc_codpais,idwc_codmoneda

end variables

on open;call wi_mvent_con_empresa::open;pb_calculadora.visible=FALSE

istr_parametros.s_titulo_ventana = "Mantenimiento de direcciones de envio"
istr_parametros.s_listado        = "report_venenvio"

This.title=istr_parametros.s_titulo_ventana

end on

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim("C"))
 criterio[2]  =  trim("C")+space(20-longitud)
 longitud     =  len(Trim(em_cliente.text))
 criterio[3]  =  trim(em_cliente.text)+space(20-longitud)
 
 seleccion    =  criterio[1]+criterio[2]+criterio[3]

 tabla        = "genter"

 dw_1.Retrieve(codigo_empresa,em_cliente.text,sle_valor.text)
 CALL Super::ue_recuperar



end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"cliente",em_cliente.text)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"tarifa",'')






end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;
		// Activamos los campos clave añadidos


sle_valor.enabled   = FALSE
em_cliente.enabled   = FALSE
pb_calculadora.visible=FALSE
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;
		// Activamos los campos clave añadidos

sle_valor.enabled = TRUE
em_cliente.enabled   = TRUE
pb_calculadora.visible = TRUE
end on

on wi_mant_venenvio.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.st_ntelefonos=create st_ntelefonos
this.st_nomcliente=create st_nomcliente
this.em_cliente=create em_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.st_ntelefonos
this.Control[iCurrent+3]=this.st_nomcliente
this.Control[iCurrent+4]=this.em_cliente
end on

on wi_mant_venenvio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.st_ntelefonos)
destroy(this.st_nomcliente)
destroy(this.em_cliente)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venenvio
integer x = 23
integer y = 332
integer width = 2153
integer height = 1072
string dataobject = "dw_venenvio"
end type

on dw_1::itemfocuschanged;call wi_mvent_con_empresa`dw_1::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE dw_1.GetColumnName()
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


end on

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"'"
		valor_empresa = FALSE
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "codpostal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"		
/*		
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
  */ 
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF


end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(dw_1,"pais")
       f_valores_numericos(dw_1,"provincia")
//---------------------------------------------//
//---------------------------------------------//
end on

event dw_1::clicked;call super::clicked;valor_empresa = TRUE
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_distribuifores"
Long esta_abierta

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_pais'
	valor_empresa = FALSE
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
      
CASE 'pb_provincia'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)  
CASE 'pb_codpostal'
	esta_abierta = f_menu_ventana_esta_abierta("wi_mant_codpostales")
	//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
	if esta_abierta = -1 then
		lstr_param.s_argumentos[1] = f_valor_columna(this,This.GetRow(),"pais")
		lstr_param.s_argumentos[2] = f_valor_columna(this,This.GetRow(),"codpostal")
		lstr_param.i_nargumentos = 2
		lstr_param.nombre_ventana = "wi_mant_clientes2"
		lstr_param.resultado = ''
		Openwithparm(wi_mant_codpostales, lstr_param)
	else
		ventanas_activas[esta_abierta].ventana.BringToTop = true
	end if
CASE "pb_tarifa"
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"tarifa")
   OpenWithParm(wi_mant_ventarifas,lstr_param)	
/*	
	
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cod_postal")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
 */
END CHOOSE



end event

event dw_1::rbuttondown;valor_empresa = TRUE
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "pais"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
	CASE "codpostal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"		
/*		
		
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
  */
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venenvio
integer x = 187
integer y = 228
integer width = 279
integer height = 68
string text = "Cliente"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venenvio
integer x = 2231
integer y = 332
integer height = 84
end type

on cb_insertar::clicked;iF cb_insertar.enabled =TRUE THEN 
	dw_1.AcceptText()
END IF

call super::clicked


end on

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venenvio
integer x = 2231
integer y = 448
integer height = 84
boolean cancel = true
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venenvio
integer x = 850
integer width = 311
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;if Trim(em_cliente.text)="" or trim(st_nomcliente.text)="" or IsNull(em_cliente.text) &
    or IsNull(st_nomcliente.text) then
        f_activar_campo(em_cliente)	
        RETURN
end iF

pb_calculadora.visible=TRUE


ue_titulo     = "AYUDA SELECCION DIRECCIONES DE ENVIO"
ue_datawindow = "dw_ayuda_venenvio_mant"
ue_filtro     = " cliente = '" + em_cliente.text + "'"
isle_campo    = this

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venenvio
integer x = 2231
integer y = 564
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venenvio
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venenvio
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venenvio
integer width = 2578
end type

type pb_calculadora from u_calculadora within wi_mant_venenvio
integer x = 1179
integer y = 208
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return

Integer registros

Select count(*) Into :registros From venenvio
Where  venenvio.empresa       = :codigo_empresa
and    venenvio.cliente       = :em_cliente.text;

IF registros=0 THEN
 sle_valor.text="1" 
ELSE
 Select max(convert(int,venenvio.codigo)+1)
 Into   :sle_valor.text
 From   venenvio
 Where  venenvio.empresa       = :codigo_empresa
 and    venenvio.cliente       = :em_cliente.text;
END IF

dw_1.TriggerEvent("Clicked")
end on

type st_ntelefonos from statictext within wi_mant_venenvio
integer x = 809
integer y = 148
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Código"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_nomcliente from statictext within wi_mant_venenvio
integer x = 1312
integer y = 220
integer width = 1230
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

type em_cliente from u_em_campo within wi_mant_venenvio
integer x = 475
integer y = 212
integer width = 347
integer height = 88
integer taborder = 10
string facename = "Courier"
end type

event getfocus;call super::getfocus;pb_calculadora.visible=FALSE
dw_1.reset()

ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""		
isle_campo    = this

IF istr_parametros.i_nargumentos>1 THEN
	  em_cliente.text=istr_parametros.s_argumentos[2]
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

on modificado;call u_em_campo::modificado;st_nomcliente.text=f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
IF Trim(st_nomcliente.text)="" THEN 
 IF Trim(st_nomcliente.text)<>"" Then f_activar_campo(em_cliente)
 em_cliente.text=""
END IF


end on

