$PBExportHeader$w_con_movimientos_tipo.srw
$PBExportComments$Movimientos de un artículo en el almacén
forward
global type w_con_movimientos_tipo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_movimientos_tipo
end type
type uo_tipo from u_marca_lista within w_con_movimientos_tipo
end type
type dw_proceso from datawindow within w_con_movimientos_tipo
end type
type uo_1 from u_manejo_datawindow within w_con_movimientos_tipo
end type
type pb_imprimir_preli from picturebutton within w_con_movimientos_tipo
end type
type dw_1 from datawindow within w_con_movimientos_tipo
end type
type st_8 from statictext within w_con_movimientos_tipo
end type
type em_fechadesde from u_em_campo within w_con_movimientos_tipo
end type
type st_9 from statictext within w_con_movimientos_tipo
end type
type gb_1 from groupbox within w_con_movimientos_tipo
end type
type em_fechahasta from u_em_campo within w_con_movimientos_tipo
end type
type cb_1 from u_boton within w_con_movimientos_tipo
end type
type cb_consulta from u_boton within w_con_movimientos_tipo
end type
type gb_2 from groupbox within w_con_movimientos_tipo
end type
type dw_almlinubicahis from datawindow within w_con_movimientos_tipo
end type
type dw_listado from datawindow within w_con_movimientos_tipo
end type
type agrupar from checkbox within w_con_movimientos_tipo
end type
end forward

global type w_con_movimientos_tipo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2953
integer height = 2244
string title = "Consulta movimientos por tipos entre fechas"
pb_2 pb_2
uo_tipo uo_tipo
dw_proceso dw_proceso
uo_1 uo_1
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
st_8 st_8
em_fechadesde em_fechadesde
st_9 st_9
gb_1 gb_1
em_fechahasta em_fechahasta
cb_1 cb_1
cb_consulta cb_consulta
gb_2 gb_2
dw_almlinubicahis dw_almlinubicahis
dw_listado dw_listado
agrupar agrupar
end type
global w_con_movimientos_tipo w_con_movimientos_tipo

type variables
STRING  tipos[]
boolean v_agrupar = false
boolean i_agrupar = false
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
end prototypes

public function string f_filtro ();Integer numero,registros,x1,y1
String filtro,filtro1

y1=0
filtro = " "
numero = uo_tipo.dw_marca.RowCount()
IF numero =0 Then return filtro


tipos={""}

FOR x1 = 1 To numero
   IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
		tipos[x1] = uo_tipo.dw_marca.GetItemString(x1,"codigo")
      y1=y1+1
      IF Trim(filtro) = "" Then
         filtro1 = " tipomov = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
       Else
         filtro1 = " Or tipomov = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      filtro = filtro  + filtro1
		filtro  = "(" + filtro + ")"
   END IF
NEXT

Return filtro

end function

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

f_filtro()
dw_data.Filter()

dw_data.Retrieve(codigo_empresa,fecha1,fecha2,tipos[])

registros = dw_data.RowCount()
If registros = 0 Then Return

dw_data.visible   = TRUE
end subroutine

event ue_listar;//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = "Consulta movimientos por tipos entre fechas"
f_mascara_columna(dw_1,"tono","##")
f_mascara_columna(dw_1,"calibre","##")

em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())
dw_1.Setfocus()
Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
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

on w_con_movimientos_tipo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_tipo=create uo_tipo
this.dw_proceso=create dw_proceso
this.uo_1=create uo_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.st_8=create st_8
this.em_fechadesde=create em_fechadesde
this.st_9=create st_9
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.cb_consulta=create cb_consulta
this.gb_2=create gb_2
this.dw_almlinubicahis=create dw_almlinubicahis
this.dw_listado=create dw_listado
this.agrupar=create agrupar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_tipo
this.Control[iCurrent+3]=this.dw_proceso
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.pb_imprimir_preli
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.st_8
this.Control[iCurrent+8]=this.em_fechadesde
this.Control[iCurrent+9]=this.st_9
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.em_fechahasta
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.cb_consulta
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.dw_almlinubicahis
this.Control[iCurrent+16]=this.dw_listado
this.Control[iCurrent+17]=this.agrupar
end on

