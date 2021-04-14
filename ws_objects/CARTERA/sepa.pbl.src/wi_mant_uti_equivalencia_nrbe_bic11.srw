$PBExportHeader$wi_mant_uti_equivalencia_nrbe_bic11.srw
$PBExportComments$Mant. de unidades.
forward
global type wi_mant_uti_equivalencia_nrbe_bic11 from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_uti_equivalencia_nrbe_bic11
end type
type gb_1 from groupbox within wi_mant_uti_equivalencia_nrbe_bic11
end type
end forward

global type wi_mant_uti_equivalencia_nrbe_bic11 from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 1989
integer height = 724
boolean controlmenu = false
pb_calculadora pb_calculadora
gb_1 gb_1
end type
global wi_mant_uti_equivalencia_nrbe_bic11 wi_mant_uti_equivalencia_nrbe_bic11

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento Equivalencias NRBE BIC 11"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

pb_calculadora.visible = FALSE

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(sle_valor.text)
     END IF
END IF
end event

event ue_activa_claves;call super::ue_activa_claves;//pb_calculadora.visible = TRUE
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"NRBE",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"BIC11","")
end event

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

on wi_mant_uti_equivalencia_nrbe_bic11.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
end on

on wi_mant_uti_equivalencia_nrbe_bic11.destroy
call super::destroy
destroy(this.pb_calculadora)
destroy(this.gb_1)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;//pb_calculadora.visible = FALSE
end event

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_uti_equivalencia_nrbe_bic11
integer x = 64
integer height = 368
string dataobject = "dw_mant_uti_equivalencia_nrbe_bic11"
end type

event dw_1::rbuttondown;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE
CHOOSE CASE bus_campo
	CASE "unidad_compras"
		valor_empresa  = FALSE
		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo     = "VENTANA SELECCION DE UNIDADES"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::RbuttonDown
 
end event

event dw_1::key;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE
CHOOSE CASE bus_campo
	CASE "unidad_compras"
		valor_empresa  = FALSE
		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo     = "VENTANA SELECCION DE UNIDADES"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_uti_equivalencia_nrbe_bic11
integer x = 247
integer width = 302
string text = "Código"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_uti_equivalencia_nrbe_bic11
integer x = 1504
integer y = 228
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_uti_equivalencia_nrbe_bic11
integer x = 1504
integer y = 360
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_uti_equivalencia_nrbe_bic11
integer x = 553
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION NRBE"
ue_datawindow     = "dw_ayuda_uti_equivalencia_nrbe_bic11"
ue_filtro         =  ""
valor_empresa     = FALSE
isle_campo        = This

end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_uti_equivalencia_nrbe_bic11
integer x = 1504
integer y = 488
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_uti_equivalencia_nrbe_bic11
end type

type pb_calculadora from u_calculadora within wi_mant_uti_equivalencia_nrbe_bic11
integer x = 837
integer y = 84
integer taborder = 0
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

type gb_1 from groupbox within wi_mant_uti_equivalencia_nrbe_bic11
integer x = 1490
integer y = 192
integer width = 434
integer height = 396
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

