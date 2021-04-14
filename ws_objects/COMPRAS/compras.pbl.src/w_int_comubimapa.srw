$PBExportHeader$w_int_comubimapa.srw
forward
global type w_int_comubimapa from w_int_con_empresa
end type
type pb_2 from upb_salir within w_int_comubimapa
end type
type dw_proceso from datawindow within w_int_comubimapa
end type
type dw_almacenes from datawindow within w_int_comubimapa
end type
type dw_zonas from datawindow within w_int_comubimapa
end type
type cb_insertar from u_boton within w_int_comubimapa
end type
type cb_borrar from u_boton within w_int_comubimapa
end type
type cb_actualizar from u_boton within w_int_comubimapa
end type
type cb_salir from u_boton within w_int_comubimapa
end type
type dw_1 from u_datawindow within w_int_comubimapa
end type
end forward

global type w_int_comubimapa from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2240
integer height = 1528
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
dw_proceso dw_proceso
dw_almacenes dw_almacenes
dw_zonas dw_zonas
cb_insertar cb_insertar
cb_borrar cb_borrar
cb_actualizar cb_actualizar
cb_salir cb_salir
dw_1 dw_1
end type
global w_int_comubimapa w_int_comubimapa

type variables
String ante_articulo,retrasos
datawindow dw_data
String donde
end variables

forward prototypes
public subroutine f_zonas ()
public subroutine f_ir ()
public subroutine f_desactivar ()
public subroutine f_activar ()
public function boolean control_dw_1 ()
public function boolean f_control_ubica2 (string var_zona, integer var_fila_desde, integer var_fila_hasta, integer var_altura_desde, integer var_altura_hasta)
public function boolean f_control_ubicacion (integer re, string var_zona, integer var_fila_desde, integer var_fila_hasta, integer var_altura_desde, integer var_altura_hasta, datawindow data)
end prototypes

public subroutine f_zonas ();String almacen
IF dw_almacenes.GetRow()= 0 Then Return
almacen= dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")
dw_zonas.Retrieve(codigo_empresa,almacen)
dw_1.Retrieve(codigo_empresa,almacen)

end subroutine

public subroutine f_ir ();String zona
Integer registro
If dw_zonas.GetRow() = 0 Then Return
zona = dw_zonas.GetItemString(dw_zonas.GetRow(),"zona")
IF dw_1.RowCount()<> 0 Then 
 registro = dw_1.find("zona = '" + zona + "'",1,dw_1.RowCount())
 dw_1.ScrollToRow(registro)
END IF

end subroutine

public subroutine f_desactivar ();dw_almacenes.enabled = FALSE
dw_zonas.enabled     = FALSE
pb_2.enabled         = FALSE
cb_insertar.visible = TRUE
cb_borrar.visible = TRUE
cb_actualizar.visible = TRUE
cb_salir.visible = TRUE
end subroutine

public subroutine f_activar ();dw_almacenes.enabled = TRUE
dw_zonas.enabled = TRUE
pb_2.enabled = TRUE
dw_almacenes.SetFocus()
cb_insertar.visible = FALSE
cb_borrar.visible = FALSE
cb_actualizar.visible = FALSE
cb_salir.visible = FALSE
end subroutine

public function boolean control_dw_1 ();Integer reg,re,var_fila_desde,var_fila_hasta,var_altura_desde,var_altura_hasta,re1
Dec{0}   var_largo
String  var_zona,argumento,var_almacen,argumento2
reg = dw_1.RowCount()
If reg = 0 Then Return TRUE
For re = 1 To reg
	var_fila_desde     =   dw_1.GetItemNumber(re, "fila_desde")
	var_fila_hasta     =   dw_1.GetItemNumber(re, "fila_hasta")
	var_altura_desde   =   dw_1.GetItemNumber(re, "altura_desde")
	var_altura_hasta   =   dw_1.GetItemNumber(re, "altura_hasta")
	var_almacen   =   dw_1.GetItemString(re,"almacen")
   var_zona   =   dw_1.GetItemString(re,"zona")
