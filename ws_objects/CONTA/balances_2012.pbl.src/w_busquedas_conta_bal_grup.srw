$PBExportHeader$w_busquedas_conta_bal_grup.srw
forward
global type w_busquedas_conta_bal_grup from window
end type
type st_2 from statictext within w_busquedas_conta_bal_grup
end type
type p_2 from picture within w_busquedas_conta_bal_grup
end type
type p_1 from picture within w_busquedas_conta_bal_grup
end type
type em_buscar from u_em_campo within w_busquedas_conta_bal_grup
end type
type st_1 from statictext within w_busquedas_conta_bal_grup
end type
type tv_arbol from treeview within w_busquedas_conta_bal_grup
end type
type st_anterior from statictext within w_busquedas_conta_bal_grup
end type
type st_siguiente from statictext within w_busquedas_conta_bal_grup
end type
end forward

global type w_busquedas_conta_bal_grup from window
integer width = 2821
integer height = 1524
boolean titlebar = true
string title = "Ayuda de Grupos de Ctas de Resultado"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
event ue_populate ( )
event po ( )
event post_open ( )
st_2 st_2
p_2 p_2
p_1 p_1
em_buscar em_buscar
st_1 st_1
tv_arbol tv_arbol
st_anterior st_anterior
st_siguiente st_siguiente
end type
global w_busquedas_conta_bal_grup w_busquedas_conta_bal_grup

type variables

DataStore ids_Grupos,ids_Grupos2, ids_busquedas, ids_busquedasR

long 		 ilPos=0, ilPosR=0

string    is_filtro    

Boolean	 ib_cambios = False

Long		 il_DragSource, il_DragParent, il_DropTarget



end variables

forward prototypes
public subroutine wf_mover_hijos (treeview atrv_arbol, long al_h_new, long al_h_old)
end prototypes

event ue_populate();Long					ll_cont, ll_total_Grupos, ll_total_conceptos, ll_total_conceptos_Grupos, ll_base, ll_hijos, ll_cod
Long					ll_hcentro, ll_cod_emp, ll_imagen, ll_fila, ll_retorno
String				ls_datos[]

TreeviewItem		ltvi_rama

f_cargar_cursor_transaccion(sqlca,ids_busquedas, "SELECT letras as descripcion, numerico as manejador FROM comodin")
f_cargar_cursor_transaccion(sqlca,ids_busquedasR, "SELECT letras as descripcion, numerico as manejador FROM comodin")
// Genera la dw de Grupos de coste
//ll_total_Grupos = f_cargar_cursor_transaccion(sqlca,ids_Grupos, "SELECT empresa, codigo, descripcion, conta_bal_grup_codigo, orden, gpo_totalizador FROM conta_bal_grup WHERE empresa = '"+codigo_empresa+"' "+is_filtro+" order by orden asc")
ll_total_Grupos = f_cargar_cursor_transaccion(sqlca,ids_Grupos, "SELECT * FROM conta_bal_grup WHERE empresa = '"+codigo_empresa+"' "+is_filtro+" order by orden asc")
f_cargar_cursor_transaccion(sqlca,ids_Grupos2, "SELECT empresa, codigo, descripcion, conta_bal_grup_codigo, orden, gpo_totalizador FROM conta_bal_grup WHERE empresa = '"+codigo_empresa+"' "+is_filtro+" order by orden asc")
ids_busquedas.reset()

ids_Grupos.SetFilter( "" )
ids_Grupos.Filter()
ids_Grupos.SetFilter( "conta_bal_grup_codigo = '' " )
ids_Grupos.Filter()
ids_Grupos.SetSort("orden A")
ids_Grupos.Sort( )

ll_total_Grupos = ids_Grupos.RowCount()

ll_base = tv_arbol.InsertItemFirst ( 0, "Grupos", 1 )

// Despues de insertar en el arbol, insertar en la ds de busquedas
ll_fila = ids_busquedas.insertrow(0)
ids_busquedas.object.descripcion[ll_fila] = "Grupos"
ids_busquedas.object.manejador[ll_fila]		= ll_base

