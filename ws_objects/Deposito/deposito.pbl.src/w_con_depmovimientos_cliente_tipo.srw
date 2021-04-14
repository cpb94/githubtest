$PBExportHeader$w_con_depmovimientos_cliente_tipo.srw
forward
global type w_con_depmovimientos_cliente_tipo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_depmovimientos_cliente_tipo
end type
type dw_proceso from datawindow within w_con_depmovimientos_cliente_tipo
end type
type em_fechadesde from u_em_campo within w_con_depmovimientos_cliente_tipo
end type
type st_9 from statictext within w_con_depmovimientos_cliente_tipo
end type
type em_fechahasta from u_em_campo within w_con_depmovimientos_cliente_tipo
end type
type cb_1 from u_boton within w_con_depmovimientos_cliente_tipo
end type
type cb_consulta from u_boton within w_con_depmovimientos_cliente_tipo
end type
type gb_2 from groupbox within w_con_depmovimientos_cliente_tipo
end type
type st_10 from statictext within w_con_depmovimientos_cliente_tipo
end type
type uo_cliente from u_em_campo_2 within w_con_depmovimientos_cliente_tipo
end type
type uo_tipo from u_marca_lista within w_con_depmovimientos_cliente_tipo
end type
type dw_1 from datawindow within w_con_depmovimientos_cliente_tipo
end type
type detalle from radiobutton within w_con_depmovimientos_cliente_tipo
end type
type dw_listado from datawindow within w_con_depmovimientos_cliente_tipo
end type
type st_1 from statictext within w_con_depmovimientos_cliente_tipo
end type
type uo_articulo from u_em_campo_2 within w_con_depmovimientos_cliente_tipo
end type
type gb_1 from groupbox within w_con_depmovimientos_cliente_tipo
end type
type uo_1 from u_manejo_datawindow within w_con_depmovimientos_cliente_tipo
end type
type pb_imprimir_preli from picturebutton within w_con_depmovimientos_cliente_tipo
end type
type resumen from radiobutton within w_con_depmovimientos_cliente_tipo
end type
end forward

global type w_con_depmovimientos_cliente_tipo from w_int_con_empresa
integer x = 347
integer y = 4
integer width = 3003
integer height = 2196
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_proceso dw_proceso
em_fechadesde em_fechadesde
st_9 st_9
em_fechahasta em_fechahasta
cb_1 cb_1
cb_consulta cb_consulta
gb_2 gb_2
st_10 st_10
uo_cliente uo_cliente
uo_tipo uo_tipo
dw_1 dw_1
detalle detalle
dw_listado dw_listado
st_1 st_1
uo_articulo uo_articulo
gb_1 gb_1
uo_1 uo_1
pb_imprimir_preli pb_imprimir_preli
resumen resumen
end type
global w_con_depmovimientos_cliente_tipo w_con_depmovimientos_cliente_tipo

type variables
String ante_articulo,retrasos,det="S"
boolean vdetalle = false
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
string  articulo,cliente,almacen_cliente

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

if uo_articulo.em_codigo.text <> "" then
	articulo = uo_articulo.em_codigo.text
else
	articulo = "%"
end if
if uo_cliente.em_codigo.text <> "" then
	cliente = uo_cliente.em_codigo.text
	almacen_cliente = f_depalmacen_cliente(codigo_empresa,cliente)
else
	almacen_cliente = "%"
end if

dw_data.SetFilter(f_filtro())
dw_data.Filter()
dw_data.Retrieve(codigo_empresa,fecha1,fecha2,almacen_cliente,articulo)

registros = dw_data.RowCount()
If registros = 0 Then Return

dw_data.visible   = TRUE
end subroutine

event ue_listar;
dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = "Consulta movimientos deposito por Ciente/tipo "
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

f_activar_campo(uo_cliente.em_campo)


end event

on w_con_depmovimientos_cliente_tipo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
this.em_fechadesde=create em_fechadesde
this.st_9=create st_9
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.cb_consulta=create cb_consulta
this.gb_2=create gb_2
this.st_10=create st_10
this.uo_cliente=create uo_cliente
this.uo_tipo=create uo_tipo
this.dw_1=create dw_1
this.detalle=create detalle
this.dw_listado=create dw_listado
this.st_1=create st_1
this.uo_articulo=create uo_articulo
this.gb_1=create gb_1
this.uo_1=create uo_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.resumen=create resumen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_9
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_consulta
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.st_10
this.Control[iCurrent+10]=this.uo_cliente
this.Control[iCurrent+11]=this.uo_tipo
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.detalle
this.Control[iCurrent+14]=this.dw_listado
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.uo_articulo
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.uo_1
this.Control[iCurrent+19]=this.pb_imprimir_preli
this.Control[iCurrent+20]=this.resumen
end on

