$PBExportHeader$uo_menu_usuarios.sru
forward
global type uo_menu_usuarios from nonvisualobject
end type
end forward

global type uo_menu_usuarios from nonvisualobject
end type
global uo_menu_usuarios uo_menu_usuarios

forward prototypes
public subroutine of_menu_limpiar_texto (ref string as_texto)
public subroutine of_menu_insertar_arbol (treeview atrv_arbol, long al_hpadre, integer ai_dibujo, string as_grupo, menu am_menu)
public function string of_menu_obtener_script (menu am_menu)
public subroutine of_menu_crear_base (ref datastore ads_base, menu am_menu, string as_grupo, string as_usuario, string as_empresa)
public function boolean of_menu_baja_usuario (string as_usuario, string as_empresa)
public function boolean of_menu_alta_usuario (string as_usuario, string as_empresa)
public subroutine of_menu_cargar (ref menu am_menu, string as_usuario, string as_empresa, string as_grupo)
public subroutine of_menu_cargar_estado (ref menu am_menu, string as_usuario, string as_empresa, string as_grupo)
public subroutine of_menu_cargar_recursivo (ref datastore ads_opciones, ref menu am_menu)
public subroutine of_menu_cargar_estado_recursivo (ref datastore ads_opciones, ref menu am_menu)
public function boolean of_menu_escribir_permiso (string as_usuario, string as_empresa, string as_grupo, string as_ventana, string as_valor, string as_campo)
public function boolean of_menu_actualizar_opciones ()
public subroutine of_menu_cargar_base (ref datastore ads_base)
public subroutine of_menu_insertar_arbol_estado (ref datastore ads_base, treeview atrv_arbol, long al_hpadre, integer ai_dibujo, string as_grupo, menu am_menu)
public subroutine of_menu_insertar_arbol_estado (ref datawindow ads_base, treeview atrv_arbol, long al_hpadre, integer ai_dibujo, string as_grupo, menu am_menu)
public subroutine of_menu_propagar_valor (ref datawindow adw_menu, string as_usuario, string as_empresa, treeview atrv_arbol, long al_nodo, string as_dato, string as_campo)
public function string of_menu_leer_permiso (string as_usuario, string as_empresa, string as_ventana, string as_campo)
public function string of_menu_leer_permiso (string as_usuario, string as_empresa, string as_grupo, string as_ventana, string as_campo)
public subroutine of_menu_leer_permiso_total (string as_usuario, string as_empresa, string as_grupo, string as_ventana, ref string as_alta, ref string as_baja, ref string as_cambio, ref string as_consulta)
public function boolean of_menu_actualizar_opciones (string as_grupo)
end prototypes

public subroutine of_menu_limpiar_texto (ref string as_texto);Long			ll_pos
String		ls_aux, ls_texto

//ll_pos = Pos (as_texto, "&")
//IF ll_pos > 0 THEN as_texto = Left(as_texto, ll_pos - 1) + Mid (as_texto, ll_pos + 1)
//
//ll_pos = Pos (as_texto, "~t")
//IF ll_pos > 0 THEN as_texto = Left(as_texto, ll_pos - 1) 


ls_texto = as_texto
ls_aux = f_get_token ( ls_texto, "&") + ls_texto

as_texto = f_get_token ( ls_aux, "~t")

end subroutine

public subroutine of_menu_insertar_arbol (treeview atrv_arbol, long al_hpadre, integer ai_dibujo, string as_grupo, menu am_menu);String				ls_descripcion, ls_datos[], ls_aux, ls_nom_menu
Long					ll_handle, ll_picture, ll_hijos
Int						li_cont
TreeviewItem		ltrvi_subarbol
ClassDefinition	lcd_clase


lcd_clase = am_menu.ClassDefinition
ls_descripcion = am_menu.text

IF  am_menu.ClassName()  = lcd_clase.Name THEN 	
		ls_nom_menu = Trim (lcd_clase.Name)
		Select descripcion
		Into   :ls_descripcion
		From   grupo_aplicacion
		where  empresa = :codigo_empresa
		and    menu  = :ls_nom_menu ;

		if isnull(ls_descripcion) OR ls_descripcion = "" then 	
			ls_descripcion = Upper ( am_menu.ClassName() )
			ls_aux = f_get_token (ls_descripcion, "_")
		end if

ELSE
	ls_descripcion = am_menu.text
END IF

IF ls_descripcion <> "-"THEN
	of_menu_limpiar_texto (ls_descripcion)
		
	ls_datos[1] = as_grupo
	ls_datos[2] = am_menu.ClassName()
	ls_datos[3] = of_menu_obtener_script ( am_menu )
	ls_datos[4] = ls_descripcion
	
	ltrvi_subarbol.label 							 = ls_descripcion
	ltrvi_subarbol.data 							 = ls_datos
	
	ll_hijos = UpperBound(am_menu.item)
	
	IF  am_menu.ClassName()  = lcd_clase.Name THEN 	
		ltrvi_subarbol.pictureindex 				 = ai_dibujo
		ltrvi_subarbol.selectedpictureindex	 = ai_dibujo 
	ELSE
		IF ll_hijos > 0 THEN
			ltrvi_subarbol.pictureindex 				 = ai_dibujo + 1
			ltrvi_subarbol.selectedpictureindex	 = ai_dibujo + 2
		ELSE
			ltrvi_subarbol.pictureindex 				 = ai_dibujo + 3
			ltrvi_subarbol.selectedpictureindex	 = ai_dibujo + 4
		END IF
	END IF
			
	ll_handle = atrv_arbol.InsertItemLast (al_hpadre, ltrvi_subarbol )	
		
		
	FOR li_cont = 1 TO ll_hijos
		of_menu_insertar_arbol (atrv_arbol, ll_handle, ai_dibujo, as_grupo, am_menu.item[li_cont] )		
	NEXT
	
END IF
end subroutine

public function string of_menu_obtener_script (menu am_menu);String					ls_aux, ls_ventana, ls_script,ls_caracter,ls_script_tratado
Long						ll_cont, ll_pos, ll_coma, ll_parentesis,ll_pos_salto_carro,ll_indice,ll_total
ClassDefinition 		lcd_windef

ls_ventana = ""
lcd_windef = am_menu.ClassDefinition	
			
//cd_windef = FindClassDefinition("lm_menu")
 
