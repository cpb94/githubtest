$PBExportHeader$w_fpago_excluidas_seglinventas.srw
forward
global type w_fpago_excluidas_seglinventas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_fpago_excluidas_seglinventas
end type
type uo_1 from u_manejo_datawindow within w_fpago_excluidas_seglinventas
end type
type dw_detalle from datawindow within w_fpago_excluidas_seglinventas
end type
end forward

global type w_fpago_excluidas_seglinventas from w_int_con_empresa
integer width = 1710
integer height = 1704
pb_1 pb_1
uo_1 uo_1
dw_detalle dw_detalle
end type
global w_fpago_excluidas_seglinventas w_fpago_excluidas_seglinventas

type variables
DateTime var_fecha

end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Formas de pago excluidas de Cancelación Riesgos"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_detalle.Retrieve(codigo_empresa)



end event

on w_fpago_excluidas_seglinventas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_1=create uo_1
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_detalle
end on

on w_fpago_excluidas_seglinventas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_1)
destroy(this.dw_detalle)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_fpago_excluidas_seglinventas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_fpago_excluidas_seglinventas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_fpago_excluidas_seglinventas
integer x = 27
integer y = 8
integer width = 1435
end type

type pb_1 from upb_salir within w_fpago_excluidas_seglinventas
integer x = 1495
integer y = 4
integer width = 137
integer height = 120
integer taborder = 0
string picturename = "exit!"
end type

type uo_1 from u_manejo_datawindow within w_fpago_excluidas_seglinventas
integer x = 1042
integer y = 124
integer width = 622
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_detalle from datawindow within w_fpago_excluidas_seglinventas
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer x = 5
integer y = 268
integer width = 1641
integer height = 1172
string dataobject = "dw_fpago_excluidas_seglinventas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;String cod_pago
Integer numero
IF row = 0 Then 
		Return
END IF
cod_pago =  f_valor_columna(This,row,"forma")
Select Count(*) Into :numero From segfpagoexcluidas
Where  segfpagoexcluidas.empresa = :codigo_empresa
And    segfpagoexcluidas.forma_pago   = :cod_pago;
If IsNull(numero) Then numero = 0
IF numero = 0 Then
	  INSERT INTO segfpagoexcluidas  
         ( empresa,   
           forma_pago )  
  VALUES ( :codigo_empresa,   
           :cod_pago )  ;

Else
  DELETE FROM segfpagoexcluidas  
   WHERE ( segfpagoexcluidas.empresa = :codigo_empresa ) AND  
         ( segfpagoexcluidas.forma_pago = :cod_pago )   ;

END IF
COMMIT;
Retrieve(codigo_empresa)
end event

