$PBExportHeader$w_genera_estructuras_tablas.srw
forward
global type w_genera_estructuras_tablas from window
end type
type cbx_genera_funciones_inicializacion from checkbox within w_genera_estructuras_tablas
end type
type cbx_generar_estructuras from checkbox within w_genera_estructuras_tablas
end type
type cbx_generar_funciones_carga from checkbox within w_genera_estructuras_tablas
end type
type sle_sufijo from singlelineedit within w_genera_estructuras_tablas
end type
type sle_prefijo from singlelineedit within w_genera_estructuras_tablas
end type
type pb_2 from picturebutton within w_genera_estructuras_tablas
end type
type sle_ruta from singlelineedit within w_genera_estructuras_tablas
end type
type dw_tablas_a_comparar from datawindow within w_genera_estructuras_tablas
end type
type cb_2 from commandbutton within w_genera_estructuras_tablas
end type
type dw_1 from datawindow within w_genera_estructuras_tablas
end type
type sle_bd_origen from singlelineedit within w_genera_estructuras_tablas
end type
type sle_servidor_origen from singlelineedit within w_genera_estructuras_tablas
end type
type cb_1 from commandbutton within w_genera_estructuras_tablas
end type
type pb_1 from picturebutton within w_genera_estructuras_tablas
end type
type lb_1 from listbox within w_genera_estructuras_tablas
end type
type gb_3 from groupbox within w_genera_estructuras_tablas
end type
type gb_7 from groupbox within w_genera_estructuras_tablas
end type
type gb_6 from groupbox within w_genera_estructuras_tablas
end type
type gb_1 from groupbox within w_genera_estructuras_tablas
end type
type sle_fichero_ini_origen from singlelineedit within w_genera_estructuras_tablas
end type
type gb_2 from groupbox within w_genera_estructuras_tablas
end type
type gb_5 from groupbox within w_genera_estructuras_tablas
end type
type gb_4 from groupbox within w_genera_estructuras_tablas
end type
type gb_8 from groupbox within w_genera_estructuras_tablas
end type
end forward

global type w_genera_estructuras_tablas from window
integer width = 3662
integer height = 1964
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 80269524
cbx_genera_funciones_inicializacion cbx_genera_funciones_inicializacion
cbx_generar_estructuras cbx_generar_estructuras
cbx_generar_funciones_carga cbx_generar_funciones_carga
sle_sufijo sle_sufijo
sle_prefijo sle_prefijo
pb_2 pb_2
sle_ruta sle_ruta
dw_tablas_a_comparar dw_tablas_a_comparar
cb_2 cb_2
dw_1 dw_1
sle_bd_origen sle_bd_origen
sle_servidor_origen sle_servidor_origen
cb_1 cb_1
pb_1 pb_1
lb_1 lb_1
gb_3 gb_3
gb_7 gb_7
gb_6 gb_6
gb_1 gb_1
sle_fichero_ini_origen sle_fichero_ini_origen
gb_2 gb_2
gb_5 gb_5
gb_4 gb_4
gb_8 gb_8
end type
global w_genera_estructuras_tablas w_genera_estructuras_tablas

type variables


boolean marcar = false
end variables

forward prototypes
public subroutine f_generar_estructuras ()
public subroutine f_generar_funcion_carga_estructuras ()
public function string f_genera_argumentos_funcion (string arg_tabla)
public function string f_genera_where (string arg_tabla)
public subroutine f_genera_funcion_inicializa_estructura ()
end prototypes

public subroutine f_generar_estructuras ();string sel,tabla_origen,linea_sql,nombre_campo_origen,nombre_tipo_campo_origen,prefijo,sufijo
string nombre_indice,seleccion_campos_origen,campos_origen,tablas_a_comparar,tipo_dato,archivo
long   indice,total,indice2,total2,donde,id_tabla_origen
long   tipo_campo_origen,longitud_campo_origen,precision_campo_origen,escala_campo_origen
long   status_indice,indid,colid

datastore ds_sysobjects_origen
datastore ds_syscolumns_origen
datastore ds_systypes_origen

prefijo = sle_prefijo.text
sufijo  = sle_sufijo.text

total = dw_tablas_a_comparar.rowcount()

for indice = 1 to total
	if dw_tablas_a_comparar.object.comparar[indice] = "S" then
		if tablas_a_comparar = "" then
			tablas_a_comparar = "'"+dw_tablas_a_comparar.object.name[indice]+"'"
		else
			tablas_a_comparar = tablas_a_comparar + ",'" + dw_tablas_a_comparar.object.name[indice]+"'"
		end if
	end if
next

//Cargamos los cursores con las tablas
sel = "select * from sysobjects where name in ("+tablas_a_comparar+")order by name"

f_cargar_cursor_transaccion(sqlca,ds_sysobjects_origen,sel)

total = ds_sysobjects_origen.rowcount()

//Cargamos los cursores con los tipos de datos
sel = "select * from systypes"

f_cargar_cursor_transaccion(sqlca,ds_systypes_origen,sel)

