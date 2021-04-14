$PBExportHeader$wi_mant_act_fcampo2.srw
forward
global type wi_mant_act_fcampo2 from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_act_fcampo2
end type
end forward

global type wi_mant_act_fcampo2 from wi_mvent_con_empresa
integer width = 2432
integer height = 832
pb_calculadora pb_calculadora
end type
global wi_mant_act_fcampo2 wi_mant_act_fcampo2

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

forward prototypes
public subroutine f_borrar_espacios ()
end prototypes

public subroutine f_borrar_espacios ();// Eliminamos los espacios
int linea
 
linea = dw_1.getrow()  
IF LINEA > 0 THEN
	dw_1.setitem(linea,"texto",trim(dw_1.getitemstring(linea,"texto")))	
end if

end subroutine

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de 2º dígito de la Familia" 
	st_1.text = f_desc_digito_familia(codigo_empresa,2)
	valor_empresa = True
	istr_parametros.s_listado        = "report_act_fcampo2"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,integer(sle_valor.Text))
      END IF
   END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",integer(sle_valor.text))
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "act_fcampo2"

dw_1.Retrieve(codigo_empresa,integer(sle_valor.Text))

CALL Super::ue_recuperar
end event

on wi_mant_act_fcampo2.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_act_fcampo2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_act_fcampo2
integer x = 59
integer y = 336
integer width = 1742
integer height = 212
string dataobject = "dwact_fcampo2"
end type

event dw_1::clicked;call super::clicked;//f_borrar_espacios()
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_act_fcampo2
integer x = 59
integer y = 212
integer width = 923
string text = "Código"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_act_fcampo2
integer x = 1861
integer y = 296
end type

event cb_insertar::clicked;String var_descripcion

IF dw_1.GetRow() <> 0 Then
  	 if cb_insertar.enabled = TRUE THEN
		 dw_1.AcceptText()
		 var_descripcion  = trim(dw_1.GetItemString(dw_1.GetRow(),"texto"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			dw_1.SetItem(dw_1.GetRow(),"texto",".")
		 END IF
	end if
END IF
CALL super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_act_fcampo2
integer x = 1861
integer y = 392
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_act_fcampo2
integer x = 997
integer y = 208
integer width = 105
string mask = "#"
string displaydata = "0"
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_fcampo2"
   ue_titulo         = "AYUDA SELECCION 2º DIGITO"
   ue_filtro         = ""
   isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_act_fcampo2
integer x = 1861
integer y = 484
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_act_fcampo2
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_act_fcampo2
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_act_fcampo2
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_act_fcampo2
integer x = 1111
integer y = 208
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From act_fcampo2
 Where  act_fcampo2.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  
  dec maxim
  long maxim_long
  
  Select max(act_fcampo2.codigo)
  Into   :maxim
  From   act_fcampo2
  Where  act_fcampo2.empresa = :codigo_empresa;
  
  maxim_long = long(maxim) + 1
    
  	If maxim_long >9 then 
		sle_valor.text=''	
	ELse
	  sle_valor.text = string(maxim_long)
	End IF
 END IF
 dw_1.TriggerEvent("Clicked")
end event

