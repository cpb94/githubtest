$PBExportHeader$wc_mantenimientos_tab.srw
$PBExportComments$Ventana para la Generación de Mantenimientos tipo pestaña.
forward
global type wc_mantenimientos_tab from window
end type
type cb_salir from u_cancelar within wc_mantenimientos_tab
end type
type cb_borrar from u_borrar within wc_mantenimientos_tab
end type
type cb_insertar from u_insertar within wc_mantenimientos_tab
end type
type wc_control_tabulador from singlelineedit within wc_mantenimientos_tab
end type
type st_empresa from statictext within wc_mantenimientos_tab
end type
type sle_valor from u_em_campo within wc_mantenimientos_tab
end type
type st_1 from statictext within wc_mantenimientos_tab
end type
type apartados from tab within wc_mantenimientos_tab
end type
type pagina_1 from userobject within apartados
end type
type dw_pagina1 from u_datawindow within pagina_1
end type
type pagina_1 from userobject within apartados
dw_pagina1 dw_pagina1
end type
type pagina_2 from userobject within apartados
end type
type dw_pagina2 from u_datawindow within pagina_2
end type
type pagina_2 from userobject within apartados
dw_pagina2 dw_pagina2
end type
type pagina_3 from userobject within apartados
end type
type dw_pagina3 from u_datawindow within pagina_3
end type
type pagina_3 from userobject within apartados
dw_pagina3 dw_pagina3
end type
type pagina_4 from userobject within apartados
end type
type dw_pagina4 from u_datawindow within pagina_4
end type
type pagina_4 from userobject within apartados
dw_pagina4 dw_pagina4
end type
type pagina_5 from userobject within apartados
end type
type dw_pagina5 from u_datawindow within pagina_5
end type
type pagina_5 from userobject within apartados
dw_pagina5 dw_pagina5
end type
type pagina_6 from userobject within apartados
end type
type dw_pagina6 from u_datawindow within pagina_6
end type
type pagina_6 from userobject within apartados
dw_pagina6 dw_pagina6
end type
type pagina_7 from userobject within apartados
end type
type dw_pagina7 from u_datawindow within pagina_7
end type
type pagina_7 from userobject within apartados
dw_pagina7 dw_pagina7
end type
type pagina_8 from userobject within apartados
end type
type dw_pagina8 from u_datawindow within pagina_8
end type
type pagina_8 from userobject within apartados
dw_pagina8 dw_pagina8
end type
type apartados from tab within wc_mantenimientos_tab
pagina_1 pagina_1
pagina_2 pagina_2
pagina_3 pagina_3
pagina_4 pagina_4
pagina_5 pagina_5
pagina_6 pagina_6
pagina_7 pagina_7
pagina_8 pagina_8
end type
end forward

global type wc_mantenimientos_tab from window
integer x = 114
integer y = 132
integer width = 2729
integer height = 1340
boolean titlebar = true
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 12632256
string icon = "C:\bmp\tencer.ico"
boolean center = true
event ue_inserta_fila pbm_custom01
event ue_borra_fila pbm_custom02
event ue_actualiza_dw pbm_custom03
event ue_pres_preliminar pbm_custom05
event ue_imprimir pbm_custom04
event ue_f3 pbm_custom13
event ue_f1 pbm_custom10
event ue_f2 pbm_custom11
event ue_f4 pbm_custom14
event ue_f5 pbm_custom15
event ue_esc pbm_custom16
event ue_f6 pbm_custom17
event ue_f7 pbm_custom18
event ue_postevent pbm_custom20
event ue_pagina_arriba pbm_custom21
event ue_pagina_abajo pbm_custom22
event ue_cursor_arriba pbm_custom23
event ue_cursor_abajo pbm_custom24
event error_basedatos pbm_custom25
event ue_valores pbm_custom26
event ue_buscar pbm_custom27
event ue_recuperar pbm_custom28
event ue_activa_claves pbm_custom29
event ue_desactiva_claves pbm_custom30
event ue_desbloquear pbm_custom31
event ue_pase_valores pbm_custom32
event ue_cerrar_sin_abrir ( )
cb_salir cb_salir
cb_borrar cb_borrar
cb_insertar cb_insertar
wc_control_tabulador wc_control_tabulador
st_empresa st_empresa
sle_valor sle_valor
st_1 st_1
apartados apartados
end type
global wc_mantenimientos_tab wc_mantenimientos_tab

type variables
	// Parametros Ventanas
Long	id_ventana_activa

Public:

str_parametros  istr_parametros

Int permiso_ventana
string is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas
Boolean cerrar_sin_abrir

// Control Páginas apartados
Boolean pag1,pag2,pag3,pag4,pag5,pag6,pag7,pag8
Boolean pag_act1,pag_act2,pag_act3,pag_act4,pag_act5,pag_act6,pag_act7,pag_act8
Boolean  prin_pag1,prin_pag2,prin_pag3,prin_pag4,prin_pag5,prin_pag6,prin_pag7,prin_pag8
Integer  wc_index

string criterio[],seleccion[8],titulo,tabla[8]
integer longitud
editmask isle_campo
// Variables de busqueda campos relacion datawindos
string bus_cadena,bus_campo,bus_titulo,bus_datawindow,bus_filtro

string  insercion
Boolean reg_insertado

// C-> para manteniminetos con claves tipo char
// N-> es por defecto matenimiento claves numericas
String tipo_mantenimiento
Datawindow  dw_pag1,dw_pag2,dw_pag3,dw_pag4,dw_pag5,dw_pag6,dw_pag7,dw_pag8

boolean ib_control_acceso_pasado = false
end variables

forward prototypes
public subroutine wc_inicio_valores ()
public subroutine wc_activar_paginas ()
public subroutine wc_settransobject ()
public function boolean wc_update ()
public function boolean wc_detelerow ()
public subroutine wc_insertrow ()
public subroutine f_valores_numericos (datawindow w, string c)
public function boolean f_tipo_mantenimiento (string tipo, string codigo)
public subroutine wc_accepttext ()
public subroutine wc_valores_numericos ()
public subroutine wc_reset ()
public subroutine wc_enabled (boolean arg)
public subroutine wc_activar_pagina (integer var_pag)
public function boolean wc_bloquear ()
end prototypes

