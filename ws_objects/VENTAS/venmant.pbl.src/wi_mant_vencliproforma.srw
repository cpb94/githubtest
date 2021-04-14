$PBExportHeader$wi_mant_vencliproforma.srw
forward
global type wi_mant_vencliproforma from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_vencliproforma
end type
type gb_1 from groupbox within wi_mant_vencliproforma
end type
end forward

global type wi_mant_vencliproforma from wi_mvent_con_empresa
integer width = 2935
integer height = 1720
boolean maxbox = false
pb_calculadora pb_calculadora
gb_1 gb_1
end type
global wi_mant_vencliproforma wi_mant_vencliproforma

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento clientes proforma"
	istr_parametros.s_listado        = "report_vencliproforma"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
		IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       This.TriggerEvent("ue_recuperar")
      END IF
   END IF



	
end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "vencliproforma"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"incremento","S")
	dw_1.setitem(dw_1.getrow(),"falta",datetime(today()))
	dw_1.setitem(dw_1.getrow(),"clase_pallet","1")
	dw_1.setitem(dw_1.getrow(),"activo","S")
end event

on wi_mant_vencliproforma.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
end on

on wi_mant_vencliproforma.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_vencliproforma
integer x = 27
integer y = 260
integer width = 2793
integer height = 1212
string dataobject = "dw_vencliproforma"
end type

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"pais")
f_valores_numericos(dw_1,"clase_pallet")
f_valores_numericos(dw_1,"provincia")


end event

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param

lstr_param.i_nargumentos    = 2
valor_empresa = TRUE

CHOOSE CASE f_objeto_datawindow(this)

  CASE 'pb_pais'
   valor_empresa = False
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)     
  CASE 'pb_provincia'
   valor_empresa = False
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param) 
  CASE 'pb_idioma'
   valor_empresa = False
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"idioma")
   OpenWithParm(wi_mant_idiomas,lstr_param)  
  CASE 'pb_moneda'
   valor_empresa = False
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  
END CHOOSE





end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 valor_empresa = TRUE
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 
 CHOOSE CASE  bus_campo 
	CASE "clase_pallet"
		bus_datawindow = "dw_ayuda_almclasepallet"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PALLET"
	CASE "pais"
 		valor_empresa = False
		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
	CASE "pais_origen"
 		valor_empresa = False
		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provincia"
  		valor_empresa = False
		bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "idioma"
  		valor_empresa = False
		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
   CASE "moneda"
  		valor_empresa = False
		bus_datawindow = "dw_ayuda_divisas"
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;string li_codprov
String li_codpais
 String var_provincia,var_pais
  String var_postal,var_localidad

CHOOSE CASE dw_1.GetColumnName()


CASE "localidad"
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


end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 CHOOSE CASE f_objeto_datawindow(this)
	CASE "clase_pallet"
		bus_datawindow = "dw_ayuda_almclasepallet"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PALLET"
	CASE "pais"
 		valor_empresa = False
		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
	CASE "pais_origen"
 		valor_empresa = False
		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provincia"
  		valor_empresa = False
		bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "idioma"
  		valor_empresa = False
		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
   CASE "moneda"
  		valor_empresa = False
		bus_datawindow = "dw_ayuda_divisas"
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_vencliproforma
integer x = 123
integer y = 156
integer width = 306
integer height = 88
string text = "Contacto:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_vencliproforma
integer x = 1742
integer y = 168
integer width = 357
integer height = 72
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_vencliproforma
integer x = 2098
integer y = 168
integer width = 357
integer height = 72
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_vencliproforma
integer x = 439
integer y = 148
integer width = 407
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_vencliproforma"
ue_titulo     =  "AYUDA SELECCION CLIENTES"
ue_filtro     =  ""
isle_campo    = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_vencliproforma
integer x = 2455
integer y = 168
integer width = 357
integer height = 72
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_vencliproforma
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_vencliproforma
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_vencliproforma
integer y = 8
integer width = 2633
integer height = 96
end type

type pb_calculadora from u_calculadora within wi_mant_vencliproforma
integer x = 855
integer y = 148
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From vencliproforma
 Where  vencliproforma.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,vencliproforma.codigo)+1)
  Into   :sle_valor.text
  From   vencliproforma
  Where  vencliproforma.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

type gb_1 from groupbox within wi_mant_vencliproforma
integer x = 1733
integer y = 132
integer width = 1088
integer height = 116
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

