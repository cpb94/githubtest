$PBExportHeader$wi_mant_deptipomov.srw
forward
global type wi_mant_deptipomov from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_deptipomov
end type
end forward

global type wi_mant_deptipomov from wi_mvent_con_empresa
integer width = 2395
integer height = 1112
pb_calculadora pb_calculadora
end type
global wi_mant_deptipomov wi_mant_deptipomov

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"tipomov",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"interno","N")
end event

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de tipos de movimientos"
	istr_parametros.s_listado         = "report_deptipomov"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
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
tabla         =  "deptipomov"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_deptipomov.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_deptipomov.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_deptipomov
integer x = 59
integer y = 364
integer width = 1742
integer height = 428
string dataobject = "dw_deptipomov"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_deptipomov
integer x = 302
integer y = 232
integer width = 270
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_deptipomov
integer x = 1865
integer y = 388
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_deptipomov
integer x = 1865
integer y = 516
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_deptipomov
integer x = 581
integer y = 228
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_deptipomov"
ue_titulo      = "AYUDA SELECCION DE TIPOS MOVIMENTOS"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_deptipomov
integer x = 1865
integer y = 644
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_deptipomov
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_deptipomov
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_deptipomov
integer width = 2240
end type

type pb_calculadora from u_calculadora within wi_mant_deptipomov
integer x = 846
integer y = 224
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   deptipomov
 Where  deptipomov.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,deptipomov.tipomov)+1)
  Into   :sle_valor.text
  From   deptipomov
  Where  deptipomov.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

