$PBExportHeader$wi_mant_venagentes.srw
$PBExportComments$Mant. Agentes comerciales.
forward
global type wi_mant_venagentes from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_venagentes
end type
type gb_1 from groupbox within wi_mant_venagentes
end type
end forward

global type wi_mant_venagentes from wi_mvent_con_empresa
integer width = 2862
integer height = 2988
boolean maxbox = false
pb_calculadora pb_calculadora
gb_1 gb_1
end type
global wi_mant_venagentes wi_mant_venagentes

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de agentes"
	istr_parametros.s_listado        = "report_venagentes"
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

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "venagentes"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"agente",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"nacional","S")
end event

on wi_mant_venagentes.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
end on

on wi_mant_venagentes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venagentes
integer x = 14
integer y = 256
integer width = 2793
integer height = 2520
string dataobject = "dw_venagentes"
boolean vscrollbar = true
end type

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"pais")
f_valores_numericos(dw_1,"provincia")
f_valores_numericos(dw_1,"paisbanco")
f_valores_numericos(dw_1,"provinciabanco")
f_valores_numericos(dw_1,"cuenta")

end on

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
valor_empresa= TRUE
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_transportistas"

CHOOSE CASE ls_objeto
CASE 'pb_moneda'
   lstr_param.s_argumentos[2] = f_valor_columna(this,This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  

CASE "pb_tipoiva"
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"tipo_iva")
	OpenWithParm(wi_mant_contaiva,lstr_param)  
CASE 'pb_paisbanco'
	valor_empresa= FALSE
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"paisbanco")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provinciabanco'
	valor_empresa= FALSE
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"paisbanco")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provinciabanco")
   OpenWithParm(wi_mant_provincias,lstr_param)   

CASE 'pb_codpostalbanco'
	valor_empresa= FALSE
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"codpostalbanco")
   OpenWithParm(wi_mant_codpostales,lstr_param) 
CASE 'pb_pais'
	valor_empresa= FALSE
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
	valor_empresa= FALSE
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param) 
CASE 'pb_cuenta'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cuenta")
   OpenWithParm(wi_mant_contaplan,lstr_param) 

CASE 'pb_codpostal'
		valor_empresa= FALSE
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"codpostal")
   OpenWithParm(wi_mant_codpostales,lstr_param) 
 
END CHOOSE





end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
 	CASE "tipo_iva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa) ,"#####")
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
   CASE "moneda"
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
		valor_empresa = FALSE
  CASE "paisbanco"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provinciabanco"
		valor_empresa = FALSE		
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"paisbanco")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "codpostalbanco"
		valor_empresa = FALSE		
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"paisbanco")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
 
 CASE "cuenta"
      bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio = "+ String(f_ejercicio_activo(codigo_empresa))
		bus_titulo = "VENTANA SELECCION DE CUENTAS"
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
 CALL Super::Key
END IF

end event

on dw_1::itemfocuschanged;call wi_mvent_con_empresa`dw_1::itemfocuschanged;string li_codprov
String li_codpais
 String var_provincia,var_pais
  String var_postal,var_localidad

CHOOSE CASE dw_1.GetColumnName()

CASE "localidadbanco"
  

  var_pais      = This.GetItemString(This.GetRow(),'paisbanco')
  var_provincia = This.GetItemString(This.GetRow(),'provinciabanco')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostalbanco')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provinciabanco",var_provincia)
   This.SetItem(This.getrow(),"localidadbanco",var_localidad)   
END IF


CASE "localidad"
 

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

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa= TRUE
 CHOOSE CASE bus_campo
 	CASE "paisbanco"
		valor_empresa= FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "moneda"
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
		valor_empresa = FALSE		
   CASE "provinciabanco"
			valor_empresa= FALSE
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"paibanco")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "codpostalbanco"
			valor_empresa= FALSE
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"paisbanco")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"

	CASE "pais"
		valor_empresa= FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provincia"
			valor_empresa= FALSE
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
  CASE "cuenta"
      bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio = "+ String(f_ejercicio_activo(codigo_empresa))
		bus_titulo = "VENTANA SELECCION DE CUENTAS"
   CASE "codpostal"
			valor_empresa= FALSE
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"paisbanco")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
 	CASE "tipo_iva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa) ,"#####")
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venagentes
integer x = 73
integer y = 140
integer width = 283
string text = "Agente"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venagentes
integer x = 1545
integer y = 144
integer width = 357
integer height = 80
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venagentes
integer x = 1902
integer y = 144
integer width = 357
integer height = 80
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venagentes
integer x = 393
integer y = 136
integer height = 92
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow =  "dw_ayuda_venagentes"
ue_titulo     =  "AYUDA SELECCION AGENTES"
ue_filtro     =  ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venagentes
integer x = 2258
integer y = 144
integer width = 357
integer height = 80
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venagentes
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venagentes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venagentes
integer y = 4
integer width = 2816
integer height = 96
end type

type pb_calculadora from u_calculadora within wi_mant_venagentes
integer x = 658
integer y = 136
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From venagentes
 Where  venagentes.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,venagentes.agente)+1)
  Into   :sle_valor.text
  From   venagentes
  Where  venagentes.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type gb_1 from groupbox within wi_mant_venagentes
integer x = 1531
integer y = 104
integer width = 1106
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

