$PBExportHeader$wi_mant_empresas_conexion.srw
forward
global type wi_mant_empresas_conexion from wi_mant_ventanas
end type
type gb_1 from groupbox within wi_mant_empresas_conexion
end type
end forward

global type wi_mant_empresas_conexion from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2825
integer height = 972
gb_1 gb_1
end type
global wi_mant_empresas_conexion wi_mant_empresas_conexion

type variables



end variables

event open;call super::open;
//Mantenimientos con clave alfanumerica
tipo_mantenimiento = "C"
valor_empresa = FALSE

istr_parametros.s_titulo_ventana = "Mantenimiento de parametros conexion"
istr_parametros.s_listado        = "report_usuarios"

This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     istr_parametros.i_nargumentos = 0
	  sle_valor.text=istr_parametros.s_argumentos[2]
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	This.TriggerEvent("ue_recuperar")
     END IF
END IF
end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"v_empresa",sle_valor.text)


end event

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "usuarios"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

on wi_mant_empresas_conexion.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on wi_mant_empresas_conexion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_empresas_conexion
integer x = 14
integer y = 184
integer width = 2711
integer height = 516
string dataobject = "dw_empresas_conexion"
end type

event dw_1::key; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "v_grupo"
 		bus_datawindow = "dw_ayuda_utigrupos"
		bus_titulo="AYUDA SELECCION DE GRUPOS"
	CASE "v_idioma"
 		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo="AYUDA SELECCION DE IDIOMAS"
		valor_empresa = FALSE
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "v_grupo"
 		bus_datawindow = "dw_ayuda_utigrupos"
		bus_titulo="AYUDA SELECCION DE GRUPOS"
      valor_empresa = FALSE
   CASE "v_idioma"
 		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo="AYUDA SELECCION DE IDIOMAS"
		valor_empresa = FALSE
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_empresas_conexion
integer x = 27
integer y = 76
integer width = 283
integer height = 88
string text = "Empresa:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_empresas_conexion
integer x = 1659
integer y = 76
integer width = 343
integer height = 84
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_empresas_conexion
integer x = 2007
integer y = 76
integer width = 343
integer height = 84
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_empresas_conexion
integer x = 311
integer y = 80
integer width = 1266
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow = "dw_ayuda_empresas"
ue_filtro = ""
valor_empresa = FALSE
isle_campo = this
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_empresas_conexion
integer x = 2354
integer y = 76
integer width = 343
integer height = 84
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_empresas_conexion
end type

type gb_1 from groupbox within wi_mant_empresas_conexion
integer x = 1646
integer y = 40
integer width = 1065
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

