$PBExportHeader$w_con_libros_iva_por_tipo.srw
forward
global type w_con_libros_iva_por_tipo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_libros_iva_por_tipo
end type
type uo_ejercicio from u_ejercicio within w_con_libros_iva_por_tipo
end type
type cb_detalle from u_boton within w_con_libros_iva_por_tipo
end type
type em_fecha_desde from u_em_campo within w_con_libros_iva_por_tipo
end type
type st_4 from statictext within w_con_libros_iva_por_tipo
end type
type em_fecha_hasta from u_em_campo within w_con_libros_iva_por_tipo
end type
type st_3 from statictext within w_con_libros_iva_por_tipo
end type
type gb_1 from groupbox within w_con_libros_iva_por_tipo
end type
type cb_resumen from u_boton within w_con_libros_iva_por_tipo
end type
type pb_2 from upb_imprimir within w_con_libros_iva_por_tipo
end type
type dw_listado2 from datawindow within w_con_libros_iva_por_tipo
end type
type gb_2 from groupbox within w_con_libros_iva_por_tipo
end type
type uo_tipo2 from u_marca_lista within w_con_libros_iva_por_tipo
end type
type cb_tipos from u_boton within w_con_libros_iva_por_tipo
end type
type dw_1 from datawindow within w_con_libros_iva_por_tipo
end type
type dw_resumen from datawindow within w_con_libros_iva_por_tipo
end type
end forward

global type w_con_libros_iva_por_tipo from w_int_con_empresa
integer width = 2958
integer height = 2160
pb_1 pb_1
uo_ejercicio uo_ejercicio
cb_detalle cb_detalle
em_fecha_desde em_fecha_desde
st_4 st_4
em_fecha_hasta em_fecha_hasta
st_3 st_3
gb_1 gb_1
cb_resumen cb_resumen
pb_2 pb_2
dw_listado2 dw_listado2
gb_2 gb_2
uo_tipo2 uo_tipo2
cb_tipos cb_tipos
dw_1 dw_1
dw_resumen dw_resumen
end type
global w_con_libros_iva_por_tipo w_con_libros_iva_por_tipo

type variables
Datawindow data
String tipo = "1"
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.visible = FALSE
dw_resumen.visible = FALSE
dw_1.Reset()
dw_listado2.reset()
dw_resumen.Reset()
String vtipo
data.visible = TRUE
DateTime  fecha1,fecha2
fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha_hasta.text))
String v[]
Dec j,l
l = 0
For j =1 To uo_tipo2.dw_marca.RowCOunt()
 IF uo_tipo2.dw_marca.Object.marca[j] = "S" Then
	l ++
   v[l] = uo_tipo2.dw_marca.Object.codigo[j]
 END IF
Next
data.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,v,fecha1,fecha2)  
dw_listado2.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,v,fecha1,fecha2)

end subroutine

event open;call super::open;DateTime fecha
   dw_1.SetTransObject(SQLCA)
   dw_listado2.SetTransObject(SQLCA)
   dw_resumen.SetTransObject(SQLCA)
   istr_parametros.s_titulo_ventana  = "Consulta libros de iva"
	istr_parametros.s_listado         = ""
   This.title = istr_parametros.s_titulo_ventana
    uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_ejercicio.em_ejercicio.text=istr_parametros.s_argumentos[2]
//      uo_libro.em_codigo.text=istr_parametros.s_argumentos[3]
//      uo_libro.em_campo.text=f_nombre_contalibros(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_libro.em_codigo.text)
   END IF
data = dw_1
em_fecha_desde.text = String(MDY(Month(Today()),1,Year(Today())),"dd-mm-yy")
fecha = DateTime(MDY(Month(Today())+1,1,Year(Today())))
fecha = DateTime(RelativeDate(Date(fecha),-1))
em_fecha_hasta.text = String(Date(fecha),"dd-mm-yy")
// mascaras
f_mascara_columna(dw_1,"impfra",f_mascara_decimales(0))
f_mascara_columna(dw_1,"impiva",f_mascara_decimales(0))
f_mascara_columna(dw_1,"imponible",f_mascara_decimales(0))
f_mascara_columna(dw_1,"totalimpfra",f_mascara_decimales(0))
f_mascara_columna(dw_1,"totalimpiva",f_mascara_decimales(0))
f_mascara_columna(dw_1,"totalimponible",f_mascara_decimales(0))
Integer x1,registros 
String var_codigo,var_texto,marca
DataStore dw
//dw = f_cargar_cursor("Select * from contaiva Where empresa = '" + codigo_empresa + "'"+" And ejercicio ="+String(ejercicio_activo,"####"))
f_cargar_cursor_nuevo("Select * from contaiva Where empresa = '" + codigo_empresa + "'"+" And ejercicio ="+String(ejercicio_activo,"####"),dw)
registros=dw.RowCount()
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw.GetItemString(x1,"tipoiva")
  var_texto   = dw.GetItemString(x1,"descripcion")
  marca="S"
  uo_tipo2.dw_marca.InsertRow(x1)
  uo_tipo2.dw_marca.setitem(x1,"marca",marca)
  uo_tipo2.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo2.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_tipo2.st_titulo1.text="Situación"
