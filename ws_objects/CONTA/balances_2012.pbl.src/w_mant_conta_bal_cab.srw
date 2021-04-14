$PBExportHeader$w_mant_conta_bal_cab.srw
forward
global type w_mant_conta_bal_cab from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within w_mant_conta_bal_cab
end type
end forward

global type w_mant_conta_bal_cab from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 2542
integer height = 1160
pb_calculadora pb_calculadora
end type
global w_mant_conta_bal_cab w_mant_conta_bal_cab

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Balances"
istr_parametros.s_listado        = ""

This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
     istr_parametros.i_nargumentos=0 
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	this.TriggerEvent("ue_recuperar")
			Return
     END IF
END IF
end event

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "conta_bal_cab"

 dw_1.Retrieve(codigo_empresa,sle_valor.Text)
 CALL Super::ue_recuperar






end event

on w_mant_conta_bal_cab.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_conta_bal_cab.destroy
call super::destroy
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mant_ventanas`dw_1 within w_mant_conta_bal_cab
integer x = 5
integer y = 256
integer width = 2121
integer height = 808
string dataobject = "dw_mant_conta_bal_cab"
end type

type st_1 from wi_mant_ventanas`st_1 within w_mant_conta_bal_cab
integer x = 219
integer width = 302
string text = "Código "
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within w_mant_conta_bal_cab
integer x = 2135
integer y = 256
integer width = 343
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within w_mant_conta_bal_cab
integer x = 2135
integer y = 384
integer width = 343
end type

type sle_valor from wi_mant_ventanas`sle_valor within w_mant_conta_bal_cab
integer x = 530
end type

event sle_valor::getfocus;call super::getfocus;valor_empresa = true
ue_titulo     = "AYUDA SELECCION DE BALANCES"
ue_datawindow = "dw_ayuda_conta_bal_cab"
isle_campo    = this

end event

type cb_salir from wi_mant_ventanas`cb_salir within w_mant_conta_bal_cab
integer x = 2135
integer y = 516
integer width = 343
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within w_mant_conta_bal_cab
end type

type pb_calculadora from u_calculadora within w_mant_conta_bal_cab
integer x = 800
integer y = 84
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From conta_bal_cab;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,conta_bal_cab.codigo)+1) 
   Into   :sle_valor.text
   From   conta_bal_cab;
END IF
dw_1.TriggerEvent("Clicked")
end event

