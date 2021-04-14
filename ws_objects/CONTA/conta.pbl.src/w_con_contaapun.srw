$PBExportHeader$w_con_contaapun.srw
$PBExportComments$€
forward
global type w_con_contaapun from w_int_con_empresa
end type
type uo_ejercicio from u_ejercicio within w_con_contaapun
end type
type dw_1 from datawindow within w_con_contaapun
end type
type uo_origen from u_em_campo_2 within w_con_contaapun
end type
type st_3 from statictext within w_con_contaapun
end type
type st_asiento from statictext within w_con_contaapun
end type
type em_asiento from u_em_campo within w_con_contaapun
end type
type cb_1 from u_boton within w_con_contaapun
end type
type uo_mes from u_em_campo_2 within w_con_contaapun
end type
type st_4 from statictext within w_con_contaapun
end type
type dw_listado from datawindow within w_con_contaapun
end type
type pb_2 from upb_imprimir within w_con_contaapun
end type
type dw_apuntes from datawindow within w_con_contaapun
end type
type pb_1 from upb_salir within w_con_contaapun
end type
end forward

global type w_con_contaapun from w_int_con_empresa
integer width = 2912
integer height = 2200
uo_ejercicio uo_ejercicio
dw_1 dw_1
uo_origen uo_origen
st_3 st_3
st_asiento st_asiento
em_asiento em_asiento
cb_1 cb_1
uo_mes uo_mes
st_4 st_4
dw_listado dw_listado
pb_2 pb_2
dw_apuntes dw_apuntes
pb_1 pb_1
end type
global w_con_contaapun w_con_contaapun

forward prototypes
public subroutine f_cambio_linea (integer reg)
end prototypes

public subroutine f_cambio_linea (integer reg);if dw_1.RowCount() = 0 tHEN Return
iF IsNull(reg) Then Return
IF reg = 0 Then Return
Integer ln
ln = Integer(dw_1.Describe("DataWindow.LastRowOnPage"))
dw_1.SetItem(ln,"cta",dw_1.GetItemString(reg,"cuenta"))
dw_1.SetItem(ln,"con",dw_1.GetItemString(reg,"concepto"))
end subroutine

event open;call super::open;   dw_1.SetTransObject(SQLCA)
	dw_listado.SetTransObject(SQLCA)
   istr_parametros.s_titulo_ventana  = "Consulta asientos"
	istr_parametros.s_listado         = "report_contabal"
   This.title = istr_parametros.s_titulo_ventana
    uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_ejercicio.em_ejercicio.text=istr_parametros.s_argumentos[2]
      uo_origen.em_codigo.text=istr_parametros.s_argumentos[3]
		uo_origen.TriggerEvent("modificado")
      uo_mes.em_codigo.text=String(Month(Date(istr_parametros.s_argumentos[4])))
		uo_mes.em_campo.text = f_nombre_mes(Dec(uo_mes.em_codigo.text))
		em_asiento.text=istr_parametros.s_argumentos[5]
		cb_1.TriggerEvent(Clicked!)
   END IF

	f_mascara_columna(dw_1,"debe",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"haber",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"totald",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"totalh",f_mascara_decimales(0))
   f_activar_campo(uo_origen.em_campo)

	
end event

on w_con_contaapun.create
int iCurrent
call super::create
this.uo_ejercicio=create uo_ejercicio
this.dw_1=create dw_1
this.uo_origen=create uo_origen
this.st_3=create st_3
this.st_asiento=create st_asiento
this.em_asiento=create em_asiento
this.cb_1=create cb_1
this.uo_mes=create uo_mes
this.st_4=create st_4
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.dw_apuntes=create dw_apuntes
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ejercicio
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.uo_origen
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_asiento
this.Control[iCurrent+6]=this.em_asiento
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.uo_mes
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.dw_listado
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.dw_apuntes
this.Control[iCurrent+13]=this.pb_1
end on

on w_con_contaapun.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_ejercicio)
destroy(this.dw_1)
destroy(this.uo_origen)
destroy(this.st_3)
destroy(this.st_asiento)
destroy(this.em_asiento)
destroy(this.cb_1)
destroy(this.uo_mes)
destroy(this.st_4)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.dw_apuntes)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_contaapun
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_contaapun
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_asiento)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_contaapun
integer y = 8
end type