for indice = 1 to total
	f_mensaje_proceso('Generando Estructuras',indice,total)
	dw_1.reset()
	
	tabla_origen    = ds_sysobjects_origen.object.name[indice]
	id_tabla_origen = ds_sysobjects_origen.object.id[indice]								
				
	linea_sql = "$PBExportHeader$"+prefijo+tabla_origen+sufijo+".srs"			
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql	
	linea_sql = "global type "+prefijo+tabla_origen+sufijo+" from structure"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
		
	sel = "SELECT syscolumns.name, "+&
			"syscolumns.colid, "+&
			"syscolumns.xtype, "+&
			"syscolumns.length, "+&
			"syscolumns.xprec, "+&
			"syscolumns.xscale, "+&
			"syscolumns.isnullable "+&
			"FROM syscolumns, "+&
			"sysobjects "+&
			"WHERE ( syscolumns.id = sysobjects.id ) and  "+&
			"( ( sysobjects.name = '"+tabla_origen+"' ) ) ORDER BY syscolumns.colid"
	
	f_cargar_cursor_transaccion(sqlca,ds_syscolumns_origen,sel)
			
	total2 = ds_syscolumns_origen.rowcount()
	
	for indice2 = 1 to total2
		nombre_campo_origen    = ds_syscolumns_origen.object.syscolumns_name[indice2]
		tipo_campo_origen      = ds_syscolumns_origen.object.syscolumns_xtype[indice2]
		longitud_campo_origen  = ds_syscolumns_origen.object.syscolumns_length[indice2]
		precision_campo_origen = ds_syscolumns_origen.object.syscolumns_xprec[indice2]
		escala_campo_origen    = ds_syscolumns_origen.object.syscolumns_xscale[indice2]
		
		ds_systypes_origen.setfilter("xtype = "+string(tipo_campo_origen,"#########0"))
		ds_systypes_origen.filter()
		
		if ds_systypes_origen.rowcount() = 1 then			
			nombre_tipo_campo_origen = ds_systypes_origen.object.name[1]
		else
			nombre_tipo_campo_origen = "Error"
		end if
				
		choose case nombre_tipo_campo_origen
			case "char"
				tipo_dato = "STRING"
				//longitud_campo_origen
			case "varchar"
				//longitud_campo_origen
				tipo_dato = "STRING"
			case "text"
				//longitud_campo_origen
				tipo_dato = "STRING"				
			case "decimal"
				//precision_campo_origen,escala_campo_origen
				tipo_dato = "DECIMAL {"+string(escala_campo_origen)+"}"
			case "numeric"
				//precision_campo_origen,escala_campo_origen
				tipo_dato = "DECIMAL {"+string(escala_campo_origen)+"}"
			case "datetime"
				tipo_dato = "DATETIME"
			case "int"
				tipo_dato = "INTEGER"
			case "float"
				tipo_dato = "DECIMAL {6}"
			case "real"
				tipo_dato = "DECIMAL {6}"
			case "money"
				tipo_dato = "DECIMAL {6}"
			case "smallmoney"
				tipo_dato = "DECIMAL {6}"
			case else
				tipo_dato = "ERROR"
		end choose
		linea_sql = "     "+tipo_dato+"     "+nombre_campo_origen	
		donde = dw_1.insertrow(0)			
		dw_1.object.linea[donde] = linea_sql	
	next
	linea_sql = "end type"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql	

	archivo = sle_ruta.text + ""+prefijo+tabla_origen+sufijo+".srs"

	if dw_1.saveas(archivo,text!, false) <> 1 then
		messagebox("ERROR", "Se produjo un error al generar la estructura "+tabla_origen)
	end if
next

destroy ds_sysobjects_origen
destroy ds_syscolumns_origen
destroy ds_systypes_origen

end subroutine

public subroutine f_generar_funcion_carga_estructuras ();string sel,tabla_origen,linea_sql,nombre_campo_origen,nombre_tipo_campo_origen,prefijo,sufijo
string nombre_indice,seleccion_campos_origen,campos_origen,tablas_a_comparar,tipo_dato,archivo
long   indice,total,indice2,total2,donde,id_tabla_origen
long   tipo_campo_origen,longitud_campo_origen,precision_campo_origen,escala_campo_origen
long   status_indice,indid,colid

datastore ds_sysobjects_origen
datastore ds_syscolumns_origen
datastore ds_systypes_origen

prefijo = sle_prefijo.text
sufijo  = sle_sufijo.text

total = dw_tablas_a_comparar.rowcount()

for indice = 1 to total
	if dw_tablas_a_comparar.object.comparar[indice] = "S" then
		if tablas_a_comparar = "" then
			tablas_a_comparar = "'"+dw_tablas_a_comparar.object.name[indice]+"'"
		else
			tablas_a_comparar = tablas_a_comparar + ",'" + dw_tablas_a_comparar.object.name[indice]+"'"
		end if
	end if
next

//Cargamos los cursores con las tablas
sel = "select * from sysobjects where name in ("+tablas_a_comparar+")order by name"

f_cargar_cursor_transaccion(sqlca,ds_sysobjects_origen,sel)

total = ds_sysobjects_origen.rowcount()

//Cargamos los cursores con los tipos de datos
sel = "select * from systypes"

f_cargar_cursor_transaccion(sqlca,ds_systypes_origen,sel)

