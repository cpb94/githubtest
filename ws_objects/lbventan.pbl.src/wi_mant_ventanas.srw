$PBExportHeader$wi_mant_ventanas.srw
$PBExportComments$Mantenimientos de Ventanas. Una Datawindow y botones.
forward
global type wi_mant_ventanas from wc_mantenimientos
end type
type st_1 from statictext within wi_mant_ventanas
end type
type cb_insertar from u_insertar within wi_mant_ventanas
end type
type cb_borrar from u_borrar within wi_mant_ventanas
end type
type sle_valor from u_em_campo within wi_mant_ventanas
end type
type cb_salir from u_cancelar within wi_mant_ventanas
end type
type control_tabulador from singlelineedit within wi_mant_ventanas
end type
end forward

global type wi_mant_ventanas from wc_mantenimientos
integer x = 297
integer width = 2327
integer height = 1032
event ue_buscar pbm_custom06
event ue_recuperar pbm_custom07
event ue_activa_claves pbm_custom08
event ue_desactiva_claves pbm_custom09
event ue_desbloquear pbm_custom10
st_1 st_1
cb_insertar cb_insertar
cb_borrar cb_borrar
sle_valor sle_valor
cb_salir cb_salir
control_tabulador control_tabulador
end type
global wi_mant_ventanas wi_mant_ventanas

type variables
string criterio[],seleccion,titulo,tabla
integer longitud
editmask isle_campo

string  insercion
boolean reg_insertado

// C-> para manteniminetos con claves tipo char
// N-> es por defecto matenimiento claves numericas
String tipo_mantenimiento

end variables

forward prototypes
public subroutine f_valores_numericos (datawindow w, string c)
public function boolean f_tipo_mantenimiento (string tipo, string codigo)
public function boolean wc_control_columnas ()
end prototypes

on ue_buscar;call wc_mantenimientos::ue_buscar;
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
end on

event ue_recuperar;   long ll_num_filas
   insercion="N" // variable de control
	// Control alfanumerico en tipo de mantenimiento numericos (en conexion directa)
	IF sle_valor.text = "" or sle_valor.text = "00-00-00" or &
        f_tipo_mantenimiento(tipo_mantenimiento,sle_valor.text) Then
        sle_valor.text = ""
        dw_1.Reset()
	END IF
	
	IF Trim(sle_valor.text) = "" or sle_valor.text = "00-00-00" Then
		f_activar_campo(sle_valor)
		Return
	END iF	
	

	IF dw_1.RowCount() = 0 THEN
      insercion="S" 
		// Control permisos altas por usuarios
		IF Not f_control_altas_usuario(codigo_empresa,nombre_usuario) Then
			f_mensaje("Control de permisos por usuario","Usted No tiene permiso de altas")
			f_grabar_incidencia("Control de altas","El usuario  "+ nombre_usuario + " Control de altas (Permiso denegado")
			f_activar_campo(sle_valor)
			return
		END IF

		IF NOT f_bloquear(tabla,seleccion,titulo) THEN
			COMMIT Using SQLCA; // problema concurrencia
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

event ue_activa_claves;call super::ue_activa_claves;//////////////////////////////////////////////////////////////////////////
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
control_tabulador.enabled = TRUE
f_activar_campo(isle_campo)
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;//////////////////////////////////////////////////////////////////////////
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

on ue_desbloquear;call wc_mantenimientos::ue_desbloquear;f_desbloquear(tabla,seleccion,titulo)
COMMIT Using SQLCA; // problema concurrencia

end on

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

public function boolean wc_control_columnas ();IF dw_1.GetRow()= 0 Then Return TRUE
String var_tabla,var_columna,var_valor,sel
Integer registros,reg
var_tabla = dw_1.object.datawindow.table.updatetable
Sel = " SELECT  tabla,columna  FROM uticontrolcolumnas " + &
      " WHERE   uticontrolcolumnas.empresa = '" +codigo_empresa + "'" + &
		" AND     uticontrolcolumnas.tabla   = '"+ var_tabla + "'" 