IF UpperBound(lcd_windef.ScriptList) >= 27 THEN  //Evento Clicked del menu 43
	ll_cont = 27 
	ls_script = lcd_windef.ScriptList[ll_cont].Source	
	
	if isnull(ls_script) then ls_script = ""
	
	ls_script = Upper(ls_script)
	
	ll_total = len(ls_script)
	
	ls_script_tratado = ""
	
	for ll_indice = 1 to ll_total
		ls_caracter       = mid(ls_script,ll_indice,1)
		if asc(ls_caracter) <> 34 then
			ls_script_tratado = ls_script_tratado + ls_caracter
		else
			ls_script_tratado = ls_script_tratado + "'"
		end if
	next
	
	ls_script = ls_script_tratado
	
	IF trim(ls_script) <> "" THEN
		
		//Quitamos las lineas del script comentadas
		ll_pos = pos(ls_script,"//")
		
		DO WHILE ll_pos > 0
			ll_pos_salto_carro = pos(ls_script,char(13),ll_pos)
			ls_script = mid(ls_script,1,ll_pos -1)+(mid(ls_script,ll_pos_salto_carro+1))
			ll_pos = pos(ls_script,"//")		
		LOOP
		//Fin de Quitamos las lineas del script comentadas
		
//		//Quitamos las lineas que hacen referencia a IF THEN
//		ll_pos = pos(ls_script,"IF")
//		
//		DO WHILE ll_pos > 0
//			ll_pos_salto_carro = pos(ls_script,"THEN",ll_pos)
//			ls_script = mid(ls_script,1,ll_pos -1)+(mid(ls_script,ll_pos_salto_carro+1))
//			ll_pos = pos(ls_script,"IF")	
//		LOOP
//		
//		//Fin de Quitamos las lineas que hacen referencia a tipo_vista	
//		
//		//Quitamos las lineas que hacen referencia a IF THEN
//		ll_pos = pos(ls_script,"F_PEDIR_CLAVE")
//		
//		DO WHILE ll_pos > 0
//			ll_pos_salto_carro = pos(ls_script,")",ll_pos)
//			ls_script = mid(ls_script,1,ll_pos -1)+(mid(ls_script,ll_pos_salto_carro+1))
//			ll_pos = pos(ls_script,"F_PEDIR_CLAVE")		
//		LOOP
//		
//		//Fin de Quitamos las lineas que hacen referencia a f_pedir_clave
		
		//Chequeamos si abrimos la ventana mediante la variable lw_ventana
		ll_pos = pos(ls_script, "LW_VENTANA")
		
		IF ll_pos > 0 THEN
			//Si es asi buscamos en antrecomillado que nos indica la ventana
			//Char(34) = "
			//Char(39) = '
			
//			ls_aux = f_get_token (ls_script,char(34))
//			
//			if ls_aux <> "" then
//				ls_ventana = f_get_token (ls_script,char(34))
//			else			
				ls_aux = f_get_token (ls_script,char(39))
				if ls_aux <> "" then
					ls_ventana = f_get_token (ls_script,char(39))				
				end if
//			end if
			
		else
			ll_pos = pos(ls_script, "OPEN")
			IF ll_pos > 0 THEN
				ls_script = Mid (ls_script, ll_pos)
				ls_aux = f_get_token (ls_script, "(" ) //Devuelve lo que hay a la izquierda del "token" y actualiza la cadena con el resto hasta el final
				ll_coma = pos(ls_script, ",")
				ll_parentesis = pos(ls_script, ")")	
				
				IF ll_coma > 0 AND ll_coma < ll_parentesis THEN
					ls_ventana = Trim ( f_get_token (ls_script, "," ) )
				ELSE
					ls_ventana = Trim ( f_get_token (ls_script, ")" ) )
				END IF
			END IF		
		end if
	END IF	
END IF

Return 	ls_ventana
end function

public subroutine of_menu_crear_base (ref datastore ads_base, menu am_menu, string as_grupo, string as_usuario, string as_empresa);String				ls_descripcion, ls_nombre_menu, ls_ventana, ls_aux, ls_desc
Long					ll_row
Int						li_cont
ClassDefinition	lcd_clase

lcd_clase = am_menu.ClassDefinition
ls_descripcion = am_menu.text

IF  am_menu.ClassName()  = lcd_clase.Name THEN 	
	ls_descripcion = Upper ( am_menu.ClassName() )
	ls_aux = f_get_token (ls_descripcion, "_")
ELSE
	ls_descripcion = am_menu.text
END IF

IF ls_descripcion <> "-"THEN
	of_menu_limpiar_texto (ls_descripcion)
	
	ls_nombre_menu = am_menu.ClassName()
	ls_ventana = of_menu_obtener_script ( am_menu )
		
	
	ll_row = ads_base.InsertRow(0)
	ads_base.Object.nombre_menu[ll_row] 		= ls_nombre_menu
	ads_base.Object.grupo[ll_row] 				= as_grupo
	ads_base.Object.usuario[ll_row] 				= as_usuario
	ads_base.Object.empresa[ll_row] 				= as_empresa
	ads_base.Object.descripcion[ll_row] 		= ls_descripcion
	ads_base.Object.activo[ll_row] 				= "0"
	ads_base.Object.nombre_ventana[ll_row] 	= ls_ventana
	ads_base.Object.altas[ll_row] 				= "N"
	ads_base.Object.bajas[ll_row] 				= "N"
	ads_base.Object.cambios[ll_row] 				= "N"
	ads_base.Object.consultas[ll_row] 			= "N"
				
	FOR li_cont = 1 TO UpperBound(am_menu.item)
		of_menu_crear_base (ads_base, am_menu.item[li_cont], as_grupo, as_usuario, as_empresa )		
	NEXT
	
END IF
end subroutine

public function boolean of_menu_baja_usuario (string as_usuario, string as_empresa);
DELETE FROM usuario_menu WHERE usuario = :as_usuario AND empresa = :as_empresa USING SQLCA;

IF SQLCA.sqlcode = 0 then
	Return True
ELSE
	Return False
END IF
end function

public function boolean of_menu_alta_usuario (string as_usuario, string as_empresa);DataStore				lds_base, lds_menu
Long						ll_total, ll_row
String					ls_sel

lds_base = f_cargar_cursor ("SELECT * FROM usuario_menu")
lds_base.Reset()
of_menu_cargar_base( lds_base)
ll_total = lds_base.RowCount()