IF ll_total_Grupos > 0 THEN
	tv_arbol.Setredraw (False)
	FOR ll_cont = 1 TO ll_total_Grupos 
		ls_datos[1] = ids_Grupos.Object.empresa[ll_cont]
		ls_datos[2] = ids_Grupos.Object.codigo[ll_cont]	

		ll_cod_emp = Long (ls_datos[1])
		ll_cod = Long (ls_datos[2])

		SELECT COUNT (*) INTO :ll_hijos FROM conta_bal_grup WHERE empresa = :ll_cod_emp AND conta_bal_grup_codigo = :ll_cod;

		IF ll_hijos > 0 THEN 
			ltvi_rama.children = True
		ELSE
			ltvi_rama.children = False
		END IF		

		//Esto no funciona.Revisar

		if ids_Grupos.Object.gpo_totalizador[ll_cont] = 'S' then
			ltvi_rama.bold = true
		else
			ltvi_rama.bold = false
		end if

		ltvi_rama.data = ls_datos
		ltvi_rama.label = ids_Grupos.Object.descripcion[ll_cont]
		ll_imagen = 0

//		ll_imagen = tv_arbol.addpicture( ids_Grupos.Object.imagen[ll_cont])

		ltvi_rama.pictureindex = 1 //ll_imagen
		ltvi_rama.selectedpictureindex = 1//ll_imagen
		ll_hcentro = tv_arbol.insertitemlast( ll_base, ltvi_rama)	

		// Despues de insertar en el arbol, insertar en la ds de busquedas
		ll_fila = ids_busquedas.insertrow(0)
		ids_busquedas.object.descripcion[ll_fila] = ids_Grupos.Object.descripcion[ll_cont]
		ids_busquedas.object.manejador[ll_fila]		= ll_hcentro
		ll_fila = ids_busquedasR.insertrow(1)
		ids_busquedasR.object.descripcion[ll_fila] = ids_Grupos.Object.descripcion[ll_cont]
		ids_busquedasR.object.manejador[ll_fila]		= ll_hcentro

		ll_cod_emp = Long (ls_datos[1])
		ll_cod = Long (ls_datos[2])

	NEXT

	tv_arbol.expandall( ll_base)

	tv_arbol.setredraw(true)	

END IF

end event

event post_open();// Populate first level

Event ue_populate()

tv_arbol.SelectItem(1)

if em_buscar.text <> "" then st_siguiente.TriggerEvent(Clicked!)

end event

public subroutine wf_mover_hijos (treeview atrv_arbol, long al_h_new, long al_h_old);TreeviewItem		ltrvi_rama

Long					ll_mover, ll_old, ll_padre

ll_old = al_h_old

DO WHILE	ll_old > 0	
	atrv_arbol.GetItem (ll_old, ltrvi_rama )	
	ll_padre = atrv_arbol.InsertItemLast ( al_h_new, ltrvi_rama )
	ll_mover = 	atrv_arbol.FindItem(ChildTreeItem!, ll_old)	
	
	wf_mover_hijos (atrv_arbol, ll_padre, ll_mover )

	atrv_arbol.DeleteItem(ll_mover)
	
	ll_old = atrv_arbol.FindItem(NextTreeItem!, ll_old)

LOOP

end subroutine

on w_busquedas_conta_bal_grup.create
this.st_2=create st_2
this.p_2=create p_2
this.p_1=create p_1
this.em_buscar=create em_buscar
this.st_1=create st_1
this.tv_arbol=create tv_arbol
this.st_anterior=create st_anterior
this.st_siguiente=create st_siguiente
this.Control[]={this.st_2,&
this.p_2,&
this.p_1,&
this.em_buscar,&
this.st_1,&
this.tv_arbol,&
this.st_anterior,&
this.st_siguiente}
end on

on w_busquedas_conta_bal_grup.destroy
destroy(this.st_2)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.em_buscar)
destroy(this.st_1)
destroy(this.tv_arbol)
destroy(this.st_anterior)
destroy(this.st_siguiente)
end on

event open;str_parametros	lstr_parametros

lstr_parametros = Message.PowerObjectParm
em_buscar.Text      		= lstr_parametros.s_criterio_busqueda
is_filtro					= lstr_parametros.s_filtro

if trim(is_filtro) <> "" then
	is_filtro = " and "+is_filtro
end if



if isnumber(em_buscar.text) then 
	closewithreturn(this, em_buscar.text)
else
	this.hide()
	this.event post_open()
	this.show()		
