$PBExportHeader$w_con_llamadas.srw
$PBExportComments$Consulta llamadas mailing.
forward
global type w_con_llamadas from w_int_con_empresa
end type
type cb_1 from u_boton within w_con_llamadas
end type
type st_1 from statictext within w_con_llamadas
end type
type pb_1 from upb_salir within w_con_llamadas
end type
type cb_2 from u_boton within w_con_llamadas
end type
type cb_3 from u_boton within w_con_llamadas
end type
type report_con_llamadas1 from datawindow within w_con_llamadas
end type
type report_con_llamadas2 from datawindow within w_con_llamadas
end type
type report_con_llamadas3 from datawindow within w_con_llamadas
end type
type pb_imprimir from picturebutton within w_con_llamadas
end type
type uo_campanya from u_em_campo_2 within w_con_llamadas
end type
type em_fdesde from u_em_campo within w_con_llamadas
end type
type em_fhasta from u_em_campo within w_con_llamadas
end type
type st_2 from statictext within w_con_llamadas
end type
type st_3 from statictext within w_con_llamadas
end type
type gb_1 from groupbox within w_con_llamadas
end type
type dw_1 from datawindow within w_con_llamadas
end type
type dw_2 from datawindow within w_con_llamadas
end type
type dw_4 from datawindow within w_con_llamadas
end type
type dw_3 from datawindow within w_con_llamadas
end type
end forward

global type w_con_llamadas from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2930
integer height = 1664
cb_1 cb_1
st_1 st_1
pb_1 pb_1
cb_2 cb_2
cb_3 cb_3
report_con_llamadas1 report_con_llamadas1
report_con_llamadas2 report_con_llamadas2
report_con_llamadas3 report_con_llamadas3
pb_imprimir pb_imprimir
uo_campanya uo_campanya
em_fdesde em_fdesde
em_fhasta em_fhasta
st_2 st_2
st_3 st_3
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_4 dw_4
dw_3 dw_3
end type
global w_con_llamadas w_con_llamadas

type variables
string filtro
end variables

event ue_listar;dw_report.SetTransObject(SQLCA)

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fdesde.Text)))
fecha2=Datetime(Date(String(em_fhasta.Text)))

dw_report.retrieve(codigo_empresa,uo_campanya.em_codigo.text,fecha1,fecha2)

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta llamadas"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)
dw_4.SetTransObject(SQLCA)

f_activar_campo(uo_campanya.em_campo)
end event

on w_con_llamadas.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.pb_1=create pb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.report_con_llamadas1=create report_con_llamadas1
this.report_con_llamadas2=create report_con_llamadas2
this.report_con_llamadas3=create report_con_llamadas3
this.pb_imprimir=create pb_imprimir
this.uo_campanya=create uo_campanya
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.st_2=create st_2
this.st_3=create st_3
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_4=create dw_4
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.report_con_llamadas1
this.Control[iCurrent+7]=this.report_con_llamadas2
this.Control[iCurrent+8]=this.report_con_llamadas3
this.Control[iCurrent+9]=this.pb_imprimir
this.Control[iCurrent+10]=this.uo_campanya
this.Control[iCurrent+11]=this.em_fdesde
this.Control[iCurrent+12]=this.em_fhasta
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.dw_1
this.Control[iCurrent+17]=this.dw_2
this.Control[iCurrent+18]=this.dw_4
this.Control[iCurrent+19]=this.dw_3
end on

on w_con_llamadas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.report_con_llamadas1)
destroy(this.report_con_llamadas2)
destroy(this.report_con_llamadas3)
destroy(this.pb_imprimir)
destroy(this.uo_campanya)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.dw_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_llamadas
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_llamadas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_llamadas
integer x = 18
integer width = 2647
integer height = 92
end type

type cb_1 from u_boton within w_con_llamadas
integer x = 2089
integer y = 260
integer width = 430
integer height = 52
integer taborder = 60
integer textsize = -7
string facename = "Small Fonts"
string text = "&Consultar"
end type