for indice = 1 to total
	f_mensaje_proceso('Generando Funciones de carga',indice,total)
	dw_1.reset()
	
	tabla_origen    = ds_sysobjects_origen.object.name[indice]
	id_tabla_origen = ds_sysobjects_origen.object.id[indice]								
				
	linea_sql = "$PBExportHeader$f_cargar_"+prefijo+tabla_origen+sufijo+".srf"			
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql
	
	linea_sql = "global type f_cargar_"+prefijo+tabla_origen+sufijo+" from function_object"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "end type"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql			
	
	linea_sql = ""
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "forward prototypes"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "global function boolean f_cargar_"+prefijo+tabla_origen+sufijo+" ("
	linea_sql = linea_sql + f_genera_argumentos_funcion(tabla_origen) +" ref "+prefijo+tabla_origen+sufijo+" "+prefijo+tabla_origen+sufijo+")"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql				
	
	linea_sql = "end prototypes"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql			

	linea_sql = ""
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql				
		
	linea_sql = "global function boolean f_cargar_"+prefijo+tabla_origen+sufijo+" ("
	linea_sql = linea_sql + f_genera_argumentos_funcion(tabla_origen) +" ref "+prefijo+tabla_origen+sufijo+" "+prefijo+tabla_origen+sufijo+");boolean lb_correcto = true"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql						
		
	linea_sql = ""
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql						
		
	sel = "SELECT syscolumns.name, "+&
			"syscolumns.colid, "+&
			"syscolumns.xtype, "+&
			"syscolumns.length, "+&
			"syscolumns.xprec, "+&
			"syscolumns.xscale, "+&
			"syscolumns.isnullable "+&
			"FROM syscolumns, "+&
			"sysobjects "+&
			"WHERE ( syscolumns.id = sysobjects.id ) and  "+&
			"( ( sysobjects.name = '"+tabla_origen+"' ) ) ORDER BY syscolumns.colid"
	
	f_cargar_cursor_transaccion(sqlca,ds_syscolumns_origen,sel)
			
	total2 = ds_syscolumns_origen.rowcount()
	
	for indice2 = 1 to total2
		nombre_campo_origen    = ds_syscolumns_origen.object.syscolumns_name[indice2]

		if indice2 = 1 then		
			linea_sql = "SELECT "+tabla_origen+"."+nombre_campo_origen+","	
		else
			if indice2 < total2 then
				linea_sql = "       "+tabla_origen+"."+nombre_campo_origen+","
			else
				linea_sql = "       "+tabla_origen+"."+nombre_campo_origen
			end if
		end if
		donde = dw_1.insertrow(0)			
		dw_1.object.linea[donde] = linea_sql	
	next
	
	for indice2 = 1 to total2
		nombre_campo_origen    = ds_syscolumns_origen.object.syscolumns_name[indice2]

		if indice2 = 1 then		
			linea_sql = "INTO   :"+prefijo+tabla_origen+sufijo+"."+nombre_campo_origen+","
		else
			if indice2 < total2 then
				linea_sql = "       :"+prefijo+tabla_origen+sufijo+"."+nombre_campo_origen+","
			else
				linea_sql = "       :"+prefijo+tabla_origen+sufijo+"."+nombre_campo_origen
			end if
		end if
		
		donde = dw_1.insertrow(0)			
		dw_1.object.linea[donde] = linea_sql	
	next	
	
	linea_sql = "FROM "+tabla_origen
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql			
	
	linea_sql = f_genera_where(tabla_origen)
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql			
	
	linea_sql = ""
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql			
	
	linea_sql = "if sqlca.sqlcode <> 0 then"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "    lb_correcto = false"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "end if"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "return lb_correcto"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "end function"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql	

	archivo = sle_ruta.text + "f_cargar_"+prefijo+tabla_origen+sufijo+".srf"

	if dw_1.saveas(archivo,text!, false) <> 1 then
		messagebox("ERROR", "Se produjo un error al generar la funcion f_cargar_str_"+tabla_origen)
	end if
next

destroy ds_sysobjects_origen
destroy ds_syscolumns_origen
destroy ds_systypes_origen

end subroutine

public function string f_genera_argumentos_funcion (string arg_tabla);string ls_columna,ls_argumentos,ls_tipo_columna,ls_valor_columna_clave
string sel,ls_longitud_columna,ls_tipo_campo,tipo_dato
long   indid,indice,total,li_longitud_columna
int    tipo_campo_origen,longitud_campo_origen,precision_campo_origen,escala_campo_origen
datastore ds_claves,ds_columnas_clave

ls_argumentos = ''

//Indices de la tabla 2097154 = indice unico 2050 = clave primaria
sel = "SELECT sysindexes.name, "+&
		"sysindexes.status, "+&
		"sysindexes.indid "+&
		"FROM sysindexes, "+&
		"sysobjects "+&
		"WHERE ( sysindexes.id = sysobjects.id ) and  "+&
		"( ( sysobjects.name = '"+arg_tabla+"' ) "+&
		"and sysindexes.status = 2050 ) "+&
		"order by sysindexes.indid "

total = f_cargar_cursor_transaccion(sqlca,ds_claves,sel)

if total = 0 then
	sel = "SELECT sysindexes.name, "+&
			"sysindexes.status, "+&
			"sysindexes.indid "+&
			"FROM sysindexes, "+&
			"sysobjects "+&
			"WHERE ( sysindexes.id = sysobjects.id ) and  "+&
			"( ( sysobjects.name = '"+arg_tabla+"' ) "+&
			"and sysindexes.status = 2097154 ) "+&
			"order by sysindexes.indid "
	
	total = f_cargar_cursor_transaccion(sqlca,ds_claves,sel)
		
end if

if total = 0 then
	sel = "SELECT sysindexes.name, "+&
			"sysindexes.status, "+&
			"sysindexes.indid "+&
			"FROM sysindexes, "+&
			"sysobjects "+&
			"WHERE ( sysindexes.id = sysobjects.id ) and  "+&
			"( ( sysobjects.name = '"+arg_tabla+"' ) "+&
			"and sysindexes.status = 2 ) "+&
			"order by sysindexes.indid "
	
	total = f_cargar_cursor_transaccion(sqlca,ds_claves,sel)
		
end if

