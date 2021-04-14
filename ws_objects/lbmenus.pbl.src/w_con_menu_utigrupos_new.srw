$PBExportHeader$w_con_menu_utigrupos_new.srw
forward
global type w_con_menu_utigrupos_new from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_menu_utigrupos_new
end type
type uo_manejo from u_manejo_datawindow within w_con_menu_utigrupos_new
end type
type pb_2 from upb_imprimir within w_con_menu_utigrupos_new
end type
type cb_guardar from commandbutton within w_con_menu_utigrupos_new
end type
type cb_act_opciones from commandbutton within w_con_menu_utigrupos_new
end type
type dw_empresas from datawindow within w_con_menu_utigrupos_new
end type
type dw_utigrupos from datawindow within w_con_menu_utigrupos_new
end type
type cbx_propagar_activo from checkbox within w_con_menu_utigrupos_new
end type
type cbx_propagar_altas from checkbox within w_con_menu_utigrupos_new
end type
type cbx_propagar_bajas from checkbox within w_con_menu_utigrupos_new
end type
type cbx_propagar_cambios from checkbox within w_con_menu_utigrupos_new
end type
type cbx_propagar_consultas from checkbox within w_con_menu_utigrupos_new
end type
type cb_perfil from commandbutton within w_con_menu_utigrupos_new
end type
type st_1 from statictext within w_con_menu_utigrupos_new
end type
type gb_1 from groupbox within w_con_menu_utigrupos_new
end type
type arbol from treeview within w_con_menu_utigrupos_new
end type
end forward

global type w_con_menu_utigrupos_new from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 5655
integer height = 3456
pb_1 pb_1
uo_manejo uo_manejo
pb_2 pb_2
cb_guardar cb_guardar
cb_act_opciones cb_act_opciones
dw_empresas dw_empresas
dw_utigrupos dw_utigrupos
cbx_propagar_activo cbx_propagar_activo
cbx_propagar_altas cbx_propagar_altas
cbx_propagar_bajas cbx_propagar_bajas
cbx_propagar_cambios cbx_propagar_cambios
cbx_propagar_consultas cbx_propagar_consultas
cb_perfil cb_perfil
st_1 st_1
gb_1 gb_1
arbol arbol
end type
global w_con_menu_utigrupos_new w_con_menu_utigrupos_new

type variables
string filtro
Long							il_new_handle
Boolean						ib_actualizar = False
end variables

forward prototypes
public subroutine wf_menu_cargar (treeview atrv_arbol)
public function integer wf_insertar_opcion_menu (string as_utigrupos, string as_datos[])
end prototypes

public subroutine wf_menu_cargar (treeview atrv_arbol);String			ls_sel, ls_descripcion, ls_programa, ls_texto, ls_datos[], ls_apli[]
Int					li_aux, li_codigo, li_pos
Long				ll_apli, ll_cont, ll_padre,  ll_base, ll_row
DataStore		lds_aplicaciones, lds_base
window 			lw_ventana
TreeviewItem	ltrvi_subarbol
Menu				lm_menu

SetPointer(HourGlass!)

ls_sel = "Select  Distinct Convert ( Char, (codigo+0)) apli, descripcion, menu  from grupo_aplicacion  order by apli"
		
lds_aplicaciones = f_cargar_cursor(ls_sel)
ll_apli = lds_aplicaciones.RowCount()
if ll_apli = 0 then 
	messagebox("Atencion","¡No hay Grupos de Aplicación definidos!")
	If IsValid (lds_aplicaciones) Then Destroy (lds_aplicaciones)
	Close(This)
end if

atrv_arbol.setredraw( False)
atrv_arbol.DeleteItem(0)
dw_utigrupos.Reset()
dw_empresas.Reset()

ll_base = atrv_arbol.InsertItemLast(0, "MENUS", 1)	
ll_padre = ll_base

f_mensaje_proceso("Cargando Menú",0,100)
For ll_cont = 1 To ll_apli	
	ls_apli = lds_aplicaciones.Object.Data[ll_cont]
	
	lm_menu = CREATE USING ls_apli[3]
	
	IF IsValid (lm_menu) THEN
		guo_menu_utigrupos.of_menu_insertar_arbol( arbol,ll_base, 2, ls_apli[1], lm_menu)	
		
		Destroy lm_menu	
	END IF
	
	f_mensaje_proceso("Cargando Menú",ll_cont,ll_apli)