event ue_inserta_fila;// Inserta una nueva fila en la Datawindow y se desplaza a ella
//

  wc_insertrow()


end event

event ue_borra_fila;//		// Borrado de la fila en curso
//
wc_detelerow()
end event

event ue_actualiza_dw;//	Actualizar la B.D. con los datos de la DataWindow
wc_AcceptText()
TriggerEvent("ue_pase_valores")
IF wc_update() Then
	COMMIT using sqlca;
ELSE		
	ROLLBACK using sqlca;
END IF

end event

on ue_imprimir;	// Abre la Ventana de Opciones de Impresion

OpenWithParm(w_impresoras,istr_parametros)
IF Message.DoubleParm = -1 THEN RETURN


end on

event ue_f2;IF cb_insertar.enabled = FALSE  Then  Return
cb_insertar.TriggerEvent(Clicked!)
end event

event ue_valores;// Introducir valores activacion paginas de apartados
// Ejemplo ....: Si se desea una pagina  : pag1= TRUE
//               Si se deseandos paginas : pag1= TRUE
//						               		  : pag2= TRUE


// Introducir valores anulacion proceso de modificado e insercion
// paginas de apartados
// Ejemplo ....: Si se desea una pagina  : pag_act1= TRUE
//               Si se deseandos paginas : pag_act1= TRUE
//						               		  : pag_act2= TRUE

// Introducir las pantallas principales  una por tabla
// paginas de apartados
// Ejemplo ....: Si se desea una pagina  : prin_pag1= TRUE
//               Si se deseandos paginas : prin_pag2= TRUE
//						               		  : prin_pag3= TRUE
end event

event ue_buscar;
// Lanza la ventana de ayuda para Busquedas de codigos si tiene datawindow asignada
IF trim(istr_parametros.s_nom_datawindow)<> "" THEN
	IF  f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) THEN
		String ll_clave
		istr_parametros.s_criterio_busqueda = isle_campo.Text
		OpenWithParm(w_busquedas,istr_parametros)
		ll_clave = Message.StringParm		// Devuelve el valor que enuentra ...
		isle_campo.text = ll_clave
		isle_campo.TriggerEvent(Modified!)	// Mostrara la descripcion
		f_activar_campo(isle_campo)
	END IF
END IF
end event

event ue_recuperar;long ll_num_filas

insercion="N" // variable de control
IF Trim(sle_valor.text) = "" or sle_valor.text = "00-00-00" Then
	f_activar_campo(sle_valor)
	Return
END iF	

IF apartados.pagina_1.dw_pagina1.RowCount() = 0 THEN
	insercion="S" 
	IF NOT wc_bloquear() THEN
		cb_insertar.TriggerEvent(clicked!)
		Return
	ELSE
		f_activar_campo(sle_valor)
		Return
	END IF
ELSE
	cb_borrar.Enabled = TRUE
	isle_campo.SelectText(1,Len(isle_campo.Text))
END IF





end event

event ue_activa_claves;//////////////////////////////////////////////////////////////////////////
//																								//
//	 Activar los campos clave del Mantenimiento:									//
//																								//
//		- Este evento lo lanzaremos cuando queramos acceder a los campos	//
//		  claves de los mantenimientos y le damos el Focus						//
//		- La unica clave considerada es "sle_valor".								//
//		- En cada Mantenimiento descendiente de este, añadiremos y 			//
//		  activaremos las claves que necesitemos.									//
//																								//
//////////////////////////////////////////////////////////////////////////

sle_valor.enabled = TRUE
wc_control_tabulador.enabled = TRUE
f_activar_campo(isle_campo)
end event

event ue_desactiva_claves;//////////////////////////////////////////////////////////////////////////
//																								//
//	 Desactivar los campos clave del Mantenimiento:								//
//																								//
//		- Este evento lo lanzaremos cuando queramos acceder a los campos	//
//		  claves de los mantenimientos.												//
//		- La unica clave considerada es "sle_valor".								//
//		- En cada Mantenimiento descendiente de este, añadiremos y 			//
//		  desactivaremos las claves que necesitemos.								//
//																								//
//////////////////////////////////////////////////////////////////////////

sle_valor.enabled = FALSE

end event

event ue_desbloquear;Long wc_des
FOR wc_des = 1 To 8
IF  Trim(tabla[wc_des]) <> "" Then
  f_desbloquear(tabla[wc_des],seleccion[wc_des],titulo)
  COMMIT Using SQLCA; // problema concurrencia
END IF
Next
end event

event ue_pase_valores;// Asignacion valores de paginas secundarias a principales
end event

event ue_cerrar_sin_abrir();if cerrar_sin_abrir = true then
	close(this)	
end if
end event

public subroutine wc_inicio_valores ();pag1= FALSE
pag2= FALSE
pag3= FALSE
pag4= FALSE
pag5= FALSE
pag6= FALSE
pag7= FALSE
pag8= FALSE

pag_act1= TRUE
pag_act2= TRUE
pag_act3= TRUE
pag_act4= TRUE
pag_act5= TRUE
pag_act6= TRUE
pag_act7= TRUE
pag_act8= TRUE


prin_pag1= TRUE
prin_pag2= FALSE
prin_pag3= FALSE
prin_pag4= FALSE
prin_pag5= FALSE
prin_pag6= FALSE
prin_pag7= FALSE
prin_pag8= FALSE
end subroutine

public subroutine wc_activar_paginas ();apartados.pagina_1.visible = pag1
apartados.pagina_2.visible = pag2
apartados.pagina_3.visible = pag3
apartados.pagina_4.visible = pag4
apartados.pagina_5.visible = pag5
apartados.pagina_6.visible = pag6
apartados.pagina_7.visible = pag7
apartados.pagina_8.visible = pag8
end subroutine

public subroutine wc_settransobject ();IF pag1= TRUE Then 
	IF pag_act1 = TRUE Then apartados.pagina_1.dw_pagina1.SetTransObject(SQLCA)
END IF
IF pag2= TRUE Then 
	IF pag_act2 = TRUE Then apartados.pagina_2.dw_pagina2.SetTransObject(SQLCA)