on w_con_movimientos_tipo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_tipo)
destroy(this.dw_proceso)
destroy(this.uo_1)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.st_8)
destroy(this.em_fechadesde)
destroy(this.st_9)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.cb_consulta)
destroy(this.gb_2)
destroy(this.dw_almlinubicahis)
destroy(this.dw_listado)
destroy(this.agrupar)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_movimientos_tipo
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_movimientos_tipo
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_movimientos_tipo
integer x = 27
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_movimientos_tipo
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type uo_tipo from u_marca_lista within w_con_movimientos_tipo
boolean visible = false
integer x = 1431
integer y = 332
integer width = 1454
integer taborder = 60
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_proceso from datawindow within w_con_movimientos_tipo
boolean visible = false
integer x = 320
integer y = 8
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_almtipomov"
boolean livescroll = true
end type

type uo_1 from u_manejo_datawindow within w_con_movimientos_tipo
integer x = 2245
integer y = 144
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type pb_imprimir_preli from picturebutton within w_con_movimientos_tipo
integer x = 2720
integer y = 188
integer width = 105
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;if agrupar.checked then
	if not i_agrupar then
		i_agrupar = true
		dw_listado.dataobject ="report_con_movimientos_tipo2"
		dw_listado.settransobject(sqlca)
	end if
else
	if i_agrupar then
		i_agrupar = false
		dw_listado.dataobject ="report_con_movimientos_tipo"
		dw_listado.settransobject(sqlca)
	end if
end if

f_cargar(dw_listado)
//Parent.TriggerEvent("ue_listar")
f_imprimir_datawindow(dw_listado)
dw_listado.visible = FALSE
end event

type dw_1 from datawindow within w_con_movimientos_tipo
integer x = 14
integer y = 312
integer width = 2862
integer height = 1688
integer taborder = 70
string dataobject = "dw_con_movimientos_tipo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row<>0 THEN
 integer registros
 dec vanyo,vnummov
 string valmacen
 registros = dw_1.RowCount()
 IF registros>0 THEN
 This.SelectRow(0,FALSE)
 This.SelectRow(row,TRUE)
 
  vanyo    =  GetItemNumber(row,"anyo")
  valmacen =  GetItemString(row,"almacen")
  vnummov  =  GetItemNumber(row,"nummov")
  dw_almlinubicahis.SetTransObject(SQLCA)
  dw_almlinubicahis.retrieve(codigo_empresa,vanyo,valmacen,vnummov)
  dw_almlinubicahis.visible=true
 END IF
END IF
end event

type st_8 from statictext within w_con_movimientos_tipo
integer x = 741
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

type em_fechadesde from u_em_campo within w_con_movimientos_tipo
integer x = 411
integer y = 188
integer width = 279
integer height = 76
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_9 from statictext within w_con_movimientos_tipo
integer x = 174
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

type gb_1 from groupbox within w_con_movimientos_tipo
integer x = 23
integer y = 120
integer width = 1298
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

type em_fechahasta from u_em_campo within w_con_movimientos_tipo
integer x = 969
integer y = 188
integer width = 279
integer height = 76
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from u_boton within w_con_movimientos_tipo
integer x = 1358
integer y = 192
integer width = 325
integer height = 84
integer taborder = 40
string text = "&Tipo Mov."
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
dw_1.visible = FALSE
end event

type cb_consulta from u_boton within w_con_movimientos_tipo
integer x = 1687
integer y = 192
integer width = 325
integer height = 84
integer taborder = 50
boolean bringtotop = true
string text = "&Consulta"
end type

event clicked;if agrupar.checked then
	if not v_agrupar then
		v_agrupar = true
		dw_1.dataobject ="dw_con_movimientos_tipo2"
		dw_1.settransobject(sqlca)
	end if
else
	if v_agrupar then
		v_agrupar = false
		dw_1.dataobject ="dw_con_movimientos_tipo"
		dw_1.settransobject(sqlca)
	end if
end if

f_cargar(dw_1)

end event

type gb_2 from groupbox within w_con_movimientos_tipo
integer x = 1339
integer y = 156
integer width = 690
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_almlinubicahis from datawindow within w_con_movimientos_tipo
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
boolean visible = false
integer x = 18
integer y = 312
integer width = 1358
integer height = 684
integer taborder = 2
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle ubicación de la linea "
string dataobject = "dw_int_movimientos_tipo"
boolean controlmenu = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type dw_listado from datawindow within w_con_movimientos_tipo
boolean visible = false
integer x = 69
integer y = 4
integer width = 174
integer height = 224
boolean bringtotop = true
string dataobject = "report_con_movimientos_tipo"
boolean livescroll = true
end type

type agrupar from checkbox within w_con_movimientos_tipo
integer x = 1339
integer y = 128
integer width = 709
integer height = 48
boolean bringtotop = true
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Agrupar por familia y formato"
end type