Next
		
If IsValid (lds_aplicaciones) Then Destroy lds_aplicaciones
If IsValid (lds_base) Then Destroy lds_base

dw_empresas.SetRedraw(False)
dw_empresas.Retrieve()
dw_empresas.SetFilter("1=2")
dw_empresas.Filter()
dw_empresas.SetRedraw( True )

dw_utigrupos.SetRedraw(True)
dw_utigrupos.Retrieve()

arbol.Sort(ll_padre , Ascending!)
ll_base = arbol.FindItem ( ChildTreeItem!, ll_base )
arbol.SelectItem(ll_base)
arbol.event SelectionChanged (1,ll_base)	

arbol.setredraw( true)

SetPointer(Arrow!)



end subroutine

public function integer wf_insertar_opcion_menu (string as_utigrupos, string as_datos[]);
DataStore	lds_empresas
String		ls_select,ls_empresa,ls_nombre_menu,ls_utigrupos,ls_grupo_aplicacion
Long			ll_total, ll_cont, ll_row,ll_existe


ls_select = "Select empresas.empresa, empresas.nombre FROM utigrupos, empresas " + & 
				" WHERE utigrupos.codigo = '" + as_utigrupos + "'"


lds_empresas = f_cargar_cursor(ls_select)
ll_total = lds_empresas.RowCount()

FOR ll_cont = 1 TO ll_total	
	ll_existe = 0
//	ls_empresa     = lds_empresas.Object.empresas_nombre[ll_cont]
	ls_empresa     = lds_empresas.Object.empresas_empresa[ll_cont]
	ls_nombre_menu = as_datos[2]
	ls_utigrupos     = as_utigrupos
	ls_grupo_aplicacion       = as_datos[1]
	
	 SELECT count(*)
	 into   :ll_existe
	 from   utigrupos_menu
	 where  utigrupos_menu.empresa     = :ls_empresa
	 and	  utigrupos_menu.nombre_menu = :ls_nombre_menu
	 and	  utigrupos_menu.utigrupos   = :ls_utigrupos
	 and	  utigrupos_menu.grupo_aplicacion = :ls_grupo_aplicacion;   
	
	if isnull(ll_existe) then ll_existe = 0
	if ll_existe = 0 then
		ll_row = dw_empresas.InsertRow(0)
		dw_empresas.Object.nombre[ll_row] 								= lds_empresas.Object.empresas_nombre[ll_cont]
		dw_empresas.Object.utigrupos_menu_nombre_menu[ll_row] 	= as_datos[2]
		dw_empresas.Object.utigrupos_menu_grupo_aplicacion[ll_row] = as_datos[1]
		dw_empresas.Object.utigrupos_menu_utigrupos[ll_row] 		= as_utigrupos
		dw_empresas.Object.utigrupos_menu_empresa[ll_row] 			= lds_empresas.Object.empresas_empresa[ll_cont]
		dw_empresas.Object.utigrupos_menu_descripcion[ll_row] 	= as_datos[4]
		dw_empresas.Object.utigrupos_menu_nombre_ventana[ll_row] = as_datos[3]
		dw_empresas.Object.activo[ll_row] 								= "0"
		dw_empresas.Object.altas[ll_row] 								= "N"
		dw_empresas.Object.bajas[ll_row] 								= "N"
		dw_empresas.Object.cambios[ll_row] 								= "N"
		dw_empresas.Object.consultas[ll_row] 							= "N"
	end if
NEXT

IF dw_empresas.Update() = 1 THEN
	Commit;
	Destroy (lds_empresas)
	Return ll_total
ELSE
	RollBack;
	Destroy (lds_empresas)
	Return 0
END IF

end function

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.TriggerEvent("pagina_arriba")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.TriggerEvent("pagina_abajo")
end event

event open;istr_parametros.s_titulo_ventana="Consulta/Generacion de Permisos de Menús por Grupos"
This.title=istr_parametros.s_titulo_ventana

dw_utigrupos.SetTransObject(SQLCA)
dw_empresas.SetTransObject(SQLCA)

