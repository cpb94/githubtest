$PBExportHeader$wi_mant_uti_parametros.srw
forward
global type wi_mant_uti_parametros from wi_mant_ventanas
end type
type gb_1 from groupbox within wi_mant_uti_parametros
end type
end forward

global type wi_mant_uti_parametros from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2085
integer height = 1008
gb_1 gb_1
end type
global wi_mant_uti_parametros wi_mant_uti_parametros

type variables



end variables

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "uti_parametros"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de parametros utilidades"
istr_parametros.s_listado        = ""

This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
   sle_valor.text=istr_parametros.s_argumentos[2]
	IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
     	dw_1.Retrieve(sle_valor.text)
   END IF
END IF


end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"indicencias","S")
   dw_1.setitem(dw_1.getrow(),"busquedas","1")

end event

on wi_mant_uti_parametros.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on wi_mant_uti_parametros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_uti_parametros
integer x = 119
integer y = 216
integer width = 1733
integer height = 516
string dataobject = "dw_int_uti_parametros"
end type

event dw_1::key;dw_1.AcceptText()
IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
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

event dw_1::rbuttondown;dw_1.AcceptText()
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
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
 CALL Super::rbuttondown
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_uti_parametros
integer x = 137
integer y = 92
integer width = 283
integer height = 88
string text = "Empresa:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_uti_parametros
integer x = 763
integer y = 84
integer width = 357
integer height = 76
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_uti_parametros
integer x = 1120
integer y = 84
integer width = 357
integer height = 76
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_uti_parametros
integer x = 434
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;valor_empresa = FALSE
ue_titulo   = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow = "dw_ayuda_empresas"
ue_filtro = ""
isle_campo = this
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_uti_parametros
integer x = 1477
integer y = 84
integer width = 357
integer height = 76
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_uti_parametros
integer taborder = 30
end type

type gb_1 from groupbox within wi_mant_uti_parametros
integer x = 750
integer y = 48
integer width = 1097
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

