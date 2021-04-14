$PBExportHeader$wi_mant_prodcaracteristicas.srw
forward
global type wi_mant_prodcaracteristicas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prodcaracteristicas
end type
end forward

global type wi_mant_prodcaracteristicas from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2533
integer height = 1024
pb_calculadora pb_calculadora
end type
global wi_mant_prodcaracteristicas wi_mant_prodcaracteristicas

on wi_mant_prodcaracteristicas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_prodcaracteristicas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Caracteristicas"

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
tabla         =  "prodcaracteristicas"

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

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodcaracteristicas
integer y = 308
integer width = 1833
integer height = 384
integer taborder = 30
string dataobject = "dw_mant_prodcaracteristicas"
end type

event dw_1::key;bus_filtro = ""
valor_empresa = FALSE	
bus_titulo = ""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "unidad"
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"
END CHOOSE

CALL Super::key

end event

event dw_1::rbuttondown;bus_filtro = ""
valor_empresa = FALSE	
bus_titulo = ""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "unidad"
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"
END CHOOSE

CALL Super::rbuttondown

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param

if row > 0 then
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[1] = "wi_mant_prodcaracteristicas"
	choose case dwo.name
		case "pb_unidad"
			if This.GetRow() > 0 then
				lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"unidad")
			else
				lstr_param.s_argumentos[2] = ""
			end if
			OpenWithParm(w_mant_comunimedida,lstr_param)  
	end choose
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodcaracteristicas
integer x = 82
integer y = 204
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodcaracteristicas
integer x = 1929
integer y = 312
integer taborder = 40
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodcaracteristicas
integer x = 1929
integer y = 408
integer taborder = 50
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodcaracteristicas
integer x = 462
integer y = 204
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodcaracteristicas"
ue_titulo      = "Ayuda selección de Caracteristicas"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodcaracteristicas
integer x = 1929
integer y = 504
integer taborder = 60
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodcaracteristicas
integer taborder = 10
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodcaracteristicas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodcaracteristicas
end type

type pb_calculadora from u_calculadora within wi_mant_prodcaracteristicas
integer x = 722
integer y = 196
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
	From	 prodcaracteristicas
	Where  prodcaracteristicas.empresa = :codigo_empresa;
	IF registros=0 THEN
   	sle_valor.text="1"
	ELSE
		Select max(convert(int,prodcaracteristicas.codigo)+1)
		Into   :sle_valor.text
		From   prodcaracteristicas
		Where  prodcaracteristicas.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

