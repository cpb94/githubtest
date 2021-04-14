$PBExportHeader$wi_mant_promseries.srw
forward
global type wi_mant_promseries from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_promseries
end type
type gb_1 from groupbox within wi_mant_promseries
end type
end forward

global type wi_mant_promseries from wi_mvent_con_empresa
integer width = 2834
integer height = 1704
pb_calculadora pb_calculadora
gb_1 gb_1
end type
global wi_mant_promseries wi_mant_promseries

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
string alta,codigo_cliente,tipoexpositor,valorpase,tipopro
end variables

event open;call super::open;   	
	istr_parametros.s_titulo_ventana = "Mantenimiento series expositores"
	istr_parametros.s_listado        = "report_promseries"
   This.title = istr_parametros.s_titulo_ventana
		
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text = istr_parametros.s_argumentos[2]
		istr_parametros.i_nargumentos=0
		IF Trim(sle_valor.text)<>"" Then
          This.TriggerEvent("ue_recuperar")
	   END IF
   END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "promseries"

     	 			 		
dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"fpedido",datetime(today()))
dw_1.setitem(dw_1.getrow(),"situacion","P")
end event

on wi_mant_promseries.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
end on

on wi_mant_promseries.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event activate;call super::activate;wi_mant_promseries = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_promseries
integer x = 18
integer y = 292
integer width = 2725
integer height = 1120
string dataobject = "dw_promseries"
end type

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param

// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

lstr_param.i_nargumentos    = 2

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
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"codpostal")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
END CHOOSE





end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
valor_empresa = TRUE
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "pais"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   cASE "clase_panel"
		bus_datawindow = "dw_ayuda_promclasepanel"
		bus_titulo = "VENTANA SELECCION CLASE PANELES"	
   CASE "cliente"
		bus_datawindow = "dw_ayuda_clientes"
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
   CASE "proveedor"
 		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
   CASE "tipo_expositor"
 		bus_datawindow = "dw_ayuda_promexpositores"
		bus_titulo = "VENTANA SELECCION TIPO EXPOSITORES"   
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
END IF

end event

on dw_1::itemfocuschanged;call wi_mvent_con_empresa`dw_1::itemfocuschanged;string li_codprov
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

event dw_1::rbuttondown;valor_empresa = TRUE
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   cASE "clase_panel"
		bus_datawindow = "dw_ayuda_promclasepanel"
		bus_titulo = "VENTANA SELECCION CLASE PANELES"	
   CASE "cliente"
		bus_datawindow = "dw_ayuda_clientes"
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
	CASE "proveedor"
 		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
   CASE "tipo_expositor"
 		bus_datawindow = "dw_ayuda_promexpositores"
		bus_titulo = "VENTANA SELECCION TIPO EXPOSITORES"   
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

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_promseries
integer x = 233
integer y = 196
integer width = 283
string text = "NºSerie:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_promseries
integer x = 1161
integer y = 192
integer height = 76
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_promseries
integer x = 1573
integer y = 192
integer height = 76
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_promseries
integer x = 526
integer y = 184
integer width = 297
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_promseries"
ue_titulo     =  "AYUDA SELECCION SERIES EXPOSITORES"
ue_filtro     =  ""
isle_campo    = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_promseries
integer x = 1984
integer y = 192
integer height = 76
end type

event cb_salir::clicked;if tipopro="S" then
  IF cb_insertar.enabled=TRUE THEN
         // saldo de proceso de altas
			IF insercion = "S" Then
			 sle_valor.text = ""
          sle_valor.TriggerEvent("modificado")
  		    cb_borrar.enabled  =FALSE
			 dw_1.Reset()
  		   END IF
         insercion= "N"
			Parent.TriggerEvent("ue_desbloquear")
			Parent.TriggerEvent("ue_recuperar")
         cb_insertar.enabled = FALSE
	     	Parent.TriggerEvent("ue_activa_claves")
        
         f_activar_campo(sle_valor)
     ELSE
         Closewithreturn(Parent,valorpase)
   END IF
else
	    call super::clicked
End if



end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_promseries
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_promseries
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_promseries
integer width = 2743
end type

type pb_calculadora from u_calculadora within wi_mant_promseries
integer x = 827
integer y = 184
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return

 Integer registros
 Select count(*) Into :registros From promseries
 Where  promseries.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,promseries.codigo)+1)
  Into   :sle_valor.text
  From   promseries
  Where  promseries.empresa = :codigo_empresa;
 END IF

 dw_1.TriggerEvent("Clicked")
end event

type gb_1 from groupbox within wi_mant_promseries
integer x = 1147
integer y = 152
integer width = 1257
integer height = 124
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