uo_tipo2.st_titulo2.text="Descripcion"


f_activar_campo(em_fecha_desde)	

destroy dw
end event

on w_con_libros_iva_por_tipo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_ejercicio=create uo_ejercicio
this.cb_detalle=create cb_detalle
this.em_fecha_desde=create em_fecha_desde
this.st_4=create st_4
this.em_fecha_hasta=create em_fecha_hasta
this.st_3=create st_3
this.gb_1=create gb_1
this.cb_resumen=create cb_resumen
this.pb_2=create pb_2
this.dw_listado2=create dw_listado2
this.gb_2=create gb_2
this.uo_tipo2=create uo_tipo2
this.cb_tipos=create cb_tipos
this.dw_1=create dw_1
this.dw_resumen=create dw_resumen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.cb_detalle
this.Control[iCurrent+4]=this.em_fecha_desde
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.em_fecha_hasta
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.cb_resumen
this.Control[iCurrent+10]=this.pb_2
this.Control[iCurrent+11]=this.dw_listado2
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.uo_tipo2
this.Control[iCurrent+14]=this.cb_tipos
this.Control[iCurrent+15]=this.dw_1
this.Control[iCurrent+16]=this.dw_resumen
end on

on w_con_libros_iva_por_tipo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_ejercicio)
destroy(this.cb_detalle)
destroy(this.em_fecha_desde)
destroy(this.st_4)
destroy(this.em_fecha_hasta)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.cb_resumen)
destroy(this.pb_2)
destroy(this.dw_listado2)
destroy(this.gb_2)
destroy(this.uo_tipo2)
destroy(this.cb_tipos)
destroy(this.dw_1)
destroy(this.dw_resumen)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_libros_iva_por_tipo
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_libros_iva_por_tipo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_libros_iva_por_tipo
integer y = 24
integer width = 2670
end type

type pb_1 from upb_salir within w_con_libros_iva_por_tipo
integer x = 2711
integer y = 20
integer width = 105
integer height = 104
integer taborder = 0
end type

type uo_ejercicio from u_ejercicio within w_con_libros_iva_por_tipo
integer x = 2199
integer y = 172
boolean bringtotop = true
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type cb_detalle from u_boton within w_con_libros_iva_por_tipo
integer x = 1719
integer y = 148
integer width = 293
integer height = 64
integer taborder = 40
string text = "&Detalle"
end type

event clicked;data = dw_1
tipo= "1"
f_control()
dw_listado2.modify("datawindow.detail.height=50")
//dw_listado2.modify("datawindow.titulo.text='resumen'+ datawindow.titulo.text")
end event

type em_fecha_desde from u_em_campo within w_con_libros_iva_por_tipo
integer x = 242
integer y = 180
integer width = 279
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "œ"
end type

type st_4 from statictext within w_con_libros_iva_por_tipo
integer x = 507
integer y = 180
integer width = 41
integer height = 84
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_hasta from u_em_campo within w_con_libros_iva_por_tipo
integer x = 549
integer y = 180
integer width = 283
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_3 from statictext within w_con_libros_iva_por_tipo
integer x = 23
integer y = 180
integer width = 210
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_libros_iva_por_tipo
integer x = 9
integer y = 128
integer width = 841
integer height = 152
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_resumen from u_boton within w_con_libros_iva_por_tipo
event clicked pbm_bnclicked
integer x = 1719
integer y = 212
integer width = 293
integer height = 64
integer taborder = 50
string text = "&Resumen"
end type

event clicked;call super::clicked;data = dw_resumen
tipo = "2"
f_control()
dw_listado2.modify("datawindow.detail.height=0")
f_activar_campo(em_fecha_desde)
end event

type pb_2 from upb_imprimir within w_con_libros_iva_por_tipo
integer x = 2025
integer y = 164
integer taborder = 0
end type

event clicked;call super::clicked;
data = dw_listado2

f_imprimir_datawindow(data)


end event

type dw_listado2 from datawindow within w_con_libros_iva_por_tipo
boolean visible = false
integer x = 251
integer y = 28
integer width = 421
integer height = 80
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_con_libros_iva_por_tipo1"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_libros_iva_por_tipo
integer x = 1705
integer y = 116
integer width = 453
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_tipo2 from u_marca_lista within w_con_libros_iva_por_tipo
boolean visible = false
integer x = 55
integer y = 392
integer width = 1454
integer height = 652
integer taborder = 60
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type cb_tipos from u_boton within w_con_libros_iva_por_tipo
integer x = 905
integer y = 180
integer width = 311
integer height = 84
integer taborder = 11
string text = "&Tipos"
end type

event clicked;IF uo_tipo2.visible Then
	uo_tipo2.visible = FALSE
ELSE
	uo_tipo2.visible = TRUE
END IF
end event

type dw_1 from datawindow within w_con_libros_iva_por_tipo
boolean visible = false
integer y = 288
integer width = 2843
integer height = 1108
string dataobject = "dw_con_libros_iva_por_tipo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_resumen from datawindow within w_con_libros_iva_por_tipo
boolean visible = false
integer y = 284
integer width = 2811
integer height = 1612
string dataobject = "dw_con_libros_iva2_por_tipo"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

