$PBExportHeader$wi_mant_balances.srw
forward
global type wi_mant_balances from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_balances
end type
end forward

global type wi_mant_balances from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 2569
integer height = 916
pb_calculadora pb_calculadora
end type
global wi_mant_balances wi_mant_balances

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Balances"
istr_parametros.s_listado        = "report_balances"

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

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"balance",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "contabal"

 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end event

on wi_mant_balances.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_balances.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_balances
integer x = 59
integer y = 240
integer width = 2016
integer height = 384
string dataobject = "dw_contabal"
end type

type st_1 from wi_mant_ventanas`st_1 within wi_mant_balances
integer x = 219
integer width = 302
string text = "Código "
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_balances
integer x = 2135
integer y = 256
integer width = 343
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_balances
integer x = 2135
integer y = 384
integer width = 343
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_balances
integer x = 530
end type

event sle_valor::getfocus;call super::getfocus;valor_empresa = true
ue_titulo     = "AYUDA SELECCION DE BALANCES"
ue_datawindow = "dw_ayuda_contabal"
isle_campo    = this

end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_balances
integer x = 2135
integer y = 516
integer width = 343
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_balances
end type

type pb_calculadora from u_calculadora within wi_mant_balances
integer x = 800
integer y = 84
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From contabal;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,contabal.balance)+1) 
   Into   :sle_valor.text
   From   contabal;
END IF
dw_1.TriggerEvent("Clicked")
end event

