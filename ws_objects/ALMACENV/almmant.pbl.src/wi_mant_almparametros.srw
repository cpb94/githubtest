$PBExportHeader$wi_mant_almparametros.srw
forward
global type wi_mant_almparametros from wi_mant_ventanas
end type
end forward

global type wi_mant_almparametros from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2043
integer height = 936
end type
global wi_mant_almparametros wi_mant_almparametros

type variables



end variables

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "venparametros"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento almacen de materiales preparados"
istr_parametros.s_listado        = "report_venparametros"

This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
   sle_valor.text=istr_parametros.s_argumentos[2]
	IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
     	dw_1.Retrieve(sle_valor.text)
   END IF
END IF
end event

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",sle_valor.text)

end on

on wi_mant_almparametros.create
call super::create
end on

on wi_mant_almparametros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_almparametros
integer x = 23
integer y = 196
integer width = 1477
integer height = 476
string dataobject = "dw_almparametros"
end type

event dw_1::key;dw_1.AcceptText()
IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	 CASE "almacen_cargas"
      bus_titulo     = "VENTANA SELECCION  DE ALMACENES "
 		bus_datawindow = "dw_ayuda_almacenes"
		CASE "tarifa"
      bus_titulo     = "VENTANA SELECCION DE TARIFAS "
 		bus_datawindow = "dw_ayuda_ventarifas"
	CASE "almacen"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almacenes"
   CASE "zona"
      bus_titulo     = "VENTANA SELECCION DE CLIENTES"
      bus_filtro     = "almacen ='" + dw_1.GetItemString(dw_1.GetRow(),"almacen")+"'"
 		bus_datawindow = "dw_ayuda_almubizonas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"almacen")
f_valores_numericos(dw_1,"almacen_cargas")
f_valores_numericos(dw_1,"tarifa")
end event

event dw_1::rbuttondown;dw_1.AcceptText()
 bus_filtro=""
 bus_campo = This.GetColumnName()
 valor_empresa  = true 
 CHOOSE CASE bus_campo
	CASE "almacen"
      bus_titulo     = "VENTANA SELECCION DE ALMACENES "
 		bus_datawindow = "dw_ayuda_almacenes"
   CASE "zona"
      bus_titulo     = "VENTANA SELECCION DE ZONAS"
      bus_filtro     = "almacen ='" + dw_1.GetItemString(dw_1.GetRow(),"almacen")+"'"
 		bus_datawindow = "dw_ayuda_almubizonas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_almparametros
integer x = 178
integer y = 76
integer width = 283
integer height = 88
string text = "Empresa:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_almparametros
integer x = 1550
integer y = 208
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_almparametros
integer x = 1550
integer y = 336
end type

event cb_borrar::clicked;// no hace nada

MessageBox("Solo se puede modificar","",Exclamation!, OK!,1)
f_activar_campo(sle_valor)
end event

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_almparametros
integer x = 457
integer y = 76
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow = "dw_ayuda_empresas"
ue_filtro = ""
isle_campo = this
valor_empresa = FALSE
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_almparametros
integer x = 1550
integer y = 464
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_almparametros
integer taborder = 30
end type

