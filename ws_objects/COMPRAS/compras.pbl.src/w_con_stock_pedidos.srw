$PBExportHeader$w_con_stock_pedidos.srw
forward
global type w_con_stock_pedidos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_stock_pedidos
end type
type st_fpedido1 from statictext within w_con_stock_pedidos
end type
type dw_listado from datawindow within w_con_stock_pedidos
end type
type pb_imprimir from upb_imprimir within w_con_stock_pedidos
end type
type em_fpedido1 from u_em_campo within w_con_stock_pedidos
end type
type st_fpedido2 from statictext within w_con_stock_pedidos
end type
type em_fpedido2 from u_em_campo within w_con_stock_pedidos
end type
type dw_1 from datawindow within w_con_stock_pedidos
end type
type gb_2 from groupbox within w_con_stock_pedidos
end type
type gb_1 from groupbox within w_con_stock_pedidos
end type
type cb_1 from commandbutton within w_con_stock_pedidos
end type
type st_prodd from statictext within w_con_stock_pedidos
end type
type st_prodh from statictext within w_con_stock_pedidos
end type
type dw_pedido from datawindow within w_con_stock_pedidos
end type
end forward

global type w_con_stock_pedidos from w_int_con_empresa
integer width = 2921
integer height = 1668
string icon = "Application!"
pb_1 pb_1
st_fpedido1 st_fpedido1
dw_listado dw_listado
pb_imprimir pb_imprimir
em_fpedido1 em_fpedido1
st_fpedido2 st_fpedido2
em_fpedido2 em_fpedido2
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
cb_1 cb_1
st_prodd st_prodd
st_prodh st_prodh
dw_pedido dw_pedido
end type
global w_con_stock_pedidos w_con_stock_pedidos

type variables
string filtro
end variables

forward prototypes
public subroutine f_cargar_dw (datawindow data)
end prototypes

public subroutine f_cargar_dw (datawindow data);IF Trim(em_fpedido1.text) = "" or IsNull(em_fpedido1.text) then 
	em_fpedido1.text = "1"
END IF

IF Trim(em_fpedido2.text) = "" OR IsNull(em_fpedido2.text) THEN
	em_fpedido2.text = "99999"
END IF

data.Reset()
data.SetRedraw(FALSE)

String	selecci,codart,fil
Long		cuantas,i,lin
DataStore	dw_ped

dw_pedido.Retrieve(codigo_empresa,Trim(em_fpedido1.text),Trim(em_fpedido2.text))
cuantas	= dw_pedido.RowCount()

FOR i = 1 TO cuantas
	lin = data.InsertRow(0)
	data.SetItem(lin,"empresa",codigo_empresa)
	data.SetItem(lin,"almacen",'0')
	codart = dw_pedido.GetItemString(i,"mprima")
	data.SetItem(lin,"producto",codart)
	data.SetItem(lin,"cantidad",dw_pedido.GetItemNumber(i,"cantidad"))
	data.SetItem(lin,"fentrega",dw_pedido.GetItemDateTime(i,"fecha_entrega"))
	data.SetItem(lin,"descripcion",dw_pedido.GetItemString(i,"venmprima_descripcion"))
NEXT

// Añadimos existencias del almacen 2. Descarga
selecci = "SELECT articulo,existencias,almacen FROM almlinubica " +&
   		 "WHERE almlinubica.empresa = '" + codigo_empresa + "' " +&
			 "AND   (almlinubica.tipo_materia BETWEEN '" + Trim(em_fpedido1.text) + "' and '" + Trim(em_fpedido2.text) +"') " +&
			 "AND   (almlinubica.almacen = '2')"

//dw_ped = f_cargar_cursor(selecci)
f_cargar_cursor_nuevo(selecci, dw_ped)

FOR i = 1 To dw_ped.RowCount()
	lin = data.InsertRow(0)
	data.SetItem(lin,"empresa",codigo_empresa)
	data.SetItem(lin,"almacen",dw_ped.GetItemString(i,"almacen"))
	data.SetItem(lin,"producto",dw_ped.GetItemString(i,"articulo"))
	data.SetItem(lin,"cantidad",dw_ped.GetItemNumber(i,"existencias"))
	data.SetItem(lin,"fentrega","")
	data.SetItem(lin,"descripcion",f_nombre_mprima(codigo_empresa,dw_ped.GetItemString(i,"articulo")))
NEXT

Destroy dw_ped

// Añadimos las lineas de existencias del almacen 1

selecci = "SELECT articulo,existencias,almacen FROM almlinubica " +&
   		 "WHERE almlinubica.empresa = '" + codigo_empresa + "' " +&
			 "AND   (almlinubica.tipo_materia BETWEEN '" + Trim(em_fpedido1.text) + "' and '" + Trim(em_fpedido2.text) +"') " +&
			 "AND   (almlinubica.almacen = '1')"

//dw_ped = f_cargar_cursor(selecci)
f_cargar_cursor_nuevo(selecci, dw_ped)

