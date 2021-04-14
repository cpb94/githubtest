$PBExportHeader$wi_mant_comusuarios.srw
forward
global type wi_mant_comusuarios from wi_mant_ventanas
end type
type gb_1 from groupbox within wi_mant_comusuarios
end type
end forward

global type wi_mant_comusuarios from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2825
integer height = 828
gb_1 gb_1
end type
global wi_mant_comusuarios wi_mant_comusuarios

type variables



end variables

event open;call super::open;
//Mantenimientos con clave alfanumerica
tipo_mantenimiento = "C"
valor_empresa = FALSE

istr_parametros.s_titulo_ventana = "Mantenimiento de usuarios"
istr_parametros.s_listado        = "report_comusuarios"

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

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"usuario",sle_valor.text)



end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "comusuarios"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end event

on wi_mant_comusuarios.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on wi_mant_comusuarios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
end on

event ue_imprimir;istr_parametros.b_empresa = TRUE
CALL Super::ue_imprimir
istr_parametros.b_empresa = FALSE
end event

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_comusuarios
integer x = 9
integer y = 184
integer width = 2711
integer height = 424
string dataobject = "dw_comusuarios"
end type

event dw_1::key;bus_filtro=""
 bus_datawindow = ""
 bus_titulo=""
 valor_empresa = TRUE
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "seccion"
 		bus_datawindow = "dw_ayuda_contaseccion"
		bus_titulo="AYUDA SELECCION DE SECCIONES"
   CASE "subseccion"
 		bus_datawindow = "dw_ayuda_contacoste"
		bus_titulo="AYUDA SELECCION DE SUB-SECCIONES"
	 bus_filtro="seccion = '"+dw_1.GetItemString(1,"seccion")+"'"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

end event

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"seccion")
f_valores_numericos(dw_1,"subseccion")
end event

event dw_1::rbuttondown; bus_filtro=""
 bus_datawindow = ""
 bus_titulo=""
 valor_empresa = TRUE
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "seccion"
 		bus_datawindow = "dw_ayuda_contaseccion"
		bus_titulo="AYUDA SELECCION DE SECCIONES"
   CASE "subseccion"
 		bus_datawindow = "dw_ayuda_contacoste"
		bus_titulo="AYUDA SELECCION DE SUB-SECCIONES"
	 bus_filtro="seccion = '"+dw_1.GetItemString(1,"seccion")+"'"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_comusuarios"
CHOOSE CASE f_objeto_datawindow(dw_1)
  CASE 'pb_seccion'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"seccion")
   OpenWithParm(w_mant_contaseccion,lstr_param)  
CASE 'pb_subseccion'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"seccion")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"subseccion")
   OpenWithParm(w_mant_contacoste,lstr_param)  
END CHOOSE




end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_comusuarios
integer x = 0
integer y = 76
integer width = 265
integer height = 88
string text = "Usuario:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_comusuarios
integer x = 1659
integer y = 76
integer width = 343
integer height = 84
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_comusuarios
integer x = 2007
integer y = 76
integer width = 343
integer height = 84
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_comusuarios
integer x = 274
integer y = 80
integer width = 1266
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA SELECCION DE USUARIOS"
ue_datawindow = "dw_ayuda_usuarios"
ue_filtro = ""
valor_empresa = FALSE
isle_campo = this
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_comusuarios
integer x = 2354
integer y = 76
integer width = 343
integer height = 84
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_comusuarios
end type

type gb_1 from groupbox within wi_mant_comusuarios
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

