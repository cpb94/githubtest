$PBExportHeader$wi_mant_almcolecciones.srw
forward
global type wi_mant_almcolecciones from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_almcolecciones
end type
end forward

global type wi_mant_almcolecciones from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 2478
integer height = 1376
pb_calculadora pb_calculadora
end type
global wi_mant_almcolecciones wi_mant_almcolecciones

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Colecciones"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

//tipo_mantenimiento='C'
 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(codigo_empresa,sle_valor.text)
     END IF
END IF
end event

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "almcolecciones"

 dw_1.Retrieve(codigo_empresa,sle_valor.Text)
 CALL Super::ue_recuperar






end event

on wi_mant_almcolecciones.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_almcolecciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_almcolecciones
integer y = 236
integer width = 1883
integer height = 780
string dataobject = "dw_almcolecciones"
end type

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_filtro = ""
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_1::rbuttondown;
bus_filtro=""
bus_titulo=""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "tarifa"
		bus_datawindow = "dw_ayuda_ventarifas"
		bus_filtro = ""
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
  CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown


end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_almcolecciones
integer x = 247
integer width = 302
string text = "Código"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_almcolecciones
integer x = 2016
integer y = 332
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_almcolecciones
integer x = 2016
integer y = 460
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_almcolecciones
integer x = 553
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION COLECCIONES"
ue_datawindow     = "dw_ayuda_almcolecciones"
ue_filtro         =  ""
valor_empresa     = true
isle_campo        = This

end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_almcolecciones
integer x = 2016
integer y = 592
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_almcolecciones
end type

type pb_calculadora from u_calculadora within wi_mant_almcolecciones
integer x = 837
integer y = 84
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return

long registros

Select count(*) 
Into :registros 
From almcolecciones
where empresa = :codigo_empresa;

if isnull(registros) then registros=0

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,codigo)+1) 
   Into   :registros
   From   almcolecciones
	where empresa = :codigo_empresa;
	
	sle_valor.text=string(registros)
END IF

dw_1.TriggerEvent("Clicked")
end event