//IF is_cambio = "S" THEN 
//	cb_act_opciones.Enabled = True
//ELSE
//	cb_act_opciones.Enabled = False
//END IF

wf_menu_cargar(arbol)

end event

on w_con_menu_utigrupos_new.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.pb_2=create pb_2
this.cb_guardar=create cb_guardar
this.cb_act_opciones=create cb_act_opciones
this.dw_empresas=create dw_empresas
this.dw_utigrupos=create dw_utigrupos
this.cbx_propagar_activo=create cbx_propagar_activo
this.cbx_propagar_altas=create cbx_propagar_altas
this.cbx_propagar_bajas=create cbx_propagar_bajas
this.cbx_propagar_cambios=create cbx_propagar_cambios
this.cbx_propagar_consultas=create cbx_propagar_consultas
this.cb_perfil=create cb_perfil
this.st_1=create st_1
this.gb_1=create gb_1
this.arbol=create arbol
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.cb_guardar
this.Control[iCurrent+5]=this.cb_act_opciones
this.Control[iCurrent+6]=this.dw_empresas
this.Control[iCurrent+7]=this.dw_utigrupos
this.Control[iCurrent+8]=this.cbx_propagar_activo
this.Control[iCurrent+9]=this.cbx_propagar_altas
this.Control[iCurrent+10]=this.cbx_propagar_bajas
this.Control[iCurrent+11]=this.cbx_propagar_cambios
this.Control[iCurrent+12]=this.cbx_propagar_consultas
this.Control[iCurrent+13]=this.cb_perfil
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.arbol
end on

on w_con_menu_utigrupos_new.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.pb_2)
destroy(this.cb_guardar)
destroy(this.cb_act_opciones)
destroy(this.dw_empresas)
destroy(this.dw_utigrupos)
destroy(this.cbx_propagar_activo)
destroy(this.cbx_propagar_altas)
destroy(this.cbx_propagar_bajas)
destroy(this.cbx_propagar_cambios)
destroy(this.cbx_propagar_consultas)
destroy(this.cb_perfil)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.arbol)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
end event

event closequery;call super::closequery;String 			ls_mensaje

ls_mensaje = ""
IF ib_actualizar THEN	ls_mensaje = "~r~rRecuerde que tiene cambios pendientes de guardar¡¡"

IF MessageBox("Menú utigrupos", "Se dispone a cerrar la ventana Menú Grupos¡ " + ls_mensaje + " ~r~r¿Quiere salir de la ventana?", Exclamation!, YesNo!, 2) = 2 THEN
	Return 1
ELSE
	Return 0
END IF

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_menu_utigrupos_new
integer x = 1943
integer y = 844
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_menu_utigrupos_new
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_menu_utigrupos_new
integer x = 9
integer y = 4
integer width = 5481
integer height = 104
long textcolor = 0
long backcolor = 134217750
boolean border = true
end type

type pb_1 from upb_salir within w_con_menu_utigrupos_new
integer x = 5504
integer width = 137
integer height = 116
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_menu_utigrupos_new
integer x = 133
integer y = 688
integer width = 649
integer height = 144
boolean border = true
end type

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type pb_2 from upb_imprimir within w_con_menu_utigrupos_new
integer x = 690
integer y = 372
integer width = 105
integer height = 192
integer taborder = 0
boolean originalsize = false
end type

type cb_guardar from commandbutton within w_con_menu_utigrupos_new
integer x = 14
integer y = 144
integer width = 645
integer height = 92
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar Menú"
end type

