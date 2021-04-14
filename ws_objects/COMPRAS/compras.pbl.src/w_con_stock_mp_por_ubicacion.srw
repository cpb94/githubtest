$PBExportHeader$w_con_stock_mp_por_ubicacion.srw
forward
global type w_con_stock_mp_por_ubicacion from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_mp_por_ubicacion
end type
type uo_mp from u_em_campo_2 within w_con_stock_mp_por_ubicacion
end type
type dw_1 from datawindow within w_con_stock_mp_por_ubicacion
end type
type cb_consulta from commandbutton within w_con_stock_mp_por_ubicacion
end type
type pb_imprimir from upb_imprimir within w_con_stock_mp_por_ubicacion
end type
type gb_5 from groupbox within w_con_stock_mp_por_ubicacion
end type
type gb_10 from groupbox within w_con_stock_mp_por_ubicacion
end type
type gb_1 from groupbox within w_con_stock_mp_por_ubicacion
end type
type gb_3 from groupbox within w_con_stock_mp_por_ubicacion
end type
type gb_2 from groupbox within w_con_stock_mp_por_ubicacion
end type
type uo_almacen from u_em_campo_2 within w_con_stock_mp_por_ubicacion
end type
type gb_4 from groupbox within w_con_stock_mp_por_ubicacion
end type
type cb_2 from commandbutton within w_con_stock_mp_por_ubicacion
end type
type uo_productos from u_marca_lista within w_con_stock_mp_por_ubicacion
end type
type sle_zona from singlelineedit within w_con_stock_mp_por_ubicacion
end type
type cb_familias from commandbutton within w_con_stock_mp_por_ubicacion
end type
type uo_familias from u_marca_lista within w_con_stock_mp_por_ubicacion
end type
end forward

global type w_con_stock_mp_por_ubicacion from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3589
integer height = 2092
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
uo_mp uo_mp
dw_1 dw_1
cb_consulta cb_consulta
pb_imprimir pb_imprimir
gb_5 gb_5
gb_10 gb_10
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
uo_almacen uo_almacen
gb_4 gb_4
cb_2 cb_2
uo_productos uo_productos
sle_zona sle_zona
cb_familias cb_familias
uo_familias uo_familias
end type
global w_con_stock_mp_por_ubicacion w_con_stock_mp_por_ubicacion

type variables
boolean detalle = false
string ante_articulo, ante_almacen
string tipos_materias_marcadas[]
end variables

event open;call super::open;long indice

dw_1.SetTransObject(sqlca)

This.title = " CONSULTA STOCKS MATERIAS PRIMAS POR UBICACION"
istr_parametros = Message.PowerObjectParm

uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Producto","Descripción")
istr_parametros = Message.PowerObjectParm
uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Codigo","Tipo de materia")

for indice =1 to uo_productos.dw_marca.rowcount()
	tipos_materias_marcadas[indice] = "N"//uo_tipo_materia.dw_marca.getitemstring(indice,"marca")
next

f_activar_campo(uo_mp.em_campo)
end event

on w_con_stock_mp_por_ubicacion.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_mp=create uo_mp
this.dw_1=create dw_1
this.cb_consulta=create cb_consulta
this.pb_imprimir=create pb_imprimir
this.gb_5=create gb_5
this.gb_10=create gb_10
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.uo_almacen=create uo_almacen
this.gb_4=create gb_4
this.cb_2=create cb_2
this.uo_productos=create uo_productos
this.sle_zona=create sle_zona
this.cb_familias=create cb_familias
this.uo_familias=create uo_familias
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_mp
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.gb_5
this.Control[iCurrent+7]=this.gb_10
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.uo_almacen
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.uo_productos
this.Control[iCurrent+15]=this.sle_zona
this.Control[iCurrent+16]=this.cb_familias
this.Control[iCurrent+17]=this.uo_familias
end on

on w_con_stock_mp_por_ubicacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_mp)
destroy(this.dw_1)
destroy(this.cb_consulta)
destroy(this.pb_imprimir)
destroy(this.gb_5)
destroy(this.gb_10)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.uo_almacen)
destroy(this.gb_4)
destroy(this.cb_2)
destroy(this.uo_productos)
destroy(this.sle_zona)
destroy(this.cb_familias)
destroy(this.uo_familias)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_mp_por_ubicacion
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_mp_por_ubicacion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_mp_por_ubicacion
integer x = 14
integer y = 12
integer width = 3323
integer height = 84
integer textsize = -11
boolean italic = true
long textcolor = 8388608
end type

