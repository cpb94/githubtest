$PBExportHeader$w_con_pedidos_por_cantidad_y_g2.srw
forward
global type w_con_pedidos_por_cantidad_y_g2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_por_cantidad_y_g2
end type
type pb_2 from upb_imprimir within w_con_pedidos_por_cantidad_y_g2
end type
type dw_detalle from datawindow within w_con_pedidos_por_cantidad_y_g2
end type
type em_fechadesde from u_em_campo within w_con_pedidos_por_cantidad_y_g2
end type
type em_fechahasta from u_em_campo within w_con_pedidos_por_cantidad_y_g2
end type
type cb_1 from commandbutton within w_con_pedidos_por_cantidad_y_g2
end type
type gb_5 from groupbox within w_con_pedidos_por_cantidad_y_g2
end type
type gb_1 from groupbox within w_con_pedidos_por_cantidad_y_g2
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_por_cantidad_y_g2
end type
type gb_3 from groupbox within w_con_pedidos_por_cantidad_y_g2
end type
type st_1 from statictext within w_con_pedidos_por_cantidad_y_g2
end type
type uo_series from u_marca_lista within w_con_pedidos_por_cantidad_y_g2
end type
type cb_2 from commandbutton within w_con_pedidos_por_cantidad_y_g2
end type
type sle_cantidad1 from singlelineedit within w_con_pedidos_por_cantidad_y_g2
end type
type sle_cantidad2 from singlelineedit within w_con_pedidos_por_cantidad_y_g2
end type
type st_2 from statictext within w_con_pedidos_por_cantidad_y_g2
end type
type uo_g2 from u_em_campo_2 within w_con_pedidos_por_cantidad_y_g2
end type
type gb_6 from groupbox within w_con_pedidos_por_cantidad_y_g2
end type
type gb_2 from groupbox within w_con_pedidos_por_cantidad_y_g2
end type
type gb_7 from groupbox within w_con_pedidos_por_cantidad_y_g2
end type
end forward

global type w_con_pedidos_por_cantidad_y_g2 from w_int_con_empresa
integer width = 3502
integer height = 2832
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_5 gb_5
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
uo_series uo_series
cb_2 cb_2
sle_cantidad1 sle_cantidad1
sle_cantidad2 sle_cantidad2
st_2 st_2
uo_g2 uo_g2
gb_6 gb_6
gb_2 gb_2
gb_7 gb_7
end type
global w_con_pedidos_por_cantidad_y_g2 w_con_pedidos_por_cantidad_y_g2

type variables
boolean detalle = true,valorado = true,muestras = false
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();long     i,indice_ser
Datetime fecha1,fecha2
String   series[1 to 20],cliente, filtro, nombre_empresa, restriccion_g2
dec cantidad1, cantidad2

dw_detalle.Reset()
uo_series.visible = false

fecha1 = Datetime(Date(String(em_fechadesde.Text)))
fecha2 = Datetime(Date(String(em_fechahasta.Text)))

indice_ser = 1
for i=1 to uo_series.dw_marca.rowcount()
	if uo_series.dw_marca.getitemstring(i,"marca")="S" then
		series[indice_ser] = uo_series.dw_marca.getitemstring(i,"codigo")
		indice_ser ++
	end if	
next

if uo_cliente.em_codigo.text <> "" then
	cliente = uo_cliente.em_codigo.text
else
	cliente = "%"
end if

cantidad1 = dec (sle_cantidad1.text)
cantidad2 = dec (sle_cantidad2.text)

if uo_g2.em_campo.text <> "" and not isnull(uo_g2.em_campo.text) then
	restriccion_g2 = "(art_codestadistico_g2 = '"+uo_g2.em_campo.text+"')"
else
	restriccion_g2 = '1=1' // Codición que siempre se cumplirá
end if

filtro = restriccion_g2
dw_detalle.SetFilter(filtro)
dw_detalle.Filter()

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series, cantidad1, cantidad2)


select nombre
into :nombre_empresa
from empresas
where empresa = :codigo_empresa;


dw_detalle.object.titulo.text = nombre_empresa
dw_detalle.object.cliente.text = uo_cliente.em_campo.text




end subroutine

event close;call super::close;dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Pedidos por Cantidad y G2"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
sle_cantidad1.text = '0'
sle_cantidad2.text = '999999'

end event

on w_con_pedidos_por_cantidad_y_g2.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_5=create gb_5
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.st_1=create st_1
this.uo_series=create uo_series
this.cb_2=create cb_2
this.sle_cantidad1=create sle_cantidad1
this.sle_cantidad2=create sle_cantidad2
this.st_2=create st_2
this.uo_g2=create uo_g2
this.gb_6=create gb_6
this.gb_2=create gb_2
this.gb_7=create gb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_5
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.uo_cliente
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.uo_series
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.sle_cantidad1
this.Control[iCurrent+15]=this.sle_cantidad2
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.uo_g2
this.Control[iCurrent+18]=this.gb_6
this.Control[iCurrent+19]=this.gb_2
this.Control[iCurrent+20]=this.gb_7
end on

