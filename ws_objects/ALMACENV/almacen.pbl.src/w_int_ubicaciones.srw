$PBExportHeader$w_int_ubicaciones.srw
forward
global type w_int_ubicaciones from w_int_con_empresa
end type
type pb_2 from upb_salir within w_int_ubicaciones
end type
type dw_proceso from datawindow within w_int_ubicaciones
end type
type dw_listado from datawindow within w_int_ubicaciones
end type
type dw_almacenes from datawindow within w_int_ubicaciones
end type
type dw_zonas from datawindow within w_int_ubicaciones
end type
type cb_insertar from u_boton within w_int_ubicaciones
end type
type cb_borrar from u_boton within w_int_ubicaciones
end type
type cb_actualizar from u_boton within w_int_ubicaciones
end type
type cb_salir from u_boton within w_int_ubicaciones
end type
type dw_1 from u_datawindow within w_int_ubicaciones
end type
type dw_2 from u_datawindow within w_int_ubicaciones
end type
type dw_3 from u_datawindow within w_int_ubicaciones
end type
type r_botones from rectangle within w_int_ubicaciones
end type
end forward

global type w_int_ubicaciones from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 3557
integer height = 2136
string title = "Introducción de Ubicaciones"
pb_2 pb_2
dw_proceso dw_proceso
dw_listado dw_listado
dw_almacenes dw_almacenes
dw_zonas dw_zonas
cb_insertar cb_insertar
cb_borrar cb_borrar
cb_actualizar cb_actualizar
cb_salir cb_salir
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
r_botones r_botones
end type
global w_int_ubicaciones w_int_ubicaciones

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
public function boolean control_dw_2 ()
public function boolean control_dw_3 ()
public function boolean f_control_ubica2 (string var_zona, integer var_fila_desde, integer var_fila_hasta, integer var_altura_desde, integer var_altura_hasta)
public function boolean f_control_ubicacion (integer re, string var_zona, integer var_fila_desde, integer var_fila_hasta, integer var_altura_desde, integer var_altura_hasta, datawindow data)
end prototypes

public subroutine f_zonas ();String almacen
IF dw_almacenes.GetRow()= 0 Then Return
almacen= dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")
dw_zonas.Retrieve(codigo_empresa,almacen)
dw_1.Retrieve(codigo_empresa,almacen)
dw_2.Retrieve(codigo_empresa,almacen)
dw_3.Retrieve(codigo_empresa,almacen)
end subroutine

public subroutine f_ir ();String zona
Integer registro
If dw_zonas.GetRow() = 0 Then Return
zona = dw_zonas.GetItemString(dw_zonas.GetRow(),"zona")
IF dw_1.RowCount()<> 0 Then 
 registro = dw_1.find("zona = '" + zona + "'",1,dw_2.RowCount())
 dw_1.ScrollToRow(registro)
END IF
IF dw_2.RowCount()<> 0 Then 
 registro = dw_2.find("zona = '" + zona + "'",1,dw_2.RowCount())
 dw_2.ScrollToRow(registro)
END IF
end subroutine

public subroutine f_desactivar ();dw_almacenes.enabled = FALSE
dw_zonas.enabled     = FALSE
pb_2.enabled         = FALSE
cb_insertar.visible = TRUE
cb_borrar.visible = TRUE
cb_actualizar.visible = TRUE
cb_salir.visible = TRUE
r_botones.visible = TRUE
end subroutine

public subroutine f_activar ();dw_almacenes.enabled = TRUE
dw_zonas.enabled = TRUE
pb_2.enabled = TRUE
dw_almacenes.SetFocus()
cb_insertar.visible = FALSE
cb_borrar.visible = FALSE
cb_actualizar.visible = FALSE
cb_salir.visible = FALSE
r_botones.visible = FALSE
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
IF Trim(f_nombre_zona_abr(codigo_empresa,var_almacen,var_zona)) = "" Then
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