end if



end event

event close;destroy ids_Grupos
destroy ids_Grupos2
destroy ids_busquedas
destroy ids_busquedasR

end event

event closequery;string ls_grupos[],ls_error,ls_sel,ls_balance
long   ll_indice,ll_total
datastore ds_datos

IF ib_cambios THEN
	IF MessageBox ("Cambios", "¿Quiere guardar los cambios realizados?", Question!, YesNo!, 2 ) = 1 THEN
		ids_grupos.setfilter("")
		ids_grupos.filter()			
		IF ids_grupos.Update() = 1 THEN
			COMMIT;
			ls_sel = "select codigo from conta_bal_cab where empresa = '"+codigo_empresa+"'"
			
			ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
			
			for ll_indice = 1 to ll_total
				ls_balance = ds_datos.object.codigo[ll_indice]
				f_asigna_orden_absoluto_conta_bal_grup(codigo_empresa,ls_balance,'',ls_grupos)
			next
			destroy ds_datos
			MessageBox ("Cambios", "!Cambios guardados correctamente¡" )
			Return 0
		ELSE
			ls_error = sqlca.sqlerrtext
			ROLLBACK;
			MessageBox ("Cambios", "!Los cambios no se han podido guardar¡~n"+ls_error )
			Return 1
		END IF
	END IF
END IF

end event

type st_2 from statictext within w_busquedas_conta_bal_grup
integer x = 27
integer y = 1364
integer width = 2757
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "*Modifique el orden de los grupos arrastrando y soltando el grupo en la posición que le corresponda*"
boolean focusrectangle = false
end type

type p_2 from picture within w_busquedas_conta_bal_grup
integer x = 2386
integer y = 28
integer width = 73
integer height = 60
string picturename = "C:\BMP\DOWN.BMP"
boolean focusrectangle = false
end type

event clicked;long  manejador, ll_retorno



tv_arbol.setfocus()

ilPos = ids_busquedas.find("upper(descripcion) like '%"+em_buscar.text+"%'", ilPos, ids_busquedas.rowcount())



if ilPos > 0 then

	manejador = ids_busquedas.object.manejador[ilPos]

	ilPosR = ids_busquedasR.find("manejador = "+string(manejador), 1, ids_busquedasR.rowcount())

	ll_retorno = tv_arbol.finditem(CurrentTreeItem!, manejador)

	tv_arbol.selectitem(manejador)

end if

ilPos++

ilPosR++

end event

type p_1 from picture within w_busquedas_conta_bal_grup
integer x = 2286
integer y = 28
integer width = 73
integer height = 60
boolean originalsize = true
string picturename = "C:\BMP\UP.BMP"
boolean focusrectangle = false
end type

type em_buscar from u_em_campo within w_busquedas_conta_bal_grup
integer x = 242
integer y = 12
integer width = 1719
integer taborder = 10
end type

event modified;call super::modified;ilPos = 0

end event

event key;tv_arbol.event key(key, keyflags)

end event

type st_1 from statictext within w_busquedas_conta_bal_grup
integer x = 14
integer y = 28
integer width = 187
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Buscar:"
boolean focusrectangle = false
end type

type tv_arbol from treeview within w_busquedas_conta_bal_grup
event ue_markitemupdated ( )
event ue_clearupdateditems ( )
event ue_changeselection ( integer ai_dwlevel )
integer x = 27
integer y = 124
integer width = 2757
integer height = 1216
integer taborder = 20
boolean dragauto = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
boolean tooltips = false
boolean trackselect = true
string picturename[] = {"C:\bmp\original2.jpg","c:\bmp\ENABLED\folder_beige2.gif","c:\bmp\ENABLED\Folder-4.GIF","",""}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 12632256
string statepicturename[] = {"C:\BMP\DISKSAVE.BMP"}
long statepicturemaskcolor = 12632256
end type

event itemexpanded;//Long			ll_hijo

//Window		lw_ventana

//

//lw_ventana = getparent( )

//

//lw_ventana.setredraw( False )

//

//ll_hijo = FindItem ( ChildTreeItem!, handle )

//

//DO WHILE ll_hijo > 0

//	SelectItem ( ll_hijo )

//	ll_hijo = FindItem ( NextTreeItem!, ll_hijo )

//LOOP

//