on w_con_pedidos_por_cantidad_y_g2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.uo_series)
destroy(this.cb_2)
destroy(this.sle_cantidad1)
destroy(this.sle_cantidad2)
destroy(this.st_2)
destroy(this.uo_g2)
destroy(this.gb_6)
destroy(this.gb_2)
destroy(this.gb_7)
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_por_cantidad_y_g2
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_por_cantidad_y_g2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_por_cantidad_y_g2
integer x = 23
integer y = 8
integer width = 3237
integer height = 88
end type

type pb_1 from upb_salir within w_con_pedidos_por_cantidad_y_g2
integer x = 3287
integer y = 4
integer width = 119
integer height = 96
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_pedidos_por_cantidad_y_g2
integer x = 3278
integer y = 156
integer width = 128
integer height = 108
integer taborder = 0
boolean originalsize = false
end type

event clicked;//long     i,indice_ser
//Datetime fecha1,fecha2
//String   series[1 to 20],cliente, filtro
//
//fecha1 = Datetime(Date(String(em_fechadesde.Text)))
//fecha2 = Datetime(Date(String(em_fechahasta.Text)))
//
//indice_ser = 1
//for i=1 to uo_series.dw_marca.rowcount()
//	if uo_series.dw_marca.getitemstring(i,"marca")="S" then
//		series[indice_ser] = uo_series.dw_marca.getitemstring(i,"codigo")
//		indice_ser ++
//	end if	
//next
//
//if uo_cliente.em_codigo.text <> "" then
//	cliente = uo_cliente.em_codigo.text
//else
//	cliente = "%"
//end if
//dw_listado.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series)
//
//if cbx_sinfecha.checked then
//	filtro = ' isnull(fentrega)  '
//	dw_listado.SetFilter("")
//	dw_listado.SetFilter(filtro)
//	dw_listado.Filter()
//end if
//
//
f_imprimir_datawindow(dw_detalle)

end event

type dw_detalle from datawindow within w_con_pedidos_por_cantidad_y_g2
integer x = 5
integer y = 280
integer width = 3415
integer height = 2296
string dataobject = "dw_con_pedidos_por_cantidad_y_g2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

type em_fechadesde from u_em_campo within w_con_pedidos_por_cantidad_y_g2
integer x = 23
integer y = 168
integer width = 270
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_pedidos_por_cantidad_y_g2
integer x = 338
integer y = 168
integer width = 270
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_pedidos_por_cantidad_y_g2
integer x = 2981
integer y = 156
integer width = 288
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked; f_control()

end event

type gb_5 from groupbox within w_con_pedidos_por_cantidad_y_g2
integer x = 2693
integer y = 116
integer width = 270
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_con_pedidos_por_cantidad_y_g2
integer x = 9
integer y = 116
integer width = 613
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fechas"
end type

type uo_cliente from u_em_campo_2 within w_con_pedidos_por_cantidad_y_g2
event destroy ( )
integer x = 635
integer y = 168
integer width = 1234
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

type gb_3 from groupbox within w_con_pedidos_por_cantidad_y_g2
integer x = 1897
integer y = 116
integer width = 553
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cantidad Entre"
end type

type st_1 from statictext within w_con_pedidos_por_cantidad_y_g2
integer x = 288
integer y = 156
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_series from u_marca_lista within w_con_pedidos_por_cantidad_y_g2
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type cb_2 from commandbutton within w_con_pedidos_por_cantidad_y_g2
integer x = 2706
integer y = 156
integer width = 242
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Series"
end type

event clicked;uo_series.visible = not(uo_series.visible)
end event

type sle_cantidad1 from singlelineedit within w_con_pedidos_por_cantidad_y_g2
integer x = 1920
integer y = 172
integer width = 224
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_cantidad2 from singlelineedit within w_con_pedidos_por_cantidad_y_g2
integer x = 2203
integer y = 172
integer width = 224
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_con_pedidos_por_cantidad_y_g2
integer x = 2149
integer y = 180
integer width = 55
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "y"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_g2 from u_em_campo_2 within w_con_pedidos_por_cantidad_y_g2
event destroy ( )
integer x = 2487
integer y = 176
integer width = 165
integer height = 80
integer taborder = 110
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g2.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g2.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo2
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g2.em_campo.text = descripcion
IF Trim(uo_g2.em_campo.text)="" THEN 
 IF Trim(uo_g2.em_codigo.text)<>"" Then uo_g2.em_campo.SetFocus()
 uo_g2.em_campo.text=""
 uo_g2.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G2"
ue_datawindow = "dw_ayuda_art_grupo2"
ue_filtro     = ""

end event

type gb_6 from groupbox within w_con_pedidos_por_cantidad_y_g2
integer x = 2962
integer y = 116
integer width = 457
integer height = 160
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_pedidos_por_cantidad_y_g2
integer x = 622
integer y = 116
integer width = 1271
integer height = 164
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type gb_7 from groupbox within w_con_pedidos_por_cantidad_y_g2
integer x = 2469
integer y = 120
integer width = 197
integer height = 156
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G2"
end type