if total = 0 then
	sel = "SELECT sysindexes.name, "+&
			"sysindexes.status, "+&
			"sysindexes.indid "+&
			"FROM sysindexes, "+&
			"sysobjects "+&
			"WHERE ( sysindexes.id = sysobjects.id ) and  "+&
			"( ( sysobjects.name = '"+arg_tabla+"' ) "+&
			"and sysindexes.status = 2066 ) "+&
			"order by sysindexes.indid "
	
	total = f_cargar_cursor_transaccion(sqlca,ds_claves,sel)
		
end if

if total = 1 then	
	indid         = ds_claves.object.sysindexes_indid[1]
											
	sel = "SELECT syscolumns.name,systypes.name,syscolumns.xtype,syscolumns.length,syscolumns.xprec,syscolumns.xscale "+&					
			"FROM sysindexkeys, "+&
			"sysobjects,syscolumns,systypes "+&
			"WHERE ( sysindexkeys.id = sysobjects.id ) "+&
			"and   ( sysobjects.id = syscolumns.id ) "+&
			"and   ( sysindexkeys.colid = syscolumns.colid ) "+&
			"and   ( systypes.xtype = syscolumns.xtype ) "+&
			"and ( ( sysobjects.name = '"+arg_tabla+"' ) "+&
			"and sysindexkeys.indid = '"+string(indid,"#########0")+"') "+&
			"order by sysindexkeys.keyno "
	
	f_cargar_cursor_transaccion(sqlca,ds_columnas_clave,sel)
	
	total = ds_columnas_clave.rowcount()
	
	for indice = 1 to total
		ls_columna    = ds_columnas_clave.object.syscolumns_name[indice]		
		ls_tipo_campo = ds_columnas_clave.object.systypes_name[indice]		

		tipo_campo_origen      = ds_columnas_clave.object.syscolumns_xtype[indice]
		longitud_campo_origen  = ds_columnas_clave.object.syscolumns_length[indice]
		precision_campo_origen = ds_columnas_clave.object.syscolumns_xprec[indice]
		escala_campo_origen    = ds_columnas_clave.object.syscolumns_xscale[indice]
				
		choose case ls_tipo_campo
			case "char"
				tipo_dato = "STRING"
				//longitud_campo_origen
			case "varchar"
				//longitud_campo_origen
				tipo_dato = "STRING"
			case "text"
				//longitud_campo_origen
				tipo_dato = "STRING"				
			case "decimal"
				//precision_campo_origen,escala_campo_origen
				tipo_dato = "DECIMAL {"+string(escala_campo_origen)+"}"
			case "numeric"
				//precision_campo_origen,escala_campo_origen
				tipo_dato = "DECIMAL {"+string(escala_campo_origen)+"}"
			case "datetime"
				tipo_dato = "DATETIME"
			case "int"
				tipo_dato = "INTEGER"
			case "float"
				tipo_dato = "DECIMAL {6}"
			case "real"
				tipo_dato = "DECIMAL {6}"
			case "money"
				tipo_dato = "DECIMAL {6}"
			case "smallmoney"
				tipo_dato = "DECIMAL {6}"
			case else
				tipo_dato = "ERROR"
		end choose		
				
		ls_argumentos = ls_argumentos + tipo_dato + " arg_"+ls_columna+", "
	
	next
	destroy ds_columnas_clave

end if

destroy ds_claves

return ls_argumentos
end function

public function string f_genera_where (string arg_tabla);string ls_columna,ls_where,ls_tipo_columna,ls_valor_columna_clave
string sel,ls_longitud_columna,ls_tipo_campo,tipo_dato
long   indid,indice,total,li_longitud_columna
int    tipo_campo_origen,longitud_campo_origen,precision_campo_origen,escala_campo_origen
datastore ds_claves,ds_columnas_clave

ls_where = ''

//Indices de la tabla 2097154 = indice unico 2050 = clave primaria
sel = "SELECT sysindexes.name, "+&
		"sysindexes.status, "+&
		"sysindexes.indid "+&
		"FROM sysindexes, "+&
		"sysobjects "+&
		"WHERE ( sysindexes.id = sysobjects.id ) and  "+&
		"( ( sysobjects.name = '"+arg_tabla+"' ) "+&
		"and sysindexes.status = 2050 ) "+&
		"order by sysindexes.indid "

total = f_cargar_cursor_transaccion(sqlca,ds_claves,sel)

if total = 0 then
	sel = "SELECT sysindexes.name, "+&
			"sysindexes.status, "+&
			"sysindexes.indid "+&
			"FROM sysindexes, "+&
			"sysobjects "+&
			"WHERE ( sysindexes.id = sysobjects.id ) and  "+&
			"( ( sysobjects.name = '"+arg_tabla+"' ) "+&
			"and sysindexes.status = 2097154 ) "+&
			"order by sysindexes.indid "
	
	total = f_cargar_cursor_transaccion(sqlca,ds_claves,sel)
		
end if

if total = 0 then
	sel = "SELECT sysindexes.name, "+&
			"sysindexes.status, "+&
			"sysindexes.indid "+&
			"FROM sysindexes, "+&
			"sysobjects "+&
			"WHERE ( sysindexes.id = sysobjects.id ) and  "+&
			"( ( sysobjects.name = '"+arg_tabla+"' ) "+&
			"and sysindexes.status = 2 ) "+&
			"order by sysindexes.indid "
	
	total = f_cargar_cursor_transaccion(sqlca,ds_claves,sel)
		
end if

