$PBExportHeader$wi_mant_ventextopiealb.srw
forward
global type wi_mant_ventextopiealb from wi_mant_ventanas
end type
end forward

global type wi_mant_ventextopiealb from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2880
integer height = 1676
end type
global wi_mant_ventextopiealb wi_mant_ventextopiealb

type variables



end variables

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "venparametros"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento almacen de materiales preparados"
istr_parametros.s_listado        = "report_venparametros"

This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
   sle_valor.text=istr_parametros.s_argumentos[2]
	IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
     	dw_1.Retrieve(sle_valor.text)
   END IF
END IF
end event

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",sle_valor.text)

end on

on wi_mant_ventextopiealb.create
call super::create
end on

on wi_mant_ventextopiealb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_ventextopiealb
integer x = 0
integer y = 156
integer width = 2793
integer height = 1252
string dataobject = "dw_ventextopiealb"
end type

type st_1 from wi_mant_ventanas`st_1 within wi_mant_ventextopiealb
integer x = 178
integer y = 52
integer width = 283
integer height = 88
string text = "Empresa:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_ventextopiealb
integer x = 782
integer y = 48
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_ventextopiealb
integer x = 1189
integer y = 48
end type

event cb_borrar::clicked;// no hace nada

MessageBox("Solo se puede modificar","",Exclamation!, OK!,1)
f_activar_campo(sle_valor)
end event

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_ventextopiealb
integer x = 457
integer y = 52
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow = "dw_ayuda_empresas"
ue_filtro = ""
isle_campo = this
valor_empresa = FALSE
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_ventextopiealb
integer x = 1595
integer y = 48
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_ventextopiealb
integer taborder = 30
end type