event clicked;IF ib_actualizar THEN
	IF MessageBox("Guardar Menú", "¿Quiere Guardar los cambios realizados en el Menú?", Question!, YesNo!, 2) = 1 THEN
		f_mensaje_proceso("Cargando Menú",0,100)
		If dw_empresas.Update() = 1 Then
		//	DELETE FROM utigrupos_menu_base USING SQLCA;
		//	IF ids_menu_base.Update() = 1 THEN
				COMMIT;
				ib_actualizar = False
				f_mensaje_proceso("Cargando Menú",100,100)
				MessageBox("Guardar Menú", "Cambios en el Menú guardados correctamente¡")
				
				if isvalid(w_con_menu_utigrupos_estado) then
					Long				ll_row
					String			ls_sel, ls_utigrupos, ls_empresa
					
					ls_utigrupos = w_con_menu_utigrupos_estado.is_grupo
					ls_empresa = w_con_menu_utigrupos_estado.is_empresa
					
					dw_empresas.SetRedraw(False)
					dw_empresas.setFilter("")
					dw_empresas.Filter()
					dw_empresas.setFilter( " utigrupos_menu_utigrupos =  '" + ls_utigrupos + "' And utigrupos_menu_empresa = '" + ls_empresa + "'")
					dw_empresas.Filter()
				
					w_con_menu_utigrupos_estado.event open()
					
					ll_row = dw_utigrupos.getselectedrow( 0)
					IF ll_row = 0 THEN ll_row = 1
					
					dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)												
				end if
			Else
				ROLLBACK;
				f_mensaje_proceso("Cargando Menú",100,100)
				MessageBox("Guardar Menú", "Cambios en el Menú NO se han podido guardar correctamente¡", Exclamation!)
			End If
		//Else
		//	ROLLBACK;
		//End If
	END IF
ELSE
		MessageBox("Guardar Menú", "No hay cambios que guardar¡")
END IF	

end event

type cb_act_opciones from commandbutton within w_con_menu_utigrupos_new
integer x = 855
integer y = 144
integer width = 645
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar Menú"
end type

event clicked;Long				ll_espacios, ll_base		
String			ls_grupo_aplicacion, ls_grupo_aplicacion_nombre, ls_datos[], ls_mensaje1, ls_mensaje2
Boolean			lb_todo
TreeViewitem  	ltvi_rama


//Tencer no utiliza modulos

il_new_handle = 1

//IF il_new_handle < 1 THEN return
//IF arbol.GetItem ( il_new_handle, ltvi_rama) = -1 THEN Return
//
//IF il_new_handle > 1 THEN 
//	If Not IsNull (ltvi_rama.data) Then					
//		ll_base = il_new_handle
//		do while ltvi_rama.level <> 2 
//			ll_base = arbol.FindItem ( ParentTreeItem!, ll_base )	
//			arbol.GetItem ( ll_base, ltvi_rama)
//		loop			
//		ls_datos = ltvi_rama.data
//		ls_grupo_aplicacion = Trim(ls_datos[1])
//		ls_grupo_aplicacion_nombre= Trim(ls_datos[4])		
//		
//		IF IsNull(ls_grupo_aplicacion) OR ls_grupo_aplicacion = "" THEN 
//			MessageBox("Actualizar Opciones Menú por Grupo", "Opciones Menú NO actualizadas correctamente por no conocer el grupo¡")
//			Return
//		END IF
//	
//		lb_todo = False
//	ELSE
//		MessageBox("Actualizar Opciones Menú por Grupo", "Opciones Menú NO actualizadas correctamente por no conocer el grupo¡")
//		Return
//	END IF
//ELSE
	ls_grupo_aplicacion = "TODOS"
	lb_todo = True
//END IF

ls_mensaje1 = "Se dispone a actualizar las opciones del Menú de utigrupos para el 'Grupo' : " + ls_grupo_aplicacion_nombre + " ¡"
ls_mensaje2 = "¿Quiere realizar dicha operación?"
ll_espacios = (Len (ls_mensaje1) - Len(ls_mensaje2)) / 2

IF MessageBox("Actualizar Opciones Menú", ls_mensaje1 + &
	Space (ll_espacios) + "~r~r" + ls_mensaje2, Question!, YesNo!, 2) = 1 THEN
	
	SetPointer(HourGlass!)
	ib_actualizar = False
	arbol.DeleteItem(0)
	arbol.setredraw( False)
	dw_utigrupos.Reset()
	dw_empresas.Reset()
	SetPointer(Arrow!)
	
	IF lb_todo THEN		
		IF guo_menu_utigrupos.of_menu_actualizar_opciones( ) THEN
			MessageBox("Actualizar Opciones Menú por Grupo", "Opciones Menú actualizadas correctamente¡")
		ELSE
			MessageBox("Actualizar Opciones Menú por Grupo", "Opciones Menú NO actualizadas correctamente¡")
		END IF
	ELSE
		IF guo_menu_utigrupos.of_menu_actualizar_opciones( ls_grupo_aplicacion) THEN
			MessageBox("Actualizar Opciones Menú por Grupo", "Opciones Menú actualizadas correctamente¡")
		ELSE
			MessageBox("Actualizar Opciones Menú por Grupo", "Opciones Menú NO actualizadas correctamente¡")
		END IF
	END IF
		
	wf_menu_cargar(arbol)
		