IF ll_total > 0 THEN
	IF of_menu_baja_usuario( as_usuario, as_empresa) THEN	
		COMMIT;	
		f_mensaje_proceso("Alta Menú Usuario",0,100) //Fución de ventana que abre objeto barra progreso de GNOCERAMICA

		lds_menu =  f_cargar_cursor ("SELECT * FROM usuario_menu")
		FOR ll_row = 1 TO ll_total
			lds_base.Object.usuario[ll_row] = as_usuario
			lds_base.Object.empresa[ll_row] = as_empresa
			f_mensaje_proceso("Alta Menú Usuario",ll_row,ll_total)
		NEXT
		
		lds_base.RowsCopy( 1, ll_total, Primary!, lds_menu, lds_menu.RowCount() + 1, Primary!)

		IF lds_menu.Update() = 1 THEN	
			Destroy lds_base
			Destroy lds_menu
			Return True
		ELSE
			Destroy lds_base
			Destroy lds_menu
			Return False
		END IF
	ELSE
		ROLLBACK;
		Destroy lds_base
		Return False
	END IF
ELSE
	Destroy lds_base
	MessageBox("Alta Menú Usuario", "Plantilla Meú Base Vacia~r~r!Debe crear una plantilla menú base antes¡", Exclamation!)
	Return False	
END IF

Destroy lds_base
Return True
end function

public subroutine of_menu_cargar (ref menu am_menu, string as_usuario, string as_empresa, string as_grupo);String			ls_sel, ls_usuario, ls_empresa, ls_grupo, ls_nombre_menu, ls_filtro, ls_filter
Long				ll_menu_base, ll_usuarios, ll_cont, ll_row, ll_encontrado, ll_cont_base, ll_menu, ll_cont_usuario
Int					li_aux
DataStore		lds_usuarios, lds_menu, lds_base


ls_sel = "SELECT * FROM usuario_menu  " + &
			" WHERE  usuario =  '" + as_usuario + "'" + &
			" AND empresa = '" + as_empresa + "'" + &
			" AND grupo = '" + as_grupo + "'" 

lds_menu =  f_cargar_cursor (ls_sel)

ll_menu = lds_menu.RowCount()

IF ll_menu > 0 THEN	of_menu_cargar_recursivo (lds_menu, am_menu )
	
Destroy lds_menu





end subroutine

public subroutine of_menu_cargar_estado (ref menu am_menu, string as_usuario, string as_empresa, string as_grupo);String			ls_sel, ls_usuario, ls_empresa, ls_grupo, ls_nombre_menu, ls_filtro, ls_filter
Long				ll_menu_base, ll_usuarios, ll_cont, ll_row, ll_encontrado, ll_cont_base, ll_menu, ll_cont_usuario
Int					li_aux
DataStore		lds_usuarios, lds_menu, lds_base


ls_sel = "SELECT * FROM usuario_menu  " + &
			" WHERE  usuario =  '" + as_usuario + "'" + &
			" AND empresa = '" + as_empresa + "'" + &
			" AND grupo = '" + as_grupo + "'" 

lds_menu =  f_cargar_cursor (ls_sel)

ll_menu = lds_menu.RowCount()

IF ll_menu > 0 THEN	of_menu_cargar_recursivo (lds_menu, am_menu )
	
Destroy lds_menu


//of_menu_insertar_arbol_estado (ads_base, atrv_arbol, ll_handle, ai_dibujo, as_grupo, am_menu.item[li_cont] )		


end subroutine

public subroutine of_menu_cargar_recursivo (ref datastore ads_opciones, ref menu am_menu);Long				ll_encontrado, ll_cont
String			ls_nombre_menu, ls_valor
Boolean			lb_valor

	
FOR ll_cont = 1 TO UpperBound(am_menu.item)
	ls_valor = ""
	ls_nombre_menu = am_menu.item[ll_cont].ClassName()	
	ll_encontrado = ads_opciones.Find( " nombre_menu = '" + ls_nombre_menu + "'", 1, ads_opciones.RowCount() )
	IF ll_encontrado > 0 Then	ls_valor = ads_opciones.Object.activo[ll_encontrado]
	
	IF IsNull (ls_valor) OR ls_valor = "" THEN ls_valor = '0'
	
	IF ls_valor = '1'  THEN 
		lb_valor = True
	ELSE
		lb_valor = False
	END IF
	
	am_menu.item[ll_cont].Enabled = lb_valor	
	
	of_menu_cargar_recursivo (ads_opciones, am_menu.item[ll_cont] )
NEXT
		

end subroutine

public subroutine of_menu_cargar_estado_recursivo (ref datastore ads_opciones, ref menu am_menu);Long				ll_encontrado, ll_cont
String			ls_nombre_menu, ls_valor
Boolean			lb_valor

	
FOR ll_cont = 1 TO UpperBound(am_menu.item)
	ls_valor = ""
	ls_nombre_menu = am_menu.item[ll_cont].ClassName()	
	ll_encontrado = ads_opciones.Find( " nombre_menu = '" + ls_nombre_menu + "'", 1, ads_opciones.RowCount() )
	IF ll_encontrado > 0 Then	ls_valor = ads_opciones.Object.activo[ll_encontrado]
	
	IF IsNull (ls_valor) OR ls_valor = "" THEN ls_valor = '0'
	
	IF ls_valor = '1'  THEN 
		lb_valor = True
	ELSE
		lb_valor = False
	END IF
	
	am_menu.item[ll_cont].Enabled = lb_valor	
	
	of_menu_cargar_recursivo (ads_opciones, am_menu.item[ll_cont] )
NEXT
		

end subroutine

public function boolean of_menu_escribir_permiso (string as_usuario, string as_empresa, string as_grupo, string as_ventana, string as_valor, string as_campo);String		ls_valor
Long			ll_row

CHOOSE CASE Upper(as_campo)
	CASE "ACTIVO"
		  UPDATE usuario_menu  SET activo = :as_valor  
			  WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
		
	CASE "ALTAS"
		UPDATE usuario_menu  SET altas = :as_valor  
			  WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
		
	CASE "BAJAS"
		UPDATE usuario_menu  SET bajas = :as_valor  
			  WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
		
	CASE "CAMBIOS"
		UPDATE usuario_menu  SET cambios = :as_valor  
			  WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
		
	CASE "CONSULTAS"
		UPDATE usuario_menu  SET consultas = :as_valor  
			  WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
				
END CHOOSE


Return True
end function

public function boolean of_menu_actualizar_opciones ();String			ls_sel, ls_usuario, ls_empresa, ls_grupo, ls_nombre_menu, ls_filtro, ls_filter
Long				ll_menu_base, ll_usuarios, ll_cont, ll_row, ll_encontrado, ll_cont_base, ll_menu, ll_cont_usuario, ll_cont_barra
Int					li_aux
DataStore		lds_usuarios, lds_menu, lds_base

