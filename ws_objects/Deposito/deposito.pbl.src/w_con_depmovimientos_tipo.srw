$PBExportHeader$w_con_depmovimientos_tipo.srw
forward
global type w_con_depmovimientos_tipo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_depmovimientos_tipo
end type
type uo_tipo from u_marca_lista within w_con_depmovimientos_tipo
end type
type dw_proceso from datawindow within w_con_depmovimientos_tipo
end type
type uo_1 from u_manejo_datawindow within w_con_depmovimientos_tipo
end type
type pb_imprimir_preli from picturebutton within w_con_depmovimientos_tipo
end type
type st_8 from statictext within w_con_depmovimientos_tipo
end type
type em_fechadesde from u_em_campo within w_con_depmovimientos_tipo
end type
type st_9 from statictext within w_con_depmovimientos_tipo
end type
type gb_1 from groupbox within w_con_depmovimientos_tipo
end type
type em_fechahasta from u_em_campo within w_con_depmovimientos_tipo
end type
type dw_listado from datawindow within w_con_depmovimientos_tipo
end type
type cb_1 from u_boton within w_con_depmovimientos_tipo
end type
type cb_consulta from u_boton within w_con_depmovimientos_tipo
end type
type gb_2 from groupbox within w_con_depmovimientos_tipo
end type
type dw_1 from datawindow within w_con_depmovimientos_tipo
end type
end forward

global type w_con_depmovimientos_tipo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2912
integer height = 1648
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_tipo uo_tipo
dw_proceso dw_proceso
uo_1 uo_1
pb_imprimir_preli pb_imprimir_preli
st_8 st_8
em_fechadesde em_fechadesde
st_9 st_9
gb_1 gb_1
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_1 cb_1
cb_consulta cb_consulta
gb_2 gb_2
dw_1 dw_1
end type
global w_con_depmovimientos_tipo w_con_depmovimientos_tipo

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_control_tono_calibre ()
public subroutine f_cargar (datawindow dw_data)
end prototypes

public function string f_filtro ();Integer numero,registros,x1,y1
String filtro,filtro1
y1=0
filtro = " "
numero = uo_tipo.dw_marca.RowCount()
IF numero =0 Then return filtro

FOR x1 = 1 To numero
   IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
      y1=y1+1
      IF Trim(filtro) = "" Then
         filtro1 = " depmovhis_tipomov = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
       Else
         filtro1 = " Or depmovhis_tipomov = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      filtro = filtro  + filtro1
		filtro  = "(" + filtro + ")"
   END IF
NEXT

Return filtro

end function

public subroutine f_control_tono_calibre ();// em_tono.enabled    =  TRUE
// em_calibre.enabled =  TRUE
//IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
//  em_tono.enabled    =  FALSE
//  em_tono.text       =  "0"
//END IF
//IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
//  em_calibre.enabled =  FALSE
//  em_calibre.text    =  "0"
//END IF  
end subroutine

public subroutine f_cargar (datawindow dw_data);Integer registros

dw_data.reset()
dw_data.visible   = FALSE
uo_tipo.visible   = FALSE
string is_filtro=""

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

dw_data.SetFilter(f_filtro())
dw_data.Filter()
dw_data.Retrieve(codigo_empresa,fecha1,fecha2)

registros = dw_data.RowCount()
If registros = 0 Then Return

dw_data.visible   = TRUE
end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = "Consulta movimientos deposito por tipo "
f_mascara_columna(dw_1,"tono","##")
f_mascara_columna(dw_1,"calibre","##")

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_1.Setfocus()
Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso.SetTransObject(SQLCA)
registros=dw_proceso.retrieve(codigo_empresa)
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"tipomov")
  var_texto   = dw_proceso.GetItemString(x1,"descripcion")
  marca="S"
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_tipo.st_titulo1.text="Tipo Mov."
uo_tipo.st_titulo2.text="Descripcion"

f_activar_campo(em_fechadesde)


end event

on w_con_depmovimientos_tipo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_tipo=create uo_tipo
this.dw_proceso=create dw_proceso
this.uo_1=create uo_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_8=create st_8
this.em_fechadesde=create em_fechadesde
this.st_9=create st_9
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.cb_consulta=create cb_consulta
this.gb_2=create gb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_tipo
this.Control[iCurrent+3]=this.dw_proceso
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.pb_imprimir_preli
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.st_9
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.em_fechahasta
this.Control[iCurrent+11]=this.dw_listado
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.cb_consulta
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.dw_1
end on

on w_con_depmovimientos_tipo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_tipo)
destroy(this.dw_proceso)
destroy(this.uo_1)
destroy(this.pb_imprimir_preli)
destroy(this.st_8)
destroy(this.em_fechadesde)
destroy(this.st_9)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.cb_consulta)
destroy(this.gb_2)
destroy(this.dw_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_depmovimientos_tipo
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_depmovimientos_tipo
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_depmovimientos_tipo
integer x = 27
integer y = 16
integer width = 2642
end type

type pb_2 from upb_salir within w_con_depmovimientos_tipo
integer x = 2715
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type uo_tipo from u_marca_lista within w_con_depmovimientos_tipo
boolean visible = false
integer x = 1413
integer y = 336
integer width = 1454
integer taborder = 60
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_proceso from datawindow within w_con_depmovimientos_tipo
boolean visible = false
integer x = 320
integer y = 4
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_deptipomov"
boolean livescroll = true
end type

type uo_1 from u_manejo_datawindow within w_con_depmovimientos_tipo
integer x = 2245
integer y = 144
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type pb_imprimir_preli from picturebutton within w_con_depmovimientos_tipo
integer x = 2720
integer y = 188
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
Parent.TriggerEvent("ue_listar")
dw_listado.visible = FALSE
end event

type st_8 from statictext within w_con_depmovimientos_tipo
integer x = 869
integer y = 188
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_depmovimientos_tipo
integer x = 539
integer y = 188
integer width = 279
integer height = 76
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_9 from statictext within w_con_depmovimientos_tipo
integer x = 302
integer y = 188
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_depmovimientos_tipo
integer x = 23
integer y = 120
integer width = 1422
integer height = 168
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type em_fechahasta from u_em_campo within w_con_depmovimientos_tipo
integer x = 1097
integer y = 188
integer width = 279
integer height = 76
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_depmovimientos_tipo
boolean visible = false
integer width = 558
integer height = 148
string dataobject = "report_con_movimientos_tipo_depo"
boolean livescroll = true
end type

type cb_1 from u_boton within w_con_depmovimientos_tipo
integer x = 1522
integer y = 188
integer width = 325
integer height = 84
integer taborder = 40
string text = "&Tipo Mov."
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
dw_1.visible = FALSE
end event

type cb_consulta from u_boton within w_con_depmovimientos_tipo
integer x = 1851
integer y = 188
integer width = 325
integer height = 84
integer taborder = 50
boolean bringtotop = true
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)

end event

type gb_2 from groupbox within w_con_depmovimientos_tipo
integer x = 1504
integer y = 152
integer width = 690
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_1 from datawindow within w_con_depmovimientos_tipo
boolean visible = false
integer x = 23
integer y = 300
integer width = 2825
integer height = 1140
integer taborder = 70
string dataobject = "dw_con_depmovimientos_tipo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