on w_con_depmovimientos_cliente_tipo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_proceso)
destroy(this.em_fechadesde)
destroy(this.st_9)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.cb_consulta)
destroy(this.gb_2)
destroy(this.st_10)
destroy(this.uo_cliente)
destroy(this.uo_tipo)
destroy(this.dw_1)
destroy(this.detalle)
destroy(this.dw_listado)
destroy(this.st_1)
destroy(this.uo_articulo)
destroy(this.gb_1)
destroy(this.uo_1)
destroy(this.pb_imprimir_preli)
destroy(this.resumen)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_depmovimientos_cliente_tipo
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_depmovimientos_cliente_tipo
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_depmovimientos_cliente_tipo
integer y = 8
integer width = 1669
end type

type pb_2 from upb_salir within w_con_depmovimientos_cliente_tipo
integer x = 2798
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_proceso from datawindow within w_con_depmovimientos_cliente_tipo
boolean visible = false
integer x = 466
integer y = 4
integer width = 480
integer height = 92
boolean bringtotop = true
string dataobject = "dw_proceso_deptipomov"
boolean livescroll = true
end type

type em_fechadesde from u_em_campo within w_con_depmovimientos_cliente_tipo
integer x = 219
integer y = 244
integer width = 279
integer height = 80
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_9 from statictext within w_con_depmovimientos_cliente_tipo
integer x = 27
integer y = 244
integer width = 192
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_depmovimientos_cliente_tipo
integer x = 517
integer y = 244
integer width = 279
integer height = 80
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from u_boton within w_con_depmovimientos_cliente_tipo
integer x = 1984
integer y = 176
integer width = 325
integer height = 72
integer taborder = 50
string facename = "Arial"
string text = "&Tipo Mov."
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
dw_1.visible = FALSE
end event

type cb_consulta from u_boton within w_con_depmovimientos_cliente_tipo
integer x = 1984
integer y = 248
integer width = 325
integer height = 72
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)

end event

type gb_2 from groupbox within w_con_depmovimientos_cliente_tipo
integer x = 1970
integer y = 140
integer width = 352
integer height = 192
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_10 from statictext within w_con_depmovimientos_cliente_tipo
integer x = 18
integer y = 152
integer width = 219
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_con_depmovimientos_cliente_tipo
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 238
integer y = 148
integer width = 1627
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo     = "Selección de Clientes"
ue_datawindow = "dw_ayuda_clientes_deposito"
ue_filtro     = ""
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type uo_tipo from u_marca_lista within w_con_depmovimientos_cliente_tipo
boolean visible = false
integer x = 1472
integer y = 352
integer taborder = 70
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_1 from datawindow within w_con_depmovimientos_cliente_tipo
boolean visible = false
integer x = 9
integer y = 352
integer width = 2939
integer height = 1612
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_con_depmovimientos_cliente_tipo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//if vdetalle then
//	this.modify("datawindow.detail.height = 72")
//else
//	this.modify("datawindow.detail.height = 144")
//end if
//vdetalle = not(vdetalle)
end event

type detalle from radiobutton within w_con_depmovimientos_cliente_tipo
event clicked pbm_bnclicked
integer x = 2661
integer y = 108
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Detalle"
boolean checked = true
end type

event clicked;det = "S"
dw_1.Modify("DataWindow.Detail.Height=18")


end event

type dw_listado from datawindow within w_con_depmovimientos_cliente_tipo
boolean visible = false
integer x = 2258
integer width = 87
integer height = 92
string dataobject = "report_con_movimientos_cliente_tipo"
boolean livescroll = true
end type

type st_1 from statictext within w_con_depmovimientos_cliente_tipo
integer x = 823
integer y = 252
integer width = 215
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_con_depmovimientos_cliente_tipo
integer x = 1042
integer y = 244
integer width = 823
integer height = 80
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
uo_articulo.em_campo.text = Trim(f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text))
IF Trim(uo_articulo.em_campo.text)="" THEN 
	IF Trim(uo_articulo.em_codigo.text)<>"" Then 
		uo_articulo.em_campo.SetFocus()
	END IF
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type gb_1 from groupbox within w_con_depmovimientos_cliente_tipo
integer x = 9
integer y = 100
integer width = 1874
integer height = 248
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_1 from u_manejo_datawindow within w_con_depmovimientos_cliente_tipo
integer x = 2322
integer y = 184
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type pb_imprimir_preli from picturebutton within w_con_depmovimientos_cliente_tipo
integer x = 2798
integer y = 232
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

event clicked;if det="S" then
	dw_listado.DataObject="report_con_movimientos_cliente_tipo"
else
	dw_listado.DataObject="report_con_movtos_cliente_tipo_resumen"
end if


f_cargar(dw_listado)
Parent.TriggerEvent("ue_listar")
dw_listado.visible = FALSE
end event

type resumen from radiobutton within w_con_depmovimientos_cliente_tipo
event clicked pbm_bnclicked
integer x = 2313
integer y = 104
integer width = 325
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Resumen"
end type

event clicked;det = "N"
dw_1.Modify("DataWindow.Detail.Height=0")


end event