public function boolean control_dw_2 ();Integer reg,re,var_fila,var_altura,re1
Dec{0}   var_largo
String  var_zona,argumento,var_almacen,var_articulo,var_calidad
reg = dw_2.RowCount()
If reg = 0 Then Return TRUE
For re = 1 To reg
	var_fila     =   dw_2.GetItemNumber(re,"fila")
	var_altura   =   dw_2.GetItemNumber(re,"altura")
	var_almacen  =   dw_2.GetItemString(re,"almacen")
	var_zona     =   dw_2.GetItemString(re,"zona")
	var_articulo =   dw_2.GetItemString(re,"articulo")
	var_calidad  =   dw_2.GetItemString(re,"calidad")
	If IsNull(var_altura) Then var_altura = 0
	
	
	IF Trim(f_nombre_zona_abr(codigo_empresa,var_almacen,var_zona)) = "" Then
		 f_mensaje("Error en datos","La zona no existe")
		 dw_2.SetRow(re)
		 dw_2.ScrollToRow(re)
		 dw_2.SetColumn("zona")
		 dw_2.SetFocus()
		 Return FALSE
   END IF
	IF IsNUll(var_articulo) Then var_articulo = ""
	IF IsNUll(var_calidad) Then var_calidad = ""
	IF trim(var_articulo) = ""  AND Trim(var_calidad) = "" Then
  		 f_mensaje("Error en datos","No se puede grabar lineas sin articulo ni calidad")
		 dw_2.SetRow(re)
		 dw_2.ScrollToRow(re)
		 dw_2.SetColumn("articulo")
		 dw_2.SetFocus()
		 Return FALSE
	END IF
	
	IF trim(var_articulo) <> "" Then
	IF Trim(f_nombre_articulo(codigo_empresa,var_articulo)) = "" Then
		 f_mensaje("Error en datos","El articulo no existe")
		 dw_2.SetRow(re)
		 dw_2.ScrollToRow(re)
		 dw_2.SetColumn("articulo")
		 dw_2.SetFocus()
		 Return FALSE
   END IF		
ELSE
	IF Trim(var_calidad) <> "" Then
		 f_mensaje("Error en datos","No pude introducir una calidad sin articulo")
		 dw_2.SetRow(re)
		 dw_2.ScrollToRow(re)
		 dw_2.SetColumn("calidad")
		 dw_2.SetFocus()
		 Return FALSE
 END IF
END IF
	IF Trim(var_calidad) <> "" Then
	IF Trim(f_nombre_calidad_abr(codigo_empresa,var_calidad)) = "" Then
		 f_mensaje("Error en datos","La calidad no existe")
		 dw_2.SetRow(re)
		 dw_2.ScrollToRow(re)
		 dw_2.SetColumn("calidad")
		 dw_2.SetFocus()
		 Return FALSE
   END IF		
END IF	

	IF IsNull(var_fila)     Then  var_fila    =  0
	IF IsNull(var_altura)   Then  var_altura  =  0
	dw_2.SetItem(re,"fila",   var_fila)
	dw_2.SetItem(re,"altura", var_altura)
	argumento = "zona = '" + var_zona+"'"+&
	            "and fila_desde<=" + String(var_fila)+&
              	"and fila_hasta>="+ String(var_fila)+&
            	"and altura_desde<="+ String(var_altura)+&
             	"and altura_hasta>="+ String(var_altura)  
					 
 IF dw_1.Find(argumento,1,dw_1.RowCount()) = 0 Then
	 f_mensaje("Error en introducción de datos","No existe la zona introducida")
	 dw_2.SetFocus()
	 dw_2.ScrollToRow(re)
	 dw_2.SetRow(re)
	 dw_2.Setcolumn("fila")
	 Return FALSE
 END IF
 
 argumento = " zona       = '" + var_zona + "'"  + &
             " and fila   = "  + String(var_fila) + &
             " and altura = "  + String(var_altura) 
re1 = re +1				 
If re1 <= reg Then 
 IF dw_2.Find(argumento,re1,reg) <> 0 Then
	 f_mensaje("Error en introducción de datos","Existen  asignaciones en zonas duplicadas")
	 dw_2.SetFocus()
	 dw_2.ScrollToRow(re)
	 dw_2.SetRow(re)
	 dw_2.Setcolumn("fila")
	 Return FALSE
 END IF	 
END IF
Next

Return TRUE
end function

