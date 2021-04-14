$PBExportHeader$wi_mant_contarecurlin.srw
forward
global type wi_mant_contarecurlin from wi_mvent_con_empresa
end type
type uo_asiento from u_em_campo_2 within wi_mant_contarecurlin
end type
type st_3 from statictext within wi_mant_contarecurlin
end type
type uo_ejercicio from u_ejercicio within wi_mant_contarecurlin
end type
type pb_calculadora from u_calculadora within wi_mant_contarecurlin
end type
type dw_lineas_asiento from datawindow within wi_mant_contarecurlin
end type
end forward

global type wi_mant_contarecurlin from wi_mvent_con_empresa
integer width = 2944
integer height = 1712
uo_asiento uo_asiento
st_3 st_3
uo_ejercicio uo_ejercicio
pb_calculadora pb_calculadora
dw_lineas_asiento dw_lineas_asiento
end type
global wi_mant_contarecurlin wi_mant_contarecurlin

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   uo_ejercicio.em_ejercicio.Text = String(f_ejercicio_activo(codigo_empresa))
	istr_parametros.s_titulo_ventana = "Mantenimiento de lineas de apuntes recurrentes"
	istr_parametros.s_listado        = "report_contarecurlin"
	istr_parametros.s_filtro         = "ejercicio = " + uo_ejercicio.em_ejercicio.Text
	
   This.title = istr_parametros.s_titulo_ventana
   dw_lineas_asiento.SetTransObject(Sqlca)
   
	
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_ejercicio.em_ejercicio.text=istr_parametros.s_argumentos[2]
      uo_asiento.em_campo.text= f_nombre_asiento(integer(uo_ejercicio.em_ejercicio.Text),codigo_empresa,uo_asiento.em_codigo.text)
      dw_lineas_asiento.Retrieve(integer(uo_ejercicio.em_ejercicio.Text),codigo_empresa,uo_asiento.em_codigo.text)
   END IF
   
	f_activar_campo(uo_asiento.em_campo)

	
end event

on ue_actualiza_dw;
CALL super::ue_actualiza_dw
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
	dw_1.setitem(dw_1.getrow(),"ejercicio",integer(uo_ejercicio.em_ejercicio.text))
   dw_1.setitem(dw_1.getrow(),"codigo",uo_asiento.em_codigo.text)
   dw_1.setitem(dw_1.getrow(),"linea",Integer(sle_valor.text))
  
end on

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(uo_asiento.em_codigo.text))
criterio[2]   =  trim(uo_asiento.em_codigo.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "contarecurlin"

dw_1.Retrieve(integer(uo_ejercicio.em_ejercicio.Text),codigo_empresa,uo_asiento.em_codigo.text,Integer(sle_valor.Text))



CALL Super::ue_recuperar
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
uo_asiento.enabled = TRUE
uo_ejercicio.enabled = TRUE
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
uo_asiento.enabled = FALSE
uo_ejercicio.enabled = FALSE
end on

on wi_mant_contarecurlin.create
int iCurrent
call super::create
this.uo_asiento=create uo_asiento
this.st_3=create st_3
this.uo_ejercicio=create uo_ejercicio
this.pb_calculadora=create pb_calculadora
this.dw_lineas_asiento=create dw_lineas_asiento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_asiento
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.uo_ejercicio
this.Control[iCurrent+4]=this.pb_calculadora
this.Control[iCurrent+5]=this.dw_lineas_asiento
end on

on wi_mant_contarecurlin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_asiento)
destroy(this.st_3)
destroy(this.uo_ejercicio)
destroy(this.pb_calculadora)
destroy(this.dw_lineas_asiento)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contarecurlin
integer x = 9
integer y = 292
integer width = 2112
integer height = 484
string dataobject = "dw_contarecurlin"
end type

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_contarecurlin"
CHOOSE CASE ls_objeto
  
CASE 'pb_cuenta'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cuenta")
   OpenWithParm(wi_mant_contaplan,lstr_param)  
CASE 'pb_concepto'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"concepto")
   OpenWithParm(wi_mant_contaconcepto,lstr_param)  

END CHOOSE





