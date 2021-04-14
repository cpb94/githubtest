$PBExportHeader$u_datawindow_consultas_2_criterios.sru
forward
global type u_datawindow_consultas_2_criterios from u_datawindow
end type
end forward

global type u_datawindow_consultas_2_criterios from u_datawindow
event ue_valores pbm_custom04
end type
global u_datawindow_consultas_2_criterios u_datawindow_consultas_2_criterios

type variables

end variables

event ue_valores;call super::ue_valores;// Introducir  ue_marca_linea = False  si no queremos quwe se seleccione
// por defecto.
ue_marca_linea = TRUE
end event

event key;// Ventanas de ayuda campos relacion de las datawindows
   String bus_cadena_return,ue_w_sigue
	ue_w_sigue= "S"
  IF Trim(bus_campo)      = "" or IsNull(bus_campo) THEN  ue_w_sigue= "N"
  IF Trim(bus_datawindow) = "" or IsNull(bus_datawindow) THEN  ue_w_sigue= "N"
  IF ue_w_sigue = "S" Then
	  This.accepttext()
	  bus_cadena= f_valor_columna(This,This.GetRow(),This.GetColumnName())
	  IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""

	IF KeyDown(KeyEnter!) OR (KeyDown(KeyTab!) and Trim(bus_cadena)<>"") THEN
	  str_parametros astr_parametros
	  IF KeyDown(KeyEnter!) Then bus_cadena = ""
	  astr_parametros.s_criterio_busqueda = bus_cadena
	  astr_parametros.s_nom_datawindow    = bus_datawindow
	  astr_parametros.s_filtro            = bus_filtro
	  astr_parametros.s_titulo_ayuda      = bus_titulo
	  astr_parametros.b_empresa     = valor_empresa
	  OpenWithParm(w_busquedas_2_criterios,astr_parametros)
	  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
	  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
        bus_cadena = f_valor_columna(This,This.GetRow(),This.GetColumnName())
	  ELSE
        bus_cadena=bus_cadena_return
     END IF
    //f_asignar_columna(This,This.getrow(),This.GetColumnName(),bus_cadena)
    SetColumn(This.GetColumn())
    This.SetRow(This.getrow())
    This.Setfocus()
 	 SetText(bus_cadena)
	 AcceptText()
END IF
END IF

IF KeyDown(KeyEnter!) Then  This.TriggerEvent("tecla_enter")
IF KeyDown(KeyF12!) Then  This.TriggerEvent(rbuttondown!)
end event

event rbuttondown;// Ventanas de ayuda campos relacion de las datawindows
  String bus_cadena_return

  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
 
  bus_cadena = "" 
    
  str_parametros astr_parametros
  astr_parametros.s_criterio_busqueda = bus_cadena
  astr_parametros.s_nom_datawindow    = bus_datawindow
  astr_parametros.s_filtro            = bus_filtro
  astr_parametros.s_titulo_ayuda      = bus_titulo
  astr_parametros.b_empresa           = valor_empresa
  OpenWithParm(w_busquedas_2_criterios,astr_parametros)
  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= f_valor_columna(This,This.GetRow(),This.GetColumnName())
     IF Not IsNumber(bus_cadena) Then
        bus_cadena=bus_cadena_return
     END IF
  ELSE
     bus_cadena=bus_cadena_return
  END IF
    //f_asignar_columna(This,This.getrow(),This.GetColumnName(),bus_cadena)
    SetColumn(This.GetColumn())
    This.SetRow(This.getrow())
    This.Setfocus()
	 SetText(bus_cadena)
	 AcceptText()

end event