lds_base = f_cargar_cursor ("SELECT * FROM usuario_menu")
lds_base.Reset()

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Comprobamos si hay algún usuario en tabla de menu de usuarios que ya no exista ó deba estar y lo borramos
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

f_mensaje_proceso("Act. Opciones Menú -A-",0,100) //Fución de ventana que abre objeto barra progreso de GNOCERAMICA

lds_menu =  f_cargar_cursor ("SELECT * FROM usuario_menu")

lds_usuarios =  f_cargar_cursor ("SELECT DISTINCT usuario, empresa  FROM usuario_menu " + &
						" WHERE  NOT  EXISTS  (SELECT DISTINCT v_usuario, v_empresa FROM usuarios " + &
						" WHERE usuario = v_usuario AND empresa = v_empresa)")
ll_usuarios = lds_usuarios.RowCount()

FOR ll_cont = 1 TO ll_usuarios
	lds_menu.SetFilter ( " usuario =  '"  + lds_usuarios.Object.usuario[ll_cont] + "' And empresa = '" +  lds_usuarios.Object.empresa[ll_cont]  + "'" )
	lds_menu.Filter()
	IF lds_menu.FilteredCount( )  > 0 Then 
		lds_menu.RowsMove(1, lds_menu.RowCount( ), Primary!, lds_menu, lds_menu.DeletedCount( ) + 1 , Delete!)
		lds_menu.SetFilter ( "")
		lds_menu.Filter()
	END IF
	f_mensaje_proceso("Act. Opciones Menú -A-", ll_cont, ll_usuarios)
NEXT

lds_menu.SetFilter ( "")
lds_menu.Filter()

lds_usuarios.Reset()
IF lds_menu.Update() = 1 THEN 
	COMMIT;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Comprobamos si hay alguna opcion en tabla de menu de usuarios que ya no exista ó deba estar y lo borramos
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	f_mensaje_proceso("Act. Opciones Menú -B-",0,100)

	lds_base.Reset()
	of_menu_cargar_base( lds_base)
	
	ll_menu_base = lds_base.RowCount()
	lds_menu =  f_cargar_cursor ("SELECT * FROM usuario_menu")
	ll_menu = lds_menu.RowCount()
	
	ll_cont_barra = ll_menu
	FOR ll_cont = ll_menu TO 1 STEP -1	
		ls_grupo = lds_menu.Object.grupo[ll_cont]
		ls_nombre_menu = lds_menu.Object.nombre_menu[ll_cont]		
		ll_encontrado = lds_base.Find( " grupo = '" + ls_grupo + "' And nombre_menu = '" + ls_nombre_menu + "'", 1, lds_base.RowCount() )
		IF NOT ll_encontrado > 0 Then	lds_menu.deleterow(ll_cont)	
		f_mensaje_proceso("Act. Opciones Menú -B-", ll_cont_barra - ll_cont, ll_cont_barra)		
	NEXT	
		
	f_mensaje_proceso("Act. Opciones Menú -B-", 99, 100)	
	IF lds_menu.Update() = 1 THEN
		COMMIT;
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Comprobamos si hay alguna opcion en tabla de menu de usuarios que  haya cambiado de texto ó ventana que abre y lo actualizamos
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		f_mensaje_proceso("Act. Opciones Menú -C-", 0,100)
		
		lds_base.Reset()
		of_menu_cargar_base( lds_base)
		ll_menu_base = lds_base.RowCount()
		lds_menu =  f_cargar_cursor ("SELECT * FROM usuario_menu")
		ll_menu = lds_menu.RowCount()	
		
		FOR ll_cont = 1 TO ll_menu_base
			ls_grupo = lds_base.Object.grupo[ll_cont]
			ls_nombre_menu = lds_base.Object.nombre_menu[ll_cont]	
			ll_encontrado = lds_menu.Find( " grupo =  '" + ls_grupo + "' And nombre_menu = '" + ls_nombre_menu + "'", 1, lds_menu.RowCount() )	
			DO WHILE ll_encontrado > 0 
				lds_menu.Object.descripcion[ll_encontrado] = lds_base.Object.descripcion[ll_cont]
				lds_menu.Object.nombre_ventana[ll_encontrado] = lds_base.Object.nombre_ventana[ll_cont]
				IF ll_encontrado > lds_menu.RowCount() THEN EXIT
				ll_encontrado = lds_menu.Find(  " grupo =  '" + ls_grupo + "' And nombre_menu = '" + ls_nombre_menu + "'", ll_encontrado + 1, lds_menu.RowCount() + 1 )	
			LOOP		
			f_mensaje_proceso("Act. Opciones Menú -C-", ll_cont, ll_menu_base)		
		NEXT
				
		f_mensaje_proceso("Act. Opciones Menú -C-", 99, 100)	
		IF lds_menu.Update() = 1 THEN
			COMMIT;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////	Comprobamos si hay algún usuario ú opcion de menu nueva y lo añadimos a la tabla de menu de usuarios
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
			f_mensaje_proceso("Act. Opciones Menú -D-", 0,100)
			
			lds_menu =  f_cargar_cursor ("SELECT * FROM usuario_menu")
			ll_menu = lds_menu.RowCount()
			lds_usuarios =  f_cargar_cursor ("SELECT DISTINCT usuario, empresa FROM usuario_menu")
			ll_usuarios = lds_usuarios.RowCount()
			
		
			FOR ll_cont = 1 TO ll_menu_base
				FOR ll_cont_usuario = 1 TO ll_usuarios
					ls_grupo = lds_base.Object.grupo[ll_cont]
					ls_nombre_menu = lds_base.Object.nombre_menu[ll_cont]
					ls_usuario = lds_usuarios.Object.usuario[ll_cont_usuario]
					ls_empresa = lds_usuarios.Object.empresa[ll_cont_usuario]
					ll_encontrado = lds_menu.Find( " usuario = '" + ls_usuario + "'And empresa = '" + ls_empresa + "' And  grupo = '" + ls_grupo + "' And nombre_menu = '" + ls_nombre_menu + "'", 1, lds_menu.RowCount() )
					IF NOT ll_encontrado > 0 Then		
						lds_base.Object.usuario[ll_cont] =  lds_usuarios.Object.usuario[ll_cont_usuario]
						lds_base.Object.empresa[ll_cont] =  lds_usuarios.Object.empresa[ll_cont_usuario]			
						lds_base.Object.activo[ll_cont] =  '0'
						lds_base.Object.altas[ll_cont] =  'N'
						lds_base.Object.bajas[ll_cont] =  'N'
						lds_base.Object.cambios[ll_cont] =  'N'
						lds_base.Object.consultas[ll_cont] =  'N'
						
						lds_base.RowsCopy (ll_cont, ll_cont, Primary!, lds_menu, lds_menu.RowCount() + 1, Primary!)						
					END IF	
					f_mensaje_proceso("Act. Opciones Menú -D-", ll_cont, ll_menu_base)
				NEXT
			NEXT
		
			f_mensaje_proceso("Act. Opciones Menú -D-", 99, 100)	
			IF lds_menu.Update() = 1 THEN
				COMMIT;
				lds_menu.ResetUpdate()
				Destroy 	lds_usuarios
				Destroy lds_menu
				Destroy lds_base
				f_mensaje_proceso("Act. Opciones Menú", 100,100)
				Return True
			ELSE
				ROLLBACK;
				Destroy 	lds_usuarios
				Destroy lds_menu
				Destroy lds_base
				f_mensaje_proceso("Act. Opciones Menú", 100, 100)
				Return False
			END IF	
		ELSE
			ROLLBACK;
			Destroy 	lds_usuarios
			Destroy lds_menu
			Destroy lds_base		
			f_mensaje_proceso("Act. Opciones Menú", 100, 100)
			Return False
		END IF
	ELSE
		ROLLBACK;
		Destroy 	lds_usuarios
		Destroy lds_menu
		Destroy lds_base	
		f_mensaje_proceso("Act. Opciones Menú", 100, 100)
		Return False
	END IF
