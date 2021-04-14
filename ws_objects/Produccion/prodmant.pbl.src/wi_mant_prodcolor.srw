$PBExportHeader$wi_mant_prodcolor.srw
forward
global type wi_mant_prodcolor from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prodcolor
end type
end forward

global type wi_mant_prodcolor from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2601
integer height = 972
pb_calculadora pb_calculadora
end type
global wi_mant_prodcolor wi_mant_prodcolor

on wi_mant_prodcolor.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_prodcolor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Colores"

This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prodcolor"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodcolor
integer y = 336
integer width = 1833
integer height = 264
string dataobject = "dw_mant_prodcolor"
end type

event dw_1::key;bus_filtro = ""
valor_empresa = TRUE	
bus_titulo = ""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE ""
END CHOOSE

CALL Super::key
end event

event dw_1::rbuttondown;bus_filtro = ""
valor_empresa = TRUE	
bus_titulo = ""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE ""
END CHOOSE

CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodcolor
integer x = 87
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodcolor
integer x = 1943
integer y = 320
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodcolor
integer x = 1943
integer y = 416
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodcolor
integer x = 498
string mask = "###"
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodcolor"
ue_titulo      = "Ayuda selección de Colores"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodcolor
integer x = 1943
integer y = 512
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodcolor
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodcolor
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodcolor
end type

type pb_calculadora from u_calculadora within wi_mant_prodcolor
integer x = 759
integer y = 204
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
	Integer registros
	Select count(*) 
	Into	 :registros
	From	 prodcolor
	Where  prodcolor.empresa = :codigo_empresa;
	IF registros=0 THEN
   	sle_valor.text="001"
	ELSE
		Select max(convert(int,prodcolor.codigo)+1)
		Into   :sle_valor.text
		From   prodcolor
		Where  prodcolor.empresa = :codigo_empresa;
END IF
sle_valor.text = right("000"+trim(sle_valor.text),3)
dw_1.triggerEvent("clicked")
  
end event