END IF







//Long				ll_espacios
//
//ll_espacios = (Len ("Se dispone a actualizar las opciones del Menú de utigrupos¡") - Len("¿Quiere realizar dicha operación?")) / 2
//
//IF MessageBox("Actualizar Opciones Menú", "Se dispone a actualizar las opciones del Menú de utigrupos¡" + &
//	Space (ll_espacios) + "~r~r¿Quiere realizar dicha operación?", Question!, YesNo!, 2) = 1 THEN
//	
//		SetPointer(HourGlass!)
//		ib_actualizar = False
//		arbol.DeleteItem(0)
//		arbol.setredraw( False)
//		dw_utigrupos.Reset()
//		dw_empresas.Reset()
//		SetPointer(Arrow!)
//		
//		IF guo_menu_utigrupos.of_menu_actualizar_opciones( ) THEN
//			MessageBox("Actualizar Opciones Menú", "Opciones Menú actualizadas correctamente¡")
//		ELSE
//			MessageBox("Actualizar Opciones Menú", "Opciones Menú NO actualizadas correctamente¡")
//		END IF
//		
//		wf_menu_cargar(arbol)
//		
//END IF
//
end event

type dw_empresas from datawindow within w_con_menu_utigrupos_new
integer x = 3310
integer y = 296
integer width = 2331
integer height = 3000
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_empresas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;String		ls_utigrupos, ls_empresa
Long			ll_valor, ll_row
		
if dwo.name = 'utigrupos_menu_activar_todo' then
	this.object.activo[row] = data
	if data = '1' then
		this.object.altas[row] = 'S'
		this.object.bajas[row] = 'S'
		this.object.cambios[row] = 'S'
		this.object.consultas[row] = 'S'
	else
		this.object.altas[row] = 'N'
		this.object.bajas[row] = 'N'
		this.object.cambios[row] = 'N'
		this.object.consultas[row] = 'N'		
	end if
	ib_actualizar = True
end if
		
IF dwo.Name = "activo"  OR dwo.Name = "altas" OR dwo.Name = "bajas" OR dwo.Name = "cambios" &
	OR dwo.Name = "consultas" OR dwo.Name = "acceso_directo" OR dwo.Name = "nombre_boton"   & 
		THEN	ib_actualizar = True


//IF dwo.Name = "activo" THEN
//	IF cbx_propagar_activo.Checked THEN		
//		
//		This.Object.activo[row] = data
//		ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
//		ls_empresa = This.Object.utigrupos_menu_empresa[row]
//		
//		ll_row = dw_utigrupos.getselectedrow( 0)
//		IF ll_row = 0 THEN ll_row = 1	
//		
//		dw_empresas.SetRedraw( False )
//		dw_empresas.SetFilter("")
//		dw_empresas.Filter()
//		
//		ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
//		guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "activo" )
//					
//		dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
//		
//	END IF
//END IF
//
//IF dwo.Name = "altas" THEN
//	IF cbx_propagar_altas.Checked THEN
//		
//		This.Object.altas[row] = data
//		ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
//		ls_empresa = This.Object.utigrupos_menu_empresa[row]
//		
//		ll_row = dw_utigrupos.getselectedrow( 0)
//		IF ll_row = 0 THEN ll_row = 1	
//		
//		dw_empresas.SetRedraw( False )
//		dw_empresas.SetFilter("")
//		dw_empresas.Filter()
//		
//		ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
//		guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "altas" )
//					
//		dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
//		
//	END IF
//END IF
//
//IF dwo.Name = "bajas" THEN
//	IF cbx_propagar_bajas.Checked THEN
//		
//		This.Object.bajas[row] = data
//		ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
//		ls_empresa = This.Object.utigrupos_menu_empresa[row]
//		
//		ll_row = dw_utigrupos.getselectedrow( 0)
//		IF ll_row = 0 THEN ll_row = 1	
//		
//		dw_empresas.SetRedraw( False )
//		dw_empresas.SetFilter("")
//		dw_empresas.Filter()
//		
//		ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
//		guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "bajas" )
//					
//		dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
//		
//	END IF
//END IF
//
//IF dwo.Name = "cambios" THEN
//	IF cbx_propagar_cambios.Checked THEN
//		
//		This.Object.cambios[row] = data
//		ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
//		ls_empresa = This.Object.utigrupos_menu_empresa[row]
//		
//		ll_row = dw_utigrupos.getselectedrow( 0)
//		IF ll_row = 0 THEN ll_row = 1	
//		
//		dw_empresas.SetRedraw( False )
//		dw_empresas.SetFilter("")
//		dw_empresas.Filter()
//		
//		ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
//		guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "cambios" )
//					
//		dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
//		
//	END IF
//END IF
//
//IF dwo.Name = "consultas" THEN
//	IF cbx_propagar_consultas.Checked THEN
//		
//		This.Object.consultas[row] = data
//		ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
//		ls_empresa = This.Object.utigrupos_menu_empresa[row]
//		
//		ll_row = dw_utigrupos.getselectedrow( 0)
//		IF ll_row = 0 THEN ll_row = 1	
//		
//		dw_empresas.SetRedraw( False )
//		dw_empresas.SetFilter("")
//		dw_empresas.Filter()
//		
//		ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
//		guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "consultas" )
//					
//		dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
//		
//	END IF
//END IF
	