ELSE
	ROLLBACK;
	Destroy 	lds_usuarios
	Destroy lds_menu
	Destroy lds_base	
	f_mensaje_proceso("Act. Opciones Menú", 100, 100)
	Return False
END IF


end function

public subroutine of_menu_cargar_base (ref datastore ads_base);String			ls_sel, ls_descripcion, ls_programa, ls_texto, ls_datos[], ls_apli[]
Int					li_aux, li_codigo, li_pos
Long				ll_apli, ll_cont, ll_padre,  ll_base, ll_row
DataStore		lds_aplicaciones
Menu				lm_menu

ls_sel = "Select  Distinct Convert ( Char, (codigo+0)) apli, descripcion, menu  from grupo_aplicacion  order by apli"
		
lds_aplicaciones = f_cargar_cursor(ls_sel)
ll_apli = lds_aplicaciones.RowCount()
if ll_apli = 0 then 
	messagebox("Atencion","¡No hay Grupos de Aplicación definidos!")
	If IsValid (lds_aplicaciones) Then Destroy (lds_aplicaciones)
	Return
end if
	
f_mensaje_proceso("Cargando Menú",0,100)
For ll_cont = 1 To ll_apli	
	ls_apli = lds_aplicaciones.Object.Data[ll_cont]
	
	lm_menu = CREATE USING ls_apli[3]
	
	IF IsValid (lm_menu) THEN
		guo_menu_usuarios.of_menu_crear_base( ads_base, lm_menu, ls_apli[1],  "", "")   			
		Destroy lm_menu	
	END IF
	
	f_mensaje_proceso("Cargando Menú",ll_cont,ll_apli)
Next
	
If IsValid (lds_aplicaciones) Then Destroy lds_aplicaciones

f_mensaje_proceso("Cargando Menú",100,100)	

Return




end subroutine

public subroutine of_menu_insertar_arbol_estado (ref datastore ads_base, treeview atrv_arbol, long al_hpadre, integer ai_dibujo, string as_grupo, menu am_menu);String				ls_descripcion, ls_dato, ls_aux, ls_nom_menu
Long					ll_handle, ll_picture, ll_hijos, ll_encontrado
Int						li_cont
TreeviewItem		ltrvi_subarbol
ClassDefinition	lcd_clase

lcd_clase = am_menu.ClassDefinition
ls_descripcion = am_menu.text

IF  am_menu.ClassName()  = lcd_clase.Name THEN 	
		ls_nom_menu = Trim (lcd_clase.Name)
		Select descripcion
		Into   :ls_descripcion
		From   grupo_aplicacion
		where  empresa = :codigo_empresa
		and    menu  = :ls_nom_menu ;

		if isnull(ls_descripcion) OR ls_descripcion = "" then 	
			ls_descripcion = Upper ( am_menu.ClassName() )
			ls_aux = f_get_token (ls_descripcion, "_")
		end if

ELSE
	ls_descripcion = am_menu.text
END IF

IF ls_descripcion <> "-"THEN
	of_menu_limpiar_texto (ls_descripcion)
	
	ls_aux = am_menu.ClassName()
	ls_dato = ""
//	ll_encontrado = ads_base.Find( " grupo = '" + as_grupo + "' And nombre_menu = '" +ls_aux + "'", 1, ads_base.RowCount() )
	ll_encontrado = ads_base.Find( " usuario_menu_grupo = '" + as_grupo + "' And usuario_menu_nombre_menu = '" +ls_aux + "'", 1, ads_base.RowCount() )

	IF ll_encontrado > 0 THEN	ls_dato = ads_base.Object.activo[ll_encontrado]
	
	ltrvi_subarbol.label 							 = ls_descripcion
	
	choose case ls_dato
		case '1'
			ltrvi_subarbol.pictureindex 				 = ai_dibujo
			ltrvi_subarbol.selectedpictureindex	 = ai_dibujo 
			
		case '0'
			ltrvi_subarbol.pictureindex 				 = ai_dibujo + 1
			ltrvi_subarbol.selectedpictureindex	 = ai_dibujo + 1
				
		case else
			ltrvi_subarbol.pictureindex 				 = ai_dibujo  + 2
			ltrvi_subarbol.selectedpictureindex	 = ai_dibujo  + 2
			
	end choose
	
	ll_handle = atrv_arbol.InsertItemLast (al_hpadre, ltrvi_subarbol )	
		
		
	FOR li_cont = 1 TO UpperBound(am_menu.item)
		of_menu_insertar_arbol_estado (ads_base, atrv_arbol, ll_handle, ai_dibujo, as_grupo, am_menu.item[li_cont] )		
	NEXT
	
END IF
end subroutine

