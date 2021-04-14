$PBExportHeader$wi_con_ubicaciones_libres.srw
forward
global type wi_con_ubicaciones_libres from w_int_con_empresa
end type
type dw_1 from datawindow within wi_con_ubicaciones_libres
end type
type dw_listado from datawindow within wi_con_ubicaciones_libres
end type
type pb_imprimir from upb_imprimir within wi_con_ubicaciones_libres
end type
type uo_manejo from u_manejo_datawindow within wi_con_ubicaciones_libres
end type
type cb_1 from u_boton within wi_con_ubicaciones_libres
end type
type cb_2 from u_boton within wi_con_ubicaciones_libres
end type
type st_1 from statictext within wi_con_ubicaciones_libres
end type
type em_cantidad from u_em_campo within wi_con_ubicaciones_libres
end type
type uo_alm from u_marca_lista within wi_con_ubicaciones_libres
end type
type pb_1 from upb_salir within wi_con_ubicaciones_libres
end type
end forward

global type wi_con_ubicaciones_libres from w_int_con_empresa
integer width = 2990
integer height = 1652
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_manejo uo_manejo
cb_1 cb_1
cb_2 cb_2
st_1 st_1
em_cantidad em_cantidad
uo_alm uo_alm
pb_1 pb_1
end type
global wi_con_ubicaciones_libres wi_con_ubicaciones_libres

forward prototypes
public subroutine f_control (datawindow data)
public function string f_filtro ()
end prototypes

public subroutine f_control (datawindow data);data.SetRedraw(FALSE)
Dec d1,d2,cont,fila_desde,fila_hasta,altura_desde,altura_hasta,f1,f2,cantidad,ex
DataStore dat
STring sel,almacen,sel1,zona
String nombre_almacen

cantidad = Dec(em_cantidad.text)


sel = "Select * from almubimapa Where empresa = '" + codigo_empresa + "'" + sel1 + " Order by  empresa,almacen,zona,fila_desde"

//dat = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dat)


cont = 0
data.Retrieve(codigo_empresa)
dat.SetFilter(f_filtro())
dat.Filter()
d2 = dat.RowCount()



For d1 = 1 To d2
		f_mensaje_proceso("Procesando",d1,d2)
		fila_desde    = dat.GetItemNumber(d1,"fila_desde")
		fila_hasta    = dat.GetItemNumber(d1,"fila_hasta")
		altura_desde  = dat.GetItemNumber(d1,"altura_desde")
		altura_hasta  = dat.GetItemNumber(d1,"altura_hasta")
		almacen       = dat.GetItemString(d1,"almacen")
		zona          = dat.GetItemString(d1,"zona")
		nombre_almacen       = f_nombre_almacen(codigo_empresa,almacen)
		For f1 = fila_desde To fila_hasta
			For f2 = altura_desde To altura_hasta
					ex = 0
					Select Sum(existencias) Into :ex from  almlinubica
					Where  empresa = :codigo_empresa
					And    almacen = :almacen
					And    zona    = :zona
					And    fila    = :f1
					And    altura  = :f2 ;
					
					If IsNull(ex) Then ex = 0
					iF ex <= cantidad Then
							cont = cont +1
							data.InsertRow(cont)
							data.SetItem(cont,"almacen",almacen)
							data.SetItem(cont,"zona",zona)
							data.SetItem(cont,"nombre_almacen",nombre_almacen)
							data.SetItem(cont,"fila",f1)
							data.SetItem(cont,"altura",f2)
							data.SetItem(cont,"existencias",ex)						
						END IF
				Next

		Next
Next
data.SetRedraw(TRUE)
data.GroupCalc()

destroy dat
end subroutine

public function string f_filtro ();Integer numero,registros,x1,y1
String filtro,filtro1
y1=0
filtro = " "
numero = uo_alm.dw_marca.RowCount()
IF numero =0 Then return filtro