event clicked;call super::clicked;if Trim(uo_campanya.em_campo.text)<>"" then
  	if Trim(em_fdesde.text)= "00-00-00" or Trim(em_fhasta.text)="00-00-00" then
	   f_mensaje("!Atención¡","Seleccione las fechas")
		f_activar_campo(uo_campanya.em_campo)
		REturn
	End if

	dw_2.visible= false
	dw_1.visible= true
	
	datetime fecha1,fecha2
	
	fecha1=Datetime(Date(String(em_fdesde.Text)))
	fecha2=Datetime(Date(String(em_fhasta.Text)))
	
	dw_1.retrieve(codigo_empresa,uo_campanya.em_codigo.text,fecha1,fecha2)
	string is_filtro=""
	dw_1.SetFilter(is_filtro)
	dw_1.Filter()
	dw_report       = report_con_llamadas1
	pb_imprimir.visible =TRUE
End if
f_activar_campo(uo_campanya.em_campo)

end event

type st_1 from statictext within w_con_llamadas
integer x = 14
integer y = 228
integer width = 311
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Campaña:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_con_llamadas
integer x = 2757
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type cb_2 from u_boton within w_con_llamadas
integer x = 2089
integer y = 156
integer width = 430
integer height = 52
integer taborder = 40
integer textsize = -7
string facename = "Small Fonts"
string text = "&Pastel Revistas"
end type

event clicked;call super::clicked;if trim(uo_campanya.em_campo.text)<>"" then
	
   if Trim(em_fdesde.text)= "00-00-00" or Trim(em_fhasta.text)="00-00-00" then
	   f_mensaje("!Atención¡","Seleccione las fechas")
		f_activar_campo(uo_campanya.em_campo)
		REturn
	End if

	datetime fecha1,fecha2
	
	fecha1=Datetime(Date(String(em_fdesde.Text)))
	fecha2=Datetime(Date(String(em_fhasta.Text)))

	dw_2.visible= true	
	dw_3.visible=false
	dw_1.visible= False
	dw_2.retrieve(codigo_empresa,uo_campanya.em_codigo.text,fecha1,fecha2)
	dw_report       = report_con_llamadas2
	pb_imprimir.visible =TRUE

End if

f_activar_campo(uo_campanya.em_campo)

end event

type cb_3 from u_boton within w_con_llamadas
integer x = 2089
integer y = 208
integer width = 430
integer height = 52
integer taborder = 50
integer textsize = -7
string facename = "Small Fonts"
string text = "P&or Provincias"
end type

event clicked;call super::clicked;if Trim(uo_campanya.em_campo.text)<>"" then

	if Trim(em_fdesde.text)= "00-00-00" or Trim(em_fhasta.text)="00-00-00" then
	   f_mensaje("!Atención¡","Seleccione las fechas")
		f_activar_campo(uo_campanya.em_campo)
		REturn
	End if

	datetime fecha1,fecha2
	
	fecha1=Datetime(Date(String(em_fdesde.Text)))
	fecha2=Datetime(Date(String(em_fhasta.Text)))

	dw_2.visible= False
	dw_1.visible= False
	dw_3.visible =True
	dw_3.retrieve(codigo_empresa,uo_campanya.em_codigo.text,fecha1,fecha2)
	dw_report       = report_con_llamadas3
	pb_imprimir.visible =TRUE

End if

f_activar_campo(uo_campanya.em_campo)

end event

type report_con_llamadas1 from datawindow within w_con_llamadas
boolean visible = false
integer x = 18
integer y = 4
integer width = 416
integer height = 104
boolean bringtotop = true
string dataobject = "report_con_llamadas1"
boolean livescroll = true
end type

type report_con_llamadas2 from datawindow within w_con_llamadas
boolean visible = false
integer x = 448
integer y = 8
integer width = 402
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_llamadas2"
boolean livescroll = true
end type