public subroutine of_menu_insertar_arbol_estado (ref datawindow ads_base, treeview atrv_arbol, long al_hpadre, integer ai_dibujo, string as_grupo, menu am_menu);String				ls_descripcion, ls_dato, ls_aux, ls_nom_menu
Long					ll_handle, ll_picture, ll_hijos, ll_encontrado
Int						li_cont
TreeviewItem		ltrvi_subarbol
ClassDefinition	lcd_clase

lcd_clase = am_menu.ClassDefinition
ls_descripcion = am_menu.text

IF  am_menu.ClassName()  = lcd_clase.Name THEN 	
		ls_nom_menu = Trim (lcd_clase.Name)
		Select descripcion
		Into   :ls_descripcion
		From   grupo_aplicacion
		where  empresa = :codigo_empresa
		and    menu  = :ls_nom_menu ;

		if isnull(ls_descripcion) OR ls_descripcion = "" then 	
			ls_descripcion = Upper ( am_menu.ClassName() )
			ls_aux = f_get_token (ls_descripcion, "_")
		end if

ELSE
	ls_descripcion = am_menu.text
END IF

IF ls_descripcion <> "-"THEN
	of_menu_limpiar_texto (ls_descripcion)
	
	ls_aux = am_menu.ClassName()
	ls_dato = ""
	ll_encontrado = ads_base.Find( " usuario_menu_grupo = '" + as_grupo + "' And usuario_menu_nombre_menu = '" +ls_aux + "'", 1, ads_base.RowCount() )
	IF ll_encontrado > 0 THEN	ls_dato = ads_base.Object.activo[ll_encontrado]
	
	ltrvi_subarbol.label 							 = ls_descripcion
	
	choose case ls_dato
		case '1'
			ltrvi_subarbol.pictureindex 				 = ai_dibujo
			ltrvi_subarbol.selectedpictureindex	 = ai_dibujo 
			
		case '0'
			ltrvi_subarbol.pictureindex 				 = ai_dibujo + 1
			ltrvi_subarbol.selectedpictureindex	 = ai_dibujo + 1
				
		case else
			ltrvi_subarbol.pictureindex 				 = ai_dibujo  + 2
			ltrvi_subarbol.selectedpictureindex	 = ai_dibujo  + 2
			
	end choose
	
	ll_handle = atrv_arbol.InsertItemLast (al_hpadre, ltrvi_subarbol )	
		
		
	FOR li_cont = 1 TO UpperBound(am_menu.item)
		of_menu_insertar_arbol_estado (ads_base, atrv_arbol, ll_handle, ai_dibujo, as_grupo, am_menu.item[li_cont] )		
	NEXT
	
END IF
end subroutine

public subroutine of_menu_propagar_valor (ref datawindow adw_menu, string as_usuario, string as_empresa, treeview atrv_arbol, long al_nodo, string as_dato, string as_campo);Long					ll_encontrado, ll_hijo, ll_hermano
String				ls_datos[]
TreeviewItem		ltrvi_rama


ll_hermano = al_nodo

DO WHILE	ll_hermano > 0
	atrv_arbol.GetItem ( ll_hermano, ltrvi_rama )
	ls_datos = ltrvi_rama.Data
	ll_encontrado = adw_menu.Find ( "usuario_menu_nombre_menu =  '"  + String(ls_datos[2]) + "' And usuario_menu_usuario = '" + & 
								as_usuario + "' And usuario_menu_grupo = '" + String(ls_datos[1]) + "' And usuario_menu_empresa = '" + & 
								as_empresa + "'" , 1, adw_menu.RowCount())
								
	IF ll_encontrado > 0 THEN	
		
		CHOOSE CASE	Upper ( as_campo )
			CASE		'ACTIVO'
				adw_menu.Object.activo[ll_encontrado] = as_dato	
				
			CASE		'ALTAS'
				adw_menu.Object.altas[ll_encontrado] = as_dato	
				
			CASE		'BAJAS'
				adw_menu.Object.bajas[ll_encontrado] = as_dato	
				
			CASE		'CAMBIOS'
				adw_menu.Object.cambios[ll_encontrado] = as_dato	
				
			CASE		'CONSULTAS'	
				adw_menu.Object.consultas[ll_encontrado] = as_dato	
				
		END CHOOSE
		
	END IF
	
	ll_hijo = atrv_arbol.FindItem ( ChildTreeItem!	, ll_hermano )
	
	of_menu_propagar_valor ( adw_menu, as_usuario, as_empresa, atrv_arbol, ll_hijo, as_dato, as_campo )
	
	ll_hermano = atrv_arbol.FindItem ( NextTreeItem!, ll_hermano )	
	
LOOP



end subroutine

public function string of_menu_leer_permiso (string as_usuario, string as_empresa, string as_ventana, string as_campo);String  ls_valor
int     li_existe_ventana_en_tabla

SELECT count(*) 
INTO   :li_existe_ventana_en_tabla 
FROM   usuario_menu 
WHERE  empresa = :as_empresa
AND    nombre_ventana = :as_ventana;

if isnull(li_existe_ventana_en_tabla) then li_existe_ventana_en_tabla = 0

