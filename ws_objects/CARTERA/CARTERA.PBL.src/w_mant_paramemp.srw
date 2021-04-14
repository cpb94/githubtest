$PBExportHeader$w_mant_paramemp.srw
forward
global type w_mant_paramemp from wi_mant_ventanas
end type
type gb_1 from groupbox within w_mant_paramemp
end type
end forward

global type w_mant_paramemp from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2784
integer height = 1020
gb_1 gb_1
end type
global w_mant_paramemp w_mant_paramemp

type variables



end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Parámetros de Empresa"
istr_parametros.s_listado        = "report_empresas"
This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo

IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
     IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(sle_valor.text)
     END IF
END IF
end event

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;  dw_1.setitem(dw_1.getrow(),"empresa",sle_valor.text)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       = This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "paramemp"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end event

on w_mant_paramemp.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on w_mant_paramemp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
end on

type dw_1 from wi_mant_ventanas`dw_1 within w_mant_paramemp
integer x = 37
integer y = 204
integer width = 2674
integer height = 588
string dataobject = "dw_paramemp"
end type

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	valor_empresa = TRUE
 	bus_filtro=""
 	bus_titulo=""
 	bus_campo = This.GetColumnName()
 	CHOOSE CASE bus_campo
		CASE "moneda_emp"
			valor_empresa = FALSE
      	bus_datawindow = "dw_ayuda_divisas"
			bus_titulo = "VENTANA SELECCION DE MONEDAS"
		CASE "tipodoc_rem"
			bus_datawindow = "dw_ayuda_cartipodoc"
			bus_titulo = "VENTANA SELECCION DE TIPOS DE DOCUMENTO"
   	CASE ELSE
		SetNull(bus_campo)
 	END CHOOSE
 	CALL Super::Key
END IF

end event

event dw_1::rbuttondown;valor_empresa = TRUE
bus_filtro=""
bus_titulo=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "moneda_emp"
	valor_empresa = FALSE
	bus_datawindow = "dw_ayuda_divisas"
	bus_titulo = "VENTANA SELECCION DE MONEDAS"
CASE "tipodoc_rem"
	bus_datawindow = "dw_ayuda_cartipodoc"
	bus_titulo = "VENTANA SELECCION DE TIPOS DE DOCUMENTO"
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

type st_1 from wi_mant_ventanas`st_1 within w_mant_paramemp
integer x = 146
integer y = 76
integer height = 88
string text = "Empresa :"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within w_mant_paramemp
integer x = 1669
integer y = 80
integer width = 338
integer height = 80
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within w_mant_paramemp
integer x = 2007
integer y = 80
integer width = 338
integer height = 80
end type

type sle_valor from wi_mant_ventanas`sle_valor within w_mant_paramemp
integer x = 503
integer y = 76
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow     = "dw_ayuda_empresas"
ue_filtro         = "" 
valor_empresa 		= FALSE
isle_campo        = This  
end event

type cb_salir from wi_mant_ventanas`cb_salir within w_mant_paramemp
integer x = 2345
integer y = 80
integer width = 338
integer height = 80
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within w_mant_paramemp
end type

type gb_1 from groupbox within w_mant_paramemp
integer x = 1655
integer y = 48
integer width = 1042
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