public function boolean control_dw_3 ();Integer reg,re,var_fila_desde,var_fila_hasta,var_altura_desde,var_altura_hasta,re1
Dec{0}   var_largo,var_orden
String  var_zona,argumento,var_almacen,var_formato
reg = dw_3.RowCount()
If reg = 0 Then Return TRUE
For re = 1 To reg
	var_fila_desde=   dw_3.GetItemNumber(re,"fila_desde")
	var_fila_hasta=   dw_3.GetItemNumber(re,"fila_hasta")
	var_altura_desde    =   dw_3.GetItemNumber(re,"altura_desde")
	var_altura_hasta    =   dw_3.GetItemNumber(re,"altura_hasta")
	var_almacen   =   dw_3.GetItemString(re,"almacen")
	var_zona      =   dw_3.GetItemString(re,"zona")
	var_orden     =   dw_3.GetItemNumber(re,"orden")
	var_formato   =   dw_3.GetItemString(re,"formato")
	
	IF Trim(f_nombre_zona_abr(codigo_empresa,var_almacen,var_zona)) = "" Then
		 f_mensaje("Error en datos","La zona no existe")
		 dw_3.SetRow(re)
		 dw_3.ScrollToRow(re)
		 dw_3.SetColumn("zona")
		 dw_3.SetFocus()
		 Return FALSE
   END IF	
	IF var_orden= 0  or IsNull(var_orden) then
		f_mensaje("Error en datos","Introduzca el orden de preferencia")
		 dw_3.SetRow(re)
		 dw_3.ScrollToRow(re)
		 dw_3.SetColumn("orden")
		 dw_3.SetFocus()
		 Return FALSE
	END IF
	IF trim(var_formato) <> "" Then
	IF Trim(f_nombre_formato(codigo_empresa,var_formato)) = "" Then
		 f_mensaje("Error en datos","El formato no existe")
		 dw_3.SetRow(re)
		 dw_3.ScrollToRow(re)
		 dw_3.SetColumn("formato")
		 dw_3.SetFocus()
		 Return FALSE
   END IF
ELSE
   	 f_mensaje("Error en datos","Introduzca el formato")
		 dw_3.SetRow(re)
		 dw_3.ScrollToRow(re)
		 dw_3.SetColumn("formato")
		 dw_3.SetFocus()
		 Return FALSE
END IF

	IF IsNull(var_fila_desde)     Then  var_fila_desde    =  0
	IF IsNull(var_altura_desde)   Then  var_altura_desde  =  0
		IF IsNull(var_fila_hasta)     Then  var_fila_hasta    =  0
	IF IsNull(var_altura_hasta)   Then  var_altura_hasta  =  0
	dw_3.SetItem(re,"fila_desde",   var_fila_desde)
	dw_3.SetItem(re,"altura_desde", var_altura_desde)
	dw_3.SetItem(re,"fila_hasta",   var_fila_hasta)
	dw_3.SetItem(re,"altura_hasta", var_altura_hasta)
	
	
	IF  Not f_control_ubica2(var_zona,var_fila_desde,var_fila_hasta,var_altura_desde,var_altura_hasta) Then
		 f_mensaje("Error en introducción de datos","La ubicacion no existe en el mapa")
		 dw_3.SetRow(re)
		 dw_3.ScrollToRow(re)
		 dw_3.SetColumn("fila_desde")
		 dw_3.SetFocus()
		 Return FALSE
	END IF

	
	
	IF f_control_ubicacion(re,var_zona,var_fila_desde,var_fila_hasta,var_altura_desde,var_altura_hasta,dw_3) Then
		 f_mensaje("Error en introducción de datos","Existen zonas duplicadas")
		 dw_3.SetRow(re)
		 dw_3.ScrollToRow(re)
		 dw_3.SetColumn("fila_desde")
		 dw_3.SetFocus()
		 Return FALSE
	END IF
	
	
	

 argumento = " zona       = '" + var_zona + "'"  + &
             " and fila_desde   = "  + String(var_fila_desde) + &
             " and fila_hasta   = "  + String(var_fila_hasta) + &
             " and altura_desde = "  + String(var_altura_desde)+& 
  	 	   	 " and altura_hasta = "  + String(var_altura_hasta)+& 
				 " and formato = '"  + var_formato  + "'"
