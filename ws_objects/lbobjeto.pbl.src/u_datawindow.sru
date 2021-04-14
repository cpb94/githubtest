$PBExportHeader$u_datawindow.sru
$PBExportComments$Objeto manejo de datos (Mantenientos, y tabutares con opcion a ventana de ayuda etc)
forward
global type u_datawindow from datawindow
end type
end forward

global type u_datawindow from datawindow
integer width = 1175
integer height = 472
integer taborder = 1
boolean livescroll = true
event key pbm_dwnkey
event valores_numericos pbm_custom01
event pbm_char pbm_char
event tecla_enter pbm_custom03
event ue_valores pbm_custom04
end type
global u_datawindow u_datawindow

type variables
String  bus_campo,bus_cadena,bus_filtro,bus_titulo,bus_datawindow
Boolean  ue_marca_linea
boolean control_itemchanged = true
end variables

forward prototypes
public subroutine f_valores_numericos (datawindow w, string c)
end prototypes

event key;// Ventanas de ayuda campos relacion de las datawindows
   String bus_cadena_return,ue_w_sigue
	dwobject ldwo_dwobject
	
	ue_w_sigue= "S"
  IF Trim(bus_campo)      = "" or IsNull(bus_campo) THEN  ue_w_sigue= "N"
  IF Trim(bus_datawindow) = "" or IsNull(bus_datawindow) THEN  ue_w_sigue= "N"
  
  IF ue_w_sigue = "S" Then
	//This.accepttext()
	//bus_cadena= f_valor_columna(This,This.GetRow(),This.GetColumnName())
	bus_cadena = this.GetText()
	IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""

	control_itemchanged = true

	IF KeyDown(KeyEnter!) OR (KeyDown(KeyTab!) and Trim(bus_cadena)<>"") THEN
	  str_parametros astr_parametros
	  IF KeyDown(KeyEnter!) Then bus_cadena = ""
	  astr_parametros.s_criterio_busqueda = bus_cadena
	  astr_parametros.s_nom_datawindow    = bus_datawindow
	  astr_parametros.s_filtro            = bus_filtro
	  astr_parametros.s_titulo_ayuda      = bus_titulo
	  astr_parametros.b_empresa     = valor_empresa
	  OpenWithParm(w_busquedas,astr_parametros)
	  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
	  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
        bus_cadena = f_valor_columna(This,This.GetRow(),This.GetColumnName())
	  ELSE
        bus_cadena=bus_cadena_return
     END IF
    //f_asignar_columna(This,This.getrow(),This.GetColumnName(),bus_cadena)
//	 Paco Marin 05-09-2016
//    SetColumn(This.GetColumn()) 
//    This.SetRow(This.getrow())
//    This.Setfocus()
// 	 SetText(bus_cadena)
//	 AcceptText()

	This.Setfocus()	 
//	if bus_campo <> This.GetColumnName() then
//		if this.setcolumn(bus_campo) <> -1 then
//			this.settext(bus_cadena)	
//			this.AcceptText()
//		else		
//			this.setitem(This.getrow(),bus_campo,bus_cadena)
//		end if		
//	else
//		this.settext(bus_cadena)	
//		this.AcceptText()
//	end if					 	 

	if bus_campo <> This.GetColumnName() then
		this.setcolumn(bus_campo)
		this.setitem(This.getrow(),bus_campo,bus_cadena)
	else
		this.settext(bus_cadena)	
		this.AcceptText()
	end if				


END IF
END IF

IF KeyDown(KeyEnter!) Then  This.TriggerEvent("tecla_enter")
IF KeyDown(KeyF12!) Then  This.TriggerEvent(rbuttondown!)
end event

event ue_valores;// Introducir  ue_marca_linea = False  si no queremos quwe se seleccione
// por defecto.
ue_marca_linea = FALSE
end event

public subroutine f_valores_numericos (datawindow w, string c);IF w.visible=FALSE Then Return
IF w.GetRow()=0 Then Return
IF IsNull(w.GetItemString(w.GetRow(),c)) Then  Return
IF Not IsNumber(w.GetItemString(w.GetRow(),c))Then w.SetItem(w.GetRow(),c,"")
end subroutine

event rbuttondown;// Ventanas de ayuda campos relacion de las datawindows
   String bus_cadena_return

	  control_itemchanged = true

  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  //This.accepttext()
 
  bus_cadena = "" 
  
  
  str_parametros astr_parametros
  astr_parametros.s_criterio_busqueda = bus_cadena
  astr_parametros.s_nom_datawindow    = bus_datawindow
  astr_parametros.s_filtro            = bus_filtro
  astr_parametros.s_titulo_ayuda      = bus_titulo
  astr_parametros.b_empresa     = valor_empresa
  OpenWithParm(w_busquedas,astr_parametros)
  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= f_valor_columna(This,This.GetRow(),This.GetColumnName())
     IF Not IsNumber(bus_cadena) Then
        bus_cadena=bus_cadena_return
     END IF
  ELSE
     bus_cadena=bus_cadena_return
  END IF
//    //f_asignar_columna(This,This.getrow(),This.GetColumnName(),bus_cadena)
//	 SetColumn(bus_campo)//SetColumn(This.GetColumn()) Paco Marin 05-09-2016
//    This.SetRow(This.getrow())
    This.Setfocus()
//	 SetText(bus_cadena)
//	 AcceptText()

if bus_campo <> This.GetColumnName() then
	this.setcolumn(bus_campo)
	this.setitem(This.getrow(),bus_campo,bus_cadena)
	This.accepttext()
else
	this.settext(bus_cadena)	
	this.AcceptText()
end if				
end event

event itemfocuschanged;This.TriggerEvent("valores_numericos")
end event

event clicked;If row=0 Then Return
IF ue_marca_linea = TRUE Then
  This.SelectRow(0,FALSE)
  This.SelectRow(row,TRUE)
  SetRow(row)
END IF
end event

event constructor;This.TriggerEvent("ue_valores")
end event

event rowfocuschanged;If This.GetRow()=0 Then Return
IF ue_marca_linea = TRUE Then
  This.SelectRow(0,FALSE)
  This.SelectRow(This.GetRow(),TRUE)
END IF
end event

on u_datawindow.create
end on

on u_datawindow.destroy
end on