//SelectItem ( handle )

//

//lw_ventana.setredraw( True )

end event

event itempopulate;Long					ll_cont, ll_total, ll_base, ll_cod, ll_hijos, ll_cod_emp, ll_hcentro

Long					ll_total_conceptos_Grupos, ll_cont_conceptos_Grupos, ll_imagen, ll_retorno, ll_fila

Long					ll_total_conceptos, ll_cont_conceptos

String				ls_datos[], ls_codigo[], ls_codigos

TreeviewItem		ltvi_rama



IF This.GetItem(handle, ltvi_rama) = -1 THEN Return 



IF ltvi_rama.level > 1 THEN

	ls_datos = ltvi_rama.data

	

	//Es Centro

	ids_Grupos2.SetFilter( "" )

	ids_Grupos2.Filter()

	ids_Grupos2.SetFilter( " conta_bal_grup_codigo = '" + ls_datos[2] + "'" )

	ids_Grupos2.Filter()

	ids_Grupos2.SetSort("orden A")

	ids_Grupos2.Sort( )

	

	ll_total = ids_Grupos2.RowCount()

	

	IF ll_total > 0 THEN

		tv_arbol.Setredraw (False)

		FOR ll_cont = 1 TO ll_total 

			ls_datos[1] = ids_Grupos2.Object.empresa[ll_cont]

			ls_datos[2] = ids_Grupos2.Object.codigo[ll_cont]

		

			ll_cod_emp = Long (ls_datos[1])

			ll_cod = Long (ls_datos[2])

			SELECT COUNT (*) INTO :ll_hijos FROM conta_bal_grup WHERE empresa = :ll_cod_emp AND conta_bal_grup_codigo = :ll_cod;

			IF ll_hijos > 0 THEN 

				ltvi_rama.children = True

			ELSE

				ltvi_rama.children = False

			END IF

			ltvi_rama.data = ls_datos

			ltvi_rama.label = ids_Grupos2.Object.descripcion[ll_cont]

			//Esto no funciona.Revisar

			if ids_Grupos2.Object.gpo_totalizador[ll_cont] = 'S' then

				ltvi_rama.bold = true

			else

				ltvi_rama.bold = false

			end if			

			

			ll_imagen = 0

//			ll_imagen = tv_arbol.addpicture( ids_Grupos2.Object.imagen[ll_cont] )

			ltvi_rama.pictureindex = 1 // ll_imagen

			ltvi_rama.selectedpictureindex = 1 // ll_imagen

			

			ll_hcentro = tv_arbol.insertitemlast( handle, ltvi_rama)

			// Despues de insertar en el arbol, insertar en la ds de busquedas

			ll_fila = ids_busquedas.insertrow(0)

			ids_busquedas.object.descripcion[ll_fila] = ids_Grupos2.Object.descripcion[ll_cont]

			ids_busquedas.object.manejador[ll_fila]		= ll_hcentro

			ll_fila = ids_busquedasR.insertrow(1)

			ids_busquedasR.object.descripcion[ll_fila] = ids_Grupos2.Object.descripcion[ll_cont]

			ids_busquedasR.object.manejador[ll_fila]		= ll_hcentro			

		

			ll_cod_emp = Long (ls_datos[1])

			ll_cod = Long (ls_datos[2])

//			SELECT COUNT (*) INTO :ll_hijos FROM cos_conceptos_Grupos WHERE empresa = :ll_cod_emp AND conta_bal_grup_codigo = :ll_cod;

//			IF ll_hijos > 0 THEN 

//				ls_datos[1] = ids_Grupos2.Object.empresa[ll_cont]

//				ls_datos[2] = ids_Grupos2.Object.codigo[ll_cont]

//				

////				ltvi_rama.children = True

////				ltvi_rama.data = ls_datos

////				ltvi_rama.label = "Conceptos --> " + Lower (ids_Grupos2.Object.descripcion[ll_cont])

////				ltvi_rama.pictureindex = 2

////				ltvi_rama.selectedpictureindex = 3

////				

////				ll_retorno = tv_arbol.insertitemlast( ll_hcentro, ltvi_rama)

////			

//				// Despues de insertar en el arbol, insertar en la ds de busquedas

//				ll_fila = ids_busquedas.insertrow(0)