re1 = re +1				 
If re1 <= reg Then 
 IF dw_3.Find(argumento,re1,reg) <> 0 Then
	 f_mensaje("Error en introducción de datos","Existen  asignaciones en formatos duplicados(preferencias por fomatos)")
	 dw_3.SetFocus()
	 dw_3.ScrollToRow(re)
	 dw_3.SetRow(re)
	 dw_3.Setcolumn("formato")
	 Return FALSE
 END IF	 
 argumento = " formato = '"  + var_formato  + "'" + &
				 " and orden = "  + String(var_orden)
 IF dw_3.Find(argumento,re1,reg) <> 0 Then
	 f_mensaje("Error en introducción de datos","Existen  asignaciones en ordenes duplicados(preferencias por fomatos)")
	 dw_3.SetFocus()
	 dw_3.ScrollToRow(re)
	 dw_3.SetRow(re)
	 dw_3.Setcolumn("orden")
	 Return FALSE
 END IF	 
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
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_almacenes.SetTransObject(sqlca)
dw_almacenes.SetRowFocusIndicator(Hand!)
dw_almacenes.Retrieve(codigo_empresa)
f_mascara_columna(dw_1,"largo","###,###")
f_mascara_columna(dw_1,"fila_hasta","###")
f_mascara_columna(dw_1,"fila_desde","###")
dw_zonas.SetRowFocusIndicator(Hand!)
This.title = "Introducción de Ubicaciones"

dw_almacenes.Setfocus()


end event

on w_int_ubicaciones.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
this.dw_listado=create dw_listado
this.dw_almacenes=create dw_almacenes
this.dw_zonas=create dw_zonas
this.cb_insertar=create cb_insertar
this.cb_borrar=create cb_borrar
this.cb_actualizar=create cb_actualizar
this.cb_salir=create cb_salir
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.r_botones=create r_botones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.dw_almacenes
this.Control[iCurrent+5]=this.dw_zonas
this.Control[iCurrent+6]=this.cb_insertar
this.Control[iCurrent+7]=this.cb_borrar
this.Control[iCurrent+8]=this.cb_actualizar
this.Control[iCurrent+9]=this.cb_salir
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.dw_2
this.Control[iCurrent+12]=this.dw_3
this.Control[iCurrent+13]=this.r_botones
end on

on w_int_ubicaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_proceso)
destroy(this.dw_listado)
destroy(this.dw_almacenes)
destroy(this.dw_zonas)
destroy(this.cb_insertar)
destroy(this.cb_borrar)
destroy(this.cb_actualizar)
destroy(this.cb_salir)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.r_botones)
end on

event ue_f2;call super::ue_f2;cb_insertar.TriggerEvent(Clicked!)
end event

event ue_f3;call super::ue_f3;cb_borrar.TriggerEvent(Clicked!)
end event

event ue_f4;call super::ue_f4;cb_actualizar.TriggerEvent(Clicked!)
end event

event ue_esc;call super::ue_esc;cb_salir.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_ubicaciones
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_ubicaciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_ubicaciones
integer x = 27
integer y = 20
integer width = 2574
end type

type pb_2 from upb_salir within w_int_ubicaciones
integer x = 2610
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_proceso from datawindow within w_int_ubicaciones
boolean visible = false
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_almtipomov"
boolean livescroll = true
end type

type dw_listado from datawindow within w_int_ubicaciones
boolean visible = false
integer x = 5
integer width = 914
integer height = 144
boolean bringtotop = true
string dataobject = "report_con_ubicaciones"
boolean livescroll = true
end type

type dw_almacenes from datawindow within w_int_ubicaciones
integer x = 18
integer y = 124
integer width = 1422
integer height = 660
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_int_ubicaciones1"
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

type dw_zonas from datawindow within w_int_ubicaciones
integer x = 1440
integer y = 124
integer width = 658
integer height = 660
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_int_ubicaciones2"
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

type cb_insertar from u_boton within w_int_ubicaciones
boolean visible = false
integer x = 2222
integer y = 248
integer height = 92
integer taborder = 0
string text = "F2 Insertar"
end type