if total = 0 then
	sel = "SELECT sysindexes.name, "+&
			"sysindexes.status, "+&
			"sysindexes.indid "+&
			"FROM sysindexes, "+&
			"sysobjects "+&
			"WHERE ( sysindexes.id = sysobjects.id ) and  "+&
			"( ( sysobjects.name = '"+arg_tabla+"' ) "+&
			"and sysindexes.status = 2066 ) "+&
			"order by sysindexes.indid "
	
	total = f_cargar_cursor_transaccion(sqlca,ds_claves,sel)
		
end if

if total = 1 then	
	indid         = ds_claves.object.sysindexes_indid[1]
											
	sel = "SELECT syscolumns.name,systypes.name,syscolumns.xtype,syscolumns.length,syscolumns.xprec,syscolumns.xscale "+&					
			"FROM sysindexkeys, "+&
			"sysobjects,syscolumns,systypes "+&
			"WHERE ( sysindexkeys.id = sysobjects.id ) "+&
			"and   ( sysobjects.id = syscolumns.id ) "+&
			"and   ( sysindexkeys.colid = syscolumns.colid ) "+&
			"and   ( systypes.xtype = syscolumns.xtype ) "+&
			"and ( ( sysobjects.name = '"+arg_tabla+"' ) "+&
			"and sysindexkeys.indid = '"+string(indid,"#########0")+"') "+&
			"order by sysindexkeys.keyno "
	
	f_cargar_cursor_transaccion(sqlca,ds_columnas_clave,sel)
	
	total = ds_columnas_clave.rowcount()
	
	for indice = 1 to total
		ls_columna    = ds_columnas_clave.object.syscolumns_name[indice]		
				
		if indice = 1 then		
			ls_where = "WHERE " + arg_tabla + "." + ls_columna + " = :arg_"+ls_columna
		else
			ls_where = ls_where + " AND " + arg_tabla + "." + ls_columna + " = :arg_"+ls_columna
		end if
	next
	ls_where = ls_where + ";"
	destroy ds_columnas_clave

end if

destroy ds_claves

return ls_where
end function

public subroutine f_genera_funcion_inicializa_estructura ();string sel,tabla_origen,linea_sql,nombre_campo_origen,nombre_tipo_campo_origen,prefijo,sufijo
string nombre_indice,seleccion_campos_origen,campos_origen,tablas_a_comparar,tipo_dato,archivo
long   indice,total,indice2,total2,donde,id_tabla_origen
long   tipo_campo_origen,longitud_campo_origen,precision_campo_origen,escala_campo_origen
long   status_indice,indid,colid

datastore ds_sysobjects_origen
datastore ds_syscolumns_origen
datastore ds_systypes_origen

prefijo = sle_prefijo.text
sufijo  = sle_sufijo.text

total = dw_tablas_a_comparar.rowcount()

for indice = 1 to total
	if dw_tablas_a_comparar.object.comparar[indice] = "S" then
		if tablas_a_comparar = "" then
			tablas_a_comparar = "'"+dw_tablas_a_comparar.object.name[indice]+"'"
		else
			tablas_a_comparar = tablas_a_comparar + ",'" + dw_tablas_a_comparar.object.name[indice]+"'"
		end if
	end if
next

//Cargamos los cursores con las tablas
sel = "select * from sysobjects where name in ("+tablas_a_comparar+")order by name"

f_cargar_cursor_transaccion(sqlca,ds_sysobjects_origen,sel)

total = ds_sysobjects_origen.rowcount()

//Cargamos los cursores con los tipos de datos
sel = "select * from systypes"

f_cargar_cursor_transaccion(sqlca,ds_systypes_origen,sel)