type uo_ejercicio from u_ejercicio within w_con_contaapun
integer x = 2185
integer y = 144
boolean bringtotop = true
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_1 from datawindow within w_con_contaapun
integer x = 9
integer y = 316
integer width = 2825
integer height = 1648
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_con_contaapun1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemfocuschanged;Dec v_ejercicio
String cta

IF GetRow()<> 0 Then
		v_ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
		cta =  getItemString(getRow(),"cuenta")
End if

end event

event rowfocuschanged;f_cambio_linea(currentrow)
end event

type uo_origen from u_em_campo_2 within w_con_contaapun
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 37
integer y = 208
integer width = 777
integer height = 80
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)

IF Trim(uo_origen.em_campo.text)="" THEN 
 IF Trim(uo_origen.em_codigo.text)<>"" Then uo_origen.em_campo.SetFocus()
 uo_origen.em_campo.text=""
 uo_origen.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE ORIGENES"
		ue_datawindow = "dw_ayuda_contaorigen"
		ue_filtro     = ""

end event

on uo_origen.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within w_con_contaapun
integer x = 41
integer y = 132
integer width = 777
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Origen "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_asiento from statictext within w_con_contaapun
event clicked pbm_bnclicked
integer x = 1202
integer y = 132
integer width = 270
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 12632256
string text = "Asiento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;dw_apuntes.SetTransObject(SQLCA)
IF dw_apuntes.retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,Dec(uo_mes.em_codigo.text),uo_origen.em_codigo.text) <> 0 Then
	dw_apuntes.visible = TRUE
END IF
end event

type em_asiento from u_em_campo within w_con_contaapun
event modificado pbm_custom02
integer x = 1202
integer y = 208
integer width = 270
integer height = 80
integer taborder = 40
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "Ä"
end type

type cb_1 from u_boton within w_con_contaapun
integer x = 1522
integer y = 164
integer width = 384
integer height = 120
integer taborder = 50
string text = "&Continuar"
end type

event clicked;call super::clicked;dw_1.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,Dec(uo_mes.em_codigo.text),uo_origen.em_codigo.text,Dec(em_asiento.text))
dw_1.setfocus()
end event

type uo_mes from u_em_campo_2 within w_con_contaapun
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 814
integer y = 208
integer width = 384
integer height = 80
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_mes.em_campo.text=f_nombre_mes(Dec(uo_mes.em_codigo.text))

IF Trim(uo_mes.em_campo.text)="" THEN 
 IF Trim(uo_mes.em_codigo.text)<>"" Then uo_mes.em_campo.SetFocus()
 uo_mes.em_campo.text=""
 uo_mes.em_codigo.text=""
END IF


end event

on uo_mes.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_con_contaapun
integer x = 818
integer y = 132
integer width = 384
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Mes"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_contaapun
boolean visible = false
integer x = 27
integer y = 16
integer width = 411
integer height = 136
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_de_un_apunte"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_con_contaapun
integer x = 1938
integer y = 136
integer width = 183
integer height = 160
integer taborder = 2
boolean originalsize = false
string picturename = "print!"
end type

event clicked;call super::clicked;dw_listado.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,Dec(uo_mes.em_codigo.text),uo_origen.em_codigo.text,Dec(em_asiento.text))
f_imprimir_datawindow(dw_listado)

end event

type dw_apuntes from datawindow within w_con_contaapun
event clicked pbm_dwnlbuttonclk
boolean visible = false
integer x = 1477
integer y = 132
integer width = 763
integer height = 788
string dataobject = "dw_con_contaapun3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0     Then return
IF IsNull(row) Then return
em_asiento.text = String(GetItemNumber(row,"asiento"))
uo_mes.em_codigo.text = String(Month(Date(GetItemDateTime(row,"fapunte"))))
uo_mes.em_campo.text  = f_nombre_mes(Dec(uo_mes.em_codigo.text))
This.Reset()
This.visible = FALSE
cb_1.TriggerEvent("clicked")

end event

type pb_1 from upb_salir within w_con_contaapun
integer x = 2702
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
string picturename = "exit!"
end type