END IF
IF pag3= TRUE Then 
	IF pag_act3 = TRUE Then apartados.pagina_3.dw_pagina3.SetTransObject(SQLCA)
END IF
IF pag4= TRUE Then 
	IF pag_act4 = TRUE Then apartados.pagina_4.dw_pagina4.SetTransObject(SQLCA)
END IF
IF pag5= TRUE Then 
	IF pag_act5 = TRUE Then apartados.pagina_5.dw_pagina5.SetTransObject(SQLCA)
END IF
IF pag6= TRUE Then 
	IF pag_act6 = TRUE Then apartados.pagina_6.dw_pagina6.SetTransObject(SQLCA)
END IF
IF pag7= TRUE Then 
	IF pag_act7 = TRUE Then apartados.pagina_7.dw_pagina7.SetTransObject(SQLCA)
END IF
IF pag8= TRUE Then 
	IF pag_act8 = TRUE Then apartados.pagina_8.dw_pagina8.SetTransObject(SQLCA)
END IF

end subroutine

public function boolean wc_update ();Integer bien
bien = 0

IF pag1= TRUE Then 
	IF pag_act1 = TRUE Then
		IF prin_pag1 = TRUE Then
			IF apartados.pagina_1.dw_pagina1.Update()<>1 Then bien=1
  		END IF
	END IF
END IF
IF pag2= TRUE Then 
	IF pag_act2 = TRUE Then
		IF prin_pag2 = TRUE Then
			IF apartados.pagina_2.dw_pagina2.Update()<>1 Then bien=1
		END IF
  	END IF
END IF
IF pag3= TRUE Then 
	IF pag_act3 = TRUE Then
		IF prin_pag3 = TRUE Then
			IF apartados.pagina_3.dw_pagina3.Update()<>1 Then bien=1
  		END IF		
	END IF
END IF
IF pag4= TRUE Then 
	IF pag_act4 = TRUE Then
		IF prin_pag4 = TRUE Then
			IF apartados.pagina_4.dw_pagina4.Update()<>1 Then bien=1
  		END IF		
	END IF
END IF
IF pag5= TRUE Then 
	IF pag_act5 = TRUE Then
		IF prin_pag5 = TRUE Then
			IF	apartados.pagina_5.dw_pagina5.Update()<>1 Then bien=1
  		END IF		
	END IF
END IF
IF pag6= TRUE Then 
	IF pag_act6 = TRUE Then
		IF prin_pag6 = TRUE Then
			IF apartados.pagina_6.dw_pagina6.Update()<>1 Then bien=1
  		END IF		
	END IF
END IF
IF pag7= TRUE Then 
	IF pag_act7 = TRUE Then
		IF prin_pag7 = TRUE Then
			IF apartados.pagina_7.dw_pagina7.Update()<>1 Then bien=1
  		END IF		
	END IF
END IF
IF pag8= TRUE Then 
	IF pag_act8 = TRUE Then
		IF prin_pag8 = TRUE Then
			IF apartados.pagina_8.dw_pagina8.Update()<>1 Then bien=1
  		END IF
	END IF
END IF

IF bien = 1 then
	Return  FALSE
ELSE
	Return  TRUE
END IF
end function

public function boolean wc_detelerow ();Integer bien
bien = 0

IF pag1= TRUE Then 
	IF pag_act1= TRUE THEN
		IF apartados.pagina_1.dw_pagina1.deleterow(1)<>1 Then bien=1
	END IF
END IF
IF pag2= TRUE Then 
	IF pag_act2= TRUE THEN
		IF apartados.pagina_2.dw_pagina2.deleterow(1)<>1 Then bien=1
	END IF
END IF
IF pag3= TRUE Then 
	IF pag_act3= TRUE THEN
		IF apartados.pagina_3.dw_pagina3.deleterow(1)<>1 Then bien=1
	END IF
END IF
IF pag4= TRUE Then 
	IF pag_act4= TRUE THEN
		IF apartados.pagina_4.dw_pagina4.deleterow(1)<>1 Then bien=1
	END IF
END IF
IF pag5= TRUE Then 
	IF pag_act5= TRUE THEN
		IF apartados.pagina_5.dw_pagina5.deleterow(1)<>1 Then bien=1
	END IF
END IF
IF pag6= TRUE Then 
	IF pag_act6= TRUE THEN
		IF apartados.pagina_6.dw_pagina6.deleterow(1)<>1 Then bien=1
	END IF
END IF
IF pag7= TRUE Then 
	IF pag_act7= TRUE THEN
		IF apartados.pagina_7.dw_pagina7.deleterow(1)<>1 Then bien=1
	END IF
END IF
IF pag8= TRUE Then 
	IF pag_act8= TRUE THEN
		IF apartados.pagina_8.dw_pagina8.deleterow(1)<>1 Then bien=1
	END IF
END IF

IF bien = 1 then
	Return  FALSE
ELSE
	Return  TRUE
END IF
end function

public subroutine wc_insertrow ();// Control pregrabacion datawindows//
//---------------------------------//

IF pag1= TRUE Then 
	IF pag_act1 = TRUE Then
		IF apartados.pagina_1.dw_pagina1.RowCount() = 0 Then
		  apartados.pagina_1.dw_pagina1.insertrow(1)
		END IF
   END IF
END IF
IF pag2= TRUE Then 
	IF pag_act2 = TRUE Then
		IF apartados.pagina_2.dw_pagina2.RowCount() = 0 Then
			apartados.pagina_2.dw_pagina2.insertrow(1)
		  END IF
	END IF
END IF
IF pag3= TRUE Then 
	IF pag_act3 = TRUE Then
		IF apartados.pagina_3.dw_pagina3.RowCount() = 0 Then
		apartados.pagina_3.dw_pagina3.insertrow(1)
		END IF
	END IF
END IF
IF pag4= TRUE Then 
	IF pag_act4 = TRUE Then
		IF apartados.pagina_4.dw_pagina4.RowCount() = 0 Then
   	 apartados.pagina_4.dw_pagina4.insertrow(1)
		END IF
	END IF
END IF
IF pag5= TRUE Then 
	IF pag_act5 = TRUE Then
		IF apartados.pagina_5.dw_pagina5.RowCount() = 0 Then
			apartados.pagina_5.dw_pagina5.insertrow(1)
   	END IF
	END IF