type pb_2 from upb_salir within w_con_stock_mp_por_ubicacion
integer x = 3360
integer y = 12
integer width = 114
integer height = 104
integer taborder = 0
end type

type uo_mp from u_em_campo_2 within w_con_stock_mp_por_ubicacion
integer x = 78
integer y = 152
integer width = 937
integer taborder = 100
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de materias primas"
ue_datawindow = "dw_ayuda_venmprima"
ue_filtro     = ""
ante_articulo = uo_mp.em_codigo.text
end event

on uo_mp.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_nombre_mprima( codigo_empresa , this.em_codigo.text )

If Trim( this.em_campo.text ) = "" Then
	If Trim( this.em_codigo.text ) <> "" then this.em_campo.SetFocus()
	this.em_campo.text  = ""
	this.em_codigo.text = ""
end if
end event

type dw_1 from datawindow within w_con_stock_mp_por_ubicacion
integer x = 14
integer y = 268
integer width = 3520
integer height = 1588
boolean bringtotop = true
string dataobject = "dw_con_stock_mp_por_ubicacion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//if detalle then
//	this.modify("datawindow.detail.height = 0")
//	dw_listado.modify("datawindow.detail.height = 0")
//else	
//	this.modify("datawindow.detail.height = 68")
//	dw_listado.modify("datawindow.detail.height = 68")
//end if
//detalle = not(detalle)
end event

type cb_consulta from commandbutton within w_con_stock_mp_por_ubicacion
integer x = 2862
integer y = 112
integer width = 411
integer height = 136
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string var_producto[], var_familias[]
long   indice,indice_array, indice2, indice_array2
string var_mp, var_almacen, var_zona

uo_productos.visible = false
uo_familias.visible = false

indice_array = 0
for indice = 1 to uo_productos.dw_marca.rowcount()
	if uo_productos.dw_marca.getitemstring(indice,"marca")="S" then
		indice_array ++		
		var_producto[indice_array] = uo_productos.dw_marca.getitemstring(indice,"codigo")
	end if
next

indice_array2 = 0
for indice2 = 1 to uo_familias.dw_marca.rowcount()
	if uo_familias.dw_marca.getitemstring(indice2,"marca")="S" then
		indice_array2 ++		
		
		var_familias[indice_array2] = mid(uo_familias.dw_marca.getitemstring(indice2,"codigo"), pos (uo_familias.dw_marca.getitemstring(indice2,"codigo"), "/") + 1)
	end if
next


if uo_mp.em_codigo.text = "" then
	var_mp = "%"
else
	var_mp = uo_mp.em_codigo.text
end if

if uo_almacen.em_codigo.text = "" then
	var_almacen = "%"
else
	var_almacen = uo_almacen.em_codigo.text
end if

if sle_zona.text = "" then
	var_zona = "%"
else
	var_zona = sle_zona.text
end if


if indice_array > 0 and indice_Array2 > 0 then
	dw_1.retrieve(codigo_empresa,var_mp, var_almacen, var_producto, var_zona, var_familias)
else
	messagebox ("Atención", "Eliga al menos un producto y una familia")
end if
end event

type pb_imprimir from upb_imprimir within w_con_stock_mp_por_ubicacion
integer x = 3333
integer y = 132
integer width = 133
integer height = 108
integer taborder = 30
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;string var_mp

if uo_mp.em_codigo.text = "" then
	var_mp = "%"
else
	var_mp = uo_mp.em_codigo.text
end if

//dw_listado.retrieve(codigo_empresa,var_mp)

f_imprimir_datawindow(dw_1)

end event

type gb_5 from groupbox within w_con_stock_mp_por_ubicacion
integer x = 2048
integer y = 92
integer width = 302
integer height = 160
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Zona"
end type

type gb_10 from groupbox within w_con_stock_mp_por_ubicacion
integer x = 2423
integer y = 76
integer width = 430
integer height = 184
integer taborder = 60
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

type gb_1 from groupbox within w_con_stock_mp_por_ubicacion
integer x = 55
integer y = 92
integer width = 983
integer height = 160
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Materia Prima"
end type

type gb_3 from groupbox within w_con_stock_mp_por_ubicacion
integer x = 3323
integer y = 92
integer width = 151
integer height = 156
integer taborder = 50
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

type gb_2 from groupbox within w_con_stock_mp_por_ubicacion
integer x = 2853
integer y = 72
integer width = 430
integer height = 184
integer taborder = 40
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