IF dwo.Name = "acceso_directo" THEN
//	IF cbx_propagar_consultas.Checked THEN
		
//		This.Object.consultas[row] = data
//		ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
//		ls_empresa = This.Object.utigrupos_menu_empresa[row]
//		
//		ll_row = dw_utigrupos.getselectedrow( 0)
//		IF ll_row = 0 THEN ll_row = 1	
//		
//		dw_empresas.SetRedraw( False )
//		dw_empresas.SetFilter("")
//		dw_empresas.Filter()
//		
//		ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
//		guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "consultas" )
//					
//		dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
		
//	END IF	
END IF
end event

event rbuttondown;IF row > 0 THEN
	Long				ll_row
	String			ls_sel, ls_utigrupos, ls_empresa
	
	ls_utigrupos = dw_empresas.Object.utigrupos_menu_utigrupos[row] 
	ls_empresa = dw_empresas.Object.utigrupos_menu_empresa[row] 
	
	dw_empresas.SetRedraw(False)
	dw_empresas.setFilter("")
	dw_empresas.Filter()
	dw_empresas.setFilter( " utigrupos_menu_utigrupos =  '" + ls_utigrupos + "' And utigrupos_menu_empresa = '" + ls_empresa + "'")
	dw_empresas.Filter()

	OpenWithParm ( w_con_menu_utigrupos_estado, dw_empresas  )
	
	ll_row = dw_utigrupos.getselectedrow( 0)
	IF ll_row = 0 THEN ll_row = 1
	dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)		
	
END IF
end event

event editchanged;IF dwo.Name = "nombre_boton"  THEN	ib_actualizar = True
end event

event clicked;string data,ls_utigrupos,ls_empresa
long   ll_row,ll_valor