type report_con_llamadas3 from datawindow within w_con_llamadas
boolean visible = false
integer x = 864
integer y = 4
integer width = 421
integer height = 88
integer taborder = 100
boolean bringtotop = true
string dataobject = "report_con_llamadas3"
boolean livescroll = true
end type

type pb_imprimir from picturebutton within w_con_llamadas
boolean visible = false
integer x = 2560
integer y = 220
integer width = 123
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "\bmp\print.bmp"
end type

event clicked;Parent.TriggerEvent("ue_listar")
f_activar_campo(uo_campanya.em_campo)
end event

type uo_campanya from u_em_campo_2 within w_con_llamadas
integer x = 334
integer y = 224
integer width = 1065
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_campanya.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_campanya.em_campo.text=f_nombre_campanya(codigo_empresa,uo_campanya.em_codigo.text)
IF Trim(uo_campanya.em_campo.text)="" THEN 
 IF Trim(uo_campanya.em_codigo.text)<>"" Then uo_campanya.em_campo.SetFocus()
 uo_campanya.em_campo.text=""
 uo_campanya.em_codigo.text=""
 Return	
END IF

datetime fdesde,fhasta

SELECT mcampanya.fdesde,   
		mcampanya.fhasta  
 INTO :fdesde,   
		:fhasta  
 FROM mcampanya  
WHERE ( mcampanya.empresa = :codigo_empresa ) AND  
		( mcampanya.codigo = :uo_campanya.em_codigo.text )   ;

em_fdesde.text = string(fdesde,"dd-mm-yy")
em_fhasta.text = string(fhasta,"dd-mm-yy")

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion campañas"
ue_datawindow = "dw_ayuda_mcampanya"
ue_filtro     = ""
valor_empresa = True

end event

type em_fdesde from u_em_campo within w_con_llamadas
integer x = 1463
integer y = 224
integer width = 283
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fhasta from u_em_campo within w_con_llamadas
integer x = 1751
integer y = 224
integer width = 283
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "l"
end type

type st_2 from statictext within w_con_llamadas
integer x = 1463
integer y = 168
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_llamadas
integer x = 1751
integer y = 168
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_llamadas
integer x = 2075
integer y = 128
integer width = 457
integer height = 196
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
end type

type dw_1 from datawindow within w_con_llamadas
boolean visible = false
integer x = 9
integer y = 332
integer width = 2834
integer height = 1104
integer taborder = 90
string dataobject = "dw_con_llamadas3"
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
			filtro = "provincia = '" + provincia + "' "
	CASE "tipo_revista"
			ordena=1
			revista   = dw_1.GetItemstring(ll_fila_actual,"tipo_revista")
			filtro = "tipo_revista = '" + revista + "' "
END CHOOSE

IF ordena=1 THEN
	dw_1.SetFilter(filtro)
	dw_1.Filter()
END IF
end event

type dw_2 from datawindow within w_con_llamadas
boolean visible = false
integer x = 18
integer y = 336
integer width = 2821
integer height = 1092
string dataobject = "dw_con_llamadas2"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_4 from datawindow within w_con_llamadas
boolean visible = false
integer x = 1422
integer y = 340
integer width = 1422
integer height = 1072
boolean titlebar = true
string title = "Detalle llamadas por provincia."
string dataobject = "dw_con_llamadas6"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_con_llamadas
boolean visible = false
integer x = 18
integer y = 340
integer width = 1403
integer height = 1072
boolean titlebar = true
string title = "Resumen llamadas por Provincia"
string dataobject = "dw_con_llamadas4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;If Row = 0 Then Return
dw_4.visible = TRUE

datetime fecha1,fecha2
	
fecha1=Datetime(Date(String(em_fdesde.Text)))
fecha2=Datetime(Date(String(em_fhasta.Text)))

dw_4.retrieve(codigo_empresa,uo_campanya.em_codigo.text,This.GetItemString(Row,"provincia"),fecha1,fecha2)
end event

