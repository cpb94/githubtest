$PBExportHeader$wi_mant_paises_simple.srw
forward
global type wi_mant_paises_simple from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_paises_simple
end type
end forward

global type wi_mant_paises_simple from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2702
integer height = 1520
pb_calculadora pb_calculadora
end type
global wi_mant_paises_simple wi_mant_paises_simple

type variables



end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Paises"
istr_parametros.s_listado        = "report_paises"

This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
     istr_parametros.i_nargumentos=0
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	This.TriggerEvent("ue_recuperar")
			return   
     END IF
END IF
end event

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"pais",sle_valor.text)

end on

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "paises"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

on wi_mant_paises_simple.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_paises_simple.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_paises_simple
integer x = 50
integer y = 204
integer width = 2569
integer height = 1092
string dataobject = "dw_paises"
end type

on dw_1::valores_numericos;call wi_mant_ventanas`dw_1::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(dw_1,"moneda")
       f_valores_numericos(dw_1,"idioma")
//---------------------------------------------//
//---------------------------------------------//
end on

event dw_1::rbuttondown;valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "moneda"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_divisas"
		bus_titulo="AYUDA SELECCION DE MONEDAS"
   CASE "idioma"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo="AYUDA SELECCION DE IDIOMAS"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

event dw_1::key;valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "moneda"
 		bus_datawindow = "dw_ayuda_divisas"
		 valor_empresa = FALSE
		bus_titulo="AYUDA SELECCION DE MONEDAS"
   CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo="AYUDA SELECCION DE IDIOMAS"
		valor_empresa = FALSE
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_paises"

CHOOSE CASE f_objeto_datawindow(dw_1)

CASE 'pb_moneda'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  

CASE 'pb_idioma'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"idioma")
   OpenWithParm(wi_mant_idiomas,lstr_param)  

END CHOOSE





end event

on dw_1::itemfocuschanged;call wi_mant_ventanas`dw_1::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE dw_1.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String     var_postal,var_localidad
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
   This.SetItem(This.getrow(),"ciudad",var_localidad)   
END IF
END CHOOSE


end on

type st_1 from wi_mant_ventanas`st_1 within wi_mant_paises_simple
integer x = 183
integer y = 76
integer width = 265
integer height = 88
string text = "Código"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_paises_simple
integer x = 951
integer y = 76
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_paises_simple
integer x = 1399
integer y = 76
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_paises_simple
integer x = 462
integer y = 72
integer taborder = 11
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;valor_empresa = FALSE
ue_titulo   = "AYUDA SELECCION DE PAISES"
ue_datawindow = "dw_ayuda_paises"
ue_filtro = ""
isle_campo = this
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_paises_simple
integer x = 1847
integer y = 76
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_paises_simple
end type

type pb_calculadora from u_calculadora within wi_mant_paises_simple
integer x = 741
integer y = 72
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From paises;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,paises.pais)+1) 
   Into   :sle_valor.text
   From   paises;
END IF
dw_1.TriggerEvent("Clicked")
end on

