$PBExportHeader$w_cancelacion_riesgos_seglinventas.srw
forward
global type w_cancelacion_riesgos_seglinventas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_cancelacion_riesgos_seglinventas
end type
type uo_1 from u_manejo_datawindow within w_cancelacion_riesgos_seglinventas
end type
type cb_1 from u_boton within w_cancelacion_riesgos_seglinventas
end type
type dw_detalle from datawindow within w_cancelacion_riesgos_seglinventas
end type
type cb_4 from u_boton within w_cancelacion_riesgos_seglinventas
end type
type em_dias from editmask within w_cancelacion_riesgos_seglinventas
end type
type st_1 from statictext within w_cancelacion_riesgos_seglinventas
end type
type st_2 from statictext within w_cancelacion_riesgos_seglinventas
end type
type em_fecha from u_em_campo within w_cancelacion_riesgos_seglinventas
end type
end forward

global type w_cancelacion_riesgos_seglinventas from w_int_con_empresa
integer width = 2885
integer height = 1672
pb_1 pb_1
uo_1 uo_1
cb_1 cb_1
dw_detalle dw_detalle
cb_4 cb_4
em_dias em_dias
st_1 st_1
st_2 st_2
em_fecha em_fecha
end type
global w_cancelacion_riesgos_seglinventas w_cancelacion_riesgos_seglinventas

type variables
DateTime var_fecha

end variables

forward prototypes
public subroutine f_fecha ()
end prototypes

public subroutine f_fecha ();IF em_dias.text = "0" Then
	var_fecha = DateTime(Date(em_fecha.text))
ELSE
	var_fecha = DateTime(RelativeDate(Date(em_fecha.text), Dec(Dec(em_dias.text) * (-1))))
END IF
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Cancelación Riesgos ventas aseguradas"
This.title=istr_parametros.s_titulo_ventana
em_dias.text ="20"
dw_detalle.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"fra",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"importe",f_mascara_decimales(0))
em_fecha.text = String(Today())


end event

on w_cancelacion_riesgos_seglinventas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_1=create uo_1
this.cb_1=create cb_1
this.dw_detalle=create dw_detalle
this.cb_4=create cb_4
this.em_dias=create em_dias
this.st_1=create st_1
this.st_2=create st_2
this.em_fecha=create em_fecha
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.em_dias
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.em_fecha
end on

on w_cancelacion_riesgos_seglinventas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.dw_detalle)
destroy(this.cb_4)
destroy(this.em_dias)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_fecha)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cancelacion_riesgos_seglinventas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cancelacion_riesgos_seglinventas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cancelacion_riesgos_seglinventas
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_cancelacion_riesgos_seglinventas
integer x = 2693
integer y = 4
integer width = 137
integer height = 120
integer taborder = 0
string picturename = "exit!"
end type

type uo_1 from u_manejo_datawindow within w_cancelacion_riesgos_seglinventas
integer x = 2181
integer y = 116
integer width = 622
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from u_boton within w_cancelacion_riesgos_seglinventas
integer x = 1303
integer y = 156
integer width = 343
integer height = 88
integer taborder = 20
boolean bringtotop = true
string text = "&Refrescar"
end type

event clicked;call super::clicked;f_fecha()
dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,var_fecha)	

end event

type dw_detalle from datawindow within w_cancelacion_riesgos_seglinventas
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer x = 5
integer y = 268
integer width = 2779
integer height = 1172
string dataobject = "dw_cancelacion_riesgo_seglinventas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_4 from u_boton within w_cancelacion_riesgos_seglinventas
event clicked pbm_bnclicked
integer x = 1737
integer y = 156
integer width = 343
integer height = 92
integer taborder = 10
boolean bringtotop = true
string text = "&Procesar"
end type

event clicked;call super::clicked;Dec{0} registros,registro,var_anyo,var_orden
DateTime var_fecha_cobro
f_fecha()
IF MessageBox("Proceso cancelación de riesgos","¿Desea Cancelar Riesgos?",Question!,YesNo!) = 2 Then
	return
END IF

var_fecha_cobro = DateTime(Date(em_fecha.text))

registros = dw_detalle.Retrieve(codigo_empresa,var_fecha)	
For registro  = 1 To registros
	var_anyo   = Dec(f_valor_columna(dw_detalle,registro,"anyo"))
	var_orden  = Dec(f_valor_columna(dw_detalle,registro,"orden"))
	  UPDATE seglinventas  
     SET fcobro = :var_fecha_cobro,   
         situacion = "4"  
   WHERE ( seglinventas.empresa = :codigo_empresa ) AND  
         ( seglinventas.anyo = :var_anyo ) AND  
         ( seglinventas.orden = :var_orden )   ;
			COMMIT;
f_contador_procesos(registro,registros)
Next
cb_1.TriggerEvent(Clicked!)
end event

type em_dias from editmask within w_cancelacion_riesgos_seglinventas
integer x = 1015
integer y = 152
integer width = 247
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####0"
boolean spin = true
string displaydata = "~b"
end type

type st_1 from statictext within w_cancelacion_riesgos_seglinventas
integer x = 594
integer y = 164
integer width = 393
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Dias Margen:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_cancelacion_riesgos_seglinventas
integer x = 5
integer y = 164
integer width = 238
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_cancelacion_riesgos_seglinventas
integer x = 247
integer y = 156
integer width = 293
integer taborder = 2
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "0¨"
end type

