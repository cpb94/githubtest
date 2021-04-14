$PBExportHeader$wi_mant_utigrupos.srw
forward
global type wi_mant_utigrupos from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_utigrupos
end type
end forward

global type wi_mant_utigrupos from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2862
integer height = 1084
pb_calculadora pb_calculadora
end type
global wi_mant_utigrupos wi_mant_utigrupos

type variables



end variables

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "utigrupos"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de grupos de usuarios"
istr_parametros.s_listado        = "report_utigrupos"
valor_empresa = FALSE
This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(sle_valor.text)
     END IF
END IF
end event

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end on

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_utigrupos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_utigrupos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_utigrupos
integer x = 46
integer y = 184
integer width = 2331
integer height = 572
string dataobject = "dw_utigrupos"
end type

on dw_1::key;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pantalla_inicio"
 		bus_datawindow = "dw_ayuda_utiprogramas"
		bus_titulo="AYUDA SELECCION DE PROGRAMAS"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
end on

on dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pantalla_inicio"
 		bus_datawindow = "dw_ayuda_utiprogramas"
		bus_titulo="AYUDA SELECCION DE PROGRAMAS"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end on

type st_1 from wi_mant_ventanas`st_1 within wi_mant_utigrupos
integer x = 192
integer y = 76
integer width = 265
integer height = 88
string text = "Código:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_utigrupos
integer x = 2400
integer y = 180
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_utigrupos
integer x = 2400
integer y = 308
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_utigrupos
integer x = 539
integer y = 76
integer taborder = 11
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA SELECCION GRUPOS DE USUARIOS"
ue_datawindow = "dw_ayuda_utigrupos"
ue_filtro = ""
valor_empresa = FALSE
isle_campo = this
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_utigrupos
integer x = 2400
integer y = 436
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_utigrupos
end type

type pb_calculadora from u_calculadora within wi_mant_utigrupos
integer x = 823
integer y = 72
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From utigrupos;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,utigrupos.codigo)+1) 
   Into   :sle_valor.text
   From   utigrupos;
END IF
dw_1.TriggerEvent("Clicked")
end on

