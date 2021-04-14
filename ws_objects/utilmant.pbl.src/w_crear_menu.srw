$PBExportHeader$w_crear_menu.srw
forward
global type w_crear_menu from w_int_con_empresa
end type
type pb_1 from upb_salir within w_crear_menu
end type
type uo_usuario from u_em_campo_2 within w_crear_menu
end type
type tv_tencer from treeview within w_crear_menu
end type
type pb_2 from picturebutton within w_crear_menu
end type
type cb_ultimo from commandbutton within w_crear_menu
end type
type cb_raiz from commandbutton within w_crear_menu
end type
type cb_borrar from commandbutton within w_crear_menu
end type
type cb_cargar from commandbutton within w_crear_menu
end type
type sle_titulo from singlelineedit within w_crear_menu
end type
type ddlb_esgrupo from dropdownlistbox within w_crear_menu
end type
type st_2 from statictext within w_crear_menu
end type
type st_3 from statictext within w_crear_menu
end type
type st_4 from statictext within w_crear_menu
end type
type sle_programa from singlelineedit within w_crear_menu
end type
type st_5 from statictext within w_crear_menu
end type
type ddlb_permiso from dropdownlistbox within w_crear_menu
end type
type st_6 from statictext within w_crear_menu
end type
type st_1 from statictext within w_crear_menu
end type
type st_7 from statictext within w_crear_menu
end type
type st_8 from statictext within w_crear_menu
end type
type uo_usuario_dest from u_em_campo_2 within w_crear_menu
end type
type st_9 from statictext within w_crear_menu
end type
type cb_copiar from commandbutton within w_crear_menu
end type
type cb_actualizar from commandbutton within w_crear_menu
end type
type cb_insertar from commandbutton within w_crear_menu
end type
type cb_1 from commandbutton within w_crear_menu
end type
type r_1 from rectangle within w_crear_menu
end type
type r_2 from rectangle within w_crear_menu
end type
type r_3 from rectangle within w_crear_menu
end type
type r_4 from rectangle within w_crear_menu
end type
end forward

global type w_crear_menu from w_int_con_empresa
integer x = 14
integer y = 4
integer width = 4261
integer height = 3196
string menuname = ""
pb_1 pb_1
uo_usuario uo_usuario
tv_tencer tv_tencer
pb_2 pb_2
cb_ultimo cb_ultimo
cb_raiz cb_raiz
cb_borrar cb_borrar
cb_cargar cb_cargar
sle_titulo sle_titulo
ddlb_esgrupo ddlb_esgrupo
st_2 st_2
st_3 st_3
st_4 st_4
sle_programa sle_programa
st_5 st_5
ddlb_permiso ddlb_permiso
st_6 st_6
st_1 st_1
st_7 st_7
st_8 st_8
uo_usuario_dest uo_usuario_dest
st_9 st_9
cb_copiar cb_copiar
cb_actualizar cb_actualizar
cb_insertar cb_insertar
cb_1 cb_1
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
end type
global w_crear_menu w_crear_menu

forward prototypes
public subroutine f_escandallo (string articulo, integer nodo)
public function integer f_grabar_arbol (str_nodo_menu nodo, long id_nodo, long id_nodoant)
end prototypes

public subroutine f_escandallo (string articulo, integer nodo);// PARAMETROS
// recibe el articulo del que hay que extraer el escandallo.
// recibe el nodo raiz del árbol a partir del cual generaremos la estructura.