type uo_almacen from u_em_campo_2 within w_con_stock_mp_por_ubicacion
integer x = 1079
integer y = 152
integer width = 942
integer taborder = 90
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;this.em_campo.text = f_nombre_comalmacen( codigo_empresa , this.em_codigo.text )

If Trim( this.em_campo.text ) = "" Then
	If Trim( this.em_codigo.text ) <> "" then this.em_campo.SetFocus()
	this.em_campo.text  = ""
	this.em_codigo.text = ""
end if
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda selección de Almacenes"
ue_datawindow = "dw_ayuda_comalmacenes"
ue_filtro     = ""
ante_almacen = uo_almacen.em_codigo.text
end event

on uo_almacen.destroy
call u_em_campo_2::destroy
end on

type gb_4 from groupbox within w_con_stock_mp_por_ubicacion
integer x = 1061
integer y = 92
integer width = 983
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Almacén"
end type

type cb_2 from commandbutton within w_con_stock_mp_por_ubicacion
integer x = 2432
integer y = 116
integer width = 411
integer height = 68
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Productos"
end type

event clicked;uo_productos.visible = not(uo_productos.visible)

end event

type uo_productos from u_marca_lista within w_con_stock_mp_por_ubicacion
event destroy ( )
boolean visible = false
integer x = 2062
integer y = 264
integer width = 1362
integer height = 668
integer taborder = 110
boolean bringtotop = true
boolean border = false
end type

on uo_productos.destroy
call u_marca_lista::destroy
end on

type sle_zona from singlelineedit within w_con_stock_mp_por_ubicacion
integer x = 2075
integer y = 152
integer width = 247
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_familias from commandbutton within w_con_stock_mp_por_ubicacion
integer x = 2432
integer y = 180
integer width = 411
integer height = 68
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;long    indice,indice2,total2,indice3,donde
datastore familias
string  sel,tipo_materia,familia,tipo_materia_linea,codigo_familia
string  codigo_materia_familia,codigo_materia,descripcion_familia
boolean salir

for indice =1 to uo_productos.dw_marca.rowcount()
	if tipos_materias_marcadas[indice] <> uo_productos.dw_marca.getitemstring(indice,"marca") then
		tipo_materia = uo_productos.dw_marca.getitemstring(indice,"codigo")		
		if tipos_materias_marcadas[indice] = "S" then
			//Debemos eliminar las familias de ese tipo de materia	
			total2  = uo_familias.dw_marca.rowcount() 
			for indice2 = 1 to total2
				codigo_materia_familia = uo_familias.dw_marca.getitemstring(indice2,"codigo")		
				indice3 = 0
				codigo_materia = ""
				salir = false
				do 
					indice3 ++
					if mid(codigo_materia_familia,indice3,1) <> "/" then
						codigo_materia = codigo_materia + mid(codigo_materia_familia,indice3,1)
					else
						salir = true
					end if					
				loop until salir or indice3 = len(codigo_materia_familia)
				if codigo_materia = tipo_materia then
					uo_familias.dw_marca.deleterow(indice2)
					total2  = uo_familias.dw_marca.rowcount() 
					indice2 = indice2 -1
				end if
			next
		else
			//Debemos añadir las familias de ese tipo de materia			
			sel = "select familia,descripcion "+&
					"from venfamilias "+&
					"where empresa = '"+codigo_empresa+"' "+&
					"and tipo_materia = '"+tipo_materia+"'"
					
			//familias = f_cargar_cursor(sel)
			f_cargar_cursor_nuevo(sel, familias)
			total2  = familias.rowcount()
			for indice2 = 1 to total2
				familia             = familias.object.familia[indice2]
				descripcion_familia = familias.object.descripcion[indice2] 
				donde = uo_familias.dw_marca.insertrow(uo_familias.dw_marca.rowcount()+1)
				uo_familias.dw_marca.setitem(donde,"codigo",tipo_materia+"/"+familia)				
				uo_familias.dw_marca.setitem(donde,"texto",descripcion_familia)				
			next
		end if
		tipos_materias_marcadas[indice] = uo_productos.dw_marca.getitemstring(indice,"marca")
	end if
next
destroy familias
uo_productos.visible = false
uo_familias.visible     = not(uo_familias.visible)
end event

type uo_familias from u_marca_lista within w_con_stock_mp_por_ubicacion
event destroy ( )
boolean visible = false
integer x = 2144
integer y = 268
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