FOR x1 = 1 To numero
   IF uo_alm.dw_marca.GetItemString(x1,"marca") = "S" THEN
      y1=y1+1
      IF Trim(filtro) = "" Then
         filtro1 = " almacen = '" + uo_alm.dw_marca.GetItemString(x1,"codigo") + "'"
       Else
         filtro1 = " Or almacen = '" + uo_alm.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      filtro = filtro  + filtro1
		filtro  = "(" + filtro + ")"
   END IF
NEXT


Return filtro
end function

on wi_con_ubicaciones_libres.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.em_cantidad=create em_cantidad
this.uo_alm=create uo_alm
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.uo_manejo
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.em_cantidad
this.Control[iCurrent+9]=this.uo_alm
this.Control[iCurrent+10]=this.pb_1
end on

on wi_con_ubicaciones_libres.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_manejo)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.em_cantidad)
destroy(this.uo_alm)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Ubicaciones Libres"
istr_parametros.s_listado        =   "report_formatos_familias"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

DataStore dd
String sel,var_codigo,var_texto,marca
Dec x1

sel = " Select * from almalmacen where empresa = '"+codigo_empresa+"'"

//dd = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dd)


 FOR x1= 1 To dd.RowcOunt()
  var_codigo  = dd.GetItemString(x1,"codigo")
  var_texto   = dd.GetItemString(x1,"descripcion")
  marca="S"
  uo_alm.dw_marca.InsertRow(x1)
  uo_alm.dw_marca.setitem(x1,"marca",marca)
  uo_alm.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_alm.dw_marca.setitem(x1,"texto",var_texto)
NEXT

uo_alm.st_titulo1.text="Almacen"
uo_alm.st_titulo2.text="Descripcion"
Destroy dd
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_ubicaciones_libres
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_ubicaciones_libres
integer taborder = 50
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_con_ubicaciones_libres
end type

type dw_1 from datawindow within wi_con_ubicaciones_libres
integer x = 389
integer y = 308
integer width = 2313
integer height = 1112
boolean bringtotop = true
string dataobject = "dw_ubicacioes_libres"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="wi_con_formatos_articulos"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(wi_mant_articulos,lstr_param)
//
end event

type dw_listado from datawindow within wi_con_ubicaciones_libres
boolean visible = false
integer y = 116
integer width = 521
integer height = 208
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_ubicaciones_libres"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_con_ubicaciones_libres
event clicked pbm_bnclicked
integer x = 2578
integer y = 196
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)

end event

type uo_manejo from u_manejo_datawindow within wi_con_ubicaciones_libres
event valores pbm_custom01
integer x = 2098
integer y = 148
integer width = 635
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from u_boton within wi_con_ubicaciones_libres
integer x = 1541
integer y = 180
integer width = 361
integer height = 112
integer taborder = 20
string text = "&Consultar"
end type

event clicked;call super::clicked;uo_alm.visible = FALSE
f_control(dw_1)

end event

type cb_2 from u_boton within wi_con_ubicaciones_libres
event clicked pbm_bnclicked
integer x = 1138
integer y = 180
integer width = 398
integer height = 112
integer taborder = 10
string text = "Almacenes"
end type

event clicked;call super::clicked;uo_alm.visible = TRUE

end event

type st_1 from statictext within wi_con_ubicaciones_libres
integer x = 375
integer y = 200
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Metros<="
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cantidad from u_em_campo within wi_con_ubicaciones_libres
integer x = 731
integer y = 196
integer width = 379
integer taborder = 2
string text = "0"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = "˜button"
end type

type uo_alm from u_marca_lista within wi_con_ubicaciones_libres
event destroy ( )
boolean visible = false
integer x = 1422
integer y = 328
integer width = 1454
integer taborder = 30
boolean bringtotop = true
end type

on uo_alm.destroy
call u_marca_lista::destroy
end on

type pb_1 from upb_salir within wi_con_ubicaciones_libres
integer x = 2711
integer y = 28
integer width = 123
integer height = 108
integer taborder = 0
boolean bringtotop = true
end type