//string sel, articulo_ant, v_Articulo, v_version, des_articulo
//integer i, nodo_hijo, nodo_raiz
//datastore registros 
//long nodo_actual, nodo_padre
//boolean procesado = false
//
//sel = " select art_escandallo.articulo, art_escandallo.version, art_escandallo.articulo_ant, articulos.descripcion "+&
//		" from art_escandallo, articulos "+&
//		" where art_escandallo.empresa = '"+codigo_empresa+"'"+&
//		" and articulos.empresa = '"+codigo_empresa+"'"+&
//		" and art_escandallo.articulo = articulos.codigo "+&
//		" and articulo = '"+articulo+"';"
//		
//f_cargar_cursor_nuevo (sel, registros )
//
//
//for i = 1 to registros.RowCount()
//	v_articulo = registros.object.art_escandallo_articulo[i]
//	v_version = registros.object.art_escandallo_version[i]
//	des_articulo = registros.object.articulos_descripcion[i]
//	if registros.RowCount() = 0 then
//		articulo_ant = "0"
//	else
//		articulo_ant = registros.object.art_escandallo_articulo_ant[i]
//	end if
//	if not procesado then
//		nodo_actual = tv_escandallo.InsertItemFirst(nodo, v_articulo+" : "+string(v_version)+" : "+des_articulo, 1)
//		procesado = true
//	end if
//	if articulo_ant <> "0" then
//		f_escandallo (articulo_ant, nodo_actual)
//	end if
//	articulo_ant = '0'
//next
//
//nodo_raiz = tv_escandallo.FindItem(RootTreeItem! , 0)
//tv_escandallo.ExpandAll(nodo_raiz)
//
//destroy registros
end subroutine

public function integer f_grabar_arbol (str_nodo_menu nodo, long id_nodo, long id_nodoant);integer retorno
//long nuevo_nodo
//TreeViewItem nodo_hijo
//nuevo_nodo = tv_tencer.FindItem ( ChildTreeItem!, id_nodo )
//if nuevo_nodo <> -1 then
////	f_grabar_nodo()
//	id_nodo ++
//	f_grabar_arbol (nodo_hijo,  id_nodo, )
//end if

return retorno
end function

on w_crear_menu.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_usuario=create uo_usuario
this.tv_tencer=create tv_tencer
this.pb_2=create pb_2
this.cb_ultimo=create cb_ultimo
this.cb_raiz=create cb_raiz
this.cb_borrar=create cb_borrar
this.cb_cargar=create cb_cargar
this.sle_titulo=create sle_titulo
this.ddlb_esgrupo=create ddlb_esgrupo
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.sle_programa=create sle_programa
this.st_5=create st_5
this.ddlb_permiso=create ddlb_permiso
this.st_6=create st_6
this.st_1=create st_1
this.st_7=create st_7
this.st_8=create st_8
this.uo_usuario_dest=create uo_usuario_dest
this.st_9=create st_9
this.cb_copiar=create cb_copiar
this.cb_actualizar=create cb_actualizar
this.cb_insertar=create cb_insertar
this.cb_1=create cb_1
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_usuario
this.Control[iCurrent+3]=this.tv_tencer
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.cb_ultimo
this.Control[iCurrent+6]=this.cb_raiz
this.Control[iCurrent+7]=this.cb_borrar
this.Control[iCurrent+8]=this.cb_cargar
this.Control[iCurrent+9]=this.sle_titulo
this.Control[iCurrent+10]=this.ddlb_esgrupo
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.sle_programa
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.ddlb_permiso
this.Control[iCurrent+17]=this.st_6
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.st_7
this.Control[iCurrent+20]=this.st_8
this.Control[iCurrent+21]=this.uo_usuario_dest
this.Control[iCurrent+22]=this.st_9
this.Control[iCurrent+23]=this.cb_copiar
this.Control[iCurrent+24]=this.cb_actualizar
this.Control[iCurrent+25]=this.cb_insertar
this.Control[iCurrent+26]=this.cb_1
this.Control[iCurrent+27]=this.r_1
this.Control[iCurrent+28]=this.r_2
this.Control[iCurrent+29]=this.r_3
this.Control[iCurrent+30]=this.r_4
end on

