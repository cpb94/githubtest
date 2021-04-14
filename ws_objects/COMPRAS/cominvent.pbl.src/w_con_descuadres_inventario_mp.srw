$PBExportHeader$w_con_descuadres_inventario_mp.srw
forward
global type w_con_descuadres_inventario_mp from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_descuadres_inventario_mp
end type
type cb_1 from commandbutton within w_con_descuadres_inventario_mp
end type
type pb_imprimir from upb_imprimir within w_con_descuadres_inventario_mp
end type
type dw_listado from datawindow within w_con_descuadres_inventario_mp
end type
type gb_6 from groupbox within w_con_descuadres_inventario_mp
end type
type gb_5 from groupbox within w_con_descuadres_inventario_mp
end type
type gb_3 from groupbox within w_con_descuadres_inventario_mp
end type
type gb_2 from groupbox within w_con_descuadres_inventario_mp
end type
type em_f_inventario from u_em_campo within w_con_descuadres_inventario_mp
end type
type gb_4 from groupbox within w_con_descuadres_inventario_mp
end type
type cb_2 from commandbutton within w_con_descuadres_inventario_mp
end type
type uo_almacenes from u_marca_lista within w_con_descuadres_inventario_mp
end type
type dw_1 from datawindow within w_con_descuadres_inventario_mp
end type
type em_porc_decuadre from u_em_campo within w_con_descuadres_inventario_mp
end type
type st_1 from statictext within w_con_descuadres_inventario_mp
end type
end forward

global type w_con_descuadres_inventario_mp from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2953
integer height = 1628
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
cb_1 cb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
gb_6 gb_6
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
em_f_inventario em_f_inventario
gb_4 gb_4
cb_2 cb_2
uo_almacenes uo_almacenes
dw_1 dw_1
em_porc_decuadre em_porc_decuadre
st_1 st_1
end type
global w_con_descuadres_inventario_mp w_con_descuadres_inventario_mp

type variables
boolean detalle = false
string ante_articulo
end variables

forward prototypes
public subroutine f_cargar (datawindow dat)
end prototypes

public subroutine f_cargar (datawindow dat);string   almacenes[]
datetime f_inventario
int      porcentaje_descuadre
long     indice,total,ind_array

uo_almacenes.visible = false

f_inventario = datetime(date(em_f_inventario.text))
porcentaje_descuadre = dec(em_porc_decuadre.text)

ind_array = 1
total     = uo_almacenes.dw_marca.RowCount()
almacenes = {""}

FOR indice = 1 To total
   IF uo_almacenes.dw_marca.GetItemString(indice,"marca") = "S" THEN
		almacenes[ind_array] = uo_almacenes.dw_marca.GetItemString(indice,"codigo")
      ind_array ++
   END IF
NEXT

dat.setfilter("")
dat.retrieve(codigo_empresa,f_inventario,porcentaje_descuadre,almacenes)
dat.setfilter("descuadre > "+string(porcentaje_descuadre,"###"))
dat.filter()

end subroutine

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

This.title = " CONSULTA DESCUADRES INVENTARIOS DE MATERIAS PRIMAS "
istr_parametros = Message.PowerObjectParm

uo_almacenes.f_cargar_datos("dw_ayuda_comalmacenes","","","Codigo","Almacen")

F_activar_campo(em_f_inventario)
end event

on w_con_descuadres_inventario_mp.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.em_f_inventario=create em_f_inventario
this.gb_4=create gb_4
this.cb_2=create cb_2
this.uo_almacenes=create uo_almacenes
this.dw_1=create dw_1
this.em_porc_decuadre=create em_porc_decuadre
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.gb_5
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.em_f_inventario
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.uo_almacenes
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.em_porc_decuadre
this.Control[iCurrent+15]=this.st_1
end on

on w_con_descuadres_inventario_mp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.em_f_inventario)
destroy(this.gb_4)
destroy(this.cb_2)
destroy(this.uo_almacenes)
destroy(this.dw_1)
destroy(this.em_porc_decuadre)
destroy(this.st_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_descuadres_inventario_mp
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_descuadres_inventario_mp
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_descuadres_inventario_mp
integer y = 20
integer width = 2587
integer height = 92
end type

type pb_2 from upb_salir within w_con_descuadres_inventario_mp
integer x = 2747
integer y = 16
integer width = 114
integer height = 104
integer taborder = 0
end type

type cb_1 from commandbutton within w_con_descuadres_inventario_mp
integer x = 2286
integer y = 144
integer width = 411
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;f_cargar(dw_1)
end event

type pb_imprimir from upb_imprimir within w_con_descuadres_inventario_mp
integer x = 2715
integer y = 144
integer width = 133
integer height = 112
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)

f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_con_descuadres_inventario_mp
boolean visible = false
integer x = 1874
integer y = 12
integer width = 443
integer height = 140
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_con_descuadres_inventario_mp"
boolean livescroll = true
end type

type gb_6 from groupbox within w_con_descuadres_inventario_mp
integer x = 366
integer y = 108
integer width = 366
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Descuadre"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within w_con_descuadres_inventario_mp
integer x = 1083
integer y = 108
integer width = 622
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_con_descuadres_inventario_mp
integer x = 2706
integer y = 104
integer width = 151
integer height = 160
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_con_descuadres_inventario_mp
integer x = 2277
integer y = 104
integer width = 430
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type em_f_inventario from u_em_campo within w_con_descuadres_inventario_mp
integer x = 50
integer y = 160
integer width = 288
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "$Œç<pïMˆïM"
end type

type gb_4 from groupbox within w_con_descuadres_inventario_mp
integer x = 23
integer y = 108
integer width = 338
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inventario"
borderstyle borderstyle = styleraised!
end type

type cb_2 from commandbutton within w_con_descuadres_inventario_mp
integer x = 1093
integer y = 144
integer width = 603
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Almacenes"
end type

event clicked;uo_almacenes.visible = not(uo_almacenes.visible)

end event

type uo_almacenes from u_marca_lista within w_con_descuadres_inventario_mp
boolean visible = false
integer x = 1166
integer y = 284
integer width = 1358
integer height = 664
integer taborder = 60
end type

on uo_almacenes.destroy
call u_marca_lista::destroy
end on

type dw_1 from datawindow within w_con_descuadres_inventario_mp
integer x = 5
integer y = 272
integer width = 2857
integer height = 1136
string dataobject = "dw_con_descuadres_inventario_mp"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if detalle then
	this.modify("datawindow.detail.height = 0")
	dw_listado.modify("datawindow.detail.height = 0")
else	
	this.modify("datawindow.detail.height = 68")
	dw_listado.modify("datawindow.detail.height = 68")
end if
detalle = not(detalle)
end event

type em_porc_decuadre from u_em_campo within w_con_descuadres_inventario_mp
integer x = 393
integer y = 160
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string mask = "###"
end type

type st_1 from statictext within w_con_descuadres_inventario_mp
integer x = 649
integer y = 168
integer width = 64
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "%"
boolean focusrectangle = false
end type