//				ids_busquedas.object.descripcion[ll_fila] = ids_Grupos2.Object.descripcion[ll_cont]

//				ids_busquedas.object.manejador[ll_fila]		= ll_retorno

//				ll_fila = ids_busquedasR.insertrow(1)

//				ids_busquedasR.object.descripcion[ll_fila] = ids_Grupos2.Object.descripcion[ll_cont]

//				ids_busquedasR.object.manejador[ll_fila]		= ll_retorno

//				

//				

//			END IF

		NEXT

	END IF

			

	tv_arbol.Setredraw (True)

END IF

end event

event key;TreeViewItem		ltvi_Source

String				ls_datos[]

long					indice



if key = KeyEnter! then

	indice = This.GetItemAtPointer() 

	

	if indice = -1 or indice = 0 THEN Return



	this.getitem(indice, ltvi_Source)

	IF FindItem(RootTreeItem!, 0) = indice THEN 

		return

	end if

	

	ls_datos = ltvi_Source.data	

	closewithreturn(parent, ls_datos[2])

end if



IF key = keyF4! then

	st_anterior.triggerevent(clicked!)

end if



if key = keyf5! then

	st_siguiente.triggerevent(clicked!)

end if



if key = keyEscape! then

	closewithreturn(parent, '')

end if

end event

event doubleclicked;this.event key(keyenter!, 0)

end event

event begindrag;TreeViewItem		ltvi_Source

String				ls_datos[]//1 EMPRESA ,2 CODIGO



IF This.GetItem(handle, ltvi_Source) = -1 THEN Return



IF FindItem(RootTreeItem!, 0) = handle THEN 

	This.Drag(Cancel!)

ELSE

	

	ls_datos = ltvi_Source.data	

		

	IF ls_datos[2] <> "" THEN 

		il_DragSource = handle

		il_DragParent = FindItem(ParentTreeItem!, handle)

	ELSE

		This.Drag(Cancel!)

	End If

END IF

end event

event dragwithin;TreeViewItem		ltvi_Over, ltvi_Source

String				ls_datos_origen[], ls_datos_destino[]



If GetItem(handle, ltvi_Over) = -1 Then

	SetDropHighlight(0)

	il_DropTarget = 0

	Return

End If



//En este if comprobamos si el elemento arrastrado y el elemento sobre el que pasamos pertenecen a la misma rama

IF FindItem(ParentTreeItem!, il_DragSource) = FindItem(ParentTreeItem!, handle) OR &
		FindItem(ParentTreeItem!, il_DragSource) = handle THEN

		

		SetDropHighlight(handle)

		il_DropTarget = handle

		

End If

	



end event

event dragdrop;TreeViewItem		ltvi_Target, ltvi_Source, ltvi_New

Integer				li_resp

Long					ll_NewItem, ll_hijo, ll_handle, ll_parent, ll_cont, ll_encontrado, ll_centro

Long					ll_mover, ll_hermano

String				ls_datos[], ls_conta_bal_grup_codigo, ls_datos_origen[], ls_datos_destino[]





If GetItem(il_DropTarget, ltvi_Target) = -1 Then Return

If GetItem(il_DragSource, ltvi_Source) = -1 Then Return