on w_crear_menu.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.uo_usuario)
destroy(this.tv_tencer)
destroy(this.pb_2)
destroy(this.cb_ultimo)
destroy(this.cb_raiz)
destroy(this.cb_borrar)
destroy(this.cb_cargar)
destroy(this.sle_titulo)
destroy(this.ddlb_esgrupo)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.sle_programa)
destroy(this.st_5)
destroy(this.ddlb_permiso)
destroy(this.st_6)
destroy(this.st_1)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.uo_usuario_dest)
destroy(this.st_9)
destroy(this.cb_copiar)
destroy(this.cb_actualizar)
destroy(this.cb_insertar)
destroy(this.cb_1)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta Escandallo"
This.title                       =   istr_parametros.s_titulo_ventana

f_activar_campo(uo_usuario.em_campo)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_crear_menu
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_crear_menu
integer width = 334
end type

event sle_opcion_orden::getfocus;f_activar_campo(uo_usuario.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_crear_menu
integer width = 3918
integer height = 84
boolean italic = true
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_crear_menu
integer x = 4091
integer y = 28
integer width = 110
integer height = 96
integer taborder = 0
end type

type uo_usuario from u_em_campo_2 within w_crear_menu
integer x = 3090
integer y = 180
integer width = 1138
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_usuario.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;valor_empresa = FALSE

ue_titulo = "Selección de Usuarios"
ue_datawindow ="dw_ayuda_usuarios"
ue_filtro = ""
end event

event modificado;uo_usuario.em_campo.text = f_nombre_usuario(uo_usuario.em_codigo.text)

If Trim(uo_usuario.em_campo.text)="" then
	uo_usuario.em_campo.text=""
	uo_usuario.em_codigo.text=""
	Return
end if 

end event

type tv_tencer from treeview within w_crear_menu
integer x = 27
integer y = 136
integer width = 2560
integer height = 2864
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
string picturename[] = {"C:\Bmp\bola_roja.gif","C:\Bmp\bola_amarilla.gif","C:\Bmp\bola_verde.gif","C:\Bmp\CARPETA1.BMP","C:\Bmp\CARPETA2.BMP"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
end type

event doubleclicked;treeviewitem nodo

MESSAGEBOX("Nodo", STRING(HANDLE))


//nodo = tv_tencer.FindItem ( CurrentTreeItem!, handle )

tv_tencer.GetItem(handle, nodo)
messagebox("Nivel",string(nodo.level))





//tv_tencer.FindItem ( CurrentTreeItem!, handle )


//
//tv_tencer.linesatroot = true
//id_nodo = tv_tencer.InsertItemFirst(0,nodo)
//
end event

type pb_2 from picturebutton within w_crear_menu
integer x = 3963
integer y = 28
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
boolean originalsize = true
string picturename = "print!"
alignment htextalign = left!
end type

event clicked;//long Job
//
//Job = PrintOpen( )
//Print(Job, "ESTRUCTURA DE ARTÍCULO")
//PrintDefineFont(Job, 1, "Decorative", -18, 400, Default!, Decorative!, true, true) 
//tv_escandallo.Print(Job, 0, PrintY(Job)+500)
//
//PrintClose(Job)
//
//
end event

type cb_ultimo from commandbutton within w_crear_menu
integer x = 3045
integer y = 1184
integer width = 379
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Último"
end type

event clicked;long  id_nodo, id_nodoant
str_nodo_menu str_nodo
treeviewitem nodo
//string programa = "NULO", esgrupo = 'S'
//integer permiso = 2



if uo_usuario.em_codigo.text <> '' then
	str_nodo.programa = sle_programa.text
	str_nodo.permiso = integer(ddlb_permiso.text)
	str_nodo.esgrupo = ddlb_esgrupo.text

	nodo.data = str_nodo
	nodo.label = sle_titulo.text
	if str_nodo.esgrupo = 'S' then
		nodo.PictureIndex = 4
		nodo.SelectedPictureIndex = 4
	else
		nodo.PictureIndex = 3
		nodo.SelectedPictureIndex = 3
	end if
	
	id_nodoant = tv_tencer.FindItem(CurrentTreeItem!, 0)
	id_nodo = tv_tencer.InsertItemLast ( id_nodoant, nodo )
	
//	insert into menuarbol (empresa, id_nodo, id_nodoant, titulo, programa, permiso, usuario, esgrupo)
//	values (:codigo_empresa, :id_nodo, :id_nodoant, :sle_titulo.text, :str_nodo.programa, :str_nodo.permiso, :uo_usuario.em_codigo.text, :str_nodo.esgrupo)
//	using SQLCA;
//	 
//	if SQLCA.SQlCode <> -1 then
//		commit using SQLCA;
//	else 
//		rollback using SQLCA;
//		messagebox("Error", "Error al introducir el nodo.")
//	end if
	
	//tv_tencer.ExpandItem ( id1 )
else
	messagebox ("Aviso", " Introduzca un usuario.")
end if	

end event

type cb_raiz from commandbutton within w_crear_menu
integer x = 2661
integer y = 1184
integer width = 379
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Raíz"
end type

event clicked;long  id_nodo, id_nodoant = 0
TreeViewItem nodo
integer permiso = 2
string programa = "NULO", esgrupo = 'S'

nodo.data = programa
nodo.label = sle_titulo.text
nodo.PictureIndex = 1
nodo.SelectedPictureIndex = 4

tv_tencer.linesatroot = true
id_nodo = tv_tencer.InsertItemFirst(0,nodo)


if uo_usuario.em_campo.text <> '' then

//	insert into menuarbol (empresa, id_nodo, id_nodoant, titulo, programa, permiso, usuario, esgrupo)
//	values (:codigo_empresa, :id_nodo, :id_nodoant, :sle_titulo.text, :programa, :permiso, :uo_usuario.em_campo.text, :esgrupo)
//	using SQLCA;
//	 
//	if SQLCA.SQlCode <> -1 then
//		commit using SQLCA;
//	else 
//		rollback using SQLCA;
//	end if
else
	messagebox("Aviso", " Introduzca un usuario")
end if
end event

type cb_borrar from commandbutton within w_crear_menu
integer x = 3808
integer y = 1184
integer width = 379
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;long nodo_actual, nodo_padre
TreeviewItem nodo
string sel
boolean exito = true

nodo_actual = tv_tencer.FindItem(CurrentTreeItem!, 0)
nodo_padre = tv_tencer.FindItem (ParentTreeItem!, nodo_actual )	
tv_tencer.GetItem (nodo_actual, nodo )

if nodo.children = false then
	delete from menuarbol 
	where id_nodo = :nodo_actual
	and id_nodoant = :nodo_padre
	and usuario = :uo_usuario.em_codigo.text
	using sqlca;

	if SQLCA.SQlCode = -1 then
		exito = false
	else
//		update menuarbol	
//		set id_nodoant = id_nodoant -1
//		where id_nodoant >= :nodo_Actual
//		and usuario = :uo_usuario.em_codigo.text
//		using sqlca;
//	
//		if SQLCA.SQlCode = -1 then
//			exito = false
//		else
//			update menuarbol	
//			set id_nodo = id_nodo -1
//			where id_nodo >= :nodo_Actual
//			and usuario = :uo_usuario.em_codigo.text
//			using sqlca;
//		
//			if SQLCA.SQlCode = -1 then
//				exito = false
//			end if
//		end if			
	end if
	
	if exito then
		commit using SQLCA;
		tv_tencer.DeleteItem(nodo_actual)
	else 
		rollback using SQLCA;
	end if
else 
	messagebox("Aviso", "No se puede borrar el nodo porque tiene hijos")
end if

//CB_CARGAR.TriggerEvent(Clicked!)
//tv_tencer.ExpandItem ( nodo_padre )
end event

type cb_cargar from commandbutton within w_crear_menu
integer x = 3099
integer y = 396
integer width = 553
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;long nodo_raiz, maximo_id
TreeviewItem nodo
datastore regs
string sel, v_titulo, v_esgrupo, v_programa
long i, v_id_nodo, v_id_nodoant
integer v_permiso
long tvi_hdl = 0
long nuevo_nodo
str_nodo_menu str_nodo

// Borramos el árbol

tv_tencer.DeleteItem(0)

sel = " select id_nodo, id_nodoant, titulo, programa, permiso, esgrupo "+&
		" from menuarbol "+&
		" where usuario = '"+uo_usuario.em_codigo.text+"' "+&
		" order by id_nodo, id_nodoant "
		
f_cargar_cursor_nuevo (sel, regs)

for i = 1 to regs.rowcount()
	v_id_nodo = regs.object.id_nodo[i]
	v_id_nodoant = regs.object.id_nodoant[i]
	v_titulo = regs.object.titulo[i]
	v_permiso = regs.object.permiso[i]	
	v_esgrupo = regs.object.esgrupo[i]	
	v_programa = regs.object.programa[i]	
	
	nodo.label = v_titulo
	str_nodo.permiso = v_permiso
	if v_esgrupo = 'S' then
		str_nodo.esgrupo = 'S'
		str_nodo.programa = 'NULO'
		if v_permiso = 1 then
			nodo.pictureindex = v_permiso
			nodo.SelectedPictureIndex = v_permiso
		else
			nodo.PictureIndex = 4
			nodo.SelectedPictureIndex = 5
		end if
	else
		str_nodo.esgrupo = 'N'
		str_nodo.programa = v_programa
		
		nodo.PictureIndex = v_permiso
		nodo.SelectedPictureIndex = v_permiso
	end if	
	nodo.data = str_nodo
	
//	nuevo_nodo = tv_tencer.InsertItem(v_id_nodoant, v_id_nodo, nodo)
	nuevo_nodo = tv_tencer.InsertItemLast(v_id_nodoant,nodo)
	nodo.ItemHandle = v_id_nodo
	nodo_raiz = tv_tencer.FindItem(RootTreeItem! , 0)
	
	tv_tencer.ExpandItem(nodo_raiz)
next
destroy regs




end event

type sle_titulo from singlelineedit within w_crear_menu
integer x = 3008
integer y = 680
integer width = 1166
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type ddlb_esgrupo from dropdownlistbox within w_crear_menu
integer x = 3694
integer y = 872
integer width = 247
integer height = 356
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"S","N"}
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_crear_menu
integer x = 2651
integer y = 692
integer width = 334
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Título:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_crear_menu
integer x = 3273
integer y = 884
integer width = 407
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Es Grupo ?:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_crear_menu
integer x = 2651
integer y = 784
integer width = 334
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Programa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_programa from singlelineedit within w_crear_menu
integer x = 3008
integer y = 768
integer width = 1166
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_crear_menu
integer x = 2651
integer y = 884
integer width = 334
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Permiso:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_permiso from dropdownlistbox within w_crear_menu
integer x = 3013
integer y = 872
integer width = 247
integer height = 352
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"1","2","3"}
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_crear_menu
integer x = 2807
integer y = 188
integer width = 270
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12639424
string text = "Usuario:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_crear_menu
integer x = 3017
integer y = 984
integer width = 567
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 134217752
string text = "1: Sin permiso"
boolean focusrectangle = false
end type