event clicked;call super::clicked;IF This.visible = FALSE Then Return
Integer reg
reg = dw_data.GetRow()
reg = reg -1
If reg <1 Then reg = 1
dw_data.InsertRow(reg)
dw_data.SetItem(reg,"empresa",codigo_empresa)
dw_data.SetItem(reg,"almacen",dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo"))
dw_data.Setfocus()
dw_data.SetRow(reg)
dw_data.SetItem(reg,"zona",dw_zonas.getitemString(dw_zonas.getRow(),"zona"))
dw_data.SetColumn("zona")

end event

type cb_borrar from u_boton within w_int_ubicaciones
boolean visible = false
integer x = 2222
integer y = 344
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

type cb_actualizar from u_boton within w_int_ubicaciones
boolean visible = false
integer x = 2222
integer y = 440
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = "F4 Actualizar"
end type

event clicked;call super::clicked;dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

IF This.visible = FALSE Then Return
If Not control_dw_1() Then Return
If Not control_dw_2() Then Return
If Not control_dw_3() Then Return
dw_1.Update()
dw_2.Update()
dw_3.Update()
COMMIT;
cb_salir.TriggerEvent(Clicked!)
end event

type cb_salir from u_boton within w_int_ubicaciones
boolean visible = false
integer x = 2222
integer y = 536
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = "Esc Salir"
boolean cancel = true
end type

event clicked;call super::clicked;IF This.visible = FALSE Then Return
f_activar()
end event

type dw_1 from u_datawindow within w_int_ubicaciones
integer x = 18
integer y = 788
integer width = 1225
integer height = 1112
integer taborder = 10
string dataobject = "dw_int_ubicaciones3"
end type

event losefocus;call super::losefocus;This.BorderStyle = StyleRaised!
f_datawindow_border_salida(This)
end event

event getfocus;This.BorderStyle = StyleLowered!
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

type dw_2 from u_datawindow within w_int_ubicaciones
event getfocus pbm_dwnsetfocus
event losefocus pbm_dwnkillfocus
integer x = 1243
integer y = 788
integer width = 1778
integer height = 556
integer taborder = 20
string dataobject = "dw_int_ubicaciones4"
end type

event getfocus;call super::getfocus;This.BorderStyle = StyleLowered!
f_datawindow_border_entrada(This)
donde ="DW_2"
dw_data= This
f_desactivar()
end event

event losefocus;call super::losefocus;This.BorderStyle = StyleRaised!
f_datawindow_border_salida(This)

end event

event rbuttondown;bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "zona"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almubizonas"
		bus_filtro = "almacen = '" + dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")+"'"
	 CASE "articulo"
      bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
 		bus_datawindow = "dw_ayuda_articulos"
 		bus_filtro = ""
   CASE "calidad"
      bus_titulo     = "VENTANA SELECCION DE CALIDADES "
 		bus_datawindow = "dw_ayuda_calidades"
 		bus_filtro = ""
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
   CASE "calidad"
      bus_titulo     = "VENTANA SELECCION DE CALIDADES "
 		bus_datawindow = "dw_ayuda_calidades"
 		bus_filtro = ""
	CASE "zona"
      bus_titulo     = "VENTANA SELECCION DE ZONAS "
 		bus_datawindow = "dw_ayuda_almubizonas"
 		bus_filtro = "almacen = '" + dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")+"'"
	 CASE "articulo"
      bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
 		bus_datawindow = "dw_ayuda_articulos"
 		bus_filtro = ""

 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

type dw_3 from u_datawindow within w_int_ubicaciones
event getfocus pbm_dwnsetfocus
event losefocus pbm_dwnkillfocus
integer x = 1243
integer y = 1344
integer width = 1778
integer height = 556
integer taborder = 30
string dataobject = "dw_int_ubicaciones5"
end type

event getfocus;call super::getfocus;This.BorderStyle = StyleLowered!
f_datawindow_border_entrada(This)
donde ="DW_3"
dw_data= This
f_desactivar()
end event

event losefocus;call super::losefocus;This.BorderStyle = StyleRaised!
f_datawindow_border_salida(This)
end event

event rbuttondown;bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
		 CASE "formato"
      bus_titulo     = "VENTANA SELECCION DE FORMATOS "
 		bus_datawindow = "dw_ayuda_formatos"
 		bus_filtro = ""
	CASE "zona"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almubizonas"
		bus_filtro = "almacen = '" + dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")+"'"

 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
 CASE "formato"
      bus_titulo     = "VENTANA SELECCION DE FORMATOS "
 		bus_datawindow = "dw_ayuda_formatos"
 		bus_filtro = ""
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

type r_botones from rectangle within w_int_ubicaciones
boolean visible = false
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 8421376
integer x = 2190
integer y = 220
integer width = 471
integer height = 432
end type