for indice = 1 to total
	f_mensaje_proceso('Generando Funciones de inicializacion',indice,total)
	dw_1.reset()
	
	tabla_origen    = ds_sysobjects_origen.object.name[indice]
	id_tabla_origen = ds_sysobjects_origen.object.id[indice]								
				
	linea_sql = "$PBExportHeader$f_inicializar_"+prefijo+tabla_origen+sufijo+".srf"			
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql
	
	linea_sql = "global type f_inicializar_"+prefijo+tabla_origen+sufijo+" from function_object"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "end type"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql			
	
	linea_sql = ""
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "forward prototypes"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "global function boolean f_inicializar_"+prefijo+tabla_origen+sufijo+" ("
	linea_sql = linea_sql + " ref "+prefijo+tabla_origen+sufijo+" "+prefijo+tabla_origen+sufijo+")"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql				
	
	linea_sql = "end prototypes"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql			

	linea_sql = ""
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql				
		
	linea_sql = "global function boolean f_inicializar_"+prefijo+tabla_origen+sufijo+" ("
	linea_sql = linea_sql + " ref "+prefijo+tabla_origen+sufijo+" "+prefijo+tabla_origen+sufijo+");boolean lb_correcto = true"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql						
		
	linea_sql = ""
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql						
		
	sel = "SELECT syscolumns.name, "+&
			"syscolumns.colid, "+&
			"syscolumns.xtype, "+&
			"syscolumns.length, "+&
			"syscolumns.xprec, "+&
			"syscolumns.xscale, "+&
			"syscolumns.isnullable "+&
			"FROM syscolumns, "+&
			"sysobjects "+&
			"WHERE ( syscolumns.id = sysobjects.id ) and  "+&
			"( ( sysobjects.name = '"+tabla_origen+"' ) ) ORDER BY syscolumns.colid"
	
	f_cargar_cursor_transaccion(sqlca,ds_syscolumns_origen,sel)
			
	total2 = ds_syscolumns_origen.rowcount()
	
	for indice2 = 1 to total2
		nombre_campo_origen    = ds_syscolumns_origen.object.syscolumns_name[indice2]


		linea_sql = "if isnull("+prefijo+tabla_origen+"."+nombre_campo_origen+") then "+prefijo+tabla_origen+"."+nombre_campo_origen+" = "

		tipo_campo_origen      = ds_syscolumns_origen.object.syscolumns_xtype[indice2]
		
		ds_systypes_origen.setfilter("xtype = "+string(tipo_campo_origen,"#########0"))
		ds_systypes_origen.filter()
		
		if ds_systypes_origen.rowcount() = 1 then			
			nombre_tipo_campo_origen = ds_systypes_origen.object.name[1]
		else
			nombre_tipo_campo_origen = "Error"
		end if
				
		choose case nombre_tipo_campo_origen
			case "char"
				linea_sql = linea_sql + "''"
			case "varchar"
				linea_sql = linea_sql + "''"
			case "text"
				linea_sql = linea_sql + "''"
			case "decimal"
				linea_sql = linea_sql + "0"
			case "numeric"
				linea_sql = linea_sql + "0"
			case "datetime"
				linea_sql = ""
			case "int"
				linea_sql = linea_sql + "0"
			case "float"
				linea_sql = linea_sql + "0"
			case "real"
				linea_sql = linea_sql + "0"
			case "money"
				linea_sql = linea_sql + "0"
			case "smallmoney"
				linea_sql = linea_sql + "0"
			case else
				linea_sql = ""
		end choose
		
		if trim(linea_sql) <> "" then
			donde = dw_1.insertrow(0)			
			dw_1.object.linea[donde] = linea_sql	
		end if
	next
	
	linea_sql = "return lb_correcto"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql		
	
	linea_sql = "end function"
	donde = dw_1.insertrow(0)			
	dw_1.object.linea[donde] = linea_sql	

	archivo = sle_ruta.text + "f_inicializar_"+prefijo+tabla_origen+sufijo+".srf"

	if dw_1.saveas(archivo,text!, false) <> 1 then
		messagebox("ERROR", "Se produjo un error al generar la funcion f_inicializar_str_"+tabla_origen)
	end if
next

destroy ds_sysobjects_origen
destroy ds_syscolumns_origen
destroy ds_systypes_origen

end subroutine

on w_genera_estructuras_tablas.create
this.cbx_genera_funciones_inicializacion=create cbx_genera_funciones_inicializacion
this.cbx_generar_estructuras=create cbx_generar_estructuras
this.cbx_generar_funciones_carga=create cbx_generar_funciones_carga
this.sle_sufijo=create sle_sufijo
this.sle_prefijo=create sle_prefijo
this.pb_2=create pb_2
this.sle_ruta=create sle_ruta
this.dw_tablas_a_comparar=create dw_tablas_a_comparar
this.cb_2=create cb_2
this.dw_1=create dw_1
this.sle_bd_origen=create sle_bd_origen
this.sle_servidor_origen=create sle_servidor_origen
this.cb_1=create cb_1
this.pb_1=create pb_1
this.lb_1=create lb_1
this.gb_3=create gb_3
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_1=create gb_1
this.sle_fichero_ini_origen=create sle_fichero_ini_origen
this.gb_2=create gb_2
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_8=create gb_8
this.Control[]={this.cbx_genera_funciones_inicializacion,&
this.cbx_generar_estructuras,&
this.cbx_generar_funciones_carga,&
this.sle_sufijo,&
this.sle_prefijo,&
this.pb_2,&
this.sle_ruta,&
this.dw_tablas_a_comparar,&
this.cb_2,&
this.dw_1,&
this.sle_bd_origen,&
this.sle_servidor_origen,&
this.cb_1,&
this.pb_1,&
this.lb_1,&
this.gb_3,&
this.gb_7,&
this.gb_6,&
this.gb_1,&
this.sle_fichero_ini_origen,&
this.gb_2,&
this.gb_5,&
this.gb_4,&
this.gb_8}
end on

on w_genera_estructuras_tablas.destroy
destroy(this.cbx_genera_funciones_inicializacion)
destroy(this.cbx_generar_estructuras)
destroy(this.cbx_generar_funciones_carga)
destroy(this.sle_sufijo)
destroy(this.sle_prefijo)
destroy(this.pb_2)
destroy(this.sle_ruta)
destroy(this.dw_tablas_a_comparar)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.sle_bd_origen)
destroy(this.sle_servidor_origen)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.lb_1)
destroy(this.gb_3)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_1)
destroy(this.sle_fichero_ini_origen)
destroy(this.gb_2)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_8)
end on

event open;string fichero_ini_origen,tabla,xtype,comparar
long   indice,total,id_tabla

this.title = "GENERACION DE ESTRUCTURAS"

sle_servidor_origen.text = sqlca.ServerName
sle_bd_origen.text       = sqlca.Database

dw_tablas_a_comparar.settransobject(sqlca)

total = dw_tablas_a_comparar.retrieve()

for indice = 1 to total
	tabla    = dw_tablas_a_comparar.object.name[indice]    
	id_tabla = dw_tablas_a_comparar.object.id[indice]    
	xtype    = dw_tablas_a_comparar.object.xtype[indice]
	
	if id_tabla > 0 then		
		if xtype <> 'U' or (left(tabla,2) = "pb" or left(tabla,3) = "sys") then
			comparar = "N"
		else
			if pos(tabla,"copy") > 0 or tabla = "dtproperties" then
				comparar = "N"
			else
				comparar = "S"
			end if	
		end if
	else
		comparar = "N"
	end if
	
	dw_tablas_a_comparar.object.comparar[indice] = comparar
	
