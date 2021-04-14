$PBExportHeader$wi_mant_carbancos.srw
forward
global type wi_mant_carbancos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_carbancos
end type
type gb_1 from groupbox within wi_mant_carbancos
end type
end forward

global type wi_mant_carbancos from wi_mvent_con_empresa
integer width = 2907
integer height = 1936
pb_calculadora pb_calculadora
gb_1 gb_1
end type
global wi_mant_carbancos wi_mant_carbancos

type variables

end variables

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE

end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE

end on

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de bancos"
	istr_parametros.s_listado        = "report_carbancos"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"banco",sle_valor.text)
end on

on ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "carbancos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end on

on wi_mant_carbancos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
end on

on wi_mant_carbancos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_carbancos
integer x = 46
integer y = 236
integer width = 2784
integer height = 1524
string dataobject = "dw_carbancos"
end type

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"pais")
f_valores_numericos(dw_1,"provincia")
f_valores_numericos(dw_1,"cuenta")


end on

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

event dw_1::key; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta","cta_riesgo"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
CASE "provincia"
      bus_titulo     = "VENTANA SELECCION DE PROVINCIAS "
 		bus_datawindow = "dw_ayuda_provincias"
      bus_filtro = " pais = '" + dw_1.GetItemString(dw_1.GetRow(),"pais") +"'"
CASE "pais"
      bus_titulo     = "VENTANA SELECCION DE PAISES "
 		bus_datawindow = "dw_ayuda_paises"
     
CASE "codpostal"
      bus_titulo     = "VENTANA SELECCION DE CODIGOS POSTALES "
 		bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro = " pais = '" + dw_1.GetItemString(dw_1.GetRow(),"pais") +"'"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 


end event

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_carbancos"
CHOOSE CASE ls_objeto
  
CASE 'pb_cuenta'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cuenta")
   OpenWithParm(wi_mant_contaplan,lstr_param)  
CASE 'pb_cta_riesgo'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cta_riesgo")
   OpenWithParm(wi_mant_contaplan,lstr_param)  
CASE 'pb_nuestracta'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cuenta")
   OpenWithParm(wi_mant_contaplan,lstr_param)  
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

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	
CASE "cuenta","cta_riesgo"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		 


CASE "provincia"
      bus_titulo     = "VENTANA SELECCION DE PROVINCIAS "
 		bus_datawindow = "dw_ayuda_provincias"
      bus_filtro = " pais = '" + dw_1.GetItemString(dw_1.GetRow(),"pais") +"'"
CASE "pais"
      bus_titulo     = "VENTANA SELECCION DE PAISES "
 		bus_datawindow = "dw_ayuda_paises"
     
CASE "codpostal"
      bus_titulo     = "VENTANA SELECCION DE CODIGOS POSTALES "
 		bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro = " pais = '" + dw_1.GetItemString(dw_1.GetRow(),"pais") +"'"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_carbancos
integer x = 256
integer y = 132
integer width = 251
string text = "Banco"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_carbancos
integer x = 1568
integer y = 132
integer height = 76
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_carbancos
integer x = 1984
integer y = 132
integer height = 76
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_carbancos
integer x = 507
integer y = 132
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;   ue_datawindow     = "dw_ayuda_carbancos"
   ue_titulo         = "AYUDA SELECCION DE BANCOS"
   ue_filtro         = ""
   isle_campo        = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_carbancos
integer x = 2400
integer y = 132
integer height = 76
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_carbancos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_carbancos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_carbancos
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_carbancos
integer x = 773
integer y = 128
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From carbancos
 Where  carbancos.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,carbancos.banco)+1)
  Into   :sle_valor.text
  From   carbancos
  Where  carbancos.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type gb_1 from groupbox within wi_mant_carbancos
integer x = 1554
integer y = 96
integer width = 1266
integer height = 124
integer taborder = 101
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