type st_7 from statictext within w_crear_menu
integer x = 3017
integer y = 1036
integer width = 567
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 134217752
string text = "2: Lectura"
boolean focusrectangle = false
end type

type st_8 from statictext within w_crear_menu
integer x = 3017
integer y = 1092
integer width = 567
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 134217752
string text = "3: Lectura / Escritura"
boolean focusrectangle = false
end type

type uo_usuario_dest from u_em_campo_2 within w_crear_menu
integer x = 3090
integer y = 280
integer width = 1138
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_usuario_dest.em_campo.text = f_nombre_usuario(uo_usuario_dest.em_codigo.text)

If Trim(uo_usuario_dest.em_campo.text)="" then
	uo_usuario_dest.em_campo.text=""
	uo_usuario_dest.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;valor_empresa = FALSE

ue_titulo = "Selección de Usuarios"
ue_datawindow ="dw_ayuda_usuarios"
ue_filtro = ""
end event

on uo_usuario_dest.destroy
call u_em_campo_2::destroy
end on

type st_9 from statictext within w_crear_menu
integer x = 2610
integer y = 288
integer width = 475
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Usuario Destino:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_copiar from commandbutton within w_crear_menu
integer x = 3666
integer y = 396
integer width = 553
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copiar Menú"
end type

event clicked;datastore regs
boolean correcto 
string sel, v_titulo, v_programa, v_esgrupo
long i, v_id_nodo, v_id_nodoant
integer v_permiso



