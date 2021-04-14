$PBExportHeader$wi_mant_distribuidores.srw
forward
global type wi_mant_distribuidores from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_distribuidores
end type
type st_ntelefonos from statictext within wi_mant_distribuidores
end type
type st_nomcliente from statictext within wi_mant_distribuidores
end type
type em_cliente from u_em_campo within wi_mant_distribuidores
end type
end forward

global type wi_mant_distribuidores from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2930
integer height = 1596
pb_calculadora pb_calculadora
st_ntelefonos st_ntelefonos
st_nomcliente st_nomcliente
em_cliente em_cliente
end type
global wi_mant_distribuidores wi_mant_distribuidores

type variables
	// Tipo Tercero

string ic_tipoter
datawindowchild idwc_nompro
datawindowchild idwc_codpostal
datawindowchild idwc_codpais,idwc_codmoneda

end variables

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"tipoter","S")
dw_1.setitem(dw_1.getrow(),"codigo_cliente",em_cliente.text)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

dw_1.SetItem(dw_1.getrow(),"sexo","H")
dw_1.SetItem(dw_1.getrow(),"activo","S")
dw_1.SetItem(dw_1.getRow(),"distribuidor","S")
dw_1.SetItem(dw_1.getrow(),"falta",DateTime(today(),now()))




end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;
		// Activamos los campos clave añadidos


sle_valor.enabled   = FALSE
em_cliente.enabled   = FALSE
pb_calculadora.visible=FALSE
end on

on open;call wi_mvent_con_empresa::open;pb_calculadora.visible=FALSE

istr_parametros.s_titulo_ventana = "Mantenimiento de Subclientes"
istr_parametros.s_listado        = "report_distribuidores"

This.title=istr_parametros.s_titulo_ventana

end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;
		// Activamos los campos clave añadidos

sle_valor.enabled = TRUE
em_cliente.enabled   = TRUE
pb_calculadora.visible = TRUE
end on

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)

 longitud     =  len(Trim(em_cliente.text))
 criterio[2]  =  trim(em_cliente.text)+space(20-longitud)
 
 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)

 seleccion    =  criterio[1]+criterio[2]+criterio[3]

 tabla        = "distribuidores"

 dw_1.Retrieve(codigo_empresa,em_cliente.text,sle_valor.text)
 CALL Super::ue_recuperar



end on

on wi_mant_distribuidores.create
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

on wi_mant_distribuidores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.st_ntelefonos)
destroy(this.st_nomcliente)
destroy(this.em_cliente)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_distribuidores
integer x = 5
integer y = 332
integer width = 2464
integer height = 1028
string dataobject = "dw_distribuidores"
end type

event dw_1::key;valor_empresa = TRUE	
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


end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(dw_1,"pais")
       f_valores_numericos(dw_1,"provincia")
       f_valores_numericos(dw_1,"idioma")
       f_valores_numericos(dw_1,"moneda")
       f_valores_numericos(dw_1,"cod_postal")
//---------------------------------------------//
//---------------------------------------------//
end on

on dw_1::itemfocuschanged;call wi_mvent_con_empresa`dw_1::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE dw_1.GetColumnName()
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


end on

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_distribuifores"

CHOOSE CASE ls_objeto

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)  
CASE 'pb_codpostal'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cod_postal")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
CASE 'pb_idioma'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"idioma")
   OpenWithParm(wi_mant_idiomas,lstr_param)  
CASE 'pb_moneda'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  
END CHOOSE



end event

event dw_1::rbuttondown;call super::rbuttondown;valor_empresa = TRUE	
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

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_distribuidores
integer x = 82
integer y = 224
integer width = 279
string text = "Cliente"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_distribuidores
integer x = 2505
integer y = 352
integer width = 366
end type

on cb_insertar::clicked;iF cb_insertar.enabled =TRUE THEN 
	dw_1.AcceptText()
END IF

call super::clicked


end on

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_distribuidores
integer x = 2505
integer y = 468
integer width = 366
boolean cancel = true
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_distribuidores
integer x = 754
integer y = 220
integer width = 311
integer taborder = 20
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;if Trim(em_cliente.text)="" or trim(st_nomcliente.text)="" or IsNull(em_cliente.text) &
    or IsNull(st_nomcliente.text) then
        f_activar_campo(em_cliente)	
        RETURN
end iF

pb_calculadora.visible=TRUE


ue_titulo     = "AYUDA SELECCION SUBCLIENTES"
ue_datawindow = "dw_ayuda_subclientes"
ue_filtro     = " codigo_cliente = '" + em_cliente.text + "'"
isle_campo    = this

end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_distribuidores
integer x = 2505
integer y = 584
integer width = 366
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_distribuidores
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_distribuidores
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_distribuidores
integer width = 2679
end type

type pb_calculadora from u_calculadora within wi_mant_distribuidores
integer x = 1083
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return

Integer registros

Select count(*) Into :registros From genter
Where  genter.empresa           = :codigo_empresa
and    genter.tipoter           = "S";


IF registros=0 THEN
 sle_valor.text="1" 
ELSE
 Select max(convert(int,genter.codigo)+1)
 Into   :sle_valor.text
 From   genter
 Where  genter.empresa       = :codigo_empresa
 and    genter.tipoter ="S";

END IF

dw_1.TriggerEvent("Clicked")
end on

type st_ntelefonos from statictext within wi_mant_distribuidores
integer x = 745
integer y = 148
integer width = 325
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
string text = "Subcliente"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_nomcliente from statictext within wi_mant_distribuidores
integer x = 1216
integer y = 224
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

type em_cliente from u_em_campo within wi_mant_distribuidores
integer x = 379
integer y = 220
integer width = 347
integer taborder = 10
end type

event getfocus;call super::getfocus;pb_calculadora.visible=FALSE
dw_1.reset()

ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
//ue_filtro     = "distribuidor = 'S' "		
isle_campo    = this

IF istr_parametros.i_nargumentos>1 THEN
     istr_parametros.i_nargumentos=0
	  em_cliente.text=istr_parametros.s_argumentos[2]
     sle_valor.text=istr_parametros.s_argumentos[3]
 	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
		  Parent.triggerEvent("ue_recuperar")
        This.TriggerEvent("Modificado")
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

