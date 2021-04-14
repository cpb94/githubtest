$PBExportHeader$wi_mant_vendomiciliacion.srw
$PBExportComments$mant. domiciliaciones bancarias.
forward
global type wi_mant_vendomiciliacion from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_vendomiciliacion
end type
type st_ntelefonos from statictext within wi_mant_vendomiciliacion
end type
type st_nomcliente from statictext within wi_mant_vendomiciliacion
end type
type em_cliente from u_em_campo within wi_mant_vendomiciliacion
end type
end forward

global type wi_mant_vendomiciliacion from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2729
integer height = 1668
pb_calculadora pb_calculadora
st_ntelefonos st_ntelefonos
st_nomcliente st_nomcliente
em_cliente em_cliente
end type
global wi_mant_vendomiciliacion wi_mant_vendomiciliacion

type variables
	// Tipo Tercero

string ic_tipoter
datawindowchild idwc_nompro
datawindowchild idwc_codpostal
datawindowchild idwc_codpais,idwc_codmoneda

end variables

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

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"cliente",em_cliente.text)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)






end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;
		// Activamos los campos clave añadidos


sle_valor.enabled   = FALSE
em_cliente.enabled   = FALSE
pb_calculadora.visible=FALSE
end on

on open;call wi_mvent_con_empresa::open;pb_calculadora.visible=FALSE

istr_parametros.s_titulo_ventana = "Mantenimiento de domiciliaciones"
istr_parametros.s_listado        = "report_vendomiciliacion"

This.title=istr_parametros.s_titulo_ventana

end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;
		// Activamos los campos clave añadidos

sle_valor.enabled = TRUE
em_cliente.enabled   = TRUE
pb_calculadora.visible = TRUE
end on

on wi_mant_vendomiciliacion.create
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

on wi_mant_vendomiciliacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.st_ntelefonos)
destroy(this.st_nomcliente)
destroy(this.em_cliente)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_vendomiciliacion
integer x = 18
integer y = 308
integer width = 2153
integer height = 1176
string dataobject = "dw_vendomiciliacion"
end type

event dw_1::rbuttondown;valor_empresa = TRUE
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
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "codpostal"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
  
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

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
 		valor_empresa = False
		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"'"
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "codpostal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   
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
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cod_postal")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
 
END CHOOSE



end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_vendomiciliacion
integer x = 187
integer y = 228
integer width = 279
integer height = 68
string text = "Cliente"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_vendomiciliacion
integer x = 2217
integer y = 332
integer height = 84
end type

on cb_insertar::clicked;iF cb_insertar.enabled =TRUE THEN 
	dw_1.AcceptText()
END IF

call super::clicked


end on

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_vendomiciliacion
integer x = 2217
integer y = 448
integer height = 84
boolean cancel = true
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_vendomiciliacion
integer x = 850
integer width = 311
integer taborder = 20
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;if Trim(em_cliente.text)="" or trim(st_nomcliente.text)="" or IsNull(em_cliente.text) &
    or IsNull(st_nomcliente.text) then
        f_activar_campo(em_cliente)	
        RETURN
end iF

pb_calculadora.visible=TRUE


ue_titulo     = "AYUDA SELECCION DOMICLIACIONES"
ue_datawindow = "dw_ayuda_vendomiciliacion"
ue_filtro     = " cliente = '" + em_cliente.text + "'"
isle_campo    = this

end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_vendomiciliacion
integer x = 2217
integer y = 564
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_vendomiciliacion
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_vendomiciliacion
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_vendomiciliacion
integer width = 2578
end type

type pb_calculadora from u_calculadora within wi_mant_vendomiciliacion
integer x = 1179
integer y = 208
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return

Integer registros

Select count(*) Into :registros From vendomiciliacion
Where  vendomiciliacion.empresa       = :codigo_empresa
and    vendomiciliacion.cliente       = :em_cliente.text;

IF registros=0 THEN
 sle_valor.text="1" 
ELSE
 Select max(convert(int,vendomiciliacion.codigo)+1)
 Into   :sle_valor.text
 From   vendomiciliacion
 Where  vendomiciliacion.empresa       = :codigo_empresa
 and    vendomiciliacion.cliente       = :em_cliente.text;
END IF

dw_1.TriggerEvent("Clicked")
end on

type st_ntelefonos from statictext within wi_mant_vendomiciliacion
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

type st_nomcliente from statictext within wi_mant_vendomiciliacion
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

type em_cliente from u_em_campo within wi_mant_vendomiciliacion
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
			Return
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