correcto = True
if uo_usuario_dest.em_codigo.text <> '' then
	delete 
	from menuarbol 
	where empresa = :codigo_empresa
	and usuario = :uo_usuario_dest.em_codigo.text
	using SQLCA;
	
	if SQLCA.SQLCode = -1 then
		correcto = false
	end if
	
	if correcto then
		sel = " select id_nodo, id_nodoant, titulo, programa, permiso, esgrupo "+&
				" from menuarbol "+&
				" where empresa = '"+codigo_empresa+"' "+&
				" and usuario = '"+uo_usuario.em_codigo.text+"' "
				
		f_cargar_cursor_nuevo (sel, regs)
		
		for i = 1 to regs.RowCount()
			
			v_id_nodo = regs.object.id_nodo[i]
			v_id_nodoant = regs.object.id_nodoant[i]
			v_titulo = regs.object.titulo[i]
			v_programa = regs.object.programa[i]
			v_permiso = regs.object.permiso[i]
			v_esgrupo = regs.object.esgrupo[i]
			
			insert into menuarbol (empresa, id_nodo, id_nodoant, titulo, programa, permiso, usuario, esgrupo)
			values (:codigo_empresa, :v_id_nodo, :v_id_nodoant, :v_titulo, :v_programa, :v_permiso, :uo_usuario_dest.em_codigo.text, :v_esgrupo)
			using SQLCA;
	 
			if SQLCA.SQlCode = -1 then
				correcto = false
				MessageBox("SQL error", SQLCA.SQLErrText)
			end if
	 		
			f_mensaje_proceso("Nodo: ",i , regs.RowCount())
		next
		if correcto then
			commit using SQLCA;
		else 
			rollback using SQLCA;
			messagebox("Error", "Error al duplicar el árbol")
		end if
	end if