IF il_DragSource <> il_DropTarget THEN

	ls_datos_origen = ltvi_Source.Data

	

	IF FindItem(ParentTreeItem!, il_DragSource) = il_DropTarget THEN

		li_resp = MessageBox("Moviendo Centros", "¿Estás seguro de que quieres mover el grupo " + &
					ltvi_Source.Label + " a la primera posición ?", Question!, YesNo!)

	ELSE

		li_resp = MessageBox("Moviendo Centros", "¿Estás seguro de que quieres mover el grupo " + &
					ltvi_Source.Label + " tras " + ltvi_Target.label + "?", Question!, YesNo!)

	END IF

	

	IF li_resp = 1 THEN		

		ll_parent = FindItem(ParentTreeItem!, il_DragSource)

		IF ll_parent = il_DropTarget THEN		

			ll_NewItem = InsertItemFirst(il_DropTarget, ltvi_Source)

		ELSE

			ll_NewItem = InsertItem(ll_parent, il_DropTarget,ltvi_Source)

		END IF			

		

		ll_mover = 	FindItem(ChildTreeItem!, il_DragSource)	

		wf_mover_hijos (This, ll_NewItem, ll_mover )				

		DeleteItem(il_DragSource)			

					

		ll_hermano = ll_mover			

		DO WHILE	ll_hermano > 0	

			ll_hermano = FindItem(NextTreeItem!, ll_hermano)	

			wf_mover_hijos (This, ll_NewItem, ll_hermano )	

			DeleteItem(ll_hermano)

		LOOP



		ll_parent = FindItem (ParentTreeItem!, ll_NewItem)

		

		IF FindItem (ParentTreeItem!, ll_NewItem) = FindItem (RootTreeItem!, 0) THEN

			ls_conta_bal_grup_codigo = ""

		ELSE

			GetItem(FindItem (ParentTreeItem!, ll_NewItem), ltvi_New)

			ls_datos = ltvi_New.Data

			ls_conta_bal_grup_codigo = ls_datos[2]

		END IF

			

		ll_cont = 0

		ids_grupos.SetFilter( "" )

		ids_grupos.Filter()

		ids_grupos.SetFilter( " conta_bal_grup_codigo = '" + ls_conta_bal_grup_codigo + "'" )

		ids_grupos.Filter()

		

		ll_hijo = FindItem (ChildTreeItem!, ll_parent)

		

		IF ll_hijo > -1 THEN		

							

			GetItem(ll_hijo, ltvi_New) //ll_parent Es el Centro del que depende

			ls_datos = ltvi_New.Data						

		

			DO WHILE ll_hijo > - 1

				ll_cont ++

				GetItem(ll_hijo, ltvi_New)

				ls_datos = ltvi_New.Data

				ll_encontrado = ids_grupos.Find ( "empresa = '" + ls_datos[1] + &
										"' And  codigo = '" + ls_datos[2] + &
										"'", 1, ids_grupos.RowCount() )

		

				IF ll_encontrado > 0 THEN ids_grupos.Object.orden[ll_encontrado] = ll_cont

				ib_cambios = True

				

				ltvi_New.statepictureindex = 1

				SetItem(ll_hijo, ltvi_New)

				ll_hijo = FindItem (NextTreeItem!, ll_hijo)

			LOOP

				

		END IF // hijo > -1

	END IF // resp = 1

		

END IF

	

	

/*  Turn off drop highlighting  */

this.SetDropHighlight (0)



	// Select the new item

IF ll_NewItem > 0 THEN

	SelectItem(ll_NewItem)

ELSE

	SelectItem(il_DragSource)

END IF





	

	



end event

type st_anterior from statictext within w_busquedas_conta_bal_grup
integer x = 1993
integer y = 16
integer width = 379
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "F4.- Anterior"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;long  manejador, ll_retorno

tv_arbol.setfocus()

ilPosR = ids_busquedasR.find("upper(descripcion) like '%"+em_buscar.text+"%'", ilPosR, ids_busquedas.rowcount())

if ilPosR > 0 then

	manejador = ids_busquedasR.object.manejador[ilPosR]

	// Simular la fila en busquedas

	ilPos = ids_busquedas.find("manejador = "+string(manejador), 1, ids_busquedas.rowcount())	

	ll_retorno = tv_arbol.finditem(CurrentTreeItem!, manejador)

	tv_arbol.selectitem(manejador)

end if

ilPosR++

ilPos++

end event

type st_siguiente from statictext within w_busquedas_conta_bal_grup
integer x = 2377
integer y = 16
integer width = 411
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "F5.- Siguiente"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;long  manejador, ll_retorno

tv_arbol.setfocus()
ilPos = ids_busquedas.find("upper(descripcion) like '%"+em_buscar.text+"%'", ilPos, ids_busquedas.rowcount())

if ilPos = 0 then
	ilPos = ids_busquedas.find("upper(descripcion) like '%"+em_buscar.text+"%'", 0, ids_busquedas.rowcount())
end if

if ilPos > 0 then
	manejador = ids_busquedas.object.manejador[ilPos]
	ilPosR = ids_busquedasR.find("manejador = "+string(manejador), 1, ids_busquedasR.rowcount())
	ll_retorno = tv_arbol.finditem(CurrentTreeItem!, manejador)
	tv_arbol.selectitem(manejador)	
end if

ilPos++

ilPosR++

end event