END IF
IF pag6= TRUE Then 
	IF pag_act6 = TRUE Then
		IF apartados.pagina_6.dw_pagina6.RowCount() = 0 Then
	 		apartados.pagina_6.dw_pagina6.insertrow(1)
	   END IF
	END IF
END IF
IF pag7= TRUE Then 
	IF pag_act7 = TRUE Then
		IF apartados.pagina_7.dw_pagina7.RowCount() = 0 Then
			 apartados.pagina_7.dw_pagina7.insertrow(1)
	   END IF
	END IF
END IF
IF pag8= TRUE Then 
	IF pag_act8 = TRUE Then
		IF apartados.pagina_8.dw_pagina8.RowCount() = 0 Then
	 		apartados.pagina_8.dw_pagina8.insertrow(1)
	   END IF
	END IF
END IF
IF insercion = "S" Then
   apartados.SelectTab(1)
	wc_activar_pagina(1)
ELSE
   apartados.SelectTab(wc_index)
	wc_activar_pagina(wc_index)

END IF

end subroutine

public subroutine f_valores_numericos (datawindow w, string c);IF w.visible=FALSE Then Return
IF w.GetRow()=0 Then Return
IF IsNull(w.GetItemString(w.GetRow(),c)) Then  Return
IF Not IsNumber(w.GetItemString(w.GetRow(),c))Then w.SetItem(w.GetRow(),c,"")
end subroutine

public function boolean f_tipo_mantenimiento (string tipo, string codigo);// Esta funcion de recibo el tipo de mantenimiento y el valor de la clave
// C-> Mantenimiento con clave alfanumerica
// N-> Mantenimiento con clave numerica 
// Devuelva FALSE si coindice el valor con el tipo 

CHOOSE CASE tipo
	CASE "N"
      IF IsNumber(codigo) THEN
         RETURN FALSE
      ELSE
         RETURN TRUE
      END IF
   CASE "C"
     IF Not IsNumber(codigo) THEN
         RETURN FALSE
      ELSE
         RETURN FALSE  // en mant. de claves alfanumericas pemitiremos calves numericas
      END IF
	CASE ELSE
      RETURN FALSE	
END CHOOSE

end function

public subroutine wc_accepttext ();IF pag1= TRUE Then 
	IF pag_act1= TRUE THEN	apartados.pagina_1.dw_pagina1.Accepttext()
END IF	
IF pag2= TRUE Then
	IF pag_act2= TRUE THEN	apartados.pagina_2.dw_pagina2.Accepttext()
END IF	
IF pag3= TRUE Then
	IF pag_act3= TRUE THEN	apartados.pagina_3.dw_pagina3.Accepttext()
END IF	
IF pag4= TRUE Then
	IF pag_act4= TRUE THEN	apartados.pagina_4.dw_pagina4.Accepttext()
END IF	
IF pag5= TRUE Then
	IF pag_act5= TRUE THEN	apartados.pagina_5.dw_pagina5.Accepttext()
END IF	
IF pag6= TRUE Then
	IF pag_act6= TRUE THEN	apartados.pagina_6.dw_pagina6.Accepttext()
END IF	
IF pag7= TRUE Then
	IF pag_act7= TRUE THEN	apartados.pagina_7.dw_pagina7.Accepttext()
END IF	
IF pag8= TRUE Then
	IF pag_act8= TRUE THEN	apartados.pagina_8.dw_pagina8.Accepttext()
END IF	

end subroutine

public subroutine wc_valores_numericos ();IF pag1= TRUE Then
	IF pag_act1 = TRUE Then apartados.pagina_1.dw_pagina1.TriggerEvent("valores_numericos")
END IF
IF pag2= TRUE Then 
	IF pag_act2 = TRUE Then apartados.pagina_2.dw_pagina2.TriggerEvent("valores_numericos")
END IF
IF pag3= TRUE Then 
	IF pag_act3 = TRUE Then apartados.pagina_3.dw_pagina3.TriggerEvent("valores_numericos")
END IF
IF pag4= TRUE Then 
	IF pag_act4 = TRUE Then apartados.pagina_4.dw_pagina4.TriggerEvent("valores_numericos")
END IF
IF pag5= TRUE Then 
	IF pag_act5 = TRUE Then apartados.pagina_5.dw_pagina5.TriggerEvent("valores_numericos")
END IF
IF pag6= TRUE Then 
	IF pag_act6 = TRUE Then apartados.pagina_6.dw_pagina6.TriggerEvent("valores_numericos")
END IF
IF pag7= TRUE Then 
	IF pag_act7 = TRUE Then apartados.pagina_7.dw_pagina7.TriggerEvent("valores_numericos")
END IF
IF pag8= TRUE Then 
	IF pag_act8 = TRUE Then apartados.pagina_8.dw_pagina8.TriggerEvent("valores_numericos")
END IF

end subroutine

public subroutine wc_reset ();IF pag1= TRUE Then 
	IF pag_act1 = TRUE Then	apartados.pagina_1.dw_pagina1.Reset()
END IF
IF pag2= TRUE Then
	IF pag_act2 = TRUE Then	apartados.pagina_2.dw_pagina2.Reset()
END IF
IF pag3= TRUE Then 
	IF pag_act3 = TRUE Then	apartados.pagina_3.dw_pagina3.Reset()
END IF
IF pag4= TRUE Then 
	IF pag_act4 = TRUE Then	apartados.pagina_4.dw_pagina4.Reset()
END IF
IF pag5= TRUE Then 
	IF pag_act5 = TRUE Then	apartados.pagina_5.dw_pagina5.Reset()
END IF
IF pag6= TRUE Then 
	IF pag_act6 = TRUE Then	apartados.pagina_6.dw_pagina6.Reset()
END IF
IF pag7= TRUE Then 
	IF pag_act7 = TRUE Then	apartados.pagina_7.dw_pagina7.Reset()
END IF
IF pag8= TRUE Then 
	IF pag_act8 = TRUE Then	apartados.pagina_8.dw_pagina8.Reset()
END IF

end subroutine

public subroutine wc_enabled (boolean arg);IF pag1= TRUE Then 
	IF pag_act1 = TRUE THEN	apartados.pagina_1.dw_pagina1.enabled= arg