next


//trans_copias.AutoCommit = sqlca.AutoCommit
//trans_copias.Database = sqlca.Database
//trans_copias.DBMS = sqlca.DBMS
//trans_copias.DBParm = sqlca.DBParm
//trans_copias.DBPass = sqlca.DBPass
//trans_copias.Lock = sqlca.Lock
//trans_copias.LogID = sqlca.LogID
//trans_copias.LogPass = sqlca.LogPass
//trans_copias.ServerName = sqlca.ServerName
//trans_copias.SQLCode = sqlca.SQLCode
//trans_copias.SQLDBCode = sqlca.SQLDBCode
//trans_copias.SQLErrText = sqlca.SQLErrText
//trans_copias.SQLNRows = sqlca.SQLNRows
//trans_copias.SQLReturnData = sqlca.SQLReturnData
//trans_copias.UserID = sqlca.UserID
end event

event key;

//if dw_tablas_a_comparar.visible = true then
//	keycode
//end if
end event

type cbx_genera_funciones_inicializacion from checkbox within w_genera_estructuras_tablas
integer x = 1824
integer y = 340
integer width = 1216
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Generar funciones inicializacion estructuras"
end type

type cbx_generar_estructuras from checkbox within w_genera_estructuras_tablas
integer x = 1824
integer y = 160
integer width = 1042
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Generar estructuras"
end type

type cbx_generar_funciones_carga from checkbox within w_genera_estructuras_tablas
integer x = 1824
integer y = 248
integer width = 1042
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Generar funciones carga estructuras"
end type

type sle_sufijo from singlelineedit within w_genera_estructuras_tablas
integer x = 2405
integer y = 504
integer width = 507
integer height = 80
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_prefijo from singlelineedit within w_genera_estructuras_tablas
integer x = 1847
integer y = 504
integer width = 507
integer height = 80
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "str_"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type pb_2 from picturebutton within w_genera_estructuras_tablas
integer x = 3479
integer y = 704
integer width = 110
integer height = 96
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean originalsize = true
string picturename = "c:\bmp\carpeta2.bmp"
alignment htextalign = right!
end type

event clicked;string ruta,fichero
long   fin_ruta
//if GetFileOpenName("Seleccione Directorio de la copia",ruta,fichero,"BMP","Texto (*.TXT),*.TXT") = 1 then
//	sle_ruta.text = ruta
//end if

if GetFileSaveName("Seleccione Directorio",ruta,fichero,"srs","SRS (*.SRS),*.SRS") = 1 then
	fin_ruta = pos(ruta,fichero)
	sle_ruta.text = left(ruta,fin_ruta -1)	
end if


end event

type sle_ruta from singlelineedit within w_genera_estructuras_tablas
integer x = 722
integer y = 712
integer width = 2752
integer height = 80
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;if fileexists(sle_ruta.text) then
	if right(trim(sle_ruta.text),1) <> "\" then
		sle_ruta.text = sle_ruta.text + "\"
	end if
else
	messagebox("Atencion", "No existe el directorio")
	sle_ruta.setfocus()
end if
end event

type dw_tablas_a_comparar from datawindow within w_genera_estructuras_tablas
boolean visible = false
integer y = 804
integer width = 1723
integer height = 1036
integer taborder = 150
string dataobject = "dw_compara_bases_de_datos2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long   indice,total
string comparar

if dwo.name = "pb_marcar" then
	if marcar then
		comparar = "S"
	else
		comparar = "N"
	end if
	
	total = this.rowcount()
	
	for indice = 1 to total
		this.object.comparar[indice] = comparar
	next
	
	marcar = not(marcar)
end if
end event

type cb_2 from commandbutton within w_genera_estructuras_tablas
integer x = 32
integer y = 696
integer width = 599
integer height = 108
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Estructuras a Generar"
end type

event clicked;dw_tablas_a_comparar.visible = not(dw_tablas_a_comparar.visible)
end event

type dw_1 from datawindow within w_genera_estructuras_tablas
integer y = 952
integer width = 3607
integer height = 884
integer taborder = 70
string dataobject = "dw_genera_estructuras_tablas"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type sle_bd_origen from singlelineedit within w_genera_estructuras_tablas
integer x = 50
integer y = 504
integer width = 1627
integer height = 80
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;string fichero_ini_origen,tabla,xtype,comparar
long   indice,total,id_tabla

fichero_ini_origen = sle_fichero_ini_origen.text

disconnect using sqlca;
sqlca.lock       = ProfileString(fichero_ini_origen,"database","lock","")
sqlca.DBMS       = ProfileString(fichero_ini_origen,"database","dbms","")
sqlca.Database   = this.text
sqlca.UserId     = ProfileString(fichero_ini_origen,"database","userid","")
sqlca.ServerName = ProfileString(fichero_ini_origen,"database","servername","")
sqlca.DbParm     = ProfileString(fichero_ini_origen,"database","dbparm","")
sqlca.logid      = ProfileString(fichero_ini_origen,"database","logid","")
//sle_usuario.text = ProfileString(fichero_ini_origen,"database","usuario","")+" EUROS"

connect using sqlca;
if sqlca.sqlcode <> 0 then
	MessageBox ("No Puedo conectar a la Base de Datos", sqlca.sqlerrtext)
end if

sle_servidor_origen.text = sqlca.ServerName
sle_bd_origen.text       = sqlca.Database