if dwo.name = 'b_propagar' then
	pointer oldpointer
	oldpointer = SetPointer(HourGlass!)	
	// activo
			
	data = This.Object.activo[row]
	ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
	ls_empresa = This.Object.utigrupos_menu_empresa[row]
	
	ll_row = dw_utigrupos.getselectedrow(0)
	IF ll_row = 0 THEN ll_row = 1	
	
	dw_empresas.SetRedraw( False )
	dw_empresas.SetFilter("")
	dw_empresas.Filter()
	
	ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
	guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "activo" )
			
	dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
	
	//altas"
			
	data = This.Object.altas[row]
	ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
	ls_empresa = This.Object.utigrupos_menu_empresa[row]
	
	ll_row = dw_utigrupos.getselectedrow( 0)
	IF ll_row = 0 THEN ll_row = 1	
	
	dw_empresas.SetRedraw( False )
	dw_empresas.SetFilter("")
	dw_empresas.Filter()
	
	ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
	guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "altas" )
	
	dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
	
	//bajas"
	
	data = This.Object.bajas[row]
	ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
	ls_empresa = This.Object.utigrupos_menu_empresa[row]
	
	ll_row = dw_utigrupos.getselectedrow( 0)
	IF ll_row = 0 THEN ll_row = 1	
	
	dw_empresas.SetRedraw( False )
	dw_empresas.SetFilter("")
	dw_empresas.Filter()
	
	ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
	guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "bajas" )
	
	dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
	
	//cambios"
			
	data = This.Object.cambios[row]
	ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
	ls_empresa = This.Object.utigrupos_menu_empresa[row]
	
	ll_row = dw_utigrupos.getselectedrow( 0)
	IF ll_row = 0 THEN ll_row = 1	
	
	dw_empresas.SetRedraw( False )
	dw_empresas.SetFilter("")
	dw_empresas.Filter()
	
	ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
	guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "cambios" )
	
	dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
	
	//consultas
			
	data = This.Object.consultas[row]
	ls_utigrupos = This.Object.utigrupos_menu_utigrupos[row]
	ls_empresa = This.Object.utigrupos_menu_empresa[row]
	
	ll_row = dw_utigrupos.getselectedrow( 0)
	IF ll_row = 0 THEN ll_row = 1	
	
	dw_empresas.SetRedraw( False )
	dw_empresas.SetFilter("")
	dw_empresas.Filter()
	
	ll_valor = arbol.FindItem ( ChildTreeItem!, arbol.FindItem ( CurrentTreeItem!	,0 )	 )
	guo_menu_utigrupos.of_menu_propagar_valor ( dw_empresas, ls_utigrupos, ls_empresa, arbol, ll_valor, data, "consultas" )
				
	dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)
			
	SetPointer(oldpointer)
end if
end event

type dw_utigrupos from datawindow within w_con_menu_utigrupos_new
integer x = 2345
integer y = 296
integer width = 960
integer height = 3000
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_utigrupos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;String 				v_cambio,v_aux,v_menu, v_des, ls_datos[], ls_utigrupos
integer 				v_level, li_Cnt, li_Parm
long  					i,v_fil,v_reg, ll_arbol, ll_row
TreeViewitem  	xxx, ltvi_New

If row > 0  Then
	This.SelectRow(0, FALSE)
	This.SelectRow(row, TRUE)
	ls_utigrupos = Trim (This.Object.codigo[row])
//	If Not IsNull (ls_utigrupos) And ls_utigrupos <> "" Then dw_2.Retrieve( ls_utigrupos )	
	If Not IsNull (ls_utigrupos) And ls_utigrupos <> "" Then 		
		IF arbol.GetItem ( il_new_handle, ltvi_New) = -1 THEN Return			
		If Not IsNull (ltvi_New.data) Then
			ls_datos = ltvi_New.data
//			dw_empresas.Retrieve( ls_datos[2], ls_utigrupos, ls_datos[1])
			dw_empresas.SetRedraw(False)
			dw_empresas.SetFilter("")
			dw_empresas.Filter()
			dw_empresas.SetFilter("utigrupos_menu_nombre_menu =  '"  + String(ls_datos[2]) + "' And utigrupos_menu_utigrupos = '" + ls_utigrupos + "' And utigrupos_menu_grupo_aplicacion = '" + String(ls_datos[1]) + "'")
			dw_empresas.Filter()
						
//			ll_base = arbol.FindItem ( ChildTreeItem!, ll_base )
//			wf_insertar_opcion_menu (ls_utigrupos, ls_datos)

			IF dw_empresas.RowCount() = 0 THEN	
				wf_insertar_opcion_menu (ls_utigrupos, ls_datos)
				ll_arbol = arbol.FindItem ( ChildTreeItem!, il_new_handle )						
				do while ll_arbol > 0
					dw_empresas.SetRedraw(False)
					arbol.GetItem ( ll_arbol, ltvi_New)
					ls_datos = ltvi_New.data
					wf_insertar_opcion_menu (ls_utigrupos, ls_datos)	
					ll_arbol = arbol.FindItem ( ChildTreeItem!, ll_arbol )
				loop
			End IF
			dw_empresas.SetRedraw(False)
			dw_empresas.SetFilter("")
			dw_empresas.Filter()
			dw_empresas.SetFilter("utigrupos_menu_nombre_menu =  '"  + String(ls_datos[2]) + "' And utigrupos_menu_utigrupos = '" + ls_utigrupos + "' And utigrupos_menu_grupo_aplicacion = '" + String(ls_datos[1]) + "'")
			dw_empresas.Filter()
				
			dw_empresas.SetSort (" utigrupos_menu_empresa A")
			dw_empresas.Sort()		
			
			dw_empresas.SetRedraw(True)
		End If
	End If	