END IF
IF pag2= TRUE Then 
	IF pag_act2 = TRUE THEN	apartados.pagina_2.dw_pagina2.enabled= arg
END IF
IF pag3= TRUE Then 
	IF pag_act3 = TRUE THEN	apartados.pagina_3.dw_pagina3.enabled= arg
END IF
IF pag4= TRUE Then 
	IF pag_act4 = TRUE THEN	apartados.pagina_4.dw_pagina4.enabled= arg
END IF
IF pag5= TRUE Then 
	IF pag_act5 = TRUE THEN	apartados.pagina_5.dw_pagina5.enabled= arg
END IF
IF pag6= TRUE Then 
	IF pag_act6 = TRUE THEN	apartados.pagina_6.dw_pagina6.enabled= arg
END IF
IF pag7= TRUE Then 
	IF pag_act7 = TRUE THEN	apartados.pagina_7.dw_pagina7.enabled= arg
END IF
IF pag8= TRUE Then 
	IF pag_act8 = TRUE THEN	apartados.pagina_8.dw_pagina8.enabled= arg
END IF

end subroutine

public subroutine wc_activar_pagina (integer var_pag);CHOOSE CASE var_pag
	CASE 1
   apartados.pagina_1.dw_pagina1.SetFocus()
   apartados.pagina_1.dw_pagina1.SetColumn(1)
	CASE 2
   apartados.pagina_2.dw_pagina2.SetFocus()
   apartados.pagina_2.dw_pagina2.SetColumn(1)
	CASE 3
   apartados.pagina_3.dw_pagina3.SetFocus()
   apartados.pagina_3.dw_pagina3.SetColumn(1)
	CASE 4
   apartados.pagina_4.dw_pagina4.SetFocus()
   apartados.pagina_4.dw_pagina4.SetColumn(1)
	CASE 5
   apartados.pagina_5.dw_pagina5.SetFocus()
   apartados.pagina_5.dw_pagina5.SetColumn(1)
	CASE 6
	apartados.pagina_6.dw_pagina6.SetFocus()
   apartados.pagina_6.dw_pagina6.SetColumn(1)
	CASE 7
   apartados.pagina_7.dw_pagina7.SetFocus()
   apartados.pagina_7.dw_pagina7.SetColumn(1)
	CASE 8
   apartados.pagina_8.dw_pagina8.SetFocus()
   apartados.pagina_8.dw_pagina8.SetColumn(1)
		
END CHOOSE


end subroutine

public function boolean wc_bloquear ();Integer bien
Long    wc_bloq

bien = 0
For wc_bloq = 1 To 8	
	IF trim(tabla[wc_bloq]) <> "" Then
		IF f_bloquear(tabla[wc_bloq],seleccion[wc_bloq],titulo) THEN 
			bien = 1
			Exit
		END IF
	END IF
Next
If bien = 1 Then
	ROLLBACK;
   RETURN TRUE
ELSE
	COMMIT;
	RETURN FALSE
END IF
end function

event key;f_inicializar_tiempo_limite()
if KeyDown(KeyF1!)        Then  This.TriggerEvent("ue_f1")
if KeyDown(KeyF2!)        Then  This.TriggerEvent("ue_f2")
if KeyDown(KeyF3!)        Then  This.TriggerEvent("ue_f3")
if KeyDown(KeyF4!)        Then  This.TriggerEvent("ue_f4")
if KeyDown(KeyF5!)        Then  This.TriggerEvent("ue_f5")
if KeyDown(KeyF6!)        Then  This.TriggerEvent("ue_f6")
if KeyDown(KeyF7!)        Then  This.TriggerEvent("ue_f7")
if KeyDown(KeyF9!)        Then  
   wc_index = 1
   apartados.TriggerEvent("pulsar_datawindow")
END IF
if KeyDown(KeyEscape!)    Then  This.TriggerEvent("ue_esc")
if KeyDown(KeyPageUp!)    Then  This.TriggerEvent("ue_pagina_arriba")
if KeyDown(KeyPageDown!)  Then  This.TriggerEvent("ue_pagina_abajo")
if KeyDown(KeyUpArrow!)   Then  This.TriggerEvent("ue_cursor_arriba")
if KeyDown(KeyDownArrow!) Then  This.TriggerEvent("ue_cursor_abajo")



end event

event open;//PERMISOS NUEVOS
//String nombre_ventana
//cerrar_sin_abrir = false
//
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana FROM uti_permisos_ventana P INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	cb_insertar.visible = false
//	cb_borrar.visible = false
//elseif permiso_ventana = 2 then
//	//OK acceso total
//	
//else
//	//Opción no contemplada -> Salir
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//end if
//
//if cerrar_sin_abrir = false then

	this.Icon = 'c:\bmp\tencer.ico'
	// facil manejo de datawindows
	dw_pag1 = apartados.pagina_1.dw_pagina1
	dw_pag2 = apartados.pagina_2.dw_pagina2
	dw_pag3 = apartados.pagina_3.dw_pagina3
	dw_pag4 = apartados.pagina_4.dw_pagina4
	dw_pag5 = apartados.pagina_5.dw_pagina5
	dw_pag6 = apartados.pagina_6.dw_pagina6
	dw_pag7 = apartados.pagina_7.dw_pagina7
	dw_pag8 = apartados.pagina_8.dw_pagina8
	
	wc_index = 1
	tabla[1]=""
	tabla[2]=""
	tabla[3]=""
	tabla[4]=""
	tabla[5]=""
	tabla[6]=""
	tabla[7]=""
	tabla[8]=""
	f_inicializar_tiempo_limite()
	wc_inicio_valores()
	This.TriggerEvent("ue_valores")
	wc_activar_paginas()
	wc_SetTransObject()
	// Asigna datos por defecto pasados como parametro
	istr_parametros = Message.PowerObjectParm
	This.Title = istr_parametros.s_titulo_ventana
	
	
	//-----------------------------------------------------
	Integer Orden
	istr_parametros.b_empresa = FALSE
	valor_empresa             = istr_parametros.b_empresa 
	isle_campo = sle_valor
	tipo_mantenimiento ="N"
	cb_borrar.enabled    =  FALSE
	cb_insertar.enabled  =  FALSE
	IF Orden =10 THEN  isle_campo.Setfocus()
	
	//--------------------------------------------------------
	st_empresa.Text = f_nombre_empresa (codigo_empresa)
	istr_parametros.b_empresa = TRUE
	valor_empresa             = istr_parametros.b_empresa 
