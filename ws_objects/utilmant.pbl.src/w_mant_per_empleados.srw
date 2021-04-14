$PBExportHeader$w_mant_per_empleados.srw
forward
global type w_mant_per_empleados from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_per_empleados
end type
type gb_1 from groupbox within w_mant_per_empleados
end type
type gb_2 from groupbox within w_mant_per_empleados
end type
type gb_3 from groupbox within w_mant_per_empleados
end type
end forward

global type w_mant_per_empleados from wi_mvent_con_empresa
integer x = 361
integer y = 112
integer width = 2318
integer height = 1044
pb_calculadora pb_calculadora
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_mant_per_empleados w_mant_per_empleados

type variables
datawindow dw_activa
end variables

forward prototypes
public subroutine f_salir ()
public subroutine f_confirmar ()
public subroutine f_borrar_linea ()
public subroutine f_insertar_linea ()
end prototypes

public subroutine f_salir ();

end subroutine

public subroutine f_confirmar ();
end subroutine

public subroutine f_borrar_linea ();if dw_activa.getrow() > 0 then
	dw_activa.deleterow(dw_activa.getrow())
end if
end subroutine

public subroutine f_insertar_linea ();
long donde
donde = dw_activa.insertrow(dw_activa.rowcount() +1)
dw_activa.object.empresa[donde] = codigo_empresa
dw_activa.object.linea[donde] = sle_valor.text
dw_activa.setrow(donde)
dw_activa.scrolltorow(donde)
dw_activa.setcolumn("formato")


end subroutine

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event open;call super::open;
istr_parametros.s_titulo_ventana  = "Mantenimiento de Empleados"
This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end event

event ue_recuperar;
// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "per_empleados"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

on w_mant_per_empleados.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_3
end on

on w_mant_per_empleados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_esc;f_salir()
end event

event ue_actualiza_dw;call super::ue_actualiza_dw;f_confirmar()
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_per_empleados
integer x = 23
integer y = 276
integer width = 2258
integer height = 516
integer taborder = 20
string dataobject = "dw_mant_per_empleados"
borderstyle borderstyle = stylelowered!
end type

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_per_empleados"
CHOOSE CASE f_objeto_datawindow(this)

		
CASE 'p_grupo'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"grupo")
	OpenWithParm(w_mant_per_grupos,lstr_param)
CASE 'p_subgrupo'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"subgrupo")
	OpenWithParm(w_mant_per_subgrupos,lstr_param)
END CHOOSE






end event

event dw_1::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "grupo"
	bus_titulo     = "AYUDA SELECCION DE GRUPOS"
	bus_datawindow = "dw_ayuda_per_grupos"
	bus_filtro     = "" 
CASE "subgrupo"
	bus_titulo     = "AYUDA SELECCION DE SUBGRUPOS"
	bus_datawindow = "dw_ayuda_per_subgrupos"
	bus_filtro     = "" 
	
END CHOOSE
CALL Super::Key


end event

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "grupo"
	bus_titulo     = "AYUDA SELECCION DE GRUPOS"
	bus_datawindow = "dw_ayuda_per_grupos"
	bus_filtro     = "" 
CASE "subgrupo"
	bus_titulo     = "AYUDA SELECCION DE SUBGRUPOS"
	bus_datawindow = "dw_ayuda_per_subgrupos"
	bus_filtro     = "" 
	
END CHOOSE
CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_per_empleados
integer x = 55
integer y = 176
integer width = 270
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_per_empleados
integer x = 992
integer y = 160
integer width = 411
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_per_empleados
integer x = 1426
integer y = 160
integer width = 411
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_per_empleados
integer x = 347
integer y = 164
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_per_empleados"
ue_titulo      = "AYUDA SELECCION DE EMPLEADOS"
ue_filtro      = ""


end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_per_empleados
integer x = 1865
integer y = 156
integer width = 411
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_per_empleados
integer taborder = 60
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_per_empleados
integer x = 69
integer y = 40
integer width = 101
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_per_empleados
integer x = 9
integer y = 16
integer width = 2277
end type

type pb_calculadora from u_calculadora within w_mant_per_empleados
integer x = 613
integer y = 160
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select   count(*) 
 Into     :registros
 From     per_empleados
 Where  per_empleados.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,per_empleados.codigo)+1)
  Into   :sle_valor.text
  From   per_empleados
  Where  per_empleados.empresa = :codigo_empresa;
END IF


dw_1.triggerEvent("clicked")
 
 

end event

type gb_1 from groupbox within w_mant_per_empleados
integer x = 983
integer y = 128
integer width = 430
integer height = 132
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_mant_per_empleados
integer x = 1417
integer y = 128
integer width = 430
integer height = 132
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_mant_per_empleados
integer x = 1856
integer y = 124
integer width = 430
integer height = 132
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