DataStore wc_proceso_columnas
//wc_proceso_columnas = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, wc_proceso_columnas)

registros = wc_proceso_columnas.RowCount()
IF registros = 0 Then 
	destroy wc_proceso_columnas
	Return TRUE
end if
For reg = 1 To registros
	var_columna = wc_proceso_columnas.GetItemSTring(reg,"columna")
	var_valor   = f_valor_columna(dw_1,dw_1.GetRow(),var_columna)
	IF trim(var_valor)="" or IsNull(var_valor) Then
		f_mensaje("Campo Obligatorio","Introduzca el valor de " + var_columna)
		dw_1.SetFocus()
		dw_1.SetRow(1)
		dw_1.SetColumn(var_columna)
		destroy wc_proceso_columnas
		Return FALSE
	END IF
NEXT
destroy wc_proceso_columnas
Return TRUE
end function

event open;call super::open;Int orden

//if cerrar_sin_abrir = false then
	
	this.Icon = 'c:\bmp\tencer.ico'
	f_inicializar_tiempo_limite()
	dw_1.SetTransObject(SQLCA)
	
	This.Title = istr_parametros.s_titulo_ventana
	istr_parametros.b_empresa = FALSE
	valor_empresa             = istr_parametros.b_empresa 
	isle_campo = sle_valor
	tipo_mantenimiento ="N"
	cb_borrar.enabled    =  FALSE
	cb_insertar.enabled  =  FALSE
	IF Orden =10 THEN  isle_campo.Setfocus()
//end if


end event

on ue_f2;call wc_mantenimientos::ue_f2;IF cb_insertar.enabled = FALSE  Then  Return
cb_insertar.TriggerEvent(Clicked!)
end on

on close;call wc_mantenimientos::close;IF cb_insertar.enabled=TRUE THEN
    CALL  wi_mant_ventanas::ue_desbloquear
    COMMIT using SQLCA; // problema concurrencia
END IF



 
end on

on clicked;call wc_mantenimientos::clicked;IF trim(sle_valor.text)<>"" THEN  dw_1.enabled=TRUE

end on

on wi_mant_ventanas.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_insertar=create cb_insertar
this.cb_borrar=create cb_borrar
this.sle_valor=create sle_valor
this.cb_salir=create cb_salir
this.control_tabulador=create control_tabulador
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_insertar
this.Control[iCurrent+3]=this.cb_borrar
this.Control[iCurrent+4]=this.sle_valor
this.Control[iCurrent+5]=this.cb_salir
this.Control[iCurrent+6]=this.control_tabulador
end on

on wi_mant_ventanas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.cb_insertar)
destroy(this.cb_borrar)
destroy(this.sle_valor)
destroy(this.cb_salir)
destroy(this.control_tabulador)
end on

event key;call super::key;if KeyDown(KeyF9!) Then  dw_1.TriggerEvent(Clicked!)
//if KeyDown(KeyF12!) then 	messagebox("",this.Classname ( ))
if keyflags = 2 and KeyDown(Key1!) then messagebox("",this.Classname ( ))

//and KeyDown(KeyControl!) 



end event