IF Trim(f_nombre_zona_compras(codigo_empresa,var_almacen,var_zona)) = "" Then
		 f_mensaje("Error en datos","La zona no existe")
		 dw_1.SetRow(re)
		 dw_1.ScrollToRow(re)
		 dw_1.SetColumn("fila_desde")
		 dw_1.SetFocus()
		 Return FALSE
   END IF		
	var_largo          =   dw_1.GetItemNumber(re, "largo")
	
	IF f_control_ubicacion(re,var_zona,var_fila_desde,var_fila_hasta,var_altura_desde,var_altura_hasta,dw_1) Then
		 f_mensaje("Error en introducción de datos","Existen zonas duplicadas")
		 dw_1.SetRow(re)
		 dw_1.ScrollToRow(re)
		 dw_1.SetColumn("fila_desde")
		 dw_1.SetFocus()
		 Return FALSE
	END IF

	
	IF IsNull(var_fila_desde)     Then var_fila_desde   = 0
	IF IsNull(var_fila_hasta)     Then var_fila_hasta   = 0
	IF IsNull(var_altura_desde)   Then var_altura_desde = 0
	IF IsNull(var_altura_hasta)   Then var_altura_hasta = 0
	
	dw_1.SetItem(re,"fila_desde",   var_fila_desde)
	dw_1.SetItem(re,"fila_hasta",   var_fila_hasta)
	dw_1.SetItem(re,"altura_desde", var_altura_desde)
	dw_1.SetItem(re,"altura_hasta", var_altura_hasta)
	
	
	IF var_fila_desde > var_fila_hasta  Then
		 f_mensaje("Error en introducción de datos","La fila desde no puede se inferior a la fila hasta")
		 dw_1.SetRow(re)
		 dw_1.ScrollToRow(re)
		 dw_1.SetColumn("fila_desde")
		 dw_1.SetFocus()
		 Return FALSE
	END IF
	
	
	IF var_altura_desde > var_altura_hasta  Then
		 f_mensaje("Error en introducción de datos","La altura desde no puede se inferior a la altura hasta")
		 dw_1.SetRow(re)
		 dw_1.ScrollToRow(re)
		 dw_1.SetColumn("altura_desde")
		 dw_1.SetFocus()
		 Return FALSE
	END IF
	
	
Next

Return TRUE
end function

public function boolean f_control_ubica2 (string var_zona, integer var_fila_desde, integer var_fila_hasta, integer var_altura_desde, integer var_altura_hasta);Integer registro,registros,r_fila_desde,r_fila_hasta,r_altura_desde,r_altura_hasta,bien1,bien2
String  r_zona

registros = dw_1.Rowcount()
For registro = 1 To registros
	r_zona = dw_1.GetItemString(registro,"zona")
	r_fila_desde   = dw_1.GetItemNumber(registro,"fila_desde")
	r_fila_hasta   = dw_1.GetItemNumber(registro,"fila_hasta")
	r_altura_desde = dw_1.GetItemNumber(registro,"altura_desde")
	r_altura_hasta = dw_1.GetItemNumber(registro,"altura_hasta")
	 IF r_zona = var_zona Then
bien1 = 0		
bien2 = 0		
CHOOSE CASE var_fila_desde
	CASE r_fila_desde To r_fila_hasta
		CHOOSE CASE var_altura_desde
			CASE r_altura_desde To r_altura_hasta
				bien1 = 1
		END CHOOSE
 END CHOOSE
 CHOOSE CASE var_fila_hasta
	CASE r_fila_desde To r_fila_hasta
		CHOOSE CASE var_altura_hasta
			CASE r_altura_desde To r_altura_hasta
      		bien2 = 1
		END CHOOSE
     END CHOOSE
 END IF	
IF bien1= 1 and bien2= 1 Then	Return True
Next



 Return False

end function

public function boolean f_control_ubicacion (integer re, string var_zona, integer var_fila_desde, integer var_fila_hasta, integer var_altura_desde, integer var_altura_hasta, datawindow data);Integer registro,registros,r_fila_desde,r_fila_hasta,r_altura_desde,r_altura_hasta
String  r_zona

registros = data.Rowcount()
For registro = 1 To registros
	r_zona = data.GetItemString(registro,"zona")
	r_fila_desde   = data.GetItemNumber(registro,"fila_desde")
	r_fila_hasta   = data.GetItemNumber(registro,"fila_hasta")
	r_altura_desde = data.GetItemNumber(registro,"altura_desde")
	r_altura_hasta = data.GetItemNumber(registro,"altura_hasta")
	IF registro <> re Then
	 IF r_zona = var_zona Then
		
CHOOSE CASE var_fila_desde
	CASE r_fila_desde To r_fila_hasta
		CHOOSE CASE var_altura_desde
			CASE r_altura_desde To r_altura_hasta
				RETURN TRUE
		END CHOOSE
 END CHOOSE
 
CHOOSE CASE var_fila_hasta
	CASE r_fila_desde To r_fila_hasta
		CHOOSE CASE var_altura_hasta
			CASE r_altura_desde To r_altura_hasta
				RETURN TRUE
		END CHOOSE
 END CHOOSE
	 END IF	
   END IF
Next

Return False
end function

event ue_listar;//String almacen
//IF dw_almacenes.GetRow()= 0 Then Return
//almacen= dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")
//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//dw_report.Retrieve(codigo_empresa,almacen)
//CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_zonas.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
dw_almacenes.SetTransObject(sqlca)
dw_almacenes.SetRowFocusIndicator(Hand!)
dw_almacenes.Retrieve(codigo_empresa)
f_mascara_columna(dw_1,"largo","###,###")
f_mascara_columna(dw_1,"fila_hasta","###")
f_mascara_columna(dw_1,"fila_desde","###")
dw_zonas.SetRowFocusIndicator(Hand!)
This.title = "INTRODUCCION  UBICACIONES DE ALMACENES DE COMPRAS"

dw_almacenes.Setfocus()


end event

