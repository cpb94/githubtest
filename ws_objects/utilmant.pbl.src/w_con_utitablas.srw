$PBExportHeader$w_con_utitablas.srw
forward
global type w_con_utitablas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_utitablas
end type
type dw_consulta from datawindow within w_con_utitablas
end type
type dw_listado from datawindow within w_con_utitablas
end type
type pb_2 from upb_imprimir within w_con_utitablas
end type
type dw_consulta2 from datawindow within w_con_utitablas
end type
type em_tabla from u_em_campo within w_con_utitablas
end type
type st_1 from statictext within w_con_utitablas
end type
type dw_consulta3 from datawindow within w_con_utitablas
end type
type cb_1 from u_boton within w_con_utitablas
end type
type dw_consulta4 from datawindow within w_con_utitablas
end type
end forward

global type w_con_utitablas from w_int_con_empresa
integer width = 2866
integer height = 1720
pb_1 pb_1
dw_consulta dw_consulta
dw_listado dw_listado
pb_2 pb_2
dw_consulta2 dw_consulta2
em_tabla em_tabla
st_1 st_1
dw_consulta3 dw_consulta3
cb_1 cb_1
dw_consulta4 dw_consulta4
end type
global w_con_utitablas w_con_utitablas

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (decimal id)
end prototypes

public subroutine f_control (decimal id);iF dw_consulta4.visible = TRUE Then Return
dw_consulta2.Retrieve(id)
dw_consulta3.Retrieve(id)



end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta bloqueos"
This.title=istr_parametros.s_titulo_ventana
dw_consulta.SetTransobject(SQLCA)
dw_consulta.SetRowFocusIndicator(Hand!)
dw_consulta2.SetTransobject(SQLCA)
dw_consulta3.SetTransobject(SQLCA)
dw_consulta4.SetTransobject(SQLCA)
dw_listado.SetTransobject(SQLCA)
dw_consulta.Retrieve("%")


end event

on ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve()
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end on

on w_con_utitablas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_consulta=create dw_consulta
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.dw_consulta2=create dw_consulta2
this.em_tabla=create em_tabla
this.st_1=create st_1
this.dw_consulta3=create dw_consulta3
this.cb_1=create cb_1
this.dw_consulta4=create dw_consulta4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_consulta
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_consulta2
this.Control[iCurrent+6]=this.em_tabla
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.dw_consulta3
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_consulta4
end on

on w_con_utitablas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_consulta)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.dw_consulta2)
destroy(this.em_tabla)
destroy(this.st_1)
destroy(this.dw_consulta3)
destroy(this.cb_1)
destroy(this.dw_consulta4)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;IF dw_consulta4.visible = TRUE Then
	f_cursor_abajo(dw_consulta4)
Else
	f_cursor_abajo(dw_consulta)
End If

end event

event ue_cursor_arriba;call super::ue_cursor_arriba;IF dw_consulta4.visible = TRUE Then
		f_cursor_arriba(dw_consulta4)
Else
	f_cursor_arriba(dw_consulta)
End IF
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;IF dw_consulta4.visible = TRUE Then
	f_pagina_abajo(dw_consulta4)
Else
	f_pagina_abajo(dw_consulta)
End If
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;IF dw_consulta4.visible = TRUE Then
	f_pagina_arriba(dw_consulta4)
ELSE
	f_pagina_arriba(dw_consulta)	
END IF
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_utitablas
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_utitablas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_utitablas
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_utitablas
integer x = 2702
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_consulta from datawindow within w_con_utitablas
integer x = 18
integer y = 292
integer width = 1056
integer height = 1108
boolean bringtotop = true
string dataobject = "dw_con_utitablas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return


end event

event rowfocuschanged;Dec id
id = dw_consulta.GetItemNumber(currentRow,"id")
f_control(id)
end event

event retrieveend;IF This.RowCOunt() = 1 Then
Dec id
id = dw_consulta.GetItemNumber(1,"id")
f_control(id)
END IF
end event

type dw_listado from datawindow within w_con_utitablas
boolean visible = false
integer x = 1577
integer y = 140
integer width = 494
integer height = 152
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_con_utitabla"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_con_utitablas
integer x = 37
integer y = 180
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Dec id
id = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"id")
dw_listado.Retrieve(id)
f_imprimir_datawindow(dw_listado)


end event

type dw_consulta2 from datawindow within w_con_utitablas
event clicked pbm_dwnlbuttonclk
integer x = 1083
integer y = 288
integer width = 1719
integer height = 700
boolean bringtotop = true
string dataobject = "dw_con_utitcolumnas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return


end event

type em_tabla from u_em_campo within w_con_utitablas
integer x = 443
integer y = 180
integer width = 997
integer taborder = 10
end type

event modified;call super::modified;dw_consulta.Retrieve("%"+em_tabla.text+"%")
end event

type st_1 from statictext within w_con_utitablas
integer x = 238
integer y = 188
integer width = 197
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tabla"
boolean focusrectangle = false
end type

type dw_consulta3 from datawindow within w_con_utitablas
event clicked pbm_dwnlbuttonclk
integer x = 1083
integer y = 984
integer width = 955
integer height = 416
boolean bringtotop = true
string dataobject = "dw_con_utitindices"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return


end event

type cb_1 from u_boton within w_con_utitablas
integer x = 2053
integer y = 992
integer width = 544
integer height = 92
string text = "&Datos"
end type

event clicked;call super::clicked;

String compuesto,errores,sys
compuesto = "Select * from " + dw_consulta.GetItemString(dw_consulta.GetRow(),"name")
sys = sqlca.SyntaxFromSQL(compuesto ,"Style(Type= grid)",errores)
IF Len(errores) > 0 Then
	f_mensaje("Erro  al generar "," Datawinodw")
END IF

dw_consulta4.Create(sys,errores)
IF Len(errores) > 0 Then
	f_mensaje("Erro  al generar "," Datawinodw")
END IF
dw_consulta.BringToTop = TRUE
dw_consulta4.SetTransObject(SQLCA)
dw_consulta4.Retrieve()
dw_consulta4.visible = True




end event

type dw_consulta4 from datawindow within w_con_utitablas
event clicked pbm_dwnlbuttonclk
boolean visible = false
integer x = 14
integer y = 292
integer width = 2779
integer height = 1124
integer taborder = 40
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return


end event

event doubleclicked;This.visible = False
end event