dw_tablas_a_comparar.settransobject(sqlca)

total = dw_tablas_a_comparar.retrieve()

for indice = 1 to total
	tabla    = dw_tablas_a_comparar.object.name[indice]    
	id_tabla = dw_tablas_a_comparar.object.id[indice]    
	xtype    = dw_tablas_a_comparar.object.xtype[indice]
	
	if id_tabla > 0 then		
		if xtype <> 'U' or (left(tabla,2) = "pb" or left(tabla,3) = "sys") then
			comparar = "N"
		else
			if pos(tabla,"copy") > 0 or tabla = "dtproperties" then
				comparar = "N"
			else
				comparar = "S"
			end if	
		end if
	else
		comparar = "N"
	end if
	
	dw_tablas_a_comparar.object.comparar[indice] = comparar
	
next
end event

type sle_servidor_origen from singlelineedit within w_genera_estructuras_tablas
integer x = 50
integer y = 316
integer width = 1627
integer height = 80
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_genera_estructuras_tablas
integer y = 840
integer width = 3607
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;if cbx_generar_estructuras.checked then
	f_generar_estructuras()
end if
if cbx_generar_funciones_carga.checked then
	f_generar_funcion_carga_estructuras()
end if
if cbx_genera_funciones_inicializacion.checked then
	f_genera_funcion_inicializa_estructura()
end if
end event

type pb_1 from picturebutton within w_genera_estructuras_tablas
integer x = 1586
integer y = 124
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean enabled = false
boolean originalsize = true
string picturename = "c:\bmp\carpeta2.bmp"
end type

event clicked;string ruta,fichero

if GetFileSaveName("Seleccione Fichero INI",ruta,fichero,"INI","Opciones de configuracion (*.INI),*.INI") = 1 then
	sle_fichero_ini_origen.text = ruta
	sle_fichero_ini_origen.triggerevent(modified!)
end if

end event

type lb_1 from listbox within w_genera_estructuras_tablas
boolean visible = false
integer x = 2894
integer y = 200
integer width = 658
integer height = 72
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_genera_estructuras_tablas
integer x = 690
integer y = 636
integer width = 2917
integer height = 200
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 33554432
long backcolor = 80269524
string text = "Ruta de los ficheros a exportar"
end type

type gb_7 from groupbox within w_genera_estructuras_tablas
integer x = 14
integer y = 444
integer width = 1696
integer height = 168
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Base Datos"
end type

type gb_6 from groupbox within w_genera_estructuras_tablas
integer x = 14
integer y = 256
integer width = 1696
integer height = 168
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Servidor "
end type

type gb_1 from groupbox within w_genera_estructuras_tablas
integer x = 14
integer y = 68
integer width = 1696
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 33554432
long backcolor = 80269524
string text = "Fichero INI"
end type

type sle_fichero_ini_origen from singlelineedit within w_genera_estructuras_tablas
integer x = 41
integer y = 128
integer width = 1531
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event modified;string fichero_ini_origen,tabla,xtype,comparar
long   indice,total,id_tabla

fichero_ini_origen = this.text

disconnect using sqlca;
sqlca.lock       = ProfileString(fichero_ini_origen,"database","lock","")
sqlca.DBMS       = ProfileString(fichero_ini_origen,"database","dbms","")
sqlca.Database   = ProfileString(fichero_ini_origen,"database","database","")
sqlca.UserId     = ProfileString(fichero_ini_origen,"database","userid","")
sqlca.ServerName = ProfileString(fichero_ini_origen,"database","servername","")
sqlca.DbParm     = ProfileString(fichero_ini_origen,"database","dbparm","")
sqlca.logid      = ProfileString(fichero_ini_origen,"database","logid","")
//sle_usuario.text = ProfileString(fichero_ini_origen,"database","usuario","")+" EUROS"

connect using sqlca;
if sqlca.sqlcode <> 0 then
	MessageBox ("No Puedo conectar a la Base de Datos", sqlca.sqlerrtext)
end if

sle_servidor_origen.text = sqlca.ServerName
sle_bd_origen.text       = sqlca.Database

dw_tablas_a_comparar.settransobject(sqlca)

total = dw_tablas_a_comparar.retrieve()

for indice = 1 to total
	tabla    = dw_tablas_a_comparar.object.name[indice]    
	id_tabla = dw_tablas_a_comparar.object.id[indice]    
	xtype    = dw_tablas_a_comparar.object.xtype[indice]
	
	if id_tabla > 0 then		
		if xtype <> 'U' or (left(tabla,2) = "pb" or left(tabla,3) = "sys") then
			comparar = "N"
		else
			if pos(tabla,"copy") > 0 or tabla = "dtproperties" then
				comparar = "N"
			else
				comparar = "S"
			end if	
		end if
	else
		comparar = "N"
	end if
	
	dw_tablas_a_comparar.object.comparar[indice] = comparar
	
next
end event

type gb_2 from groupbox within w_genera_estructuras_tablas
integer width = 1723
integer height = 640
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "B.D. Origen"
end type

type gb_5 from groupbox within w_genera_estructuras_tablas
integer y = 636
integer width = 667
integer height = 200
integer taborder = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Opciones"
end type

type gb_4 from groupbox within w_genera_estructuras_tablas
integer x = 1824
integer y = 444
integer width = 553
integer height = 168
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prefijo"
end type

type gb_8 from groupbox within w_genera_estructuras_tablas
integer x = 2382
integer y = 444
integer width = 553
integer height = 168
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sufijo"
end type