End If


end event

type cbx_propagar_activo from checkbox within w_con_menu_utigrupos_new
boolean visible = false
integer x = 3360
integer y = 180
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Activo"
end type

type cbx_propagar_altas from checkbox within w_con_menu_utigrupos_new
boolean visible = false
integer x = 3867
integer y = 180
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Altas"
end type

type cbx_propagar_bajas from checkbox within w_con_menu_utigrupos_new
boolean visible = false
integer x = 4357
integer y = 180
integer width = 242
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Bajas"
end type

type cbx_propagar_cambios from checkbox within w_con_menu_utigrupos_new
boolean visible = false
integer x = 4718
integer y = 180
integer width = 517
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Modificaciones"
end type

type cbx_propagar_consultas from checkbox within w_con_menu_utigrupos_new
boolean visible = false
integer x = 5321
integer y = 180
integer width = 306
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Lectura"
end type

type cb_perfil from commandbutton within w_con_menu_utigrupos_new
integer x = 1696
integer y = 144
integer width = 645
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copiar Perfil"
end type

event clicked;str_parametros lstr_param	

SetPointer(HourGlass!)

arbol.DeleteItem(0)
arbol.setredraw( False)
dw_utigrupos.Reset()
dw_empresas.Reset()


OpenWithParm(w_con_menu_utigrupos_perfil, lstr_param)

wf_menu_cargar(arbol)

SetPointer(Arrow!)
end event

type st_1 from statictext within w_con_menu_utigrupos_new
integer x = 1381
integer y = 236
integer width = 1385
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "(*) Botón derecho expande/comprime opciones"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_menu_utigrupos_new
boolean visible = false
integer x = 3310
integer y = 112
integer width = 2331
integer height = 164
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Propagar Permisos"
end type

type arbol from treeview within w_con_menu_utigrupos_new
integer x = 14
integer y = 296
integer width = 2327
integer height = 3000
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean linesatroot = true
boolean hideselection = false
boolean fullrowselect = true
string picturename[] = {"ArrangeIcons!","AppIcon!","Custom039!","Custom050!","Window!","C:\bmp\uti.bmp"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 553648127
string statepicturename[] = {"ExecuteSQL!","",""}
long statepicturemaskcolor = 12632256
end type

event selectionchanged;long  					ll_row
TreeViewitem  	ltvi_New, ltvi_Old

//ltvi_Current.StatePictureIndex = 1
IF GetItem(newhandle, ltvi_New) = -1 THEN Return

GetItem(oldhandle, ltvi_Old) 
ltvi_Old.StatePictureIndex = 0
SetItem(oldhandle, ltvi_Old)

GetItem(newhandle, ltvi_New) 
ltvi_New.StatePictureIndex = 1
SetItem(newhandle, ltvi_New)
il_new_handle = newhandle

IF ltvi_New.level > 1 THEN
	IF NOT dw_utigrupos.RowCount() > 0 THEN dw_utigrupos.Retrieve()
	IF dw_utigrupos.RowCount() > 0 THEN
		dw_utigrupos.SetRedraw( True )
		ll_row = dw_utigrupos.getselectedrow( 0)
		IF ll_row = 0 THEN ll_row = 1
		dw_utigrupos.event Clicked (0, 0, ll_row, dw_utigrupos.Object.codigo)			
	END IF
ELSE
	dw_empresas.SetFilter("1=2")
	dw_empresas.Filter()
END IF


end event

event rightclicked;

TreeViewitem  	ltvi_New, ltvi_Old


IF GetItem(handle, ltvi_New) = -1 THEN Return

IF ltvi_New.expanded THEN
	This.CollapseItem(handle)
ELSE
	This.ExpandAll ( handle )
END IF


end event