//end if
//
//this.Post Event ue_cerrar_sin_abrir()


end event

on wc_mantenimientos_tab.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.cb_salir=create cb_salir
this.cb_borrar=create cb_borrar
this.cb_insertar=create cb_insertar
this.wc_control_tabulador=create wc_control_tabulador
this.st_empresa=create st_empresa
this.sle_valor=create sle_valor
this.st_1=create st_1
this.apartados=create apartados
this.Control[]={this.cb_salir,&
this.cb_borrar,&
this.cb_insertar,&
this.wc_control_tabulador,&
this.st_empresa,&
this.sle_valor,&
this.st_1,&
this.apartados}
end on

on wc_mantenimientos_tab.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_salir)
destroy(this.cb_borrar)
destroy(this.cb_insertar)
destroy(this.wc_control_tabulador)
destroy(this.st_empresa)
destroy(this.sle_valor)
destroy(this.st_1)
destroy(this.apartados)
end on

event clicked;IF trim(sle_valor.text)<>"" THEN  wc_enabled(TRUE)

end event

event close;IF cb_insertar.enabled=TRUE THEN
    CALL  wc_mantenimientos_tab::ue_desbloquear
    COMMIT using SQLCA; // problema concurrencia
END IF

f_menu_cerrar_ventana(this,id_ventana_activa)



 
end event

event resize;//// Si modificamos el tamaño de la ventana:
////
////			Modificamos el tamaño del texto empresa
//IF This.Width > 200 THEN
//		st_empresa.Resize(This.width - 250, st_empresa.height)
//END IF
end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

if not(ib_control_acceso_pasado) then
	IF guo_menu_utigrupos.of_menu_leer_permiso (gs_usuarios_v_grupo, codigo_empresa, This.ClassName (), 'activo') = '0' THEN
		MessageBox ("Permisos", "NO tiene permisos para acceder a esta ventana¡", StopSign!)
		Close (this)
	ELSE
		//Compatibilidad permisos GNO con permisos Tencer
		guo_menu_utigrupos.of_menu_leer_permiso_total(gs_usuarios_v_grupo,codigo_empresa,This.ClassName(),is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas)
		
		if is_permiso_altas = 'S' or is_permiso_bajas = 'S' or is_permiso_cambios = 'S' then
			permiso_ventana = 2 //Permisos escritura
		else
			if is_permiso_consultas = 'S' then
				permiso_ventana = 1 //Permisos lectura
			else
				permiso_ventana = 0 //Sin permisos
			end if
		end if
		//Compatibilidad permisos GNO con permisos Tencer		
		ib_control_acceso_pasado = true
	END IF
end if


end event

type cb_salir from u_cancelar within wc_mantenimientos_tab
event clicked pbm_bnclicked
integer x = 2071
integer y = 128
integer height = 92
integer taborder = 20
string text = "&Salir    "
boolean cancel = true
end type

event clicked;IF cb_insertar.enabled=TRUE THEN
	// saldo de proceso de altas
	IF insercion = "S" Then
		sle_valor.text = ""
		sle_valor.TriggerEvent("modificado")
		cb_borrar.enabled  =FALSE
		wc_reset()
	END IF
	insercion= "N"
	Parent.TriggerEvent("ue_desbloquear")
	Parent.TriggerEvent("ue_recuperar")
	cb_insertar.enabled = FALSE
	Parent.TriggerEvent("ue_activa_claves")
	
	f_activar_campo(sle_valor)
ELSE
	Call Super::Clicked
END IF


 
end event

type cb_borrar from u_borrar within wc_mantenimientos_tab
event clicked pbm_bnclicked
integer x = 1664
integer y = 128
integer height = 92
integer taborder = 30
string text = "&Borrar  "
end type

event clicked;integer li_opcion

IF trim(sle_valor.text)<> ""  AND Not IsNull(sle_valor.text) AND   Not f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) THEN
	li_opcion = MessageBox("Proceso de Borrado", &
					"Desea dar de baja el registro", &
					Question!, YesNo!,2)
	IF li_opcion=1 THEN
		IF NOT wc_bloquear() THEN
			CALL Super::clicked
			Parent.TriggerEvent("ue_borra_fila")
			IF wc_Update() THEN 
				Commit using sqlca;
			ELSE		
				RollBack using sqlca;
			END IF
			sle_valor.text = ""
			Parent.TriggerEvent("ue_desbloquear")
			cb_insertar.Enabled = FALSE
			cb_borrar.Enabled = FALSE
			Parent.TriggerEvent("ue_recuperar")
		END IF
	END IF
END IF
f_activar_campo(sle_valor)
end event

type cb_insertar from u_insertar within wc_mantenimientos_tab
event clicked pbm_bnclicked
integer x = 1257
integer y = 128
integer height = 92
integer taborder = 40
string text = "&Aceptar"
end type

event clicked;wc_accepttext()
Integer li_opcion

reg_insertado = false

IF cb_insertar.enabled =TRUE THEN
	IF insercion="N" THEN
		li_opcion = MessageBox("Proceso de Modificacion", &
											"Desea modificar el registro", &
											Question!, YesNo!,2)
	ELSE
		li_opcion=1
	END IF
	IF li_opcion=2 THEN 
		wc_valores_numericos()
		cb_insertar.enabled = FALSE
		cb_borrar.enabled  =TRUE
		Parent.TriggerEvent("ue_recuperar")
		Parent.TriggerEvent("ue_activa_claves")
		Parent.TriggerEvent("ue_desbloquear") 
	ELSE
		wc_valores_numericos()
		Parent.TriggerEvent("ue_actualiza_dw")
		cb_insertar.enabled = FALSE
		cb_borrar.enabled  =TRUE
		Parent.TriggerEvent("ue_recuperar")
		Parent.TriggerEvent("ue_activa_claves")
		Parent.TriggerEvent("ue_desbloquear")
		reg_insertado = true
	END IF
	// saldo de proceso de altas
	insercion= "N"