type dw_1 from wc_mantenimientos`dw_1 within wi_mant_ventanas
event key pbm_dwnkey
event valores_numericos pbm_custom01
integer x = 73
integer y = 220
integer width = 1349
integer height = 448
integer taborder = 0
end type

event dw_1::key;call super::key;// Gestionado por el Objeto
end event

event dw_1::clicked;call super::clicked;This.Setfocus()
dw_1.AcceptText()
IF trim(sle_valor.text)=""  Or   f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) THEN
  dw_1.enabled=FALSE
  dw_1.reset()
  cb_borrar.enabled     = FALSE
  f_activar_campo(sle_valor)
ELSE
  IF cb_insertar.enabled = FALSE THEN
   Parent.TriggerEvent("ue_recuperar")
	IF insercion = "S" and Not f_control_altas_usuario(codigo_empresa,nombre_usuario) Then
		return
	END IF
    IF insercion="N" THEN
		// Control permisos modificaciones por usuarios
		IF Not f_control_modificaciones_usuario(codigo_empresa,nombre_usuario) Then
			f_mensaje("Control de permisos por usuario","Usted No tiene permiso de Modificaciones")
			f_grabar_incidencia("Control de modificaciones","El usuario  "+ nombre_usuario + " Control de Modificaciones (Permiso denegado")
		   dw_1.enabled          =  FALSE
      	cb_insertar.enabled   =  FALSE
	      Parent.TriggerEvent("ue_activa_claves")
			return
		END IF
	  IF NOT f_bloquear(tabla,seleccion,titulo) THEN
      COMMIT Using SQLCA; // problema concurrencia
      cb_insertar.enabled   = TRUE
      cb_borrar.enabled     = FALSE
      Parent.TriggerEvent("ue_desactiva_claves")
		control_tabulador.enabled = FALSE
     ELSE
      dw_1.enabled          =  FALSE
      cb_insertar.enabled   =  FALSE
      Parent.TriggerEvent("ue_activa_claves")
     END IF
   END IF
  END IF
END IF

end event

on dw_1::getfocus;call wc_mantenimientos`dw_1::getfocus;sle_valor.TriggerEvent("modificado")

end on

type st_1 from statictext within wi_mant_ventanas
integer x = 91
integer y = 96
integer width = 361
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Codigo"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_insertar from u_insertar within wi_mant_ventanas
integer x = 1829
integer y = 288
integer height = 92
integer taborder = 0
string text = "&Aceptar"
end type

event clicked;Integer li_opcion

reg_insertado = FALSE

dw_1.AcceptText()
   
IF cb_insertar.enabled =TRUE THEN
	 IF Not wc_control_columnas() then 
		//MESSAGEBOX("","AQUI HACE EL RETURN")
		return
	 END IF	
	
	 IF insercion="N" THEN
		 li_opcion = MessageBox("Proceso de Modificacion", "Desea modificar el registro", Question!, YesNo!,2)
	 ELSE
		 li_opcion=1
	 END IF
	 IF li_opcion=2 THEN 
		dw_1.TriggerEvent("valores_numericos")
		cb_insertar.enabled = FALSE
		cb_borrar.enabled  =TRUE
		Parent.TriggerEvent("ue_recuperar")
		Parent.TriggerEvent("ue_activa_claves")
		Parent.TriggerEvent("ue_desbloquear") 
	 ELSE
		dw_1.TriggerEvent("valores_numericos")
		Parent.TriggerEvent("ue_actualiza_dw")		
		cb_insertar.enabled = FALSE
		cb_borrar.enabled  =TRUE
		Parent.TriggerEvent("ue_recuperar")
		Parent.TriggerEvent("ue_activa_claves")
		Parent.TriggerEvent("ue_desbloquear")
		reg_insertado = TRUE

	 END IF
	 // saldo de proceso de altas
	 insercion= "N"
ELSE
		cb_insertar.enabled = TRUE
		cb_insertar.Text    = "&Aceptar"
		cb_borrar.enabled   = FALSE
   	Parent.TriggerEvent("ue_inserta_fila")
		Parent.TriggerEvent("ue_desactiva_claves")
		control_tabulador.enabled = FALSE
END IF


end event

type cb_borrar from u_borrar within wi_mant_ventanas
integer x = 1824
integer y = 412
integer height = 92
integer taborder = 0
end type

event clicked;// Control permisos bajas por usuarios
IF Not f_control_bajas_usuario(codigo_empresa,nombre_usuario) Then
	f_mensaje("Control de permisos por usuario","Usted No tiene permiso de bajas")
	f_grabar_incidencia("Control de bajas","El usuario  "+ nombre_usuario + " Control de bajas (Permiso denegado")
	f_activar_campo(sle_valor)
	return
