$PBExportHeader$w_mant_mapa_almacen.srw
forward
global type w_mant_mapa_almacen from w_int_con_empresa
end type
type pb_2 from upb_salir within w_mant_mapa_almacen
end type
type dw_proceso from datawindow within w_mant_mapa_almacen
end type
type dw_almacenes from datawindow within w_mant_mapa_almacen
end type
type dw_zonas from datawindow within w_mant_mapa_almacen
end type
type cb_insertar from u_boton within w_mant_mapa_almacen
end type
type cb_borrar from u_boton within w_mant_mapa_almacen
end type
type cb_actualizar from u_boton within w_mant_mapa_almacen
end type
type cb_salir from u_boton within w_mant_mapa_almacen
end type
type dw_1 from u_datawindow within w_mant_mapa_almacen
end type
type dw_2 from u_datawindow within w_mant_mapa_almacen
end type
type dw_3 from u_datawindow within w_mant_mapa_almacen
end type
type st_color_escogido from statictext within w_mant_mapa_almacen
end type
type dw_ubicaciones from u_datawindow within w_mant_mapa_almacen
end type
type pb_paleta_colores from picturebutton within w_mant_mapa_almacen
end type
type rb_fondo from radiobutton within w_mant_mapa_almacen
end type
type rb_texto from radiobutton within w_mant_mapa_almacen
end type
type pb_refrescar_marcados from picturebutton within w_mant_mapa_almacen
end type
type pb_imprimir_etiquetas from picturebutton within w_mant_mapa_almacen
end type
type dw_etiquetas_ubicaciones100 from datawindow within w_mant_mapa_almacen
end type
type cbx_flechas from checkbox within w_mant_mapa_almacen
end type
type em_altura_a_marcar from editmask within w_mant_mapa_almacen
end type
type cb_marcar_altura from commandbutton within w_mant_mapa_almacen
end type
type gb_1 from groupbox within w_mant_mapa_almacen
end type
type r_botones from rectangle within w_mant_mapa_almacen
end type
type gb_impresion_etiquetas from groupbox within w_mant_mapa_almacen
end type
type dw_listado from datawindow within w_mant_mapa_almacen
end type
type cb_generar_bultos from commandbutton within w_mant_mapa_almacen
end type
type cb_1 from commandbutton within w_mant_mapa_almacen
end type
type cb_2 from commandbutton within w_mant_mapa_almacen
end type
type dw_etiquetas_bultos_100 from datawindow within w_mant_mapa_almacen
end type
type pb_imprimir_bultos from picturebutton within w_mant_mapa_almacen
end type
type cbx_formato_pequeño from checkbox within w_mant_mapa_almacen
end type
type cbx_formato_pequeño_estanterias from checkbox within w_mant_mapa_almacen
end type
type gb_2 from groupbox within w_mant_mapa_almacen
end type
end forward

global type w_mant_mapa_almacen from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 8498
integer height = 3808
string title = "Introducción de Ubicaciones"
pb_2 pb_2
dw_proceso dw_proceso
dw_almacenes dw_almacenes
dw_zonas dw_zonas
cb_insertar cb_insertar
cb_borrar cb_borrar
cb_actualizar cb_actualizar
cb_salir cb_salir
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
st_color_escogido st_color_escogido
dw_ubicaciones dw_ubicaciones
pb_paleta_colores pb_paleta_colores
rb_fondo rb_fondo
rb_texto rb_texto
pb_refrescar_marcados pb_refrescar_marcados
pb_imprimir_etiquetas pb_imprimir_etiquetas
dw_etiquetas_ubicaciones100 dw_etiquetas_ubicaciones100
cbx_flechas cbx_flechas
em_altura_a_marcar em_altura_a_marcar
cb_marcar_altura cb_marcar_altura
gb_1 gb_1
r_botones r_botones
gb_impresion_etiquetas gb_impresion_etiquetas
dw_listado dw_listado
cb_generar_bultos cb_generar_bultos
cb_1 cb_1
cb_2 cb_2
dw_etiquetas_bultos_100 dw_etiquetas_bultos_100
pb_imprimir_bultos pb_imprimir_bultos
cbx_formato_pequeño cbx_formato_pequeño
cbx_formato_pequeño_estanterias cbx_formato_pequeño_estanterias
gb_2 gb_2
end type
global w_mant_mapa_almacen w_mant_mapa_almacen

type variables
String ante_articulo,retrasos
datawindow dw_data
String donde
boolean ib_ubicaciones_marcadas = true,ib_ubicaciones_activas = true
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
dw_ubicaciones.Retrieve(codigo_empresa,almacen)
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
dw_ubicaciones.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_almacenes.SetTransObject(sqlca)
dw_almacenes.SetRowFocusIndicator(Hand!)
dw_almacenes.Retrieve(codigo_empresa)

f_mascara_columna(dw_1,"fila_desde","###")
f_mascara_columna(dw_1,"fila_hasta","###")
f_mascara_columna(dw_1,"altura_desde","###")
f_mascara_columna(dw_1,"altura_hasta","###")
f_mascara_columna(dw_1,"largo","###,###")
f_mascara_columna(dw_1,"ancho","###,###")
f_mascara_columna(dw_1,"alto","###,###")
f_mascara_columna(dw_1,"peso_maximo","###,###")

dw_zonas.SetRowFocusIndicator(Hand!)
This.title = "Gestión de Ubicaciones"

dw_almacenes.Setfocus()

dw_etiquetas_ubicaciones100.Object.DataWindow.Zoom = 50

end event

on w_mant_mapa_almacen.create
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
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_color_escogido=create st_color_escogido
this.dw_ubicaciones=create dw_ubicaciones
this.pb_paleta_colores=create pb_paleta_colores
this.rb_fondo=create rb_fondo
this.rb_texto=create rb_texto
this.pb_refrescar_marcados=create pb_refrescar_marcados
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.dw_etiquetas_ubicaciones100=create dw_etiquetas_ubicaciones100
this.cbx_flechas=create cbx_flechas
this.em_altura_a_marcar=create em_altura_a_marcar
this.cb_marcar_altura=create cb_marcar_altura
this.gb_1=create gb_1
this.r_botones=create r_botones
this.gb_impresion_etiquetas=create gb_impresion_etiquetas
this.dw_listado=create dw_listado
this.cb_generar_bultos=create cb_generar_bultos
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_etiquetas_bultos_100=create dw_etiquetas_bultos_100
this.pb_imprimir_bultos=create pb_imprimir_bultos
this.cbx_formato_pequeño=create cbx_formato_pequeño
this.cbx_formato_pequeño_estanterias=create cbx_formato_pequeño_estanterias
this.gb_2=create gb_2
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
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.dw_3
this.Control[iCurrent+12]=this.st_color_escogido
this.Control[iCurrent+13]=this.dw_ubicaciones
this.Control[iCurrent+14]=this.pb_paleta_colores
this.Control[iCurrent+15]=this.rb_fondo
this.Control[iCurrent+16]=this.rb_texto
this.Control[iCurrent+17]=this.pb_refrescar_marcados
this.Control[iCurrent+18]=this.pb_imprimir_etiquetas
this.Control[iCurrent+19]=this.dw_etiquetas_ubicaciones100
this.Control[iCurrent+20]=this.cbx_flechas
this.Control[iCurrent+21]=this.em_altura_a_marcar
this.Control[iCurrent+22]=this.cb_marcar_altura
this.Control[iCurrent+23]=this.gb_1
this.Control[iCurrent+24]=this.r_botones
this.Control[iCurrent+25]=this.gb_impresion_etiquetas
this.Control[iCurrent+26]=this.dw_listado
this.Control[iCurrent+27]=this.cb_generar_bultos
this.Control[iCurrent+28]=this.cb_1
this.Control[iCurrent+29]=this.cb_2
this.Control[iCurrent+30]=this.dw_etiquetas_bultos_100
this.Control[iCurrent+31]=this.pb_imprimir_bultos
this.Control[iCurrent+32]=this.cbx_formato_pequeño
this.Control[iCurrent+33]=this.cbx_formato_pequeño_estanterias
this.Control[iCurrent+34]=this.gb_2
end on

on w_mant_mapa_almacen.destroy
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
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_color_escogido)
destroy(this.dw_ubicaciones)
destroy(this.pb_paleta_colores)
destroy(this.rb_fondo)
destroy(this.rb_texto)
destroy(this.pb_refrescar_marcados)
destroy(this.pb_imprimir_etiquetas)
destroy(this.dw_etiquetas_ubicaciones100)
destroy(this.cbx_flechas)
destroy(this.em_altura_a_marcar)
destroy(this.cb_marcar_altura)
destroy(this.gb_1)
destroy(this.r_botones)
destroy(this.gb_impresion_etiquetas)
destroy(this.dw_listado)
destroy(this.cb_generar_bultos)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_etiquetas_bultos_100)
destroy(this.pb_imprimir_bultos)
destroy(this.cbx_formato_pequeño)
destroy(this.cbx_formato_pequeño_estanterias)
destroy(this.gb_2)
end on

event ue_f2;call super::ue_f2;cb_insertar.TriggerEvent(Clicked!)
end event

event ue_f3;call super::ue_f3;cb_borrar.TriggerEvent(Clicked!)
end event

event ue_f4;call super::ue_f4;cb_actualizar.TriggerEvent(Clicked!)
end event

