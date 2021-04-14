$PBExportHeader$wi_mant_unidades.srw
$PBExportComments$Mant. de unidades.
forward
global type wi_mant_unidades from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_unidades
end type
end forward

global type wi_mant_unidades from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 2030
integer height = 908
pb_calculadora pb_calculadora
end type
global wi_mant_unidades wi_mant_unidades

on open;call wi_mant_ventanas::open;istr_parametros.s_titulo_ventana = "Mantenimiento de unidades"
istr_parametros.s_listado        = "report_unidades"
This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(sle_valor.text)
     END IF
END IF
end on

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "unidades"

 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

on wi_mant_unidades.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_unidades.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_unidades
integer x = 64
integer height = 428
string dataobject = "dw_unidades"
end type

type st_1 from wi_mant_ventanas`st_1 within wi_mant_unidades
integer x = 247
integer width = 302
string text = "Código"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_unidades
integer x = 1504
integer y = 232
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_unidades
integer x = 1504
integer y = 360
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_unidades
integer x = 553
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION UNIDADES"
ue_datawindow     = "dw_ayuda_unidades"
ue_filtro         =  ""
valor_empresa     = FALSE
isle_campo        = This

end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_unidades
integer x = 1504
integer y = 492
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_unidades
end type

type pb_calculadora from u_calculadora within wi_mant_unidades
integer x = 837
integer y = 84
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From unidades;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,unidades.codigo)+1) 
   Into   :sle_valor.text
   From   unidades;
END IF
dw_1.TriggerEvent("Clicked")
end on