FOR i = 1 To dw_ped.RowCount()
	codart = dw_ped.GetItemString(i,"articulo")
	fil = "producto = '" + Trim(codart) + "'"
	data.SetFilter(fil)
	data.Filter()
	cuantas = data.RowCount()
	IF cuantas > 0 THEN
		lin = data.InsertRow(0)
		data.SetItem(lin,"empresa",codigo_empresa)
		data.SetItem(lin,"almacen",dw_ped.GetItemString(i,"almacen"))
		data.SetItem(lin,"producto",dw_ped.GetItemString(i,"articulo"))
		data.SetItem(lin,"cantidad",dw_ped.GetItemNumber(i,"existencias"))
		data.SetItem(lin,"fentrega","")
		data.SetItem(lin,"descripcion",f_nombre_mprima(codigo_empresa,dw_ped.GetItemString(i,"articulo")))
	END IF
NEXT

Destroy dw_ped

data.SetFilter("")
data.Filter()
data.Sort()
data.groupCalc()

data.SetRedraw(TRUE)
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Artículos para Control de Stock"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_pedido.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
em_fpedido1.text="100"
em_fpedido2.text="500"
st_prodd.text = f_nombre_tipo_materia(codigo_empresa, Trim(em_fpedido1.text))
st_prodh.text = f_nombre_tipo_materia(codigo_empresa, Trim(em_fpedido2.text))
end event

on w_con_stock_pedidos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_fpedido1=create st_fpedido1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.em_fpedido1=create em_fpedido1
this.st_fpedido2=create st_fpedido2
this.em_fpedido2=create em_fpedido2
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_1=create cb_1
this.st_prodd=create st_prodd
this.st_prodh=create st_prodh
this.dw_pedido=create dw_pedido
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_fpedido1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.em_fpedido1
this.Control[iCurrent+6]=this.st_fpedido2
this.Control[iCurrent+7]=this.em_fpedido2
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.st_prodd
this.Control[iCurrent+13]=this.st_prodh
this.Control[iCurrent+14]=this.dw_pedido
end on

on w_con_stock_pedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_fpedido1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.em_fpedido1)
destroy(this.st_fpedido2)
destroy(this.em_fpedido2)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.st_prodd)
destroy(this.st_prodh)
destroy(this.dw_pedido)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_pedidos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_pedidos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_pedidos
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_stock_pedidos
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type st_fpedido1 from statictext within w_con_stock_pedidos
integer x = 165
integer y = 196
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_stock_pedidos
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_stock_mprima"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_stock_pedidos
integer x = 2295
integer y = 180
integer width = 142
integer height = 120
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;call super::clicked;f_cargar_dw(dw_listado)

f_imprimir_datawindow(dw_listado)

f_activar_campo(em_fpedido1)
end event

type em_fpedido1 from u_em_campo within w_con_stock_pedidos
integer x = 462
integer y = 188
integer width = 165
integer taborder = 20
alignment alignment = center!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = "~b"
end type

event modified;call super::modified;st_prodd.text = f_nombre_tipo_materia(codigo_empresa, Trim(em_fpedido1.text))
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipos de Materias"
ue_datawindow = "dw_ayuda_venmateria"
end event

type st_fpedido2 from statictext within w_con_stock_pedidos
integer x = 174
integer y = 348
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fpedido2 from u_em_campo within w_con_stock_pedidos
integer x = 462
integer y = 340
integer width = 165
integer taborder = 30
alignment alignment = center!
string mask = "!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = ""
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipos de Materias"
ue_datawindow = "dw_ayuda_venmateria"
end event

event modified;call super::modified;st_prodh.text = f_nombre_tipo_materia(codigo_empresa, Trim(em_fpedido2.text))
end event

type dw_1 from datawindow within w_con_stock_pedidos
integer x = 23
integer y = 480
integer width = 2825
integer height = 960
boolean bringtotop = true
string dataobject = "dw_stock_mprima"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//IF Row = 0 Then Return
//
//str_parametros lstr_param
//lstr_param.i_nargumentos=3
//lstr_param.s_argumentos[3]=f_valor_columna(dw_fechas,dw_fechas.GetRow(),"comlinalb_anyo")
//lstr_param.s_argumentos[2]= f_valor_columna(dw_fechas,dw_fechas.GetRow(),"comlinalb_albaran")
//OpenWithParm(w_mant_comlinalb,lstr_param) 
//
//
end event

type gb_2 from groupbox within w_con_stock_pedidos
integer x = 1838
integer y = 144
integer width = 416
integer height = 152
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_con_stock_pedidos
integer x = 9
integer y = 120
integer width = 1806
integer height = 356
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Producto"
end type

type cb_1 from commandbutton within w_con_stock_pedidos
integer x = 1856
integer y = 196
integer width = 379
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Continuar"
end type

event clicked;
f_cargar_dw(dw_1)
end event

type st_prodd from statictext within w_con_stock_pedidos
integer x = 649
integer y = 196
integer width = 1093
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
long bordercolor = 12632256
boolean focusrectangle = false
end type

type st_prodh from statictext within w_con_stock_pedidos
integer x = 645
integer y = 344
integer width = 1093
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
long bordercolor = 12632256
boolean focusrectangle = false
end type

type dw_pedido from datawindow within w_con_stock_pedidos
boolean visible = false
integer x = 654
integer y = 124
integer width = 1166
integer height = 360
boolean bringtotop = true
string dataobject = "dw_stock_ped"
boolean livescroll = true
end type

