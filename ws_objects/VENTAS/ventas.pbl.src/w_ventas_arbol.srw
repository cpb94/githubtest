$PBExportHeader$w_ventas_arbol.srw
forward
global type w_ventas_arbol from window
end type
type st_titulo from statictext within w_ventas_arbol
end type
type tv_menu from treeview within w_ventas_arbol
end type
end forward

global type w_ventas_arbol from window
integer width = 2144
integer height = 2600
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_titulo st_titulo
tv_menu tv_menu
end type
global w_ventas_arbol w_ventas_arbol

event open;string titulo

f_cargar_menu_arbol (w_ventas, tv_menu, titulo)
st_titulo.text = 'Ventas'



end event

on w_ventas_arbol.create
this.st_titulo=create st_titulo
this.tv_menu=create tv_menu
this.Control[]={this.st_titulo,&
this.tv_menu}
end on

on w_ventas_arbol.destroy
destroy(this.st_titulo)
destroy(this.tv_menu)
end on

type st_titulo from statictext within w_ventas_arbol
integer x = 55
integer y = 32
integer width = 1998
integer height = 104
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type tv_menu from treeview within w_ventas_arbol
integer x = 50
integer y = 144
integer width = 2021
integer height = 2408
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string picturename[] = {"C:\Bmp\CARPETA1.BMP","C:\Bmp\bola_verde.gif"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event doubleclicked;Menu v_menu
TreeViewItem nodo
int i1,i2,i3,i4,i5, nivel[]

//Open (w_general)

v_menu = w_ventas.MenuID

tv_menu.GetItem(handle, nodo )

nivel[] = nodo.data

choose case UpperBound(nivel)
	case 1
		v_menu.item[nivel[1]].TriggerEvent (clicked!)
	case 2
		v_menu.item[nivel[1]].item[nivel[2]].TriggerEvent (clicked!)
	case 3
		v_menu.item[nivel[1]].item[nivel[2]].item[nivel[3]].TriggerEvent (clicked!)
	case 4
		v_menu.item[nivel[1]].item[nivel[2]].item[nivel[3]].item[nivel[4]].TriggerEvent (clicked!)
	case 5
		v_menu.item[nivel[1]].item[nivel[2]].item[nivel[3]].item[nivel[4]].item[nivel[5]].TriggerEvent (clicked!)
end choose
end event

