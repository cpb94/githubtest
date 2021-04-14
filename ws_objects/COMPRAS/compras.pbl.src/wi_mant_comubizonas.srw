$PBExportHeader$wi_mant_comubizonas.srw
forward
global type wi_mant_comubizonas from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_comubizonas
end type
type st_nombre_almacen from statictext within wi_mant_comubizonas
end type
type sle_almacen from u_em_campo within wi_mant_comubizonas
end type
end forward

global type wi_mant_comubizonas from wi_mvent_con_empresa
integer height = 1148
st_almacen st_almacen
st_nombre_almacen st_nombre_almacen
sle_almacen sle_almacen
end type
global wi_mant_comubizonas wi_mant_comubizonas

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
dw_1.Retrieve(codigo_empresa,sle_almacen.text,sle_valor.Text)

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de zonas de ubicacion"
This.title=istr_parametros.s_titulo_ventana
tipo_mantenimiento = 'C'

end event

on ue_buscar;
// Lanza la ventana de ayuda para Busquedas de codigos si tiene datawindow asignada

isle_campo = sle_valor

IF trim(istr_parametros.s_nom_datawindow)<> "" THEN
  IF Not IsNumber(isle_campo.Text) THEN
		String ll_clave
		istr_parametros.s_criterio_busqueda = isle_campo.Text
           
		OpenWithParm(w_busquedas,istr_parametros)
		ll_clave = Message.StringParm		// Devuelve el valor que enuentra ...
		if TRIM(ll_clave)="" and TRIM(sle_valor.text)<>"" then
         Return
      END IF
   	
		isle_campo.text = ll_clave
      isle_campo.TriggerEvent(Modified!)	// Mostrara la descripcion
      f_activar_campo(isle_campo)
	END IF
END IF
end on

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_almacen.text))
criterio[2]   =  trim(sle_almacen.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "comubizonas"


dw_1.Retrieve(codigo_empresa,sle_almacen.text,sle_valor.Text)

CALL Super::ue_recuperar
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;sle_almacen.enabled    = FALSE

end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"almacen",sle_almacen.text)
dw_1.setitem(dw_1.getrow(),"zona",sle_valor.text)
end on

on wi_mant_comubizonas.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_almacen=create st_nombre_almacen
this.sle_almacen=create sle_almacen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_almacen
this.Control[iCurrent+3]=this.sle_almacen
end on

on wi_mant_comubizonas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_almacen)
destroy(this.sle_almacen)
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;sle_almacen.enabled    =TRUE

end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_comubizonas
integer x = 59
integer y = 436
integer width = 1477
string dataobject = "dw_comubizona"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_comubizonas
integer x = 160
integer y = 320
integer width = 343
integer height = 80
string text = "Zona"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_comubizonas
integer x = 1577
integer y = 440
end type

event cb_insertar::clicked;IF dw_1.GetRow() <> 0 Then
	 dw_1.AcceptText()
	 String var_descripcion,var_resumido,var_codcli,var_tipoalm,des_codcli,des_tipoalm
	 integer var_filas
	 var_descripcion  = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
	 var_resumido     = dw_1.GetItemString(dw_1.GetRow(),"resumido")
	  var_filas     = dw_1.GetItemNumber(dw_1.GetRow(),"filas")
	if cb_insertar.enabled = TRUE THEN
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			  MessageBox("Campo Obligatorio","Introduzca la descripcion de la zona ",exclamation!,Ok!,1)
				dw_1.SetColumn("descripcion")
		  dw_1.SetFocus()
		  Return
		 END IF
		If Trim(var_resumido) = ""  or ISNULL(var_resumido) Then
		  MessageBox("Campo Obligatorio","Introduzca el resumido de la zona ",Exclamation!,Ok!,1)
		  dw_1.SetColumn("resumido")
		  dw_1.SetFocus()
		  Return
		END IF
		If var_filas = 0  or ISNULL(var_filas) Then
		  MessageBox("Campo Obligatorio","Introduzca las filas de la zona ",Exclamation!,Ok!,1)
		  dw_1.SetColumn("filas")
		  dw_1.SetFocus()
		  Return
		END IF
	END IF
END IF
CALL super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_comubizonas
integer x = 1577
integer y = 576
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_comubizonas
integer x = 535
integer y = 316
integer height = 92
integer taborder = 20
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo 	     = "AYUDA SELECCION DE ZONAS DE COMPRAS"
ue_datawindow	  = "dw_ayuda_comubizonas"
ue_filtro 		  = "almacen = '" + sle_almacen.text + "'" 
isle_campo       = This

IF trim(sle_almacen.text)= "" THEN
    f_activar_campo(sle_almacen)
	 Return
END IF

IF trim(sle_valor.text)  = "" THEN
  dw_1.Retrieve(codigo_empresa,sle_almacen.text,sle_valor.Text)
end if

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_comubizonas
integer x = 1577
integer y = 712
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_comubizonas
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_comubizonas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_comubizonas
end type

type st_almacen from statictext within wi_mant_comubizonas
integer x = 160
integer y = 200
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Almacén"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_almacen from statictext within wi_mant_comubizonas
integer x = 814
integer y = 204
integer width = 1339
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type sle_almacen from u_em_campo within wi_mant_comubizonas
integer x = 535
integer y = 192
integer height = 92
integer taborder = 10
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

event getfocus;call super::getfocus;  ue_titulo         =  "AYUDA SELECCION DE ALMACENES DE COMPRAS"
  ue_datawindow     =  "dw_ayuda_comalmacenes"
  ue_filtro         =  ""
  isle_campo        =  This

  sle_valor.Text = ""
        
  IF istr_parametros.i_nargumentos>1 THEN
 	  sle_almacen.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(sle_almacen)
     sle_almacen.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     f_no_nulo(sle_valor)
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(sle_almacen.text)<>"" THEN
        Parent.TriggerEvent("ue_recuperar")
        Return
     END IF
   END IF
   
	f_control()


end event

event modificado;call super::modificado;st_nombre_almacen.text=f_nombre_comalmacen(codigo_empresa,sle_almacen.text)
IF Trim(st_nombre_almacen.text)="" THEN 
 IF Trim(sle_almacen.text)<>"" Then  f_activar_campo(sle_almacen)
 sle_almacen.text=""
  
END IF
end event