end event

on dw_1::key;bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
      bus_filtro     = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
 		bus_datawindow = "dw_ayuda_contaplan"
	CASE "concepto"
	   bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_contaconcepto"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::key
end on

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"concepto")
end event

on dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
      bus_filtro     = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
 		bus_datawindow = "dw_ayuda_contaplan"
   CASE "concepto"
      bus_titulo     = "VENTANA SELECCION DE CONCEPTOS"
      bus_filtro     = "" 
 		bus_datawindow = "dw_ayuda_contaconcepto"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end on

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contarecurlin
integer x = 1458
integer y = 176
integer width = 192
integer height = 88
string text = "Linea:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contarecurlin
integer x = 2167
integer y = 464
end type

on cb_insertar::clicked;call wi_mvent_con_empresa`cb_insertar::clicked;dw_lineas_asiento.Retrieve(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_asiento.em_codigo.text)

end on

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contarecurlin
integer x = 2167
integer y = 564
end type

on cb_borrar::clicked;call wi_mvent_con_empresa`cb_borrar::clicked;dw_lineas_asiento.Retrieve(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_asiento.em_codigo.text)

end on

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contarecurlin
integer x = 1664
integer y = 172
integer height = 88
integer taborder = 20
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;IF Trim(uo_asiento.em_campo.text) = "" Then f_activar_campo(uo_asiento.em_campo)
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contarecurlin
integer x = 2167
integer y = 664
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contarecurlin
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contarecurlin
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contarecurlin
integer width = 2816
end type

type uo_asiento from u_em_campo_2 within wi_mant_contarecurlin
integer x = 466
integer y = 172
integer width = 969
integer height = 88
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on modificado;call u_em_campo_2::modificado;uo_asiento.em_campo.text=f_nombre_asiento(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_asiento.em_codigo.text)
IF Trim(uo_asiento.em_campo.text)="" THEN 
 IF Trim(uo_asiento.em_codigo.text)<>"" Then uo_asiento.em_campo.SetFocus()
 uo_asiento.em_campo.text=""
 uo_asiento.em_codigo.text=""
END IF
dw_lineas_asiento.Retrieve(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_asiento.em_codigo.text)

 
end on

on getfocus;call u_em_campo_2::getfocus;ue_datawindow  = "dw_ayuda_contarecur"
ue_titulo      = "AYUDA SELECCION DE ASIENTOS RECURRENTES"
ue_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
end on

on uo_asiento.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within wi_mant_contarecurlin
integer x = 82
integer y = 172
integer width = 352
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Recurrente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_ejercicio from u_ejercicio within wi_mant_contarecurlin
integer x = 2203
integer y = 168
integer height = 288
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type pb_calculadora from u_calculadora within wi_mant_contarecurlin
integer x = 1925
integer y = 172
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled = TRUE THEN
  Return
END IF

 Integer registros,var_ejercicio,ln
 String cod 
 cod = uo_asiento.em_codigo.text
 var_ejercicio = Integer(uo_ejercicio.em_ejercicio.text)

 Select count(*) Into :registros
 From   contarecurlin
 Where  contarecurlin.ejercicio = :var_ejercicio
 and    contarecurlin.empresa   = :codigo_empresa
 and    contarecurlin.codigo   = :cod;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(contarecurlin.linea +1 ) Into   :ln
  From   contarecurlin
  Where  contarecurlin.ejercicio = :var_ejercicio
  and    contarecurlin.empresa   = :codigo_empresa
  and    contarecurlin.codigo   = :cod;
END IF
sle_valor.text  = STring(ln,"###0")
dw_1.triggerEvent("clicked")
  
end event

type dw_lineas_asiento from datawindow within wi_mant_contarecurlin
integer x = 5
integer y = 776
integer width = 2615
integer height = 664
boolean bringtotop = true
string dataobject = "dw_contarecurlin2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row =0 Then 
 f_activar_campo(uo_asiento.em_campo)
 Return
END IF

sle_valor.text = String(This.GetItemNumber(row,"linea"))
Parent.TriggerEvent("ue_recuperar")

f_activar_campo(sle_valor)
end event

