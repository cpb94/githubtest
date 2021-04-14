$PBExportHeader$wi_mant_promclasepaneles.srw
forward
global type wi_mant_promclasepaneles from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_promclasepaneles
end type
end forward

global type wi_mant_promclasepaneles from wi_mvent_con_empresa
integer width = 2519
integer height = 980
pb_calculadora pb_calculadora
end type
global wi_mant_promclasepaneles wi_mant_promclasepaneles

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
 
end event

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de Clases de Paneles"
	istr_parametros.s_listado         = "report_promclasepaneles"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF
	
	f_mascara_columna(dw_1,"porcentaje","#,##0.00")

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "promclasepaneles"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_promclasepaneles.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_promclasepaneles.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_promclasepaneles
integer x = 110
integer y = 324
integer width = 1806
integer height = 420
string dataobject = "dw_promclasepaneles"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_promclasepaneles
integer x = 110
integer width = 471
string text = "Clase Paneles:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_promclasepaneles
integer x = 2011
integer y = 336
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_promclasepaneles
integer x = 2011
integer y = 444
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_promclasepaneles
integer x = 594
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_promclasepanel"
ue_titulo      = "AYUDA SELECCION DE CLASES PANELES"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_promclasepaneles
integer x = 2011
integer y = 556
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_promclasepaneles
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_promclasepaneles
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_promclasepaneles
integer width = 2834
end type

type pb_calculadora from u_calculadora within wi_mant_promclasepaneles
integer x = 859
integer y = 212
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   promclasepaneles
 Where  promclasepaneles.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,promclasepaneles.codigo)+1)
  Into   :sle_valor.text
  From   promclasepaneles
  Where  promclasepaneles.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