else
	messagebox("Atención", "Introduzca el usuario.")
end if

destroy regs
end event

type cb_actualizar from commandbutton within w_crear_menu
integer x = 3429
integer y = 1184
integer width = 379
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;long nodo_actual, nodo_padre
integer v_permiso
TreeviewItem nodo
string sel
boolean exito = true

nodo_actual = tv_tencer.FindItem(CurrentTreeItem!, 0)
nodo_padre = tv_tencer.FindItem (ParentTreeItem!, nodo_actual )	
tv_tencer.GetItem (nodo_actual, nodo )

if sle_programa.text <> '' then
	update menuarbol	
	set programa = :sle_programa.text
	where id_nodo = :nodo_Actual
	and	id_nodoant = :nodo_padre
	and usuario = :uo_usuario.em_codigo.text
	and empresa = :codigo_empresa
	using SQLCA;
end if

if SQLCA.SQlCode = -1 then
	exito = false
end if

if sle_titulo.text <> '' then
	update menuarbol	
	set titulo = :sle_titulo.text
	where id_nodo = :nodo_Actual
	and	id_nodoant = :nodo_padre
	and usuario = :uo_usuario.em_codigo.text
	and empresa = :codigo_empresa
	using SQLCA;
end if

if SQLCA.SQlCode = -1 then
	exito = false
end if

if ddlb_esgrupo.text <> '' then
	update menuarbol	
	set esgrupo = :ddlb_esgrupo.text
	where id_nodo = :nodo_Actual
	and	id_nodoant = :nodo_padre
	and usuario = :uo_usuario.em_codigo.text
	and empresa = :codigo_empresa
	using SQLCA;
