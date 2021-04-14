$PBExportHeader$w_con_menu_utigrupos_estado.srw
forward
global type w_con_menu_utigrupos_estado from window
end type
type cb_1 from commandbutton within w_con_menu_utigrupos_estado
end type
type p_imprimir from picture within w_con_menu_utigrupos_estado
end type
type st_menu from statictext within w_con_menu_utigrupos_estado
end type
type tv_arbol_estado from treeview within w_con_menu_utigrupos_estado
end type
end forward

global type w_con_menu_utigrupos_estado from window
integer width = 2363
integer height = 3404
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
p_imprimir p_imprimir
st_menu st_menu
tv_arbol_estado tv_arbol_estado
end type
global w_con_menu_utigrupos_estado w_con_menu_utigrupos_estado

type variables
string is_empresa, is_grupo
DataWindow idw_menu
end variables

forward prototypes
public subroutine f_contraer_tv (long hijo)
end prototypes

public subroutine f_contraer_tv (long hijo);Long hijo_sig

do while (hijo <> -1)
	tv_arbol_estado.collapseItem(hijo)
	hijo_sig = tv_arbol_estado.FindItem(ChildTreeItem! , hijo)
	f_contraer_tv(hijo_sig)
	hijo	= 	tv_arbol_estado.FindItem(NextTreeItem!, hijo)
loop		
end subroutine

on w_con_menu_utigrupos_estado.create
this.cb_1=create cb_1
this.p_imprimir=create p_imprimir
this.st_menu=create st_menu
this.tv_arbol_estado=create tv_arbol_estado
this.Control[]={this.cb_1,&
this.p_imprimir,&
this.st_menu,&
this.tv_arbol_estado}
end on

on w_con_menu_utigrupos_estado.destroy
destroy(this.cb_1)
destroy(this.p_imprimir)
destroy(this.st_menu)
destroy(this.tv_arbol_estado)
end on

event open;String     ls_sel, ls_apli[]
Long       ll_apli, ll_base, ll_cont
menu       lm_menu
DataStore  lds_aplicaciones

if isvalid(Message.powerobjectparm) and not isnull(Message.powerobjectparm) then 
	idw_menu = Message.powerobjectparm
	
	is_empresa = idw_menu.Object.utigrupos_menu_empresa[1]
	
	is_grupo   = idw_menu.Object.utigrupos_menu_utigrupos[1]
	
	st_menu.text = f_nombre_utigrupo(idw_menu.Object.utigrupos_menu_utigrupos[1])+' EN LA EMPRESA '+f_nombre_empresa(idw_menu.Object.utigrupos_menu_empresa[1]) 
end if
//f_centrar_ventana(This)

This.title = "Estado del Menú"

SetPointer(HourGlass!)

ls_sel = "Select  Distinct Convert ( Char, (codigo+0)) apli, descripcion, menu  from grupo_aplicacion  order by apli"
		
lds_aplicaciones = f_cargar_cursor(ls_sel)
ll_apli = lds_aplicaciones.RowCount()
	
tv_arbol_estado.setredraw( False)
tv_arbol_estado.DeleteItem(0)

//ll_base = tv_arbol_estado.InsertItemLast(0, "Estado del Menú para el utigrupos: " + ldw_menu.Object.utigrupos_menu_utigrupos[1] + " en la Empresa: " + ls_empresa, 1)	
ll_base = tv_arbol_estado.InsertItemLast(0, "Menú", 1)	

f_mensaje_proceso("Cargando Menú",0,100)
For ll_cont = 1 To ll_apli	
	ls_apli = lds_aplicaciones.Object.Data[ll_cont]
	
	lm_menu = CREATE USING ls_apli[3]
	
	IF IsValid (lm_menu) THEN
		guo_menu_utigrupos.of_menu_insertar_arbol_estado (idw_menu, tv_arbol_estado, ll_base, 2, ls_apli[1], lm_menu )	
		
		Destroy lm_menu	
	END IF
	
	f_mensaje_proceso("Cargando Menú",ll_cont,ll_apli)
Next
		
If IsValid (lds_aplicaciones) Then Destroy lds_aplicaciones

//tv_arbol_estado.expandall(ll_base)

ll_base = tv_arbol_estado.FindItem(RootTreeItem! , 0)
tv_arbol_estado.SetFirstVisible(ll_base)

tv_arbol_estado.Sort(ll_base , Ascending!)

tv_arbol_estado.setredraw( True)

SetPointer(Arrow!)


end event

type cb_1 from commandbutton within w_con_menu_utigrupos_estado
integer x = 1856
integer width = 375
integer height = 72
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Expandir"
end type

event clicked;if this.text = 'Contraer' then
	tv_arbol_estado.CollapseItem(1)
	long raiz, hijo, temporal 
	int li_tvret
	
	raiz = tv_arbol_estado.FindItem(RootTreeItem!, 0)
	tv_arbol_estado.SelectItem(raiz)
	temporal = tv_arbol_estado.FindItem(ChildTreeItem! , raiz)
	do while (temporal <> -1)
		tv_arbol_estado.collapseItem(temporal)
		hijo = tv_arbol_estado.FindItem(ChildTreeItem! , temporal)
		//
		f_contraer_tv(hijo)
		//
		temporal	= 	tv_arbol_estado.FindItem(NextTreeItem!, temporal)
	loop	
	this.text = 'Expandir'
else
	tv_arbol_estado.expandall(1)
	this.text = 'Contraer'
end if
end event

type p_imprimir from picture within w_con_menu_utigrupos_estado
integer x = 2235
integer width = 87
integer height = 72
boolean originalsize = true
string picturename = "C:\bmp\PRINT.BMP"
boolean border = true
boolean focusrectangle = false
end type

event clicked;long ll_Job 

ll_Job = PrintOpen( ) 
tv_arbol_estado.Print(ll_Job,0,0, 7960, 11400) 
PrintClose(ll_Job) 

//long ll_tvi = 0,ll_indice
//int  li_tvret
//
//for ll_indice = 1 to 50	
//	ll_tvi = tv_arbol_estado.FindItem(NextVisibleTreeItem!,ll_tvi)
//	messagebox("ll_tvi",ll_tvi)
//next
//li_tvret = tv_arbol_estado.SetFirstVisible(ll_tvi)
//
//IF li_tvret = -1 THEN
//	MessageBox("Warning!" , "Didn't Work")
//END IF

end event

type st_menu from statictext within w_con_menu_utigrupos_estado
integer y = 4
integer width = 1856
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type tv_arbol_estado from treeview within w_con_menu_utigrupos_estado
integer y = 72
integer width = 2327
integer height = 3224
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"c:\bmp\rana1.GIF","c:\bmp\bola_verde.gif","c:\bmp\bola_roja.gif","c:\bmp\bola_amarilla.gif"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

