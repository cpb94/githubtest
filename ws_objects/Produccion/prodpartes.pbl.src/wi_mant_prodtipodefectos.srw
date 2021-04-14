$PBExportHeader$wi_mant_prodtipodefectos.srw
forward
global type wi_mant_prodtipodefectos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prodtipodefectos
end type
end forward

global type wi_mant_prodtipodefectos from wi_mvent_con_empresa
integer width = 2834
integer height = 852
pb_calculadora pb_calculadora
end type
global wi_mant_prodtipodefectos wi_mant_prodtipodefectos

type variables

end variables

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Tipos de Defectos"

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
tabla         =  "prodplatos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_prodtipodefectos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_prodtipodefectos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodtipodefectos
integer x = 50
integer y = 340
integer width = 2688
integer height = 212
string dataobject = "dw_mant_prodtipodefectos"
end type

event dw_1::rbuttondown;call super::rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
END CHOOSE
end event

event dw_1::key;call super::key; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
END CHOOSE
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodtipodefectos
integer x = 59
integer y = 196
integer width = 270
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodtipodefectos
integer x = 1467
integer y = 196
end type

event cb_insertar::clicked;String descrip

dw_1.accepttext()



Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodtipodefectos
integer x = 1883
integer y = 196
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodtipodefectos
integer x = 361
integer y = 192
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodtipodefectos"
ue_titulo      = "AYUDA SELECCION DE TIPOS DE DEFECTOS"
ue_filtro      =""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodtipodefectos
integer x = 2304
integer y = 196
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodtipodefectos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodtipodefectos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodtipodefectos
integer width = 2437
end type

type pb_calculadora from u_calculadora within wi_mant_prodtipodefectos
integer x = 626
integer y = 188
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select   count(*) 
 Into     :registros
 From     prodtipodefectos
 Where  prodtipodefectos.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,prodtipodefectos.codigo)+1)
  Into   :registros
  From   prodtipodefectos
  Where  prodtipodefectos.empresa = :codigo_empresa;
  
  sle_valor.text=string(registros)
END IF
dw_1.triggerEvent("clicked")
  
end event