end if

if SQLCA.SQlCode = -1 then
	exito = false
end if

if ddlb_permiso.text <> '' then
	v_permiso = integer(ddlb_permiso.text)
	update menuarbol	
	set permiso = :v_permiso
	where id_nodo = :nodo_Actual
	and	id_nodoant = :nodo_padre
	and usuario = :uo_usuario.em_codigo.text
	and empresa = :codigo_empresa
	using SQLCA;
end if

if SQLCA.SQlCode = -1 then
	exito = false
end if


if exito then
	commit using SQLCA;
else 
	rollback using SQLCA;
end if

CB_CARGAR.TriggerEvent(Clicked!)
tv_tencer.ExpandItem ( nodo_padre )
end event

type cb_insertar from commandbutton within w_crear_menu
integer x = 2734
integer y = 1408
integer width = 379
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;long  id_nodo, id_nodoant, id_nodo_actual
str_nodo_menu str_nodo
treeviewitem nodo
//string programa = "NULO", esgrupo = 'S'
//integer permiso = 2



if uo_usuario.em_codigo.text <> '' then
	str_nodo.programa = sle_programa.text
	str_nodo.permiso = integer(ddlb_permiso.text)
	str_nodo.esgrupo = ddlb_esgrupo.text

	nodo.data = str_nodo
	nodo.label = sle_titulo.text
	if str_nodo.esgrupo = 'S' then
		nodo.PictureIndex = 1
		nodo.SelectedPictureIndex = 4
	else
		nodo.PictureIndex = 2
		nodo.SelectedPictureIndex = 2
	end if
	
	id_nodo_actual = tv_tencer.FindItem(CurrentTreeItem!, 0)
	id_nodoant = tv_tencer.FindItem(ParentTreeItem!, id_nodo_actual)
//	id_nodoant = tv_tencer.FindItem(CurrentTreeItem!, 0)
	
	id_nodo = tv_tencer.InsertItem ( id_nodoant, id_nodo_actual, nodo )
//	messagebox("", string(id_nodo))
	insert into menuarbol (empresa, id_nodo, id_nodoant, titulo, programa, permiso, usuario, esgrupo)
	values (:codigo_empresa, :id_nodo, :id_nodoant, :sle_titulo.text, :str_nodo.programa, :str_nodo.permiso, :uo_usuario.em_codigo.text, :str_nodo.esgrupo)
	using SQLCA;
	 
	if SQLCA.SQlCode <> -1 then
		commit using SQLCA;
	else 
		rollback using SQLCA;
		messagebox("Error", "Error al introducir el nodo.")
	end if
	
	
else
	messagebox ("Aviso", " Introduzca un usuario.")
end if	

end event

type cb_1 from commandbutton within w_crear_menu
integer x = 3383
integer y = 1620
integer width = 686
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recorrer un Treeview"
end type

event clicked;treeviewitem nodo
long itemhandle, i, j

i = 2
j = 2
do while j <> -1 
	messagebox("Nodo", string(j))
	j = tv_tencer.FindItem ( NextTreeItem!, J )
loop
end event

type r_1 from rectangle within w_crear_menu
long linecolor = 8388736
integer linethickness = 10
long fillcolor = 134217752
integer x = 2633
integer y = 648
integer width = 1582
integer height = 528
end type

type r_2 from rectangle within w_crear_menu
long linecolor = 8388736
integer linethickness = 10
long fillcolor = 134217752
integer x = 2633
integer y = 1164
integer width = 1582
integer height = 136
end type

type r_3 from rectangle within w_crear_menu
integer linethickness = 4
long fillcolor = 12639424
integer x = 2597
integer y = 164
integer width = 1646
integer height = 220
end type

type r_4 from rectangle within w_crear_menu
integer linethickness = 4
long fillcolor = 12639424
integer x = 3081
integer y = 380
integer width = 1161
integer height = 128
end type