event ue_esc;call super::ue_esc;cb_salir.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mant_mapa_almacen
integer x = 2880
integer y = 4
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mant_mapa_almacen
end type

type st_empresa from w_int_con_empresa`st_empresa within w_mant_mapa_almacen
integer x = 27
integer y = 20
integer width = 2574
integer textsize = -8
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

type pb_2 from upb_salir within w_mant_mapa_almacen
integer x = 8361
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_proceso from datawindow within w_mant_mapa_almacen
boolean visible = false
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_almtipomov"
boolean livescroll = true
end type

type dw_almacenes from datawindow within w_mant_mapa_almacen
integer x = 18
integer y = 124
integer width = 1422
integer height = 3520
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Almacenes"
string dataobject = "dw_mant_mapa_almacen1"
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

type dw_zonas from datawindow within w_mant_mapa_almacen
integer x = 1440
integer y = 124
integer width = 658
integer height = 3520
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Zonas"
string dataobject = "dw_mant_mapa_almacen2"
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

type cb_insertar from u_boton within w_mant_mapa_almacen
boolean visible = false
integer x = 2112
integer y = 136
integer width = 398
integer height = 92
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
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

type cb_borrar from u_boton within w_mant_mapa_almacen
boolean visible = false
integer x = 2514
integer y = 136
integer width = 398
integer height = 92
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "F3 Borrar"
end type

event clicked;call super::clicked;IF This.visible = FALSE Then Return
If dw_data.GetRow() <> 0 Then
	dw_data.DeleteRow(dw_data.GetRow())
	dw_data.SetColumn("zona")
END IF
end event

type cb_actualizar from u_boton within w_mant_mapa_almacen
boolean visible = false
integer x = 2917
integer y = 136
integer width = 398
integer height = 92
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
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
dw_ubicaciones.Update()
COMMIT;
cb_salir.TriggerEvent(Clicked!)
end event

type cb_salir from u_boton within w_mant_mapa_almacen
boolean visible = false
integer x = 2112
integer y = 232
integer width = 1202
integer height = 92
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Esc Salir"
boolean cancel = true
end type

event clicked;call super::clicked;IF This.visible = FALSE Then Return
f_activar()
end event

type dw_1 from u_datawindow within w_mant_mapa_almacen
integer x = 2103
integer y = 352
integer width = 2139
integer height = 3292
integer taborder = 10
boolean titlebar = true
string title = "Configuración de las Zonas"
string dataobject = "dw_mant_mapa_almacen3"
borderstyle borderstyle = styleraised!
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

event retrieveend;call super::retrieveend;if rowcount() > 0 then
	this.setrow(1)
	this.event rowfocuschanged(1)
else
	this.event rowfocuschanged(0)
end if
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_almacen,ls_zona,ls_evaluacion,ls_ean_13
long   ll_fila,ll_altura,ll_fila_desde,ll_altura_desde,ll_fila_hasta,ll_altura_hasta,ll_donde,ll_color_fondo,ll_color_texto
long   ll_indice,ll_total

if currentrow > 0 then
	dw_ubicaciones.setfilter("zona = '"+this.object.zona[currentrow]+"' and ( fila >= "+string(this.object.fila_desde[currentrow],"###0")+" and fila <= "+string(this.object.fila_hasta[currentrow],"###0")+" ) and ( altura >= "+string(this.object.altura_desde[currentrow],"###0")+" and altura <= "+string(this.object.altura_hasta[currentrow],"###0")+" ) ")
	dw_ubicaciones.filter()	
	
	ls_evaluacion = this.describe("evaluate('IsRowNew()',"+string(currentrow,"###0")+")")
	
	if dw_ubicaciones.rowcount() = 0 and ls_evaluacion = "false" then
		ls_almacen      = this.object.almacen[currentrow]
		ls_zona         = this.object.zona[currentrow]
		ll_color_fondo  = st_color_escogido.backcolor
		ll_color_texto  = st_color_escogido.textcolor
		ll_fila_desde   = this.object.fila_desde[currentrow]
		ll_altura_desde = this.object.altura_desde[currentrow]
		ll_fila_hasta   = this.object.fila_hasta[currentrow]
		ll_altura_hasta = this.object.altura_hasta[currentrow]
		
		for ll_fila = ll_fila_desde to ll_fila_hasta
			for ll_altura = ll_altura_desde to ll_altura_hasta
				ll_donde = dw_ubicaciones.insertrow(0)
				
				dw_ubicaciones.object.empresa[ll_donde]     = codigo_empresa
				dw_ubicaciones.object.almacen[ll_donde]     = ls_almacen
				dw_ubicaciones.object.zona[ll_donde]        = ls_zona
				dw_ubicaciones.object.fila[ll_donde]        = ll_fila
				dw_ubicaciones.object.altura[ll_donde]      = ll_altura
				dw_ubicaciones.object.code39[ll_donde]      = ls_almacen+"-"+ls_zona+"-"+string(ll_fila,"###0")+"-"+string(ll_altura,"###0")
				dw_ubicaciones.object.color_fondo[ll_donde] = ll_color_fondo
				dw_ubicaciones.object.color_texto[ll_donde] = ll_color_texto
				dw_ubicaciones.object.marcado[ll_donde]     = "S"
				dw_ubicaciones.object.activo[ll_donde]      = "S"
				dw_ubicaciones.object.apilado_en_bloque[ll_donde]   = "N"
				dw_ubicaciones.object.id_alm_bultos[ll_donde]       = 0
				dw_ubicaciones.object.gestionar_en_piezas[ll_donde] = "N"
				dw_ubicaciones.object.tipo_ubicacion[ll_donde]      = 0
				dw_ubicaciones.object.permitir_reservas[ll_donde]   = "S"
			next			
		next
		
		dw_ubicaciones.Update()
		commit;
		
		ll_total = dw_ubicaciones.rowcount()
		for ll_indice = 1 to ll_total
			ls_ean_13 = dw_ubicaciones.object.ean13[ll_indice]
			if isnull(ls_ean_13) then ls_ean_13 = ""
	
			if trim(ls_ean_13) = "" then
				ls_ean_13 = "20"+string(dw_ubicaciones.object.id[ll_indice],"0000000000")
				ls_ean_13 = f_calcula_ean13(ls_ean_13)
				dw_ubicaciones.object.ean13[ll_indice] = ls_ean_13
			end if			
		next
		
		dw_ubicaciones.Update()
		commit;		
		
	end if
else
	dw_ubicaciones.setfilter("0 = 1")
	dw_ubicaciones.filter()
end if		

end event

type dw_2 from u_datawindow within w_mant_mapa_almacen
event getfocus pbm_dwnsetfocus
event losefocus pbm_dwnkillfocus
integer x = 6551
integer y = 3088
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

type dw_3 from u_datawindow within w_mant_mapa_almacen
event getfocus pbm_dwnsetfocus
event losefocus pbm_dwnkillfocus
integer x = 6555
integer y = 3088
integer width = 1778
integer height = 556
integer taborder = 30
string dataobject = "dw_mant_mapa_almacen5"
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

type st_color_escogido from statictext within w_mant_mapa_almacen
integer x = 4443
integer y = 188
integer width = 1225
integer height = 128
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Texto Etiqueta"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_ubicaciones from u_datawindow within w_mant_mapa_almacen
integer x = 4242
integer y = 352
integer width = 2286
integer height = 3292
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Ubicaciones"
string dataobject = "dw_mant_mapa_almacen6"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event getfocus;dw_1.event getfocus()
end event

event losefocus;call super::losefocus;//dw_1.BorderStyle = StyleRaised!
//f_datawindow_border_salida(dw_1)
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

event clicked;call super::clicked;long ll_color_escogido,ll_donde

if dwo.name = 'p_captura_colores' then

	ll_color_escogido = this.object.color_fondo[row]

	st_color_escogido.backcolor = ll_color_escogido
	rb_fondo.backcolor          = ll_color_escogido
	rb_texto.backcolor          = ll_color_escogido
	
	ll_color_escogido = this.object.color_texto[row]

	st_color_escogido.textcolor = ll_color_escogido
	
	em_altura_a_marcar.text = string(this.object.altura[row],em_altura_a_marcar.mask)
else
	if dwo.name = 't_marca' then
		for ll_donde = 1 to this.rowcount()
			if ib_ubicaciones_marcadas then
				this.object.marcado[ll_donde] = 'N' 
			else
				this.object.marcado[ll_donde] = 'S'
			end if	
		next
		ib_ubicaciones_marcadas = not(ib_ubicaciones_marcadas)
	else
		if dwo.name = 't_activo' then
			for ll_donde = 1 to this.rowcount()
				if ib_ubicaciones_activas then
					this.object.activo[ll_donde] = 'N' 
				else
					this.object.activo[ll_donde] = 'S'
				end if	
			next
			ib_ubicaciones_activas = not(ib_ubicaciones_activas)
		end if		
	end if
end if
end event

event retrieveend;call super::retrieveend;ib_ubicaciones_marcadas = true
ib_ubicaciones_activas  = true
end event

event itemchanged;call super::itemchanged;string ls_bulto_asociado
string ls_ean_13
string ls_sel
long   ll_indice,ll_total,ll_total_vacios,ll_almubimapa_codbar_id,ll_lineas_bulto
datastore lds_bultos_ubicacion

str_alm_bultos lstr_alm_bultos

if dwo.name = "bulto_asociado" then
	ls_bulto_asociado = data
	ll_almubimapa_codbar_id = this.object.id[row]
	
	if ls_bulto_asociado = "S" then
		//Vamos a comprobar si hay un bulto en esa ubicacion y está vacio
		ls_sel = "SELECT isnull(alm_bultos.id,0) as alm_bultos_id, "+&
					"		  isnull(alm_bultos_lineas.id,0) as alm_bultos_lineas_id "+&
					"FROM   alm_bultos, "+&
					"		  alm_bultos_lineas "+&
					"WHERE ( alm_bultos.id *= alm_bultos_lineas.id_alm_bultos ) "+&
					"AND ( ( alm_bultos.empresa      = '"+codigo_empresa+"' ) "+&
					"AND 	 ( alm_bultos.id_ubicacion = "+string(ll_almubimapa_codbar_id,"#########0")+" ) ) "+&
					"ORDER BY alm_bultos.id"
		
		ll_total        = f_cargar_cursor_transaccion(sqlca,lds_bultos_ubicacion,ls_sel)		
		ll_total_vacios = long(lds_bultos_ubicacion.describe("evaluate ('sum(if ( alm_bultos_lineas_id = 0 , 1 , 0 ) for all)',1)"))
				
		if ll_total > 0 then
			if ll_total = ll_total_vacios then
				//Vamos a asignar el primer bulto que ya existe en la ubicacion vacio y a borrar el resto
				for ll_indice = 1 to ll_total
					lstr_alm_bultos.id = lds_bultos_ubicacion.object.alm_bultos_id[ll_indice]
					
					if ll_indice = 1 then
						if f_cargar_str_alm_bultos(lstr_alm_bultos.id,lstr_alm_bultos) then 
							
							lstr_alm_bultos.observaciones = "BULTO ASOCIADO A UBICACION"
							
							update alm_bultos
							set    alm_bultos.observaciones = :lstr_alm_bultos.observaciones 
							where  alm_bultos.id            = :lstr_alm_bultos.id;
							
							if sqlca.sqlcode <> 0 then
								rollback;
								messagebox("¡Error!","El bulto existente en la ubicación no se puede asociar.")
								
								return 2
							else
								this.object.id_alm_bultos[row] = lstr_alm_bultos.id
							end if							
						else
							messagebox("¡Error!","El bulto existente en la ubicación no se puede asociar.")
							
							return 2							
						end if
					else							
						delete alm_bultos
						where  alm_bultos.id = :lstr_alm_bultos.id;
						
						if sqlca.sqlcode <> 0 then
							rollback;
							messagebox("¡Error!","El bulto existente en la ubicación no se puede asociar.")
							
							this.object.id_alm_bultos[row] = 0
							
							return 2
						end if													
					end if
				next
			else
				messagebox("¡Error!","Existen bultos en la ubicación.~nNo se puede asociar.")
				return 2
			end if
		else
			//Creamos nuevo bulto asociado a la ubicación
			lstr_alm_bultos.empresa            = codigo_empresa
			lstr_alm_bultos.ean13              = "" 
			lstr_alm_bultos.tipo_pallet        = "00000" //Sin Pallet 
			lstr_alm_bultos.alto               = 0
			lstr_alm_bultos.usuario            = nombre_usuario 
			lstr_alm_bultos.fecha_hora_alta    = datetime(today(),now())
			lstr_alm_bultos.id_ubicacion       = ll_almubimapa_codbar_id
			lstr_alm_bultos.anyo_orden_carga   = 0 
			lstr_alm_bultos.codigo_orden_carga = ""
			lstr_alm_bultos.observaciones      = "BULTO ASOCIADO A UBICACION"
			
			if f_insert_alm_bultos(lstr_alm_bultos) then
				this.object.id_alm_bultos[row] = lstr_alm_bultos.id
				commit;
			else
				rollback;
				return 2
			end if		
			
		end if		
		
		destroy lds_bultos_ubicacion
		
		update almubimapa_codbar
		set    almubimapa_codbar.id_alm_bultos = :lstr_alm_bultos.id
		where  almubimapa_codbar.id            = :ll_almubimapa_codbar_id;
		
		if sqlca.sqlcode <> 0 then
			rollback;
			messagebox("¡Error!","No se puede asociar.")
			this.object.id_alm_bultos[row] = 0
			return 2
		else
			commit;
		end if
	else
		//Vamos a comprobar si el bulto asociado a la ubicacio está vacio	
		lstr_alm_bultos.id = this.object.id_alm_bultos[row]
		
		select isnull(count(*),0) as lineas
		into   :ll_lineas_bulto
		from   alm_bultos_lineas
		where  alm_bultos_lineas.id_alm_bultos = :lstr_alm_bultos.id;
		
		if ll_lineas_bulto = 0 then
			lstr_alm_bultos.observaciones = ""
			
			update alm_bultos
			set    alm_bultos.observaciones = :lstr_alm_bultos.observaciones 
			where  alm_bultos.id            = :lstr_alm_bultos.id;
			
			if sqlca.sqlcode <> 0 then
				rollback;
				messagebox("¡Error!","El bulto existente en la ubicación no se puede desligar.")
				
				return 2
			else
				update almubimapa_codbar
				set    almubimapa_codbar.id_alm_bultos = 0
				where  almubimapa_codbar.id            = :ll_almubimapa_codbar_id;
				
				if sqlca.sqlcode <> 0 then
					rollback;
					messagebox("¡Error!","No se puede desligar.")

					return 2
				else
					commit;
					
					this.object.id_alm_bultos[row] = 0					
				end if
			end if										
		else
			messagebox("¡Error!","No se puede desligar de la ubicacion un bulto con lineas.")
			return 2
		end if
	end if
end if
end event

type pb_paleta_colores from picturebutton within w_mant_mapa_almacen
integer x = 4293
integer y = 188
integer width = 151
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\paleta_colores_24x24.bmp"
alignment htextalign = left!
end type

event clicked;long  ll_color_escogido,custom[],ll_color

//if isvalid(dwo) then
	if rb_fondo.checked then
		ll_color_escogido = st_color_escogido.backcolor
		if ChooseColor(ll_color_escogido, custom [ ] ) = 1 then
			st_color_escogido.backcolor = ll_color_escogido
			rb_fondo.backcolor          = ll_color_escogido
			rb_texto.backcolor          = ll_color_escogido
		end if
	end if
	
	if rb_texto.checked then
		ll_color_escogido = st_color_escogido.textcolor
		if ChooseColor(ll_color_escogido, custom [ ] ) = 1 then
			st_color_escogido.textcolor = ll_color_escogido
		end if
	end if
//end if
end event

type rb_fondo from radiobutton within w_mant_mapa_almacen
integer x = 4457
integer y = 200
integer width = 82
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type rb_texto from radiobutton within w_mant_mapa_almacen
integer x = 4667
integer y = 220
integer width = 82
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type pb_refrescar_marcados from picturebutton within w_mant_mapa_almacen
integer x = 5673
integer y = 188
integer width = 151
integer height = 128
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\db-Refresh.jpg"
alignment htextalign = left!
end type

event clicked;long ll_donde,ll_desde,ll_hasta

ll_desde = 1
ll_hasta = dw_ubicaciones.rowcount()

do
	ll_donde = dw_ubicaciones.find("marcado = 'S'",ll_desde,ll_hasta)
	
	if ll_donde > 0 then
		ll_desde = ll_donde +1
		
		dw_ubicaciones.object.color_fondo[ll_donde] = st_color_escogido.backcolor
		dw_ubicaciones.object.color_texto[ll_donde] = st_color_escogido.textcolor
		
	end if
loop while ll_donde > 0 and ll_desde <= ll_hasta
end event

type pb_imprimir_etiquetas from picturebutton within w_mant_mapa_almacen
integer x = 8325
integer y = 188
integer width = 151
integer height = 128
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;string ls_ean_13
long ll_donde,ll_desde,ll_hasta,ll_row_etiqueta
boolean lb_actualizar_ubicaciones = false

ll_desde = 1
ll_hasta = dw_ubicaciones.rowcount()

if not(cbx_formato_pequeño.checked) then
	if not(cbx_formato_pequeño_estanterias.checked) then
		dw_etiquetas_ubicaciones100.dataobject = "dw_etiquetas_ubicaciones_100"
	else
		dw_etiquetas_ubicaciones100.dataobject = "dw_etiquetas_ubicaciones_pequeña_estanterias"
	end if
else
	dw_etiquetas_ubicaciones100.dataobject = "dw_etiquetas_ubicaciones_pequeña"
end if

dw_etiquetas_ubicaciones100.reset()

do
	ll_donde = dw_ubicaciones.find("marcado = 'S'",ll_desde,ll_hasta)
	
	if ll_donde > 0 then
		ls_ean_13 = dw_ubicaciones.object.ean13[ll_donde]
		if isnull(ls_ean_13) then ls_ean_13 = ""

		if trim(ls_ean_13) = "" then
			ls_ean_13 = "20"+string(dw_ubicaciones.object.id[ll_donde],"0000000000")
			ls_ean_13 = f_calcula_ean13(ls_ean_13)
			dw_ubicaciones.object.ean13[ll_donde] = ls_ean_13
			lb_actualizar_ubicaciones = true
		end if
		
		ll_desde = ll_donde +1
		
		ll_row_etiqueta = dw_etiquetas_ubicaciones100.insertrow(0)
		
		ls_ean_13 = dw_ubicaciones.object.ean13[ll_donde]				

		dw_etiquetas_ubicaciones100.object.codigo_barras[ll_row_etiqueta] = f_imprimir_ean_13(ls_ean_13)//f_ean_13(ls_ean_13)
		dw_etiquetas_ubicaciones100.object.descripcion[ll_row_etiqueta]   = dw_ubicaciones.object.almacen[ll_donde]+'-'+dw_ubicaciones.object.zona[ll_donde]+'-'+string(dw_ubicaciones.object.fila[ll_donde],"###0")+'-'+string(dw_ubicaciones.object.altura[ll_donde],"###0")
		if cbx_formato_pequeño.checked then
			dw_etiquetas_ubicaciones100.object.almacen[ll_row_etiqueta]       = "(ETIQUETA PARA CARRETILLA)"
		else
			dw_etiquetas_ubicaciones100.object.almacen[ll_row_etiqueta]       = dw_ubicaciones.object.almacen[ll_donde]
		end if
		dw_etiquetas_ubicaciones100.object.zona[ll_row_etiqueta]          = dw_ubicaciones.object.zona[ll_donde]
		dw_etiquetas_ubicaciones100.object.fila[ll_row_etiqueta]          = string(dw_ubicaciones.object.fila[ll_donde],"###0")
		dw_etiquetas_ubicaciones100.object.altura[ll_row_etiqueta]        = string(dw_ubicaciones.object.altura[ll_donde],"###0")
		dw_etiquetas_ubicaciones100.object.color_fondo[ll_row_etiqueta]   = dw_ubicaciones.object.color_fondo[ll_donde]
		dw_etiquetas_ubicaciones100.object.color_texto[ll_row_etiqueta]   = dw_ubicaciones.object.color_texto[ll_donde]
		dw_etiquetas_ubicaciones100.object.texto_control[ll_row_etiqueta] = dw_ubicaciones.object.ean13[ll_donde]

		if cbx_flechas.checked then
			if dw_ubicaciones.object.altura[ll_donde] = 1 then
				dw_etiquetas_ubicaciones100.object.flecha_abajo[ll_row_etiqueta]  = 'S'
				dw_etiquetas_ubicaciones100.object.flecha_arriba[ll_row_etiqueta] = 'N'
			else
				if dw_ubicaciones.object.altura[ll_donde] = 2 then
					dw_etiquetas_ubicaciones100.object.flecha_abajo[ll_row_etiqueta]  = 'N'
					dw_etiquetas_ubicaciones100.object.flecha_arriba[ll_row_etiqueta] = 'S'				
				else
					dw_etiquetas_ubicaciones100.object.flecha_abajo[ll_row_etiqueta]  = 'N'
					dw_etiquetas_ubicaciones100.object.flecha_arriba[ll_row_etiqueta] = 'N'				
				end if			
			end if
		else
			dw_etiquetas_ubicaciones100.object.flecha_abajo[ll_row_etiqueta]  = 'N'
			dw_etiquetas_ubicaciones100.object.flecha_arriba[ll_row_etiqueta] = 'N'							
		end if
	end if
loop while ll_donde > 0 and ll_desde <= ll_hasta

if ll_row_etiqueta > 0 then
	dw_etiquetas_ubicaciones100.setredraw(false)
	dw_etiquetas_ubicaciones100.Object.DataWindow.Zoom = 100
	dw_etiquetas_ubicaciones100.groupcalc()
	f_imprimir_datawindow(dw_etiquetas_ubicaciones100)
	dw_etiquetas_ubicaciones100.Object.DataWindow.Zoom = 50
	dw_etiquetas_ubicaciones100.setredraw(true)
	
	if lb_actualizar_ubicaciones then
		dw_ubicaciones.Update()
		COMMIT;	
	end if
end if
end event

type dw_etiquetas_ubicaciones100 from datawindow within w_mant_mapa_almacen
integer x = 6560
integer y = 352
integer width = 1920
integer height = 1220
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiquetas_ubicaciones_100"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cbx_flechas from checkbox within w_mant_mapa_almacen
integer x = 6597
integer y = 184
integer width = 722
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Flechas en alturas 1 y 2"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type em_altura_a_marcar from editmask within w_mant_mapa_almacen
integer x = 6277
integer y = 192
integer width = 91
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#0"
boolean autoskip = true
double increment = 1
string minmax = "0~~99"
end type

type cb_marcar_altura from commandbutton within w_mant_mapa_almacen
integer x = 5888
integer y = 188
integer width = 389
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcar Altura:"
end type

event clicked;long ll_donde,ll_desde,ll_hasta,ll_altura_marco

ll_altura_marco = dec(em_altura_a_marcar.text)
ll_desde = 1
ll_hasta = dw_ubicaciones.rowcount()

for ll_donde = ll_desde to ll_hasta
	
	if dw_ubicaciones.object.altura[ll_donde] = ll_altura_marco then
		dw_ubicaciones.object.marcado[ll_donde] = 'S'
	else
		dw_ubicaciones.object.marcado[ll_donde] = 'N'
	end if
next
end event

type gb_1 from groupbox within w_mant_mapa_almacen
integer x = 4279
integer y = 128
integer width = 2176
integer height = 208
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Asignar Colores"
borderstyle borderstyle = styleraised!
end type

type r_botones from rectangle within w_mant_mapa_almacen
boolean visible = false
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 12639424
integer x = 2103
integer y = 128
integer width = 1221
integer height = 208
end type

type gb_impresion_etiquetas from groupbox within w_mant_mapa_almacen
integer x = 6546
integer y = 128
integer width = 1943
integer height = 1460
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Etiquetas Ubicaciones"
borderstyle borderstyle = styleraised!
end type

type dw_listado from datawindow within w_mant_mapa_almacen
boolean visible = false
integer x = 5
integer width = 914
integer height = 192
string dataobject = "report_con_ubicaciones"
boolean livescroll = true
end type

type cb_generar_bultos from commandbutton within w_mant_mapa_almacen
boolean visible = false
integer x = 6560
integer y = 2704
integer width = 1920
integer height = 112
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Generar Bultos"
end type

event clicked;string ls_execute,ls_sel
long   ll_indice,ll_total,ll_donde
str_alm_bultos lstr_alm_bultos
str_alm_bultos_lineas lstr_alm_bultos_lineas

datastore ds_datos,ds_insert

delete alm_bultos;

commit;

delete alm_bultos_lineas;

commit;

ls_execute = "DBCC CHECKIDENT (alm_bultos, RESEED, 0)"
execute immediate :ls_execute using sqlca;
if sqlca.sqlcode = 0 then
	commit;
else
	rollback;
end if

ls_execute = "DBCC CHECKIDENT (alm_bultos_lineas, RESEED, 0)"
execute immediate :ls_execute using sqlca;
if sqlca.sqlcode = 0 then
	commit;
else
	rollback;
end if

delete orden_carga_linea_reservas;
commit;

/*
//update venliped set tono_imprimir = isnull(tonochar,''),calibre_imprimir = isnull(convert(char(5),calibre),'');
//commit;
//update venliped set calibre_imprimir = replace(calibre_imprimir,'0','');
//commit;
//
//update venlialb set tono_imprimir = isnull(tonochar,''),calibre_imprimir = isnull(convert(char(5),calibre),'');
//commit;
//update venlialb set calibre_imprimir = replace(calibre_imprimir,'0','');
//commit;
//
//update venlifac set tono_imprimir = isnull(tonochar,''),calibre_imprimir = isnull(convert(char(5),calibre),'');
//commit;
//update venlifac set calibre_imprimir = replace(calibre_imprimir,'0','');
//commit;
*/

ls_sel = "select almacenmovimientos.almacen, "+&
			"       almacenmovimientos.zona, "+&
			"       almacenmovimientos.fila, "+&
			"       almacenmovimientos.altura, "+&
			"		  almubimapa_codbar.id, "+&
			"       almacenmovimientos.articulo, "+&
			"       almacenmovimientos.calidad, "+&
			"       isnull(almacenmovimientos.tono,'') as tono, "+&
			"       isnull(almacenmovimientos.calibre,0) as calibre, "+&
			"       isnull(almacenmovimientos.tipo_pallet,'') as almacenmovimientos_tipo_pallet, "+&
			"       isnull(almacenmovimientos.caja,'') as almacenmovimientos_caja, "+&
			"       isnull(sum(isnull(almacenmovimientos.cantidade,0) - isnull(almacenmovimientos.cantidads,0)),0) as existencias "+&
			"from   almacenmovimientos,almubimapa_codbar "+&
			"where  almacenmovimientos.empresa = almubimapa_codbar.empresa "+&
			"and    almacenmovimientos.almacen = almubimapa_codbar.almacen "+&
			"and    almacenmovimientos.zona    = almubimapa_codbar.zona "+&
			"and    almacenmovimientos.fila    = almubimapa_codbar.fila "+&
			"and    almacenmovimientos.altura  = almubimapa_codbar.altura "+&
			"and    almacenmovimientos.empresa = '"+codigo_empresa+"' "+&
			"group by almacenmovimientos.almacen, "+&
			"       almacenmovimientos.zona, "+&
			"       almacenmovimientos.fila, "+&
			"       almacenmovimientos.altura, "+&
			"       almubimapa_codbar.id, "+&
			"       almacenmovimientos.articulo, "+&
			"       almacenmovimientos.calidad, "+&
			"       isnull(almacenmovimientos.tono,''), "+&
			"       isnull(almacenmovimientos.calibre,0), "+&
			"       isnull(almacenmovimientos.tipo_pallet,''), "+&
			"       isnull(almacenmovimientos.caja,'') "+&
			"having   isnull(sum(isnull(almacenmovimientos.cantidade,0) - isnull(almacenmovimientos.cantidads,0)),0) <> 0 "+&
			"order by almacenmovimientos.almacen, "+&
			"       almacenmovimientos.zona, "+&
			"       almacenmovimientos.fila, "+&
			"       almacenmovimientos.altura, "+&
			"       almubimapa_codbar.id, "+&
			"       almacenmovimientos.articulo, "+&
			"       almacenmovimientos.calidad, "+&
			"       isnull(almacenmovimientos.tono,''), "+&
			"       isnull(almacenmovimientos.calibre,0), "+&
			"       isnull(almacenmovimientos.tipo_pallet,''), "+&
			"       isnull(almacenmovimientos.caja,'')"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total	
	f_mensaje_proceso("",ll_indice,ll_total)
	string ls_articulo,ls_caja,ls_tipo_pallet
	long   ll_piezascaja,ll_cajaspallet,ll_piezas_pallet,ll_cantidad_ubicacion,ll_cantidad_pendiente_bultos
	
	//Hacemos la gestion de entrada o salida en el bulto
	ls_articulo           = ds_datos.object.almacenmovimientos_articulo[ll_indice]
	ls_caja               = ds_datos.object.almacenmovimientos_caja[ll_indice]
	ls_tipo_pallet        = ds_datos.object.almacenmovimientos_tipo_pallet[ll_indice]
	ll_cantidad_ubicacion = ds_datos.object.existencias[ll_indice]
	
	SELECT isnull(almartcajas.piezascaja,0)
	INTO   :ll_piezascaja 
	FROM   almartcajas  
	WHERE  almartcajas.empresa   = :codigo_empresa
	AND    almartcajas.articulo  = :ls_articulo
	AND    almartcajas.caja      = :ls_caja;
		
	SELECT isnull(palarticulo.cajaspallet,0) 
	INTO   :ll_cajaspallet
	FROM   palarticulo
	WHERE  palarticulo.empresa  = :codigo_empresa
	AND    palarticulo.articulo = :ls_articulo
	AND    palarticulo.codigo   = :ls_tipo_pallet
	AND    palarticulo.caja     = :ls_caja;
	
	ll_piezas_pallet = ll_piezascaja * ll_cajaspallet
	
	ll_cantidad_pendiente_bultos = ll_cantidad_ubicacion
	
	do
		lstr_alm_bultos.id                 = 0
		lstr_alm_bultos.empresa            = codigo_empresa
		lstr_alm_bultos.ean13              = ""
		lstr_alm_bultos.tipo_pallet        = ds_datos.object.almacenmovimientos_tipo_pallet[ll_indice]
		lstr_alm_bultos.alto               = 0
		lstr_alm_bultos.usuario            = "AUTOMATICO"
		lstr_alm_bultos.fecha_hora_alta    = datetime(today(),now())
		lstr_alm_bultos.id_ubicacion       = ds_datos.object.almubimapa_codbar_id[ll_indice]
		lstr_alm_bultos.anyo_orden_carga   = 0
		lstr_alm_bultos.codigo_orden_carga = ""
		
		f_cargar_cursor_transaccion(sqlca,ds_insert ,"select * from alm_bultos where 0 = 1")
		
		ll_donde = ds_insert.insertrow(0)
		
		ds_insert.object.empresa[ll_donde]            = lstr_alm_bultos.empresa
		ds_insert.object.ean13[ll_donde]              = lstr_alm_bultos.ean13
		ds_insert.object.tipo_pallet[ll_donde]        = lstr_alm_bultos.tipo_pallet
		ds_insert.object.alto[ll_donde]               = lstr_alm_bultos.alto
		ds_insert.object.usuario[ll_donde]            = lstr_alm_bultos.usuario
		ds_insert.object.fecha_hora_alta[ll_donde]    = lstr_alm_bultos.fecha_hora_alta
		ds_insert.object.id_ubicacion[ll_donde]       = lstr_alm_bultos.id_ubicacion
		ds_insert.object.anyo_orden_carga[ll_donde]   = lstr_alm_bultos.anyo_orden_carga
		ds_insert.object.codigo_orden_carga[ll_donde] = lstr_alm_bultos.codigo_orden_carga
		
		if ds_insert.update(true) = 1 then
			f_mensaje_proceso(string(ds_insert.object.id[ll_donde]),ll_indice,ll_total)
			
			if ds_insert.object.id[ll_donde] = 3042 then
				ds_insert.object.id[ll_donde] = 3042
			end if
			
			setnull(lstr_alm_bultos_lineas.id)
			lstr_alm_bultos_lineas.id_alm_bultos = ds_insert.object.id[ll_donde] 
			lstr_alm_bultos_lineas.empresa       = lstr_alm_bultos.empresa
			lstr_alm_bultos_lineas.articulo      = ds_datos.object.almacenmovimientos_articulo[ll_indice]
			lstr_alm_bultos_lineas.calidad       = ds_datos.object.almacenmovimientos_calidad[ll_indice]
			lstr_alm_bultos_lineas.tono          = ds_datos.object.tono[ll_indice]
			lstr_alm_bultos_lineas.calibre       = ds_datos.object.calibre[ll_indice]
			lstr_alm_bultos_lineas.caja          = ds_datos.object.almacenmovimientos_caja[ll_indice]
			
			if ll_piezas_pallet = 0 then ll_piezas_pallet = ll_cantidad_pendiente_bultos
			
			if ll_cantidad_pendiente_bultos > ll_piezas_pallet then
				lstr_alm_bultos_lineas.cantidad = ll_piezas_pallet
				ll_cantidad_pendiente_bultos    = ll_cantidad_pendiente_bultos - ll_piezas_pallet
			else
				lstr_alm_bultos_lineas.cantidad = ll_cantidad_pendiente_bultos
				ll_cantidad_pendiente_bultos    = 0
			end if
			
			lstr_alm_bultos_lineas.linea_orden_carga = 0
			
			insert into alm_bultos_lineas
				(alm_bultos_lineas.id_alm_bultos,
				 alm_bultos_lineas.empresa,
				 alm_bultos_lineas.articulo,
				 alm_bultos_lineas.calidad,
				 alm_bultos_lineas.tono,
				 alm_bultos_lineas.calibre,
				 alm_bultos_lineas.caja,
				 alm_bultos_lineas.cantidad,
				 alm_bultos_lineas.linea_orden_carga)
			values 
				(:lstr_alm_bultos_lineas.id_alm_bultos,
				 :lstr_alm_bultos_lineas.empresa,
				 :lstr_alm_bultos_lineas.articulo,
				 :lstr_alm_bultos_lineas.calidad,
				 :lstr_alm_bultos_lineas.tono,
				 :lstr_alm_bultos_lineas.calibre,
				 :lstr_alm_bultos_lineas.caja,
				 :lstr_alm_bultos_lineas.cantidad,
				 :lstr_alm_bultos_lineas.linea_orden_carga);
				 
			if sqlca.sqlcode <> 0 then
				messagebox("¡Error!",sqlca.sqlerrtext)
				rollback;
			else
				commit;			
			end if
		else
			messagebox("¡Error!",sqlca.sqlerrtext)
			rollback;
		end if
		
		destroy ds_insert
	loop while ll_cantidad_pendiente_bultos > 0
next

destroy ds_datos

ls_sel = "SELECT orden_carga.anyo, "+&
         "       orden_carga.codigo, "+&
         "       orden_carga_linea.linea, "+&
         "       orden_carga.almacen_destino, "+&
         "       orden_carga.zona_destino, "+&
         "       orden_carga.fila_destino, "+&
         "       orden_carga.altura_destino, "+& 
         "       venliped.articulo, "+&
         "       venliped.calidad, "+&
         "       venliped.tonochar, "+&
         "       venliped.calibre, "+&
         "       venliped.tipo_pallet, "+&
         "       venliped.caja, "+&
         "       venliped.numpalet, "+&
         "       venliped.cantidad, "+&
         "       almartcajas.piezascaja, "+&
         "       almartcajas.metroscaja, "+&
			"       case when articulos.unidad = '0' then venliped.cantidad else (venliped.cantidad / almartcajas.metroscaja) *  almartcajas.piezascaja end as cantidad_piezas "+&
         "FROM orden_carga, "+&
         "     orden_carga_linea, "+&
         "     venliped, "+&
         "     articulos, "+&
         "     almartcajas "+&
         "WHERE ( orden_carga.empresa = orden_carga_linea.empresa ) and "+&
         "      ( orden_carga.anyo = orden_carga_linea.anyo ) and "+&
         "      ( orden_carga.codigo = orden_carga_linea.codigo ) and "+&
         "      ( orden_carga_linea.empresa = venliped.empresa ) and "+&
         "      ( orden_carga_linea.venliped_anyo = venliped.anyo ) and "+& 
         "      ( orden_carga_linea.venliped_pedido = venliped.pedido ) and "+&
         "      ( orden_carga_linea.venliped_linea = venliped.linea ) and "+&
         "      ( venliped.empresa = articulos.empresa ) and "+&
         "      ( venliped.articulo = articulos.codigo ) and "+&
         "      ( venliped.empresa = almartcajas.empresa ) and "+&
         "      ( venliped.articulo = almartcajas.articulo ) and "+&
         "      ( venliped.caja = almartcajas.caja ) and "+&
         "      ( ( orden_carga.empresa = '1' ) AND "+&
         "      ( orden_carga.finalizada = 'S' ) ) "+&
         "ORDER BY orden_carga.anyo ASC, "+&
         "         orden_carga.codigo ASC, "+& 
         "         venliped.numpalet ASC,"+&
			"         venliped.cantidad DESC"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

boolean lb_correcto = true
dec     ld_cantidad_pendiente_bulto
long    ll_venliped_numpallet

str_orden_carga_linea_reservas lstr_orden_carga_linea_reservas
str_movimiento_almacen lstr_movimiento_almacen

for ll_indice = 1 to ll_total	
	f_mensaje_proceso("OCS Preparadas",ll_indice,ll_total)
		
	lstr_movimiento_almacen.empresa            = codigo_empresa
	lstr_movimiento_almacen.articulo           = ds_datos.object.venliped_articulo[ll_indice]
	lstr_movimiento_almacen.calidad            = ds_datos.object.venliped_calidad[ll_indice]
	lstr_movimiento_almacen.tono               = ds_datos.object.venliped_tonochar[ll_indice]
	lstr_movimiento_almacen.calibre            = ds_datos.object.venliped_calibre[ll_indice]
	lstr_movimiento_almacen.tipo_pallet        = ds_datos.object.venliped_tipo_pallet[ll_indice]
	lstr_movimiento_almacen.caja               = ds_datos.object.venliped_caja[ll_indice]
	lstr_movimiento_almacen.cantidad           = (ds_datos.object.cantidad_piezas[ll_indice] * -1)
	lstr_movimiento_almacen.orden_carga_anyo   = 0
	lstr_movimiento_almacen.orden_carga_codigo = ""
	lstr_movimiento_almacen.orden_carga_linea  = 0
	lstr_movimiento_almacen.tipo_movimiento    = "204" //Salida Preparación
	lstr_movimiento_almacen.observaciones      = ""
	lstr_movimiento_almacen.almacen            = ds_datos.object.orden_carga_almacen_destino[ll_indice]
	lstr_movimiento_almacen.zona               = ds_datos.object.orden_carga_zona_destino[ll_indice]
	lstr_movimiento_almacen.fila               = ds_datos.object.orden_carga_fila_destino[ll_indice]
	lstr_movimiento_almacen.altura             = ds_datos.object.orden_carga_altura_destino[ll_indice]
	lstr_movimiento_almacen.tercero            = ""
	lstr_movimiento_almacen.documento          = ""
	lstr_movimiento_almacen.fecha              = datetime(today(),now())
	lstr_movimiento_almacen.id_ubicacion       = 0
	lstr_movimiento_almacen.id_alm_bultos		 = 0
					
	if not(f_movimiento_almacen_sin_almacenmovimientos(lstr_movimiento_almacen)) then
		lb_correcto = false
	end if
	
	//Si la salida ha sido de todo el bulto la entrada será tambien de ese mismo bulto
	ld_cantidad_pendiente_bulto = 0
	
	SELECT isnull(sum(alm_bultos_lineas.cantidad),0)
	INTO   :ld_cantidad_pendiente_bulto
	FROM   alm_bultos,   
			 alm_bultos_lineas  
	WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
	AND ( ( alm_bultos.id = :lstr_movimiento_almacen.id_alm_bultos ) ) ;
	
	//				
	lstr_orden_carga_linea_reservas.empresa       = codigo_empresa
	lstr_orden_carga_linea_reservas.anyo          = ds_datos.object.orden_carga_anyo[ll_indice]
	lstr_orden_carga_linea_reservas.codigo        = ds_datos.object.orden_carga_codigo[ll_indice]
	ll_venliped_numpallet                         = ds_datos.object.venliped_numpalet[ll_indice]	
	
	if lstr_movimiento_almacen.articulo = "107634" then
		lstr_movimiento_almacen.articulo = "107634"
	end if
	
	lstr_movimiento_almacen.id_alm_bultos = 0	
	
	SELECT isnull(max(orden_carga_linea_reservas.id_alm_bultos),0)
	INTO   :lstr_movimiento_almacen.id_alm_bultos 
	FROM  orden_carga_linea_reservas,
			orden_carga_linea,
			venliped 
	WHERE orden_carga_linea_reservas.empresa = orden_carga_linea.empresa 
	AND   orden_carga_linea_reservas.anyo    = orden_carga_linea.anyo 
	AND   orden_carga_linea_reservas.codigo  = orden_carga_linea.codigo 	
	AND   orden_carga_linea_reservas.linea   = orden_carga_linea.linea 	
   AND   orden_carga_linea.empresa          = venliped.empresa
   AND   orden_carga_linea.venliped_anyo    = venliped.anyo
   AND   orden_carga_linea.venliped_pedido  = venliped.pedido
   AND   orden_carga_linea.venliped_linea   = venliped.linea	
	AND   orden_carga_linea_reservas.empresa = :lstr_orden_carga_linea_reservas.empresa 
	AND   orden_carga_linea_reservas.anyo    = :lstr_orden_carga_linea_reservas.anyo 
	AND   orden_carga_linea_reservas.codigo  = :lstr_orden_carga_linea_reservas.codigo 
	AND   venliped.numpalet                  = :ll_venliped_numpallet;
	
	
	if lstr_movimiento_almacen.id_alm_bultos <> 0 then
		lstr_movimiento_almacen.tipo_pallet = ""
		
		select isnull(alm_bultos.tipo_pallet,'')
		into   :lstr_movimiento_almacen.tipo_pallet
		from   alm_bultos
		where  alm_bultos.id = :lstr_movimiento_almacen.id_alm_bultos;
		
		if trim(lstr_movimiento_almacen.tipo_pallet) = "" then
			lstr_movimiento_almacen.tipo_pallet   = ds_datos.object.venliped_tipo_pallet[ll_indice]
		end if
	else
		lstr_movimiento_almacen.tipo_pallet   = ds_datos.object.venliped_tipo_pallet[ll_indice]
	end if
	
	//Debo controlar si traspaso el bulto o pongo las cajas en destino sobre otro que ya existe
	//Lo hacemos mediante venliped_numpallet
	
	lstr_movimiento_almacen.empresa            = codigo_empresa
	lstr_movimiento_almacen.articulo           = ds_datos.object.venliped_articulo[ll_indice]
	lstr_movimiento_almacen.calidad            = ds_datos.object.venliped_calidad[ll_indice]
	lstr_movimiento_almacen.tono               = ds_datos.object.venliped_tonochar[ll_indice]
	lstr_movimiento_almacen.calibre            = ds_datos.object.venliped_calibre[ll_indice]
	//lstr_movimiento_almacen.tipo_pallet        = ds_datos.object.venliped_tipo_pallet[ll_indice]
	lstr_movimiento_almacen.caja               = ds_datos.object.venliped_caja[ll_indice]
	lstr_movimiento_almacen.cantidad           = ds_datos.object.cantidad_piezas[ll_indice]
	lstr_movimiento_almacen.orden_carga_anyo   = ds_datos.object.orden_carga_anyo[ll_indice]
	lstr_movimiento_almacen.orden_carga_codigo = ds_datos.object.orden_carga_codigo[ll_indice]
	lstr_movimiento_almacen.orden_carga_linea  = ds_datos.object.orden_carga_linea_linea[ll_indice]
	lstr_movimiento_almacen.tipo_movimiento    = "205" //Entrada Preparación
	lstr_movimiento_almacen.observaciones      = ""
	lstr_movimiento_almacen.almacen            = ds_datos.object.orden_carga_almacen_destino[ll_indice]
	lstr_movimiento_almacen.zona               = ds_datos.object.orden_carga_zona_destino[ll_indice]
	lstr_movimiento_almacen.fila               = ds_datos.object.orden_carga_fila_destino[ll_indice]
	lstr_movimiento_almacen.altura             = ds_datos.object.orden_carga_altura_destino[ll_indice]
	lstr_movimiento_almacen.tercero            = ""
	lstr_movimiento_almacen.documento          = ""
	lstr_movimiento_almacen.fecha              = datetime(today(),now())
	lstr_movimiento_almacen.id_ubicacion       = 0
	//lstr_movimiento_almacen.id_alm_bultos		 = 0
	
	//Introduce pallet a pallet
	if not(f_movimiento_almacen_sin_almacenmovimientos(lstr_movimiento_almacen)) then
		lb_correcto = false
	end if									
	
	lstr_orden_carga_linea_reservas.empresa       = codigo_empresa
	lstr_orden_carga_linea_reservas.anyo          = ds_datos.object.orden_carga_anyo[ll_indice]
	lstr_orden_carga_linea_reservas.codigo        = ds_datos.object.orden_carga_codigo[ll_indice]
	lstr_orden_carga_linea_reservas.linea         = ds_datos.object.orden_carga_linea_linea[ll_indice]
	lstr_orden_carga_linea_reservas.id_alm_bultos = lstr_movimiento_almacen.id_alm_bultos
	lstr_orden_carga_linea_reservas.cantidad      = ds_datos.object.cantidad_piezas[ll_indice]			
	
	insert into orden_carga_linea_reservas
		(orden_carga_linea_reservas.empresa,
		 orden_carga_linea_reservas.anyo,
		 orden_carga_linea_reservas.codigo,
		 orden_carga_linea_reservas.linea,
		 orden_carga_linea_reservas.id_alm_bultos,
		 orden_carga_linea_reservas.cantidad)
	values
		(:lstr_orden_carga_linea_reservas.empresa,
		 :lstr_orden_carga_linea_reservas.anyo,
		 :lstr_orden_carga_linea_reservas.codigo,
		 :lstr_orden_carga_linea_reservas.linea,
		 :lstr_orden_carga_linea_reservas.id_alm_bultos,
		 :lstr_orden_carga_linea_reservas.cantidad);

	if sqlca.sqlcode <> 0 then
		lb_correcto = false
	end if
	
next

if lb_correcto then
	commit;
else
	rollback;
end if

destroy ds_datos

/*
//Vamos a asignar los lotes a la planificacion
long ll_lote
int  li_calibre

delete contador_lotes;

commit;

ls_execute = "DBCC CHECKIDENT (contador_lotes, RESEED, 0)"
execute immediate :ls_execute using sqlca;
if sqlca.sqlcode = 0 then
	commit;
else
	rollback;
end if

/*
SELECT planificacion.empresa, planificacion.ot, planificacion.pedido, planificacion.linped, planificacion.anyo, 
planificacion.orden, planificacion.lineaprod, planificacion.ordenoperacion, planificacion.tipo_operacion, planificacion.stockacabado, 
planificacion.stockbase, planificacion.cantidad, planificacion.formato, planificacion.cod_articulo, planificacion.version, 
planificacion.base, planificacion.formato_base, planificacion.f_entrega, planificacion.usuario, planificacion.ordenmarcado, 
planificacion.velocidad, planificacion.fecha_fin, planificacion.hay_obs_ubicaciones, planificacion.fecha_anterior, planificacion.fecha_sugerida, 
planificacion.fecha_salida, planificacion.ajuste, planificacion.factor, planificacion.art_encajado, planificacion.nivel, 
planificacion.fecha_exacta, planificacion.stock_cajas, planificacion.f_fin_estimada, planificacion.ordenf, planificacion.calidad, 
planificacion.lote, planificacion.calibre, planificacion.ean128 
FROM planificacion;
*/

string ls_lote
long   ll_anyo,ll_pedido,ll_linped

ls_sel = "SELECT planificacion.pedido, planificacion.linped, planificacion.anyo "+&
			"FROM   planificacion "+&
			"WHERE  planificacion.empresa = '"+codigo_empresa+"' "+&
			"GROUP BY planificacion.anyo, planificacion.pedido, planificacion.linped "+&
			"ORDER BY planificacion.anyo, planificacion.pedido, planificacion.linped"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

lb_correcto = true

for ll_indice = 1 to ll_total	
	f_mensaje_proceso("Lotes Producción",ll_indice,ll_total)

	ll_anyo   = ds_datos.object.anyo[ll_indice]
	ll_pedido = ds_datos.object.pedido[ll_indice]
	ll_linped = ds_datos.object.linped[ll_indice]

	ll_lote    = f_contador("contador_lotes",1) //El segundo parametro es el valor inicial en caso de que no exista el contador
	li_calibre = 5					

	ls_lote    = string(ll_lote,"#######0")

	update planificacion
	set    planificacion.lote    = :ls_lote,
			 planificacion.calibre = :li_calibre 
	where  planificacion.empresa = :codigo_empresa 
	and    planificacion.anyo   = :ll_anyo 
	and    planificacion.pedido = :ll_pedido 
	and    planificacion.linped = :ll_linped;

	if sqlca.sqlcode <> 0 then
		lb_correcto = false
	end if
	
next

if lb_correcto then
	commit;
else
	rollback;
end if

destroy ds_datos

update articulos
set    articulos.tono     = 'S',
		 articulos.calibre  = 'S' 
where articulos.empresa   = :codigo_empresa 
and   articulos.promocion = 'N' 
and   articulos.sector    = 'S';

commit;
*/
end event

type cb_1 from commandbutton within w_mant_mapa_almacen
boolean visible = false
integer x = 6560
integer y = 2928
integer width = 1920
integer height = 112
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Observaciones Bultos"
end type

event clicked;string ls_sel,ls_observaciones
long   ll_indice,ll_total,ll_id

datastore ds_datos

ls_sel = " SELECT alm_bultos.id, "+&
			"			almacenmovimientos_observaciones.observaciones "+&
			"	 FROM alm_bultos, "+&
			"			alm_bultos_lineas, "+&
			"			almacenmovimientos_observaciones, "+&
			"			almubimapa_codbar "+&
			"	WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) and "+&
			"			( alm_bultos.id_ubicacion = almubimapa_codbar.id ) and "+&
			"			( alm_bultos_lineas.empresa = almacenmovimientos_observaciones.empresa ) and "+&
			"			( alm_bultos_lineas.articulo = almacenmovimientos_observaciones.articulo ) and "+&
			"			( alm_bultos_lineas.calidad = almacenmovimientos_observaciones.calidad ) and "+&
			"			( alm_bultos_lineas.tono = almacenmovimientos_observaciones.tono ) and "+&
			"			( alm_bultos_lineas.calibre = almacenmovimientos_observaciones.calibre ) and "+&
			"			( alm_bultos.tipo_pallet = almacenmovimientos_observaciones.tipo_pallet ) and "+&
			"			( alm_bultos_lineas.caja = almacenmovimientos_observaciones.caja ) and "+&
			"			( almubimapa_codbar.almacen = almacenmovimientos_observaciones.almacen ) and "+&
			"			( almubimapa_codbar.zona = almacenmovimientos_observaciones.zona ) and "+&
			"			( almubimapa_codbar.fila = almacenmovimientos_observaciones.fila ) and "+&
			"			( almubimapa_codbar.altura = almacenmovimientos_observaciones.altura ) and "+&
			"			( ( alm_bultos.empresa = '1' ) AND "+&
			"			( isnull(almacenmovimientos_observaciones.observaciones,'') <> '' ) )"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	f_mensaje_proceso("",ll_indice,ll_total)
	
	ll_id            = ds_datos.object.alm_bultos_id[ll_indice]
	ls_observaciones = trim(ds_datos.object.almacenmovimientos_observaciones_observaciones[ll_indice])
	
	update alm_bultos
	set    alm_bultos.observaciones = :ls_observaciones
	where  alm_bultos.id            = :ll_id;
		
	if sqlca.sqlcode <> 0 then
		rollback;
		messagebox("Error",string(ll_id)+"~n"+ls_observaciones)
	else
		commit;
	end if
next

destroy ds_datos
end event

type cb_2 from commandbutton within w_mant_mapa_almacen
boolean visible = false
integer x = 6560
integer y = 2816
integer width = 1920
integer height = 112
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Agrupar bultos"
end type

event clicked;string ls_sel
long   ll_indice,ll_total,ll_indice2,ll_total2
long   ll_anyo_orden_carga,ll_linea_orden_carga,ll_id_alm_bultos,ll_id_alm_bultos2,ll_id_alm_bultos_lineas2
string ls_codigo_orden_carga
dec    ld_cantidad_alm_bultos

datastore ds_datos,ds_datos2

ls_sel = "select alm_bultos.anyo_orden_carga,"+&
			"		alm_bultos.codigo_orden_carga,"+&
			"		alm_bultos_lineas.linea_orden_carga,"+&
			"		count(*)  "+&
			"from    alm_bultos,"+&
			"		   alm_bultos_lineas "+&
			"where alm_bultos.id = alm_bultos_lineas.id_alm_bultos "+&
			"and ( alm_bultos.empresa = '1' ) "+&
			"and ( alm_bultos.codigo_orden_carga <> '' ) "+&
			"group by alm_bultos.anyo_orden_carga, "+&
			"			  alm_bultos.codigo_orden_carga, "+&  
			"			  alm_bultos_lineas.linea_orden_carga "+&
			"having ( count(*) > 1 ) "+&
			"order by alm_bultos.anyo_orden_carga,"+&
			"			  alm_bultos.codigo_orden_carga,"+&   
			"			  alm_bultos_lineas.linea_orden_carga"
			
ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	f_mensaje_proceso("Agrupando",ll_indice,ll_total)
	ll_anyo_orden_carga = ds_datos.object.alm_bultos_anyo_orden_carga[ll_indice]
	ls_codigo_orden_carga = ds_datos.object.alm_bultos_codigo_orden_carga[ll_indice]
	ll_linea_orden_carga = ds_datos.object.alm_bultos_lineas_linea_orden_carga[ll_indice]
	
	ll_id_alm_bultos = 0
	ld_cantidad_alm_bultos = 0
	
	select orden_carga_linea_reservas.id_alm_bultos, 
			 orden_carga_linea_reservas.cantidad 
	into    :ll_id_alm_bultos,
			 :ld_cantidad_alm_bultos 
	from   orden_carga_linea_reservas
	where orden_carga_linea_reservas.empresa = :codigo_empresa
	and     orden_carga_linea_reservas.anyo = :ll_anyo_orden_carga
	and     orden_carga_linea_reservas.codigo = :ls_codigo_orden_carga
	and     orden_carga_linea_reservas.linea = :ll_linea_orden_carga;
	
	if ll_id_alm_bultos <> 0 then
		update alm_bultos_lineas
		set       cantidad = :ld_cantidad_alm_bultos
		where  id_alm_bultos = :ll_id_alm_bultos
		and     linea_orden_carga = :ll_linea_orden_carga;
		
		if sqlca.sqlcode <> 0 then
			rollback;
			messagebox("1 Error!","OC "+ls_codigo_orden_carga)
		else
			ls_sel = "select alm_bultos.id,"+&
						"		alm_bultos_lineas.id "+&
						"from    alm_bultos,"+&
						"		   alm_bultos_lineas "+&
						"where alm_bultos.id = alm_bultos_lineas.id_alm_bultos "+&
						"and ( alm_bultos.empresa = '1' ) "+&
						"and ( alm_bultos.anyo_orden_carga = "+string(ll_anyo_orden_carga,"###0")+" ) "+&
						"and ( alm_bultos.codigo_orden_carga = '"+ls_codigo_orden_carga+"' ) "+&
						"and ( alm_bultos_lineas.linea_orden_carga ="+string(ll_linea_orden_carga,"###0")+" ) "+&
						"and ( alm_bultos.id <> "+string(ll_id_alm_bultos,"#########0")+" ) "+&
						"order by alm_bultos.id,"+&
						"			  alm_bultos_lineas.id"
						
			ll_total2 = f_cargar_cursor_transaccion(sqlca,ds_datos2,ls_sel)
			
			for ll_indice2 = 1 to ll_total2
				ll_id_alm_bultos2 = ds_datos2.object.alm_bultos_id[ll_indice2]
				ll_id_alm_bultos_lineas2 = ds_datos2.object.alm_bultos_lineas_id[ll_indice2]
				
				delete alm_bultos_lineas where id = :ll_id_alm_bultos_lineas2;
				
				if sqlca.sqlcode <> 0 then
					rollback;
					messagebox("2 Error!","OC "+ls_codigo_orden_carga)
				else
					delete alm_bultos_lineas where id = :ll_id_alm_bultos_lineas2;
					
					if sqlca.sqlcode <> 0 then
						rollback;
						messagebox("3 Error!","OC "+ls_codigo_orden_carga)
					else					
						commit;
					end if
				end if
			next
			destroy ds_datos2
		end if
	end if
	
next

destroy ds_datos

messagebox("Fin!","Proceso finalizado.")
end event

type dw_etiquetas_bultos_100 from datawindow within w_mant_mapa_almacen
integer x = 6560
integer y = 1844
integer width = 1920
integer height = 1220
integer taborder = 31
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiquetas_bultos_100"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_imprimir_bultos from picturebutton within w_mant_mapa_almacen
integer x = 8325
integer y = 1680
integer width = 151
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;string ls_ean_13,ls_almacen,ls_zona,ls_sel,ls_descripcion_bulto
long ll_donde,ll_desde,ll_hasta,ll_indice,ll_total,ll_lineas_bulto
int  li_row_etiqueta,li_fila,li_altura
str_alm_bultos lstr_alm_bultos

datastore ds_datos

ll_desde = 1
ll_hasta = dw_ubicaciones.rowcount()

dw_etiquetas_bultos_100.reset()

do
	ll_donde = dw_ubicaciones.find("marcado = 'S'",ll_desde,ll_hasta)
	
	if ll_donde > 0 then
		ll_desde = ll_donde +1
		
		ls_almacen = dw_ubicaciones.object.almacen[ll_donde]
		ls_zona    = dw_ubicaciones.object.zona[ll_donde]
		li_fila    = dw_ubicaciones.object.fila[ll_donde]
		li_altura  = dw_ubicaciones.object.altura[ll_donde]
		
		ls_sel = "SELECT alm_bultos.id "+&
					"FROM   alm_bultos, "+& 
					"       alm_bultos_lineas, "+& 
					"		  almubimapa_codbar "+&
					"WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
					"AND   ( alm_bultos.id_ubicacion = almubimapa_codbar.id ) "+&
					"and ( ( alm_bultos.empresa        = '"+codigo_empresa+"' ) "+&
					"AND   ( almubimapa_codbar.almacen = '"+ls_almacen+"' ) "+&
					"AND   ( almubimapa_codbar.zona    = '"+ls_zona+"' ) "+&
					"AND   ( almubimapa_codbar.fila    = "+string(li_fila,"###0")+" ) "+&
					"AND   ( almubimapa_codbar.altura  = "+string(li_altura,"##0")+" ) ) "+&   
					"ORDER BY alm_bultos.id ASC"
		
		ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice = 1 to ll_total
			lstr_alm_bultos.id = ds_datos.object.alm_bultos_id[ll_indice]
			
			if f_cargar_str_alm_bultos(lstr_alm_bultos.id,lstr_alm_bultos) then
				ls_descripcion_bulto = ''
				ll_lineas_bulto = 0
				
				select isnull(count(*),0)
				into   :ll_lineas_bulto
				from   alm_bultos_lineas
				where  alm_bultos_lineas.id_alm_bultos = :lstr_alm_bultos.id;
				
				if ll_lineas_bulto = 1 then
					select 'B '+ltrim(rtrim(isnull(articulos.descripcion,'')))+' '+ltrim(rtrim(isnull(formatos.descripcion,'')))+' '+ltrim(rtrim(convert(char(10),isnull(convert(dec(16,0),alm_bultos_lineas.cantidad),0))))+' UDS'
					into   :ls_descripcion_bulto 
					from   alm_bultos_lineas,
							 articulos,
							 formatos 
					where  alm_bultos_lineas.empresa  = articulos.empresa 
					and    alm_bultos_lineas.articulo = articulos.codigo 
					and    alm_bultos_lineas.empresa  = formatos.empresa 
					and    articulos.formato          = formatos.codigo 
					and    alm_bultos_lineas.id_alm_bultos = :lstr_alm_bultos.id;					
				else
					ls_descripcion_bulto = 'B MULTIREFERENCIA'
				end if
				
				ls_ean_13 = lstr_alm_bultos.ean13
				if isnull(ls_ean_13) then ls_ean_13 = ""
			
				if trim(ls_ean_13) = "" then
					ls_ean_13 = "25"+string(lstr_alm_bultos.id,"0000000000")
					ls_ean_13 = f_calcula_ean13(ls_ean_13)
				end if
				
				li_row_etiqueta = dw_etiquetas_bultos_100.insertrow(0)
			
				dw_etiquetas_bultos_100.object.codigo_barras[li_row_etiqueta] = f_imprimir_ean_13(ls_ean_13)
				dw_etiquetas_bultos_100.object.descripcion[li_row_etiqueta]   = ls_descripcion_bulto//"B"+string(lstr_alm_bultos.id,"0000000000")
				dw_etiquetas_bultos_100.object.almacen[li_row_etiqueta]       = string(lstr_alm_bultos.id,"0000000000")
				dw_etiquetas_bultos_100.object.zona[li_row_etiqueta]          = ""
				dw_etiquetas_bultos_100.object.fila[li_row_etiqueta]          = ""
				dw_etiquetas_bultos_100.object.altura[li_row_etiqueta]        = ""
				dw_etiquetas_bultos_100.object.color_fondo[li_row_etiqueta]   = rgb(255,255,255)//dw_ubicaciones.object.color_fondo[ll_donde] //
				dw_etiquetas_bultos_100.object.color_texto[li_row_etiqueta]   = rgb(0,0,0)//dw_ubicaciones.object.color_texto[ll_donde] //
				dw_etiquetas_bultos_100.object.texto_control[li_row_etiqueta] = ls_almacen+'-'+ls_zona+'-'+string(li_fila,"###0")+'-'+string(li_altura,"##0")
			
				dw_etiquetas_bultos_100.object.flecha_abajo[li_row_etiqueta]  = 'N'
				dw_etiquetas_bultos_100.object.flecha_arriba[li_row_etiqueta] = 'N'												
			end if
		next
		
		destroy ds_datos
	end if
loop while ll_donde > 0 and ll_desde <= ll_hasta

if li_row_etiqueta > 0 then
	dw_etiquetas_bultos_100.setredraw(false)
	//dw_etiquetas_bultos_100.Object.DataWindow.Zoom = 100
	dw_etiquetas_bultos_100.groupcalc()
	f_imprimir_datawindow(dw_etiquetas_bultos_100)
	//dw_etiquetas_bultos_100.Object.DataWindow.Zoom = 50
	dw_etiquetas_bultos_100.setredraw(true)
end if
end event

type cbx_formato_pequeño from checkbox within w_mant_mapa_almacen
integer x = 6597
integer y = 240
integer width = 1280
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Imprimir en formato pequeño (Para carretillas)"
borderstyle borderstyle = styleraised!
end type

event clicked;if this.checked then
	cbx_flechas.checked = false
	cbx_formato_pequeño_estanterias.checked = false
end if
end event

type cbx_formato_pequeño_estanterias from checkbox within w_mant_mapa_almacen
integer x = 6597
integer y = 296
integer width = 1298
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Imprimir en formato pequeño (Para estanterias)"
borderstyle borderstyle = styleraised!
end type

event clicked;if this.checked then
	cbx_flechas.checked = false
	cbx_formato_pequeño.checked = false
end if
end event

type gb_2 from groupbox within w_mant_mapa_almacen
integer x = 6546
integer y = 1620
integer width = 1943
integer height = 1460
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Etiquetas Bultos"
borderstyle borderstyle = styleraised!
end type