on w_int_comubimapa.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
this.dw_almacenes=create dw_almacenes
this.dw_zonas=create dw_zonas
this.cb_insertar=create cb_insertar
this.cb_borrar=create cb_borrar
this.cb_actualizar=create cb_actualizar
this.cb_salir=create cb_salir
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.dw_almacenes
this.Control[iCurrent+4]=this.dw_zonas
this.Control[iCurrent+5]=this.cb_insertar
this.Control[iCurrent+6]=this.cb_borrar
this.Control[iCurrent+7]=this.cb_actualizar
this.Control[iCurrent+8]=this.cb_salir
this.Control[iCurrent+9]=this.dw_1
end on

on w_int_comubimapa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_proceso)
destroy(this.dw_almacenes)
destroy(this.dw_zonas)
destroy(this.cb_insertar)
destroy(this.cb_borrar)
destroy(this.cb_actualizar)
destroy(this.cb_salir)
destroy(this.dw_1)
end on

event ue_f2;call super::ue_f2;cb_insertar.TriggerEvent(Clicked!)
end event

event ue_f3;call super::ue_f3;cb_borrar.TriggerEvent(Clicked!)
end event

event ue_f4;call super::ue_f4;cb_actualizar.TriggerEvent(Clicked!)
end event

event ue_esc;call super::ue_esc;cb_salir.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_comubimapa
integer x = 238
integer y = 1024
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_comubimapa
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_comubimapa
integer x = 27
integer y = 20
integer width = 1989
end type

type pb_2 from upb_salir within w_int_comubimapa
integer x = 2043
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_proceso from datawindow within w_int_comubimapa
boolean visible = false
integer x = 18
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_comtipomov"
boolean livescroll = true
end type

type dw_almacenes from datawindow within w_int_comubimapa
integer x = 18
integer y = 124
integer width = 1367
integer height = 368
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_int_comubicaciones1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event getfocus;This.BorderStyle = StyleLowered!
f_datawindow_border_entrada(This)
f_zonas()
donde = "NO"
end event

event rowfocuschanged;f_zonas()
end event

event losefocus;This.BorderStyle = StyleRaised!
f_datawindow_border_salida(This)
end event

type dw_zonas from datawindow within w_int_comubimapa
integer x = 1568
integer y = 132
integer width = 603
integer height = 368
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_int_comubicaciones2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event getfocus;This.BorderStyle = StyleLowered!
f_datawindow_border_entrada(This)
f_ir()
donde = "NO"
end event

event rowfocuschanged;f_ir()
end event

event losefocus;This.BorderStyle = StyleRaised!
f_datawindow_border_salida(This)

end event

type cb_insertar from u_boton within w_int_comubimapa
boolean visible = false
integer x = 1563
integer y = 588
integer height = 92
integer taborder = 0
string text = "F2 Insertar"
end type

event clicked;IF This.visible = FALSE Then Return
Integer reg
reg = dw_data.GetRow()
reg = reg - 1
If reg <1 Then reg = 1
dw_data.InsertRow(reg)
dw_data.SetItem(reg,"empresa",codigo_empresa)
dw_data.SetItem(reg,"almacen",dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo"))
dw_data.Setfocus()
dw_data.SetRow(reg)
dw_data.SetItem(reg,"zona",dw_zonas.getitemString(dw_zonas.getRow(),"zona"))
dw_data.SetColumn("zona")

end event

type cb_borrar from u_boton within w_int_comubimapa
boolean visible = false
integer x = 1563
integer y = 696
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = "F3 Borrar"
end type

event clicked;call super::clicked;IF This.visible = FALSE Then Return
If dw_data.GetRow() <> 0 Then
	dw_data.DeleteRow(dw_data.GetRow())
	dw_data.SetColumn("zona")
END IF
end event

type cb_actualizar from u_boton within w_int_comubimapa
boolean visible = false
integer x = 1563
integer y = 804
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = "F4 Actualizar"
end type

event clicked;dw_1.AcceptText()

IF This.visible = FALSE Then Return
If Not control_dw_1() Then Return

dw_1.Update()
COMMIT;
cb_salir.TriggerEvent(Clicked!)
end event

type cb_salir from u_boton within w_int_comubimapa
boolean visible = false
integer x = 1563
integer y = 912
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = "Esc Salir"
boolean cancel = true
end type

event clicked;call super::clicked;IF This.visible = FALSE Then Return
f_activar()
end event

type dw_1 from u_datawindow within w_int_comubimapa
integer x = 23
integer y = 508
integer width = 965
integer height = 820
integer taborder = 20
string dataobject = "dw_int_comubicaciones3"
end type

event losefocus;call super::losefocus;This.BorderStyle = StyleRaised!
f_datawindow_border_salida(This)
end event

event getfocus;call super::getfocus;This.BorderStyle = StyleLowered!
f_datawindow_border_entrada(This)
donde ="DW_1"
dw_data= This
f_desactivar()
end event

event key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "zona"
      bus_titulo     = "VENTANA SELECCION DE ZONAS "
 		bus_datawindow = "dw_ayuda_almubizonas"
 		bus_filtro = "almacen = '" + dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")+"'"

 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "zona"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almubizonas"
		bus_filtro = "almacen = '" + dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")+"'"

 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

