$PBExportHeader$w_list_llamadas.srw
forward
global type w_list_llamadas from w_int_con_empresa
end type
type st_1 from statictext within w_list_llamadas
end type
type pb_1 from upb_salir within w_list_llamadas
end type
type report_con_llamadas1 from datawindow within w_list_llamadas
end type
type pb_imprimir from picturebutton within w_list_llamadas
end type
type uo_provincias from u_marca_lista within w_list_llamadas
end type
type dw_proceso from datawindow within w_list_llamadas
end type
type uo_campanya from u_em_campo_2 within w_list_llamadas
end type
type st_2 from statictext within w_list_llamadas
end type
type em_fdesde from u_em_campo within w_list_llamadas
end type
type em_fhasta from u_em_campo within w_list_llamadas
end type
type st_3 from statictext within w_list_llamadas
end type
end forward

global type w_list_llamadas from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2871
integer height = 1524
st_1 st_1
pb_1 pb_1
report_con_llamadas1 report_con_llamadas1
pb_imprimir pb_imprimir
uo_provincias uo_provincias
dw_proceso dw_proceso
uo_campanya uo_campanya
st_2 st_2
em_fdesde em_fdesde
em_fhasta em_fhasta
st_3 st_3
end type
global w_list_llamadas w_list_llamadas

type variables
string filtro
end variables

event ue_listar;Integer numero,registros,x1,y1
String filtro1
datetime fecha1,fecha2

fecha1=Datetime(Date(String(em_fdesde.Text)))
fecha2=Datetime(Date(String(em_fhasta.Text)))

y1=0
filtro = ""
numero = uo_provincias.dw_marca.RowCount()
IF numero =0 Then return

FOR x1 = 1 To numero
IF uo_provincias.dw_marca.GetItemString(x1,"marca") = "S" THEN
 y1=y1+1
 IF Trim(filtro)=""  Then
  filtro1=" provincia = '" + uo_provincias.dw_marca.GetItemString(x1,"codigo") + "'"
 Else
  filtro1=" Or provincia = '" + uo_provincias.dw_marca.GetItemString(x1,"codigo") + "'"
 End If
 filtro = filtro + filtro1
END IF
NEXT
dw_report.SetFilter("")
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
dw_report.SetTransObject(SQLCA)
dw_report.retrieve(codigo_empresa,uo_campanya.em_codigo.text,fecha1,fecha2)
CALL Super::ue_listar
end event

event open;call super::open;Integer registros,x1
String var_codigo,var_texto,marca

dw_proceso.SetTransObject(SQLCA)

istr_parametros.s_titulo_ventana="Listado llamadas por provincia"
This.title=istr_parametros.s_titulo_ventana

registros=dw_proceso.retrieve(f_pais_empresa(codigo_empresa))

If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"provincia")
  var_texto   = dw_proceso.GetItemString(x1,"nombre")
  marca="S"
  uo_provincias.dw_marca.InsertRow(x1)
  uo_provincias.dw_marca.setitem(x1,"marca",marca)
  uo_provincias.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_provincias.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_provincias.st_titulo1.text="Provincia"
uo_provincias.st_titulo2.text="Nombre"

f_activar_campo(uo_campanya.em_campo)



end event

on w_list_llamadas.create
int iCurrent
call super::create
this.st_1=create st_1
this.pb_1=create pb_1
this.report_con_llamadas1=create report_con_llamadas1
this.pb_imprimir=create pb_imprimir
this.uo_provincias=create uo_provincias
this.dw_proceso=create dw_proceso
this.uo_campanya=create uo_campanya
this.st_2=create st_2
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.report_con_llamadas1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.uo_provincias
this.Control[iCurrent+6]=this.dw_proceso
this.Control[iCurrent+7]=this.uo_campanya
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.em_fdesde
this.Control[iCurrent+10]=this.em_fhasta
this.Control[iCurrent+11]=this.st_3
end on

on w_list_llamadas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.report_con_llamadas1)
destroy(this.pb_imprimir)
destroy(this.uo_provincias)
destroy(this.dw_proceso)
destroy(this.uo_campanya)
destroy(this.st_2)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.st_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_list_llamadas
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_list_llamadas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_list_llamadas
integer width = 2569
end type

type st_1 from statictext within w_list_llamadas
integer x = 27
integer y = 220
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

type pb_1 from upb_salir within w_list_llamadas
integer x = 2656
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type report_con_llamadas1 from datawindow within w_list_llamadas
boolean visible = false
integer x = 46
integer y = 412
integer width = 2702
integer height = 520
boolean bringtotop = true
string dataobject = "report_list_llamadas1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

type pb_imprimir from picturebutton within w_list_llamadas
integer x = 2368
integer y = 204
integer width = 123
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;if trim(uo_campanya.em_campo.text)<>"" then
	
   if Trim(em_fdesde.text)= "00-00-00" or Trim(em_fhasta.text)="00-00-00" then
	   f_mensaje("!Atención¡","Seleccione las fechas")
		f_activar_campo(uo_campanya.em_campo)
		REturn
	End if

  dw_report = report_con_llamadas1
  PArent.TriggerEvent("ue_listar")
End if

f_activar_campo(uo_campanya.em_campo)

end event

type uo_provincias from u_marca_lista within w_list_llamadas
integer x = 343
integer y = 312
integer width = 1431
integer taborder = 70
end type

on uo_provincias.destroy
call u_marca_lista::destroy
end on

type dw_proceso from datawindow within w_list_llamadas
boolean visible = false
integer width = 494
integer height = 104
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_proceso_provincias"
boolean livescroll = true
end type

type uo_campanya from u_em_campo_2 within w_list_llamadas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 347
integer y = 216
integer width = 1426
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

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

on uo_campanya.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_list_llamadas
integer x = 1787
integer y = 160
integer width = 274
integer height = 56
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

type em_fdesde from u_em_campo within w_list_llamadas
integer x = 1787
integer y = 216
integer width = 274
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fhasta from u_em_campo within w_list_llamadas
integer x = 2071
integer y = 216
integer width = 274
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "l"
end type

type st_3 from statictext within w_list_llamadas
integer x = 2071
integer y = 160
integer width = 274
integer height = 56
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