ELSE
	cb_insertar.enabled = TRUE
	cb_insertar.Text    = "&Aceptar"
	cb_borrar.enabled   = FALSE
	Parent.TriggerEvent("ue_inserta_fila")
	Parent.TriggerEvent("ue_desactiva_claves")
	wc_control_tabulador.enabled = FALSE
END IF

end event

type wc_control_tabulador from singlelineedit within wc_mantenimientos_tab
integer x = 2281
integer y = 36
integer width = 105
integer height = 76
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
end type

event getfocus;f_activar_campo(sle_valor)
end event

type st_empresa from statictext within wc_mantenimientos_tab
integer width = 2775
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
long textcolor = 16810239
long backcolor = 0
boolean enabled = false
string text = "Empresa"
boolean focusrectangle = false
end type

type sle_valor from u_em_campo within wc_mantenimientos_tab
event cambia_valor pbm_enchange
integer x = 338
integer y = 132
integer width = 521
integer taborder = 10
end type

event cambia_valor;call super::cambia_valor;cb_borrar.enabled = FALSE
end event

event getfocus;call super::getfocus;isle_campo = This

end event

event busqueda;str_parametros param
IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
param.s_titulo_ayuda    = ue_titulo
param.s_nom_datawindow  = ue_datawindow
param.s_filtro          = ue_filtro
param.b_empresa         = valor_empresa
This.text= ue_valor
f_buscar(This,param)
This.TriggerEvent("modificado")
This.SelectText(1,Len(This.Text))
wc_control_tabulador.Setfocus()




	 
end event

event rbuttondown;call super::rbuttondown;// Esta sintaxis debe de ser la misma en los eventos tecla_enter,tabulador y button
 IF cb_insertar.enabled= FALSE  THEN
      wc_enabled(TRUE)
      f_no_nulo(isle_campo)
      IF isle_campo.text = "" or &
        f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) Then
        isle_campo.text=""
        wc_Reset()
      ELSE
        IF isle_campo=sle_valor  and Trim(isle_campo.text)<>"" THEN
           Parent.TriggerEvent("ue_recuperar")
        END IF
      END IF
    END IF
end event

event tecla_enter;call super::tecla_enter; IF cb_insertar.enabled= FALSE  THEN
      wc_enabled(TRUE)
      f_no_nulo(isle_campo)
      IF isle_campo.text = "" or &
        f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) Then
        isle_campo.text=""
        wc_Reset()
      ELSE
        IF isle_campo=sle_valor  and Trim(isle_campo.text)<>"" THEN
           Parent.TriggerEvent("ue_recuperar")
        END IF
      END IF
    END IF
end event

event tecla_tabulador;IF Len(ue_valor) <> 0  and Not IsNumber(ue_valor)Then 
	This.TriggerEvent("busqueda")
END IF
IF cb_insertar.enabled= FALSE  THEN
	wc_enabled(TRUE)
	f_no_nulo(isle_campo)
	IF isle_campo.text = "" or f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) Then
	  isle_campo.text=""
	  wc_Reset()
	ELSE
	  IF isle_campo=sle_valor  and Trim(isle_campo.text)<>"" THEN
			Parent.TriggerEvent("ue_recuperar")
	  END IF
	END IF
END IF
end event

event losefocus;call super::losefocus;//This.BackColor= RGB(255,255,255)
//ue_valor = This.text
//	This.TriggerEvent("modificado")
//	IF KeyDown(KeyTab!) THEN  
//		This.TriggerEvent("tecla_tabulador")
//	END IF
//
end event

type st_1 from statictext within wc_mantenimientos_tab
integer x = 64
integer y = 140
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Codigo:"
boolean focusrectangle = false
end type

type apartados from tab within wc_mantenimientos_tab
event pulsar_datawindow pbm_custom01
integer x = 27
integer y = 232
integer width = 2441
integer height = 864
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
pagina_1 pagina_1
pagina_2 pagina_2
pagina_3 pagina_3
pagina_4 pagina_4
pagina_5 pagina_5
pagina_6 pagina_6
pagina_7 pagina_7
pagina_8 pagina_8
end type

event pulsar_datawindow;wc_AcceptText()
IF trim(sle_valor.text)=""  Or f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) THEN
	wc_enabled(FALSE)
	wc_reset()
	cb_borrar.enabled     = FALSE
	f_activar_campo(sle_valor)
ELSE
	IF cb_insertar.enabled = FALSE THEN
		Parent.TriggerEvent("ue_recuperar")
		IF insercion="N" THEN
			IF NOT wc_bloquear() THEN
				cb_insertar.enabled   = TRUE
				cb_borrar.enabled     = FALSE
				Parent.TriggerEvent("ue_desactiva_claves")
				wc_control_tabulador.enabled = FALSE
				Parent.TriggerEvent("ue_inserta_fila")
			ELSE
				wc_enabled(FALSE)
				cb_insertar.enabled   =  FALSE
				Parent.TriggerEvent("ue_activa_claves")
			END IF
		END IF
	END IF
END IF

end event

on apartados.create
this.pagina_1=create pagina_1
this.pagina_2=create pagina_2
this.pagina_3=create pagina_3
this.pagina_4=create pagina_4
this.pagina_5=create pagina_5
this.pagina_6=create pagina_6
this.pagina_7=create pagina_7
this.pagina_8=create pagina_8
this.Control[]={this.pagina_1,&
this.pagina_2,&
this.pagina_3,&
this.pagina_4,&
this.pagina_5,&
this.pagina_6,&
this.pagina_7,&
this.pagina_8}
end on

on apartados.destroy
destroy(this.pagina_1)
destroy(this.pagina_2)
destroy(this.pagina_3)
destroy(this.pagina_4)
destroy(this.pagina_5)
destroy(this.pagina_6)
destroy(this.pagina_7)
destroy(this.pagina_8)
end on

event getfocus;f_activar_campo(sle_valor)
sle_valor.TriggerEvent("modificado")
end event

event clicked;IF cb_insertar.enabled = FALSE Then Return
wc_index = index
wc_activar_pagina(wc_index)


end event

event selectionchanged;wc_index = newindex
end event

