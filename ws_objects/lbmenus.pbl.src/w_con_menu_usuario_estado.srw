$PBExportHeader$w_con_menu_usuario_estado.srw
forward
global type w_con_menu_usuario_estado from window
end type
type cb_cerrar from commandbutton within w_con_menu_usuario_estado
end type
type tv_arbol_estado from treeview within w_con_menu_usuario_estado
end type
end forward

global type w_con_menu_usuario_estado from window
integer width = 2546
integer height = 1544
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_cerrar cb_cerrar
tv_arbol_estado tv_arbol_estado
end type
global w_con_menu_usuario_estado w_con_menu_usuario_estado

on w_con_menu_usuario_estado.create
this.cb_cerrar=create cb_cerrar
this.tv_arbol_estado=create tv_arbol_estado
this.Control[]={this.cb_cerrar,&
this.tv_arbol_estado}
end on

on w_con_menu_usuario_estado.destroy
destroy(this.cb_cerrar)
destroy(this.tv_arbol_estado)
end on

event open;String			ls_sel, ls_apli[], ls_empresa
Long				ll_apli, ll_base, ll_cont
menu				lm_menu
DataStore		lds_aplicaciones
DataWindow	ldw_menu


ldw_menu = Message.powerobjectparm

//f_centrar_ventana(This)

ls_empresa = f_nombre_empresa ( ldw_menu.Object.usuario_menu_empresa[1]) 
This.title = "Estado del Menú "

SetPointer(HourGlass!)

ls_sel = "Select  Distinct Convert ( Char, (codigo+0)) apli, descripcion, menu  from grupo_aplicacion  order by apli"
		
lds_aplicaciones = f_cargar_cursor(ls_sel)
ll_apli = lds_aplicaciones.RowCount()
	
tv_arbol_estado.setredraw( False)

ll_base = tv_arbol_estado.InsertItemLast(0, "Estado del Menú para el Usuario: " + ldw_menu.Object.usuario_menu_usuario[1] + " en la Empresa: " + ls_empresa, 1)	

f_mensaje_proceso("Cargando Menú",0,100)
For ll_cont = 1 To ll_apli	
	ls_apli = lds_aplicaciones.Object.Data[ll_cont]
	
	lm_menu = CREATE USING ls_apli[3]
	
	IF IsValid (lm_menu) THEN
		guo_menu_usuarios.of_menu_insertar_arbol_estado (ldw_menu, tv_arbol_estado, ll_base, 2, ls_apli[1], lm_menu )	
		
		Destroy lm_menu	
	END IF
	
	f_mensaje_proceso("Cargando Menú",ll_cont,ll_apli)
Next
		
If IsValid (lds_aplicaciones) Then Destroy lds_aplicaciones

tv_arbol_estado.expandall( ll_base)

ll_base = tv_arbol_estado.FindItem(RootTreeItem! , 0)
tv_arbol_estado.SetFirstVisible(ll_base)


tv_arbol_estado.Sort(ll_base , Ascending!)

tv_arbol_estado.setredraw( True)



SetPointer(Arrow!)


end event

type cb_cerrar from commandbutton within w_con_menu_usuario_estado
integer x = 1079
integer y = 1440
integer width = 370
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;Close (Parent)
end event

type tv_arbol_estado from treeview within w_con_menu_usuario_estado
integer x = 37
integer y = 40
integer width = 2441
integer height = 1360
integer taborder = 10
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"c:\bmp\pc1.GIF","c:\bmp\CHECK.gif","c:\bmp\check_no.gif","c:\bmp\check_nulo.gif"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

