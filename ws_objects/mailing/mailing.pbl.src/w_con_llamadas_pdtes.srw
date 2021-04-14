$PBExportHeader$w_con_llamadas_pdtes.srw
forward
global type w_con_llamadas_pdtes from w_int_con_empresa
end type
type dw_1 from datawindow within w_con_llamadas_pdtes
end type
type dw_listado from datawindow within w_con_llamadas_pdtes
end type
type pb_2 from upb_imprimir within w_con_llamadas_pdtes
end type
type pb_1 from upb_salir within w_con_llamadas_pdtes
end type
end forward

global type w_con_llamadas_pdtes from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 1568
integer height = 1524
dw_1 dw_1
dw_listado dw_listado
pb_2 pb_2
pb_1 pb_1
end type
global w_con_llamadas_pdtes w_con_llamadas_pdtes

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta llamadas pendientes"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

dw_1.retrieve(codigo_empresa)


end event

on w_con_llamadas_pdtes.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.pb_1
end on

on w_con_llamadas_pdtes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event ue_listar;dw_report  = dw_listado
dw_report.retrieve(codigo_empresa)
CALL Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_llamadas_pdtes
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_llamadas_pdtes
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_llamadas_pdtes
integer x = 18
integer width = 1257
integer height = 92
end type

type dw_1 from datawindow within w_con_llamadas_pdtes
integer x = 183
integer y = 204
integer width = 992
integer height = 1060
integer taborder = 40
string dataobject = "dw_con_llamadas_pdtes"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;long ll_fila_actual

string provincia,revista,columna
integer ordena=0
String is_filtro="" 

ll_fila_actual = Row
This.SelectRow(0,FALSE)
This.SelectRow(ll_fila_actual,TRUE)

columna = dwo.name

CHOOSE CASE columna
	CASE "provincia"
			ordena=1
			provincia = dw_1.GetItemstring(ll_fila_actual,"provincia")
			is_filtro = "provincia = '" + provincia + "' "
	CASE "tipo_revista"
			ordena=1
			revista   = dw_1.GetItemstring(ll_fila_actual,"tipo_revista")
			is_filtro = "tipo_revista = '" + revista + "' "
END CHOOSE

IF ordena=1 THEN
	dw_1.SetFilter(is_filtro)
	dw_1.Filter()
END IF
end event

type dw_listado from datawindow within w_con_llamadas_pdtes
boolean visible = false
integer x = 5
integer width = 489
integer height = 164
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_con_llamadas_pdtes"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_con_llamadas_pdtes
integer x = 1248
integer y = 208
integer width = 123
integer height = 104
integer taborder = 2
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
end event

type pb_1 from upb_salir within w_con_llamadas_pdtes
integer x = 1257
integer width = 119
integer height = 104
integer taborder = 0
boolean bringtotop = true
string picturename = "exit!"
end type