type pagina_1 from userobject within apartados
event ue_clicked pbm_lbuttondown
integer x = 18
integer y = 112
integer width = 2405
integer height = 736
long backcolor = 12632256
string text = "Página1"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_pagina1 dw_pagina1
end type

event ue_clicked;wc_index = 1
end event

on pagina_1.create
this.dw_pagina1=create dw_pagina1
this.Control[]={this.dw_pagina1}
end on

on pagina_1.destroy
destroy(this.dw_pagina1)
end on

type dw_pagina1 from u_datawindow within pagina_1
integer x = 27
integer y = 16
integer width = 1541
integer height = 636
integer taborder = 2
boolean border = false
end type

event clicked;call super::clicked;wc_index = 1
IF pag_act1= TRUE Then
  apartados.TriggerEvent("pulsar_datawindow")
END IF
end event

type pagina_2 from userobject within apartados
event ue_clicked pbm_lbuttondown
integer x = 18
integer y = 112
integer width = 2405
integer height = 736
long backcolor = 12632256
string text = "Página2"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_pagina2 dw_pagina2
end type

event ue_clicked;wc_index = 2
end event

on pagina_2.create
this.dw_pagina2=create dw_pagina2
this.Control[]={this.dw_pagina2}
end on

on pagina_2.destroy
destroy(this.dw_pagina2)
end on

type dw_pagina2 from u_datawindow within pagina_2
integer x = 27
integer y = 16
boolean border = false
end type

event clicked;call super::clicked;wc_index = 2
IF pag_act2= TRUE Then
	apartados.TriggerEvent("pulsar_datawindow")
END IF
end event

type pagina_3 from userobject within apartados
event ue_clicked pbm_lbuttondown
integer x = 18
integer y = 112
integer width = 2405
integer height = 736
long backcolor = 12632256
string text = "Página3"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_pagina3 dw_pagina3
end type

event ue_clicked;wc_index = 3
end event

on pagina_3.create
this.dw_pagina3=create dw_pagina3
this.Control[]={this.dw_pagina3}
end on

on pagina_3.destroy
destroy(this.dw_pagina3)
end on

type dw_pagina3 from u_datawindow within pagina_3
integer x = 37
integer y = 40
boolean border = false
end type

event clicked;call super::clicked;wc_index = 3
IF pag_act3= TRUE Then
	apartados.TriggerEvent("pulsar_datawindow")
END IF
end event

type pagina_4 from userobject within apartados
event ue_clicked pbm_lbuttondown
integer x = 18
integer y = 112
integer width = 2405
integer height = 736
long backcolor = 12632256
string text = "Página4"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_pagina4 dw_pagina4
end type

event ue_clicked;wc_index = 4
end event

on pagina_4.create
this.dw_pagina4=create dw_pagina4
this.Control[]={this.dw_pagina4}
end on

on pagina_4.destroy
destroy(this.dw_pagina4)
end on

type dw_pagina4 from u_datawindow within pagina_4
integer x = 27
integer y = 16
boolean border = false
end type

event clicked;call super::clicked;wc_index = 4
IF pag_act4= TRUE Then
    apartados.TriggerEvent("pulsar_datawindow")
END IF
end event

type pagina_5 from userobject within apartados
event ue_clicked pbm_lbuttondown
integer x = 18
integer y = 112
integer width = 2405
integer height = 736
long backcolor = 12632256
string text = "Página5"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_pagina5 dw_pagina5
end type

event ue_clicked;wc_index = 5
end event

on pagina_5.create
this.dw_pagina5=create dw_pagina5
this.Control[]={this.dw_pagina5}
end on

on pagina_5.destroy
destroy(this.dw_pagina5)
end on

type dw_pagina5 from u_datawindow within pagina_5
integer x = 27
integer y = 20
boolean border = false
end type

event clicked;call super::clicked;wc_index = 5
IF pag_act5= TRUE Then
	apartados.TriggerEvent("pulsar_datawindow")
END IF
end event

type pagina_6 from userobject within apartados
event ue_clicked pbm_lbuttondown
integer x = 18
integer y = 112
integer width = 2405
integer height = 736
long backcolor = 12632256
string text = "Página6"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_pagina6 dw_pagina6
end type

event ue_clicked;wc_index = 6
end event

on pagina_6.create
this.dw_pagina6=create dw_pagina6
this.Control[]={this.dw_pagina6}
end on

on pagina_6.destroy
destroy(this.dw_pagina6)
end on

type dw_pagina6 from u_datawindow within pagina_6
integer x = 27
integer y = 16
boolean border = false
end type

event clicked;call super::clicked;wc_index = 6
IF pag_act6= TRUE Then
	apartados.TriggerEvent("pulsar_datawindow")
END IF
end event

type pagina_7 from userobject within apartados
event ue_clicked pbm_lbuttondown
integer x = 18
integer y = 112
integer width = 2405
integer height = 736
long backcolor = 12632256
string text = "Página7"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_pagina7 dw_pagina7
end type

event ue_clicked;wc_index = 7
end event

on pagina_7.create
this.dw_pagina7=create dw_pagina7
this.Control[]={this.dw_pagina7}
end on

on pagina_7.destroy
destroy(this.dw_pagina7)
end on

type dw_pagina7 from u_datawindow within pagina_7
integer x = 27
integer y = 20
boolean border = false
end type

event clicked;call super::clicked;wc_index = 7
IF pag_act7= TRUE Then
	apartados.TriggerEvent("pulsar_datawindow")
END IF
end event

type pagina_8 from userobject within apartados
event ue_clicked pbm_lbuttondown
integer x = 18
integer y = 112
integer width = 2405
integer height = 736
long backcolor = 12632256
string text = "Página8"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_pagina8 dw_pagina8
end type

event ue_clicked;wc_index = 8
end event

on pagina_8.create
this.dw_pagina8=create dw_pagina8
this.Control[]={this.dw_pagina8}
end on

on pagina_8.destroy
destroy(this.dw_pagina8)
end on

type dw_pagina8 from u_datawindow within pagina_8
integer x = 27
integer y = 16
boolean border = false
end type

event clicked;call super::clicked;wc_index = 8
IF pag_act8= TRUE Then
	apartados.TriggerEvent("pulsar_datawindow")
END IF
end event