if li_existe_ventana_en_tabla > 0 then
	CHOOSE CASE Upper(as_campo)
		CASE "ACTIVO"
			SELECT Max( activo ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND nombre_ventana = :as_ventana;
			
		CASE "ALTAS"
			SELECT Max( altas ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND nombre_ventana = :as_ventana;
			
		CASE "BAJAS"
			SELECT Max( bajas ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND nombre_ventana = :as_ventana;
			
		CASE "CAMBIOS"
			SELECT Max( cambios ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND nombre_ventana = :as_ventana;
			
		CASE "CONSULTAS"
			SELECT Max( consultas ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND nombre_ventana = :as_ventana;
					
	END CHOOSE
else
	//Si la ventana no existe en la tabla damos todos los permisos
	CHOOSE CASE Upper(as_campo)
		CASE "ACTIVO"
			ls_valor = "1"
		CASE ELSE
			ls_valor = "S"
	END CHOOSE	
end if

IF IsNull (ls_valor) THEN ls_valor = "" 

Return ls_valor
end function

public function string of_menu_leer_permiso (string as_usuario, string as_empresa, string as_grupo, string as_ventana, string as_campo);String		ls_valor
int     li_existe_ventana_en_tabla

SELECT count(*) 
INTO   :li_existe_ventana_en_tabla 
FROM   usuario_menu 
WHERE  empresa = :as_empresa
AND    nombre_ventana = :as_ventana;

if isnull(li_existe_ventana_en_tabla) then li_existe_ventana_en_tabla = 0

if li_existe_ventana_en_tabla > 0 then
	CHOOSE CASE Upper(as_campo)
		CASE "ACTIVO"
			SELECT Max( activo ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
			
		CASE "ALTAS"
			SELECT Max( altas ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
			
		CASE "BAJAS"
			SELECT Max( bajas ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
			
		CASE "CAMBIOS"
			SELECT Max( cambios ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
			
		CASE "CONSULTAS"
			SELECT Max( consultas ) INTO :ls_valor FROM usuario_menu 
				WHERE   usuario =  :as_usuario 
				AND empresa = :as_empresa
				AND grupo = :as_grupo
				AND nombre_ventana = :as_ventana;
					
	END CHOOSE
else
	//Si la ventana no existe en la tabla damos todos los permisos
	CHOOSE CASE Upper(as_campo)
		CASE "ACTIVO"
			ls_valor = "1"
		CASE ELSE
			ls_valor = "S"
	END CHOOSE	
end if

IF IsNull (ls_valor) THEN ls_valor = "" 

Return ls_valor
end function

public subroutine of_menu_leer_permiso_total (string as_usuario, string as_empresa, string as_grupo, string as_ventana, ref string as_alta, ref string as_baja, ref string as_cambio, ref string as_consulta);
SELECT max( altas ), max( bajas ), max( cambios ), max( consultas ) INTO :as_alta, :as_baja, :as_cambio, :as_consulta FROM usuario_menu 
WHERE   usuario =  :as_usuario 
AND empresa = :as_empresa
AND nombre_ventana = :as_ventana;

IF IsNull ( as_alta ) THEN as_alta = ""
IF IsNull ( as_baja ) THEN as_baja = ""
IF IsNull ( as_cambio ) THEN as_cambio = ""
IF IsNull ( as_consulta ) THEN as_consulta = ""

if trim(as_alta) = "" then as_alta = "S"
if trim(as_baja) = "" then as_baja = "S"
if trim(as_cambio) = "" then as_cambio = "S"
if trim(as_consulta) = "" then as_consulta = "S"

//CHOOSE CASE Upper(as_campo)
//	CASE "ACTIVO"
//		SELECT activo INTO :ls_valor FROM usuario_menu 
//			WHERE   usuario =  :as_usuario 
//			AND empresa = :as_empresa
//			AND nombre_ventana = :as_ventana;
//		
//	CASE "ALTAS"
//		SELECT altas INTO :ls_valor FROM usuario_menu 
//			WHERE   usuario =  :as_usuario 
//			AND empresa = :as_empresa
//			AND nombre_ventana = :as_ventana;
//		
//	CASE "BAJAS"
//		SELECT bajas INTO :ls_valor FROM usuario_menu 
//			WHERE   usuario =  :as_usuario 
//			AND empresa = :as_empresa
//			AND nombre_ventana = :as_ventana;
//		
//	CASE "CAMBIOS"
//		SELECT cambios INTO :ls_valor FROM usuario_menu 
//			WHERE   usuario =  :as_usuario 
//			AND empresa = :as_empresa
//			AND nombre_ventana = :as_ventana;
//		
//	CASE "CONSULTAS"
//		SELECT consultas INTO :ls_valor FROM usuario_menu 
//			WHERE   usuario =  :as_usuario 
//			AND empresa = :as_empresa
//			AND nombre_ventana = :as_ventana;
//				
//END CHOOSE
//
//IF IsNull (ls_valor) THEN ls_valor = "" 


end subroutine

public function boolean of_menu_actualizar_opciones (string as_grupo);String			ls_sel, ls_usuario, ls_empresa, ls_grupo, ls_nombre_menu, ls_filtro, ls_filter
Long				ll_menu_base, ll_usuarios, ll_cont, ll_row, ll_encontrado, ll_cont_base, ll_menu, ll_cont_usuario, ll_cont_barra
Int					li_aux
DataStore		lds_usuarios, lds_menu, lds_base

lds_base = f_cargar_cursor ("SELECT * FROM usuario_menu where 1=2")
lds_base.Reset()

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Comprobamos si hay algún usuario en tabla de menu de usuarios que ya no exista ó deba estar y lo borramos
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

f_mensaje_proceso("Act. Opciones Menú -A-",0,100) //Fución de ventana que abre objeto barra progreso de GNOCERAMICA

lds_menu =  f_cargar_cursor ("SELECT * FROM usuario_menu where grupo = '" + as_grupo + "'")

lds_usuarios =  f_cargar_cursor ("SELECT DISTINCT usuario, empresa  FROM usuario_menu " + &
						" WHERE grupo = '" +  as_grupo + "' and NOT  EXISTS  (SELECT DISTINCT v_usuario, v_empresa FROM usuarios " + &
						" WHERE usuario = v_usuario AND empresa = v_empresa)")
ll_usuarios = lds_usuarios.RowCount()

FOR ll_cont = 1 TO ll_usuarios
	lds_menu.SetFilter ( " usuario =  '"  + lds_usuarios.Object.usuario[ll_cont] + "' And empresa = '" +  lds_usuarios.Object.empresa[ll_cont]  + "'" )
	lds_menu.Filter()
	IF lds_menu.FilteredCount( )  > 0 Then 
		lds_menu.RowsMove(1, lds_menu.RowCount( ), Primary!, lds_menu, lds_menu.DeletedCount( ) + 1 , Delete!)
		lds_menu.SetFilter ( "")
		lds_menu.Filter()
	END IF
	f_mensaje_proceso("Act. Opciones Menú -A-", ll_cont, ll_usuarios)
NEXT

lds_menu.SetFilter ( "")
lds_menu.Filter()

lds_usuarios.Reset()
IF lds_menu.Update() = 1 THEN 
	COMMIT;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Comprobamos si hay alguna opcion en tabla de menu de usuarios que ya no exista ó deba estar y lo borramos
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	f_mensaje_proceso("Act. Opciones Menú -B-",0,100)

	lds_base.Reset()
	lds_base.SetFilter ("")
	lds_base.Filter()
	of_menu_cargar_base( lds_base)
	
	lds_base.SetFilter (" grupo = '" + as_grupo + "'")
	lds_base.Filter()
	
	lds_base.RowsDiscard( 1, lds_base.filteredcount( ), Filter!)
	
	
	ll_menu_base = lds_base.RowCount()
	lds_menu =  f_cargar_cursor ("SELECT * FROM usuario_menu WHERE grupo = '" +  as_grupo + "'")
	ll_menu = lds_menu.RowCount()
	
	ll_cont_barra = ll_menu
	FOR ll_cont = ll_menu TO 1 STEP -1	
		ls_grupo = lds_menu.Object.grupo[ll_cont]
		ls_nombre_menu = lds_menu.Object.nombre_menu[ll_cont]		
		ll_encontrado = lds_base.Find( " grupo = '" + ls_grupo + "' And nombre_menu = '" + ls_nombre_menu + "'", 1, lds_base.RowCount() )
		IF NOT ll_encontrado > 0 Then	lds_menu.deleterow(ll_cont)	
		f_mensaje_proceso("Act. Opciones Menú -B-", ll_cont_barra - ll_cont, ll_cont_barra)		
	NEXT	
		
	f_mensaje_proceso("Act. Opciones Menú -B-", 99, 100)	
	IF lds_menu.Update() = 1 THEN
		COMMIT;
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Comprobamos si hay alguna opcion en tabla de menu de usuarios que  haya cambiado de texto ó ventana que abre y lo actualizamos
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		f_mensaje_proceso("Act. Opciones Menú -C-", 0,100)
		
		lds_base.Reset()
		lds_base.SetFilter ("")
		lds_base.Filter()
		of_menu_cargar_base( lds_base)
		
		lds_base.SetFilter (" grupo = '" + as_grupo + "'")
		lds_base.Filter()
	
		lds_base.RowsDiscard( 1, lds_base.filteredcount( ), Filter!)
	
		ll_menu_base = lds_base.RowCount()
		lds_menu =  f_cargar_cursor ("SELECT * FROM usuario_menu WHERE grupo = '" +  as_grupo + "'")
		ll_menu = lds_menu.RowCount()	
		
		FOR ll_cont = 1 TO ll_menu_base
			ls_grupo = lds_base.Object.grupo[ll_cont]
			ls_nombre_menu = lds_base.Object.nombre_menu[ll_cont]	
			ll_encontrado = lds_menu.Find( " grupo =  '" + ls_grupo + "' And nombre_menu = '" + ls_nombre_menu + "'", 1, lds_menu.RowCount() )	
			DO WHILE ll_encontrado > 0 
				lds_menu.Object.descripcion[ll_encontrado] = lds_base.Object.descripcion[ll_cont]
				lds_menu.Object.nombre_ventana[ll_encontrado] = lds_base.Object.nombre_ventana[ll_cont]
				IF ll_encontrado > lds_menu.RowCount() THEN EXIT
				ll_encontrado = lds_menu.Find(  " grupo =  '" + ls_grupo + "' And nombre_menu = '" + ls_nombre_menu + "'", ll_encontrado + 1, lds_menu.RowCount() + 1 )	
			LOOP		
			f_mensaje_proceso("Act. Opciones Menú -C-", ll_cont, ll_menu_base)		
		NEXT
				
		f_mensaje_proceso("Act. Opciones Menú -C-", 99, 100)	
		IF lds_menu.Update() = 1 THEN
			COMMIT;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////	Comprobamos si hay algún usuario ú opcion de menu nueva y lo añadimos a la tabla de menu de usuarios
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
			f_mensaje_proceso("Act. Opciones Menú -D-", 0,100)
			
			lds_menu =  f_cargar_cursor ("SELECT * FROM usuario_menu WHERE grupo = '" +  as_grupo + "'")
			ll_menu = lds_menu.RowCount()
			lds_usuarios =  f_cargar_cursor ("SELECT DISTINCT usuario, empresa FROM usuario_menu WHERE grupo = '" +  as_grupo + "'")
			ll_usuarios = lds_usuarios.RowCount()
			
		
			FOR ll_cont = 1 TO ll_menu_base
				FOR ll_cont_usuario = 1 TO ll_usuarios
					ls_grupo = lds_base.Object.grupo[ll_cont]
					ls_nombre_menu = lds_base.Object.nombre_menu[ll_cont]
					ls_usuario = lds_usuarios.Object.usuario[ll_cont_usuario]
					ls_empresa = lds_usuarios.Object.empresa[ll_cont_usuario]
					ll_encontrado = lds_menu.Find( " usuario = '" + ls_usuario + "'And empresa = '" + ls_empresa + "' And  grupo = '" + ls_grupo + "' And nombre_menu = '" + ls_nombre_menu + "'", 1, lds_menu.RowCount() )
					IF NOT ll_encontrado > 0 Then		
						lds_base.Object.usuario[ll_cont] =  lds_usuarios.Object.usuario[ll_cont_usuario]
						lds_base.Object.empresa[ll_cont] =  lds_usuarios.Object.empresa[ll_cont_usuario]			
						lds_base.Object.activo[ll_cont] =  '0'
						lds_base.Object.altas[ll_cont] =  'N'
						lds_base.Object.bajas[ll_cont] =  'N'
						lds_base.Object.cambios[ll_cont] =  'N'
						lds_base.Object.consultas[ll_cont] =  'N'
						
						lds_base.RowsCopy (ll_cont, ll_cont, Primary!, lds_menu, lds_menu.RowCount() + 1, Primary!)						
					END IF	
					f_mensaje_proceso("Act. Opciones Menú -D-", ll_cont, ll_menu_base)
				NEXT
			NEXT
		
			f_mensaje_proceso("Act. Opciones Menú -D-", 99, 100)	
			IF lds_menu.Update() = 1 THEN
				COMMIT;
				lds_menu.ResetUpdate()
				Destroy 	lds_usuarios
				Destroy lds_menu
				Destroy lds_base
				f_mensaje_proceso("Act. Opciones Menú", 100,100)
				Return True
			ELSE
				ROLLBACK;
				Destroy 	lds_usuarios
				Destroy lds_menu
				Destroy lds_base
				f_mensaje_proceso("Act. Opciones Menú", 100, 100)
				Return False
			END IF	
		ELSE
			ROLLBACK;
			Destroy 	lds_usuarios
			Destroy lds_menu
			Destroy lds_base		
			f_mensaje_proceso("Act. Opciones Menú", 100, 100)
			Return False
		END IF
	ELSE
		ROLLBACK;
		Destroy 	lds_usuarios
		Destroy lds_menu
		Destroy lds_base	
		f_mensaje_proceso("Act. Opciones Menú", 100, 100)
		Return False
	END IF
ELSE
	ROLLBACK;
	Destroy 	lds_usuarios
	Destroy lds_menu
	Destroy lds_base	
	f_mensaje_proceso("Act. Opciones Menú", 100, 100)
	Return False
END IF


end function

on uo_menu_usuarios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_menu_usuarios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