END IF
  
  IF trim(sle_valor.text)<> ""  AND Not IsNull(sle_valor.text) AND   Not f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) THEN
    integer li_opcion
    li_opcion = MessageBox("Proceso de Borrado", &
						"Desea dar de baja el registro", &
						Question!, YesNo!,2)
    IF li_opcion=1 THEN
     IF NOT f_bloquear(tabla,seleccion,titulo) THEN
     CALL Super::clicked
     Parent.TriggerEvent("ue_borra_fila")
     IF dw_1.Update() = 1 THEN 
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

type sle_valor from u_em_campo within wi_mant_ventanas
event cambia_valor pbm_enchange
integer x = 494
integer y = 92
integer taborder = 10
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event cambia_valor;call super::cambia_valor;cb_borrar.enabled = FALSE
end event

event busqueda;call super::busqueda;
//
// No lanzon busquedas en modo inserción Resulve ploblemas de anidamiento de eventos 17-04-96
//IF insercion = "S" Then Return
////
////
//str_parametros param
//IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
//param.s_titulo_ayuda    = ue_titulo
//param.s_nom_datawindow  = ue_datawindow
//param.s_filtro          = ue_filtro
//param.b_empresa         = valor_empresa
//this.text = ue_valor
//f_buscar(This,param)
//This.TriggerEvent("modificado")
//This.SelectText(1,Len(This.Text))
//control_tabulador.Setfocus()
//
//
//

	 

end event

event getfocus;call super::getfocus;isle_campo = This

end event

event tecla_tabulador;
IF Len(ue_valor) <> 0  and Not IsNumber(ue_valor)  Then 
	This.TriggerEvent("busqueda")
END IF


IF cb_insertar.enabled= FALSE  THEN
	dw_1.enabled=TRUE
	f_no_nulo(isle_campo)
	IF isle_campo.text = "" or isle_campo.text = "00-00-00"or &
	  	f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) Then
	  	isle_campo.text=""
	  	dw_1.Reset()
	ELSE
	  	IF isle_campo=sle_valor  and Trim(isle_campo.text)<>"" THEN
		  	Parent.TriggerEvent("ue_recuperar")
	  	END IF
	END IF
END IF
ue_ante_valor= This.text




end event

event tecla_enter;call super::tecla_enter;IF cb_insertar.enabled= FALSE  THEN
      dw_1.enabled=TRUE
      f_no_nulo(isle_campo)
      IF isle_campo.text = "" or &
        f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) Then
        isle_campo.text=""
        dw_1.Reset()
      ELSE
        IF isle_campo=sle_valor  and Trim(isle_campo.text)<>"" THEN
           Parent.TriggerEvent("ue_recuperar")
        END IF
      END IF
    END IF
end event

event rbuttondown;call super::rbuttondown;// Esta sintaxis debe de ser la misma en los eventos tecla_enter,tabulador y button
 IF cb_insertar.enabled= FALSE  THEN
      dw_1.enabled=TRUE
      f_no_nulo(isle_campo)
      IF isle_campo.text = "" or &
        f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) Then
        isle_campo.text=""
        dw_1.Reset()
      ELSE
        IF isle_campo=sle_valor  and Trim(isle_campo.text)<>"" THEN
           Parent.TriggerEvent("ue_recuperar")
        END IF
      END IF
    END IF
end event

type cb_salir from u_cancelar within wi_mant_ventanas
integer x = 1829
integer y = 540
integer height = 92
integer taborder = 0
fontcharset fontcharset = ansi!
string text = "&Salir"
boolean cancel = true
end type

event clicked;IF cb_insertar.enabled=TRUE THEN
         // saldo de proceso de altas
			IF insercion = "S" Then
			 sle_valor.text = ""
          sle_valor.TriggerEvent("modificado")
  		    cb_borrar.enabled  =FALSE
			 dw_1.Reset()
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

type control_tabulador from singlelineedit within wi_mant_ventanas
integer width = 46
integer height = 40
integer taborder = 20
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

on getfocus;f_activar_campo(sle_valor)
end on

