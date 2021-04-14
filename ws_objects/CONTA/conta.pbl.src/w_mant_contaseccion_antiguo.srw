$PBExportHeader$w_mant_contaseccion_antiguo.srw
forward
global type w_mant_contaseccion_antiguo from wi_mvent_con_empresa
end type
type gb_1 from groupbox within w_mant_contaseccion_antiguo
end type
type pb_calculadora from u_calculadora within w_mant_contaseccion_antiguo
end type
type gb_3 from groupbox within w_mant_contaseccion_antiguo
end type
type gb_2 from groupbox within w_mant_contaseccion_antiguo
end type
end forward

global type w_mant_contaseccion_antiguo from wi_mvent_con_empresa
integer width = 2263
integer height = 964
gb_1 gb_1
pb_calculadora pb_calculadora
gb_3 gb_3
gb_2 gb_2
end type
global w_mant_contaseccion_antiguo w_mant_contaseccion_antiguo

on w_mant_contaseccion_antiguo.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.pb_calculadora=create pb_calculadora
this.gb_3=create gb_3
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.pb_calculadora
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.gb_2
end on

on w_mant_contaseccion_antiguo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.pb_calculadora)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "contaseccion"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Secciones"
istr_parametros.s_listado        = "report_contaseccion"
This.title = istr_parametros.s_titulo_ventana
   
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text = istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
	 dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

	
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_contaseccion_antiguo
integer x = 41
integer y = 356
integer width = 1582
integer height = 308
string dataobject = "dw_contaseccion"
end type

event dw_1::key;call super::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS CONTABLES"
 		bus_datawindow = "dw_ayuda_contaplan"
		bus_filtro     = "ejercicio = " + String(f_ejercicio_activo(codigo_empresa))
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::rbuttondown;call super::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipocta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS CONTABLES "
 		bus_datawindow = "dw_ayuda_contaplan"
		bus_filtro     = "ejercicio = " + String(f_ejercicio_activo(codigo_empresa))
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;string 			ls_objeto
str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_venmateria"

CHOOSE CASE f_objeto_datawindow(dw_1)
  
	CASE 'pb_cuenta'
		lstr_param.s_argumentos[2] = String(f_ejercicio_activo(codigo_empresa))
		lstr_param.s_argumentos[3] = GetItemString(This.GetRow(),"cuenta")
		OpenWithParm(wi_mant_contaplan,lstr_param) 
 
END CHOOSE





end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_contaseccion_antiguo
integer x = 64
integer y = 228
integer width = 489
string text = "Código Sección:"
alignment alignment = left!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_contaseccion_antiguo
integer x = 1723
integer y = 268
integer textsize = -10
string facename = "Arial"
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_contaseccion_antiguo
integer x = 1723
integer y = 416
integer textsize = -10
string facename = "Arial"
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_contaseccion_antiguo
integer x = 553
integer y = 220
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_contaseccion"
ue_titulo     =  "AYUDA SELECCIÓN DE SECCIONES"
ue_filtro     =  ""
isle_campo    = This
valor_empresa = TRUE
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_contaseccion_antiguo
integer x = 1723
integer y = 564
integer textsize = -10
string facename = "Arial"
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_contaseccion_antiguo
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_contaseccion_antiguo
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_contaseccion_antiguo
integer width = 2121
end type

type gb_1 from groupbox within w_mant_contaseccion_antiguo
integer x = 1710
integer y = 224
integer width = 434
integer height = 152
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_calculadora from u_calculadora within w_mant_contaseccion_antiguo
integer x = 818
integer y = 216
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN 
	Return
END IF

Integer registros

SELECT count(*) 
	INTO  :registros 
	FROM  contaseccion
	WHERE contaseccion.empresa = :codigo_empresa
	USING SQLCA;
	
IF (registros=0) OR (SQLCA.SQLCode<>0) OR IsNull(registros) THEN
	sle_valor.text="1"
ELSE
	Select max(convert(int,contaseccion.codigo)+1)
	Into   :sle_valor.text
	From   contaseccion
	Where  contaseccion.empresa = :codigo_empresa;
END IF
dw_1.TriggerEvent("Clicked")
end event

type gb_3 from groupbox within w_mant_contaseccion_antiguo
integer x = 1710
integer y = 516
integer width = 434
integer height = 152
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_mant_contaseccion_antiguo
integer x = 1710
integer y = 368
integer width = 434
integer height = 152
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

