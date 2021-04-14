$PBExportHeader$wc_mantenimientos.srw
$PBExportComments$Ventana para la Generación de Mantenimientos.
forward
global type wc_mantenimientos from window
end type
type dw_1 from u_datawindow within wc_mantenimientos
end type
end forward

global type wc_mantenimientos from window
integer x = 114
integer y = 132
integer width = 1298
integer height = 660
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
event ue_cerrar_sin_abrir ( )
dw_1 dw_1
end type
global wc_mantenimientos wc_mantenimientos

type variables
	// Parametros Ventanas
Long id_ventana_activa
Boolean cerrar_sin_abrir

Public:

str_parametros  istr_parametros
Int permiso_ventana
string is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas
boolean ib_control_acceso_pasado = false
end variables

on ue_inserta_fila;// Inserta una nueva fila en la Datawindow y se desplaza a ella

  dw_1.scrolltorow(dw_1.InsertRow(dw_1.getrow()))
  dw_1.SetColumn(1)
  dw_1.setfocus()
end on

on ue_borra_fila;		// Borrado de la fila en curso

dw_1.DeleteRow( dw_1.GetRow() )
end on

on ue_actualiza_dw;//	Actualizar la B.D. con los datos de la DataWindow
dw_1.AcceptText()
IF dw_1.Update() = 1 THEN 
				COMMIT using sqlca;
ELSE		
				ROLLBACK using sqlca;
END IF

end on

on ue_imprimir;	// Abre la Ventana de Opciones de Impresion

OpenWithParm(w_impresoras,istr_parametros)
IF Message.DoubleParm = -1 THEN RETURN


end on

event ue_cerrar_sin_abrir();if cerrar_sin_abrir = true then
	close(this)
end if
end event

event key;f_inicializar_tiempo_limite()
if KeyDown(KeyF1!)        Then  This.TriggerEvent("ue_f1")
if KeyDown(KeyF2!)        Then  This.TriggerEvent("ue_f2")
if KeyDown(KeyF3!)        Then  This.TriggerEvent("ue_f3")
if KeyDown(KeyF4!)        Then  This.TriggerEvent("ue_f4")
if KeyDown(KeyF5!)        Then  This.TriggerEvent("ue_f5")
if KeyDown(KeyF6!)        Then  This.TriggerEvent("ue_f6")
if KeyDown(KeyF7!)        Then  This.TriggerEvent("ue_f7")
if KeyDown(KeyEscape!)    Then  This.TriggerEvent("ue_esc")
if KeyDown(KeyPageUp!)    Then  This.TriggerEvent("ue_pagina_arriba")
if KeyDown(KeyPageDown!)  Then  This.TriggerEvent("ue_pagina_abajo")
if KeyDown(KeyUpArrow!)   Then  This.TriggerEvent("ue_cursor_arriba")
if KeyDown(KeyDownArrow!) Then  This.TriggerEvent("ue_cursor_abajo")



end event

event open;// Asigna datos por defecto pasados como parametro
istr_parametros = Message.PowerObjectParm

//cerrar_sin_abrir = false
//
////PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana FROM uti_permisos_ventana P INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	
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
	f_inicializar_tiempo_limite()
	dw_1.SetTransObject(SQLCA)
	
	
	This.Title = istr_parametros.s_titulo_ventana
	
//	return
//end if
//
//this.Post Event ue_cerrar_sin_abrir()
end event

on wc_mantenimientos.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on wc_mantenimientos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event activate;//Ventanas en el menú principal
id_ventana_activa = f_menu_insertar_ventana(this)

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

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

type dw_1 from u_datawindow within wc_mantenimientos
integer x = 69
integer y = 44
integer width = 1061
integer height = 376
integer taborder = 11
borderstyle borderstyle = styleraised!
end type

event itemfocuschanged;call super::itemfocuschanged;///////////////////////////////////////////////////////////////////////
// Cambiar la Ayuda en la Ventana por los valores Tag de la DataWindow 
///////////////////////////////////////////////////////////////////////


int		li_col
li_col = this.GetColumn()
IF li_col > 0 THEN
	Parent_mensaje = this.Describe ("#" + String (li_col) + ".tag")
END IF
Parent.SetMicroHelp (f_la_hora() + "   " + Parent_mensaje)


end event

event key;call super::key;//Gestionado por un objeto.
end event

