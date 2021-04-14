$PBExportHeader$w_con_utiincidencias.srw
forward
global type w_con_utiincidencias from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_utiincidencias
end type
type dw_consulta from datawindow within w_con_utiincidencias
end type
type dw_listado from datawindow within w_con_utiincidencias
end type
type pb_2 from upb_imprimir within w_con_utiincidencias
end type
type cb_consultar from u_boton within w_con_utiincidencias
end type
type cb_borrar from u_boton within w_con_utiincidencias
end type
type st_2 from statictext within w_con_utiincidencias
end type
type sle_programa from singlelineedit within w_con_utiincidencias
end type
type st_3 from statictext within w_con_utiincidencias
end type
end forward

global type w_con_utiincidencias from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 4489
integer height = 2316
pb_1 pb_1
dw_consulta dw_consulta
dw_listado dw_listado
pb_2 pb_2
cb_consultar cb_consultar
cb_borrar cb_borrar
st_2 st_2
sle_programa sle_programa
st_3 st_3
end type
global w_con_utiincidencias w_con_utiincidencias

type variables
string filtro
end variables

on open;call w_int_con_empresa::open;istr_parametros.s_titulo_ventana="Consulta incidencias"
This.title=istr_parametros.s_titulo_ventana
dw_consulta.SetTransobject(SQLCA)
cb_consultar.TriggerEvent(Clicked!)


end on

on ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve()
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end on

on w_con_utiincidencias.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_consulta=create dw_consulta
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.cb_consultar=create cb_consultar
this.cb_borrar=create cb_borrar
this.st_2=create st_2
this.sle_programa=create sle_programa
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_consulta
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.cb_consultar
this.Control[iCurrent+6]=this.cb_borrar
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.sle_programa
this.Control[iCurrent+9]=this.st_3
end on

on w_con_utiincidencias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_consulta)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.cb_consultar)
destroy(this.cb_borrar)
destroy(this.st_2)
destroy(this.sle_programa)
destroy(this.st_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_utiincidencias
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_utiincidencias
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_utiincidencias
integer x = 32
integer width = 2427
end type

type pb_1 from upb_salir within w_con_utiincidencias
integer x = 2688
integer y = 4
integer width = 119
integer height = 104
integer taborder = 0
end type

type dw_consulta from datawindow within w_con_utiincidencias
integer x = 14
integer y = 284
integer width = 4366
integer height = 1768
boolean bringtotop = true
string dataobject = "dw_con_utiincidencias"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return


end event

type dw_listado from datawindow within w_con_utiincidencias
boolean visible = false
integer x = 3022
integer y = 12
integer width = 494
integer height = 152
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_utiincidencias"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_con_utiincidencias
integer x = 3419
integer y = 160
integer taborder = 30
end type

event clicked;call super::clicked;PArent.triggerEvent("ue_listar")

end event

type cb_consultar from u_boton within w_con_utiincidencias
integer x = 2999
integer y = 164
integer height = 92
integer taborder = 10
string text = "&Consultar"
end type

event clicked;call super::clicked;string programa 

if sle_programa.text = '' or isnull(sle_programa.text) then
	programa = '%'
else
	programa = sle_programa.text
end if
	
dw_consulta.Retrieve(programa)
end event

type cb_borrar from u_boton within w_con_utiincidencias
integer x = 18
integer y = 176
integer width = 622
integer height = 92
integer taborder = 20
string text = "&Borrar incidencias"
end type

event clicked;call super::clicked;Integer opcion
string programa 

if sle_programa.text = '' or isnull(sle_programa.text) then
	programa = '%'
else
	programa = sle_programa.text
end if

opcion = messageBox("Proceso borrado de bloqueos","Desea Borrar las incidencias?",Question!, YesNo!,2)

IF opcion=2 Then Return
If opcion=1 Then
// Delete from utiincidencias;
 // David 19-09-03
 Delete from utiincidencias
 where programa like :programa;
 // Fin David 19-09-03
 COMMIT;
END IF
cb_consultar.TriggerEvent(clicked!)
end event

type st_2 from statictext within w_con_utiincidencias
integer x = 686
integer y = 188
integer width = 325
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Programa:"
boolean focusrectangle = false
end type

type sle_programa from singlelineedit within w_con_utiincidencias
integer x = 1010
integer y = 184
integer width = 773
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
end type

type st_3 from statictext within w_con_utiincidencias
integer x = 1047
integer y = 128
integer width = 699
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32768
long backcolor = 67108864
string text = "( % --> Cualquier Carácter)"
boolean focusrectangle = false
end type

