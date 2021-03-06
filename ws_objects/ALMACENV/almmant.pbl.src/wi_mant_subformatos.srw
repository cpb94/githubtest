$PBExportHeader$wi_mant_subformatos.srw
forward
global type wi_mant_subformatos from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_subformatos
end type
end forward

global type wi_mant_subformatos from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 2030
integer height = 876
pb_calculadora pb_calculadora
end type
global wi_mant_subformatos wi_mant_subformatos

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de SubFormatos"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(codigo_empresa,sle_valor.text)
     END IF
END IF
end event

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "subformatos"

 dw_1.Retrieve(codigo_empresa,sle_valor.Text)
 CALL Super::ue_recuperar






end event

on wi_mant_subformatos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_subformatos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_subformatos
integer x = 14
integer y = 232
integer width = 1463
integer height = 352
string dataobject = "dw_subformatos"
end type

type st_1 from wi_mant_ventanas`st_1 within wi_mant_subformatos
integer x = 247
integer width = 302
string text = "Código"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_subformatos
integer x = 1504
integer y = 232
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_subformatos
integer x = 1504
integer y = 360
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_subformatos
integer x = 553
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION SUBFORMATOS"
ue_datawindow     = "dw_ayuda_subformatos"
ue_filtro         =  ""
valor_empresa     = true
isle_campo        = This

end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_subformatos
integer x = 1504
integer y = 492
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_subformatos
end type

type pb_calculadora from u_calculadora within wi_mant_subformatos
integer x = 832
integer y = 84
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros 
From subformatos
where empresa = :codigo_empresa;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,codigo)+1) 
   Into   :sle_valor.text
   From   subformatos
	where empresa = :codigo_empresa;
END IF
dw_1.TriggerEvent("Clicked")
end event

