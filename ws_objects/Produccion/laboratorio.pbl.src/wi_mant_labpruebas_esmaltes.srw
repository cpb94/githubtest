$PBExportHeader$wi_mant_labpruebas_esmaltes.srw
forward
global type wi_mant_labpruebas_esmaltes from wi_mvent_con_empresa
end type
type em_observaciones from u_em_campo within wi_mant_labpruebas_esmaltes
end type
type pb_calculadora from u_calculadora within wi_mant_labpruebas_esmaltes
end type
type cb_version from u_boton within wi_mant_labpruebas_esmaltes
end type
type gb_6 from groupbox within wi_mant_labpruebas_esmaltes
end type
type gb_5 from groupbox within wi_mant_labpruebas_esmaltes
end type
type gb_2 from groupbox within wi_mant_labpruebas_esmaltes
end type
type pb_calculadora_prueba from u_calculadora within wi_mant_labpruebas_esmaltes
end type
type dw_listado_esmaltes from datawindow within wi_mant_labpruebas_esmaltes
end type
type cbx_lab from checkbox within wi_mant_labpruebas_esmaltes
end type
type cbx_com from checkbox within wi_mant_labpruebas_esmaltes
end type
type pb_2 from upb_imprimir within wi_mant_labpruebas_esmaltes
end type
type cb_formatos from commandbutton within wi_mant_labpruebas_esmaltes
end type
type pb_borra_version from picturebutton within wi_mant_labpruebas_esmaltes
end type
type gb_1 from groupbox within wi_mant_labpruebas_esmaltes
end type
type dw_versiones from datawindow within wi_mant_labpruebas_esmaltes
end type
type dw_formatos from u_datawindow within wi_mant_labpruebas_esmaltes
end type
type dw_anyade_formulas from u_datawindow within wi_mant_labpruebas_esmaltes
end type
type dw_formulas from u_datawindow within wi_mant_labpruebas_esmaltes
end type
type dw_aplicaciones from u_datawindow within wi_mant_labpruebas_esmaltes
end type
type gb_4 from groupbox within wi_mant_labpruebas_esmaltes
end type
type gb_3 from groupbox within wi_mant_labpruebas_esmaltes
end type
end forward

global type wi_mant_labpruebas_esmaltes from wi_mvent_con_empresa
integer width = 3707
integer height = 2044
em_observaciones em_observaciones
pb_calculadora pb_calculadora
cb_version cb_version
gb_6 gb_6
gb_5 gb_5
gb_2 gb_2
pb_calculadora_prueba pb_calculadora_prueba
dw_listado_esmaltes dw_listado_esmaltes
cbx_lab cbx_lab
cbx_com cbx_com
pb_2 pb_2
cb_formatos cb_formatos
pb_borra_version pb_borra_version
gb_1 gb_1
dw_versiones dw_versiones
dw_formatos dw_formatos
dw_anyade_formulas dw_anyade_formulas
dw_formulas dw_formulas
dw_aplicaciones dw_aplicaciones
gb_4 gb_4
gb_3 gb_3
end type
global wi_mant_labpruebas_esmaltes wi_mant_labpruebas_esmaltes

type variables
String version_actual,inserta_aplicacion,borra_version
Long  registros_aplicacion,donde_inserto_aplicacion
end variables

forward prototypes
public subroutine f_imprimir_pruebas_esmaltes (datawindow data, long inicio, long fin)
public subroutine f_inserta_en_blanco (datawindow data, long linea, long donde)
end prototypes

public subroutine f_imprimir_pruebas_esmaltes (datawindow data, long inicio, long fin);string    sel_esm,sel_esm_versiones,sel_esm_ver_detalle,sel_esm_ver_formulas,sel_esm_formatos,cadena
Datastore datos1,datos2,datos3,datos4,datos5
Long      total1,total2,total3,total4,total5,indice1,indice2,indice3,indice4,indice5,donde,i,j,total_registros
String    var_cliente,var_modelo,var_descripcion,var_formato,var_version,var_n_aplicacion
String    var_aplicacion,var_nom_aplicacion,var_formula,var_observaciones,var_tipo_cliente,var_unidad
String    var_cadena_cantidad,var_cadena_unidad,var_cadena_aplicacion,var_cadena_densidad,var_cadena_gramaje,var_cadena_temperatura,var_cadena_nom_apli
Dec{2}    var_cantidad,var_gramaje,var_densidad,var_temperatura
Dec{0}    var_orden
Datetime  var_falta
Long      columna
String    version_aux

data.Reset()
data.setredraw(false)

if trim(sle_valor.text) <> "" and dw_1.rowcount() = 1 then
	//Obtenemos los datos de la prueba
	sel_esm = "select * "+&
				 "from prod_esmaltes "+&
				 "where empresa = '"+codigo_empresa+"' and "+&
				 "prueba = '"+sle_valor.text+"'"			 
	//datos1 = f_cargar_cursor(sel_esm)
	f_cargar_cursor_nuevo(sel_esm, datos1)
	
	var_cliente     = datos1.object.cliente[1]
	var_descripcion = datos1.object.descripcion[1]
	var_falta       = datos1.object.f_alta[1]
	var_tipo_cliente= datos1.object.tipo_cli[1]
	
	//Obtenemos los datos de los formatos de la prueba
	sel_esm_formatos = "select * "+&
							 "from prod_esmaltes_formato "+&
							 "where empresa = '"+codigo_empresa+"' and "+&
							 "prueba = '"+sle_valor.text+"'"
	//datos5 = f_cargar_cursor(sel_esm_formatos)
	f_cargar_cursor_nuevo(sel_esm_formatos, datos5)
	
	total5 = datos5.RowCount()
	var_formato = ""
	i = 0
	for indice5 = 1 to total5
		if i = 0 then
			cadena = ""
		else
			cadena = " / "
		end if
		var_formato = var_formato + cadena + f_nombre_formato(codigo_empresa,datos5.object.formato[indice5]) + " " + f_nombre_modelos(codigo_empresa, datos5.object.modelo[indice5])
		i++
	next
	if fin = 999 then 
		sel_esm_versiones = "select * "+&
								  "from prod_esmaltes_versiones "+&
								  "where empresa = '"+codigo_empresa+"' and "+&
								  "prueba = '"+sle_valor.text+"'"
		//datos2 = f_cargar_cursor(sel_esm_versiones)
		f_cargar_cursor_nuevo(sel_esm_versiones, datos2)
		total2 = datos2.RowCount()
		if total2 > 0 then
			fin = total2
		else
			fin = 0
		end if
		destroy datos2
	end if
	
	for columna = inicio to fin
		version_aux= string(columna)
		//Obtenemos los datos de las versiones de la prueba
		sel_esm_versiones = "select * "+&
								  "from prod_esmaltes_versiones "+&
								  "where empresa = '"+codigo_empresa+"' and "+&
								  "prueba = '"+sle_valor.text+"' and "+&
								  "version = '"+version_aux+"'"
		//datos2 = f_cargar_cursor(sel_esm_versiones)
		f_cargar_cursor_nuevo(sel_esm_versiones, datos2)
		total2 = datos2.RowCount()
		//Para cada versión
		for indice2 = 1 to total2
				var_version       = datos2.object.version[indice2]
				var_observaciones = datos2.object.observaciones[indice2]
				//Obtenemos los datos de las aplicaciones de la versión
				sel_esm_ver_detalle = "select * "+&
											 "from prod_esmaltes_detalle "+&
											 "where empresa = '"+codigo_empresa+"' and "+&
											 "prueba = '"+sle_valor.text+"' and "+&
											 "version = '"+var_version+"'"
				//datos3 = f_cargar_cursor(sel_esm_ver_detalle)
				f_cargar_cursor_nuevo(sel_esm_ver_detalle, datos3)
				total3 = datos3.RowCount()
				//Para cada Nº de aplicación de la versión
				for indice3 = 1 to total3
					var_n_aplicacion = datos3.object.n_aplicacion[indice3]
					var_aplicacion     = datos3.object.aplicacion[indice3]
					var_nom_aplicacion = f_nombre_aplicacion_abr(codigo_empresa ,datos3.object.aplicacion[indice3])
					var_densidad     = datos3.object.densidad[indice3]
					var_gramaje      = datos3.object.gramaje[indice3]
					var_temperatura  = datos3.object.temperatura[indice3]
					//Obtenemos las fórmulas de cada aplicación
					sel_esm_ver_formulas = "select * "+&
												  "from prod_esmaltes_detalle_formula "+&
												  "where empresa = '"+codigo_empresa+"' and "+&
												  "prueba = '"+sle_valor.text+"' and "+&
												  "version = '"+var_version+"' and "+&
												  "n_aplicacion = '"+var_n_aplicacion+"'"
					//datos4 = f_cargar_cursor(sel_esm_ver_formulas)
					f_cargar_cursor_nuevo(sel_esm_ver_formulas, datos4)
					total4 = datos4.RowCount()
					for indice4 = 1 to total4
							var_orden      = datos4.object.orden[indice4]
							var_formula    = datos4.object.formula[indice4]
							var_cantidad   = datos4.object.cantidad[indice4]
							var_unidad     = f_nombre_unidad_abr(datos4.object.unidad[indice4])
							total_registros = data.RowCount()
							donde = data.find("empresa = '"+codigo_empresa+"' and n_aplicacion = '"+var_n_aplicacion+"' and formula = '"+var_formula+"'",1,total_registros)
							if donde > 0 then
								CHOOSE CASE columna
									CASE 1
										data.object.aplicacion1[donde]    = var_aplicacion
										data.object.nombre_aplicacion1[donde] = var_nom_aplicacion
										data.object.densidad1[donde]      = var_densidad
										data.object.gramaje1[donde]       = var_gramaje
										data.object.temperatura1[donde]   = var_temperatura
										data.object.cantidad1[donde]      = var_cantidad
										data.object.unidad1[donde]        = var_unidad
										
									CASE 2
										data.object.aplicacion2[donde]    = var_aplicacion
										data.object.nombre_aplicacion2[donde] = var_nom_aplicacion
										data.object.densidad2[donde]      = var_densidad
										data.object.gramaje2[donde]       = var_gramaje
										data.object.temperatura2[donde]   = var_temperatura
										data.object.cantidad2[donde]      = var_cantidad
										data.object.unidad2[donde]        = var_unidad
										
									CASE 3
										data.object.aplicacion3[donde]    = var_aplicacion
										data.object.nombre_aplicacion3[donde] = var_nom_aplicacion
										data.object.densidad3[donde]      = var_densidad
										data.object.gramaje3[donde]       = var_gramaje
										data.object.temperatura3[donde]   = var_temperatura
										data.object.cantidad3[donde]      = var_cantidad
										data.object.unidad3[donde]        = var_unidad
										
									CASE 4
										data.object.aplicacion4[donde]    = var_aplicacion
										data.object.nombre_aplicacion4[donde] = var_nom_aplicacion
										data.object.densidad4[donde]      = var_densidad
										data.object.gramaje4[donde]       = var_gramaje
										data.object.temperatura4[donde]   = var_temperatura
										data.object.cantidad4[donde]      = var_cantidad
										data.object.unidad4[donde]        = var_unidad
									CASE 5
										data.object.aplicacion5[donde]    = var_aplicacion
										data.object.nombre_aplicacion5[donde] = var_nom_aplicacion
										data.object.densidad5[donde]      = var_densidad
										data.object.gramaje5[donde]       = var_gramaje
										data.object.temperatura5[donde]   = var_temperatura
										data.object.cantidad5[donde]      = var_cantidad
										data.object.unidad5[donde]        = var_unidad
									CASE 6
										data.object.aplicacion6[donde]    = var_aplicacion
										data.object.nombre_aplicacion6[donde] = var_nom_aplicacion
										data.object.densidad6[donde]      = var_densidad
										data.object.gramaje6[donde]       = var_gramaje
										data.object.temperatura6[donde]   = var_temperatura
										data.object.cantidad6[donde]      = var_cantidad
										data.object.unidad6[donde]        = var_unidad
									CASE 7
										data.object.aplicacion7[donde]    = var_aplicacion
										data.object.nombre_aplicacion7[donde] = var_nom_aplicacion
										data.object.densidad7[donde]      = var_densidad
										data.object.gramaje7[donde]       = var_gramaje
										data.object.temperatura7[donde]   = var_temperatura
										data.object.cantidad7[donde]      = var_cantidad
										data.object.unidad7[donde]        = var_unidad
									CASE 8
										data.object.aplicacion8[donde]    = var_aplicacion
										data.object.nombre_aplicacion8[donde] = var_nom_aplicacion
										data.object.densidad8[donde]      = var_densidad
										data.object.gramaje8[donde]       = var_gramaje
										data.object.temperatura8[donde]   = var_temperatura
										data.object.cantidad8[donde]      = var_cantidad
										data.object.unidad8[donde]        = var_unidad
									CASE 9
										data.object.aplicacion9[donde]    = var_aplicacion
										data.object.nombre_aplicacion9[donde] = var_nom_aplicacion
										data.object.densidad9[donde]      = var_densidad
										data.object.gramaje9[donde]       = var_gramaje
										data.object.temperatura9[donde]   = var_temperatura
										data.object.cantidad9[donde]      = var_cantidad
										data.object.unidad9[donde]        = var_unidad
									CASE 10						
										data.object.aplicacion10[donde]   = var_aplicacion
										data.object.nombre_aplicacion10[donde] = var_nom_aplicacion
										data.object.densidad10[donde]     = var_densidad
										data.object.gramaje10[donde]      = var_gramaje
										data.object.temperatura10[donde]  = var_temperatura
										data.object.cantidad10[donde]     = var_cantidad
										data.object.unidad10[donde]       = var_unidad
								END CHOOSE
								
							else
								donde = data.insertrow(0)
								data.object.empresa[donde]       = codigo_empresa
								data.object.prueba[donde]        = sle_valor.text
								data.object.cliente[donde]       = var_cliente
								data.object.modelo[donde]        = var_modelo
								data.object.descripcion[donde]   = var_descripcion
								data.object.formato[donde]       = var_formato
								data.object.f_alta[donde]        = var_falta
								data.object.version[donde]       = var_version
								data.object.observaciones[donde] = var_observaciones
								data.object.n_aplicacion[donde]  = var_n_aplicacion
								data.object.formula[donde]       = var_formula
								CHOOSE CASE columna
									CASE 1
										data.object.aplicacion1[donde]    = var_aplicacion
										data.object.nombre_aplicacion1[donde] = var_nom_aplicacion
										data.object.densidad1[donde]      = var_densidad
										data.object.gramaje1[donde]       = var_gramaje
										data.object.temperatura1[donde]   = var_temperatura
										data.object.cantidad1[donde]      = var_cantidad
										data.object.unidad1[donde]        = var_unidad
										
									CASE 2
										data.object.aplicacion2[donde]    = var_aplicacion
										data.object.nombre_aplicacion2[donde] = var_nom_aplicacion
										data.object.densidad2[donde]      = var_densidad
										data.object.gramaje2[donde]       = var_gramaje
										data.object.temperatura2[donde]   = var_temperatura
										data.object.cantidad2[donde]      = var_cantidad
										data.object.unidad2[donde]        = var_unidad
										
									CASE 3
										data.object.aplicacion3[donde]    = var_aplicacion
										data.object.nombre_aplicacion3[donde] = var_nom_aplicacion
										data.object.densidad3[donde]      = var_densidad
										data.object.gramaje3[donde]       = var_gramaje
										data.object.temperatura3[donde]   = var_temperatura
										data.object.cantidad3[donde]      = var_cantidad
										data.object.unidad3[donde]        = var_unidad
										
									CASE 4
										data.object.aplicacion4[donde]    = var_aplicacion
										data.object.nombre_aplicacion4[donde] = var_nom_aplicacion
										data.object.densidad4[donde]      = var_densidad
										data.object.gramaje4[donde]       = var_gramaje
										data.object.temperatura4[donde]   = var_temperatura
										data.object.cantidad4[donde]      = var_cantidad
										data.object.unidad4[donde]        = var_unidad
									CASE 5
										data.object.aplicacion5[donde]    = var_aplicacion
										data.object.nombre_aplicacion5[donde] = var_nom_aplicacion
										data.object.densidad5[donde]      = var_densidad
										data.object.gramaje5[donde]       = var_gramaje
										data.object.temperatura5[donde]   = var_temperatura
										data.object.cantidad5[donde]      = var_cantidad
										data.object.unidad5[donde]        = var_unidad
									CASE 6
										data.object.aplicacion6[donde]    = var_aplicacion
										data.object.nombre_aplicacion6[donde] = var_nom_aplicacion
										data.object.densidad6[donde]      = var_densidad
										data.object.gramaje6[donde]       = var_gramaje
										data.object.temperatura6[donde]   = var_temperatura
										data.object.cantidad6[donde]      = var_cantidad
										data.object.unidad6[donde]        = var_unidad
									CASE 7
										data.object.aplicacion7[donde]    = var_aplicacion
										data.object.nombre_aplicacion7[donde] = var_nom_aplicacion
										data.object.densidad7[donde]      = var_densidad
										data.object.gramaje7[donde]       = var_gramaje
										data.object.temperatura7[donde]   = var_temperatura
										data.object.cantidad7[donde]      = var_cantidad
										data.object.unidad7[donde]        = var_unidad
									CASE 8
										data.object.aplicacion8[donde]    = var_aplicacion
										data.object.nombre_aplicacion8[donde] = var_nom_aplicacion
										data.object.densidad8[donde]      = var_densidad
										data.object.gramaje8[donde]       = var_gramaje
										data.object.temperatura8[donde]   = var_temperatura
										data.object.cantidad8[donde]      = var_cantidad
										data.object.unidad8[donde]        = var_unidad
									CASE 9
										data.object.aplicacion9[donde]    = var_aplicacion
										data.object.nombre_aplicacion9[donde] = var_nom_aplicacion
										data.object.densidad9[donde]      = var_densidad
										data.object.gramaje9[donde]       = var_gramaje
										data.object.temperatura9[donde]   = var_temperatura
										data.object.cantidad9[donde]      = var_cantidad
										data.object.unidad9[donde]        = var_unidad
									CASE 10						
										data.object.aplicacion10[donde]   = var_aplicacion
										data.object.nombre_aplicacion10[donde] = var_nom_aplicacion
										data.object.densidad10[donde]     = var_densidad
										data.object.gramaje10[donde]      = var_gramaje
										data.object.temperatura10[donde]  = var_temperatura
										data.object.cantidad10[donde]     = var_cantidad
										data.object.unidad10[donde]       = var_unidad
								END CHOOSE
							end if
						next
				next								
		next	
	next
end if

destroy datos1
destroy datos2
destroy datos3
destroy datos4
destroy datos5

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

public subroutine f_inserta_en_blanco (datawindow data, long linea, long donde);choose case linea
	case 1
		data.object.cantidad1[donde]     = 0
		data.object.unidad1[donde]       = ""
		data.object.aplicacion1[donde]   = ""
		data.object.nombre_aplicacion1[donde] = ""
		data.object.densidad1[donde]     = 0
		data.object.gramaje1[donde]      = 0
		data.object.temperatura1[donde]  = 0
	case 2
		data.object.cantidad2[donde]     = 0
		data.object.unidad2[donde]       = ""
		data.object.aplicacion2[donde]   = ""
		data.object.nombre_aplicacion2[donde] = ""
		data.object.densidad2[donde]     = 0
		data.object.gramaje2[donde]      = 0
		data.object.temperatura2[donde]  = 0
	case 3
		data.object.cantidad3[donde]     = 0
		data.object.unidad3[donde]       = ""
		data.object.aplicacion3[donde]   = ""
		data.object.nombre_aplicacion3[donde] = ""
		data.object.densidad3[donde]     = 0
		data.object.gramaje3[donde]      = 0
		data.object.temperatura3[donde]  = 0
	case 4
		data.object.cantidad4[donde]     = 0
		data.object.unidad4[donde]       = ""
		data.object.aplicacion4[donde]   = ""
		data.object.nombre_aplicacion4[donde] = ""
		data.object.densidad4[donde]     = 0
		data.object.gramaje4[donde]      = 0
		data.object.temperatura4[donde]  = 0
	case 5
		data.object.cantidad5[donde]     = 0
		data.object.unidad5[donde]       = ""
		data.object.aplicacion5[donde]   = ""
		data.object.nombre_aplicacion5[donde] = ""
		data.object.densidad5[donde]     = 0
		data.object.gramaje5[donde]      = 0
		data.object.temperatura5[donde]  = 0
	case 6
		data.object.cantidad6[donde]     = 0
		data.object.unidad6[donde]       = ""
		data.object.aplicacion6[donde]   = ""
		data.object.nombre_aplicacion6[donde] = ""
		data.object.densidad6[donde]     = 0
		data.object.gramaje6[donde]      = 0
		data.object.temperatura6[donde]  = 0
	case 7
		data.object.cantidad7[donde]     = 0
		data.object.unidad7[donde]       = ""
		data.object.aplicacion7[donde]   = ""
		data.object.nombre_aplicacion7[donde] = ""
		data.object.densidad7[donde]     = 0
		data.object.gramaje7[donde]      = 0
		data.object.temperatura7[donde]  = 0
	case 8
		data.object.cantidad8[donde]     = 0
		data.object.unidad8[donde]       = ""
		data.object.aplicacion8[donde]   = ""
		data.object.nombre_aplicacion8[donde] = ""
		data.object.densidad8[donde]     = 0
		data.object.gramaje8[donde]      = 0
		data.object.temperatura8[donde]  = 0
	case 9
		data.object.cantidad9[donde]     = 0
		data.object.unidad9[donde]       = ""
		data.object.aplicacion9[donde]   = ""
		data.object.nombre_aplicacion9[donde] = ""
		data.object.densidad9[donde]     = 0
		data.object.gramaje9[donde]      = 0
		data.object.temperatura9[donde]  = 0
	case 10
		data.object.cantidad10[donde]     = 0
		data.object.unidad10[donde]       = ""
		data.object.aplicacion10[donde]   = ""
		data.object.nombre_aplicacion10[donde] = ""
		data.object.densidad10[donde]     = 0
		data.object.gramaje10[donde]      = 0
		data.object.temperatura10[donde]  = 0
end choose
end subroutine

on wi_mant_labpruebas_esmaltes.create
int iCurrent
call super::create
this.em_observaciones=create em_observaciones
this.pb_calculadora=create pb_calculadora
this.cb_version=create cb_version
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_2=create gb_2
this.pb_calculadora_prueba=create pb_calculadora_prueba
this.dw_listado_esmaltes=create dw_listado_esmaltes
this.cbx_lab=create cbx_lab
this.cbx_com=create cbx_com
this.pb_2=create pb_2
this.cb_formatos=create cb_formatos
this.pb_borra_version=create pb_borra_version
this.gb_1=create gb_1
this.dw_versiones=create dw_versiones
this.dw_formatos=create dw_formatos
this.dw_anyade_formulas=create dw_anyade_formulas
this.dw_formulas=create dw_formulas
this.dw_aplicaciones=create dw_aplicaciones
this.gb_4=create gb_4
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_observaciones
this.Control[iCurrent+2]=this.pb_calculadora
this.Control[iCurrent+3]=this.cb_version
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.pb_calculadora_prueba
this.Control[iCurrent+8]=this.dw_listado_esmaltes
this.Control[iCurrent+9]=this.cbx_lab
this.Control[iCurrent+10]=this.cbx_com
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.cb_formatos
this.Control[iCurrent+13]=this.pb_borra_version
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.dw_versiones
this.Control[iCurrent+16]=this.dw_formatos
this.Control[iCurrent+17]=this.dw_anyade_formulas
this.Control[iCurrent+18]=this.dw_formulas
this.Control[iCurrent+19]=this.dw_aplicaciones
this.Control[iCurrent+20]=this.gb_4
this.Control[iCurrent+21]=this.gb_3
end on

on wi_mant_labpruebas_esmaltes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_observaciones)
destroy(this.pb_calculadora)
destroy(this.cb_version)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.pb_calculadora_prueba)
destroy(this.dw_listado_esmaltes)
destroy(this.cbx_lab)
destroy(this.cbx_com)
destroy(this.pb_2)
destroy(this.cb_formatos)
destroy(this.pb_borra_version)
destroy(this.gb_1)
destroy(this.dw_versiones)
destroy(this.dw_formatos)
destroy(this.dw_anyade_formulas)
destroy(this.dw_formulas)
destroy(this.dw_aplicaciones)
destroy(this.gb_4)
destroy(this.gb_3)
end on

event open;call super::open;titulo = "Mantenimiento de Pruebas de Esmaltes"
This.title = titulo
dw_1.SetTransObject(SQLCA)
dw_versiones.SetTransObject(SQLCA)
dw_aplicaciones.SetTransObject(SQLCA)
dw_formulas.SetTransObject(SQLCA)
dw_formatos.SetTransObject(SQLCA)
dw_listado_esmaltes.SetTransObject(SQLCA)
inserta_aplicacion = "N"
borra_version = "N"
dw_aplicaciones.Modify("cb_anadir.visible = false")
dw_aplicaciones.Modify("cb_borrar.visible = false")
cbx_com.checked = TRUE


end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora_prueba.enabled = true
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora_prueba.enabled = false
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.SetItem(1,"empresa",codigo_empresa)
dw_1.SetItem(1,"prueba",sle_valor.text)
dw_1.SetItem(1,"cliente","")
dw_1.SetItem(1,"descripcion","ESM "+sle_valor.text)  
dw_1.SetItem(1,"f_alta",today())
if cbx_lab.checked then
	dw_1.SetItem(1,"tipo_cli","L")
else
	dw_1.SetItem(1,"tipo_cli","C")
end if
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo       = This.title
longitud     = len(trim(codigo_empresa))
criterio[1]  = trim(codigo_empresa)+ space(20-longitud)
longitud     = len(trim(sle_valor.text))
criterio[2]  = trim(sle_valor.text)+space(20-longitud)
seleccion    = criterio[1]+criterio[2]
tabla        = "prod_esmaltes"

if trim(cb_version.text) <> "" then
	dw_aplicaciones.retrieve(codigo_empresa,sle_valor.text,cb_version.text)
	dw_formulas.retrieve(codigo_empresa,sle_valor.text,cb_version.text)
	dw_versiones.retrieve(codigo_empresa,sle_valor.text)
	pb_calculadora.enabled = true
	dw_aplicaciones.Setfocus()
	dw_aplicaciones.SetRow(1)
	dw_aplicaciones.ScrollToRow(1)
	if cb_insertar.enabled = false then
		cb_insertar.enabled = true
	end if
else
	dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	dw_formatos.Retrieve(codigo_empresa,sle_valor.Text)
	dw_versiones.retrieve(codigo_empresa,sle_valor.text)
	cb_version.text = ""
	em_observaciones.text = ""
	dw_aplicaciones.reset()
	dw_formulas.reset()
end if

CALL Super::ue_recuperar
end event

event ue_actualiza_dw;Long   anyo
String contador

if dw_aplicaciones.update() = -1 then
	rollback;
	messagebox("Atención","Error al actualizar Aplicaciones",Exclamation!)
end if
if dw_formulas.update() = -1 then
	rollback;
	messagebox("Atención","Error al actualizar Formulas",Exclamation!)
end if
if dw_formatos.update() = -1 then
	rollback;
	messagebox("Atención","Error al actualizar Formatos",Exclamation!)
end if
if dw_versiones.update() = -1 then
	rollback;
	messagebox("Atención","Error al actualizar Versiones",Exclamation!)
end if
if (not isnull(em_observaciones.text)) or (trim(em_observaciones.text)<>"") then
	update prod_esmaltes_versiones
	set observaciones = :em_observaciones.text
	where empresa = :codigo_empresa and
			prueba  = :sle_valor.text and
			version = :cb_version.text;
	IF SQLCA.SQLCode = -1 THEN
		rollback;
		messagebox("Atención","Error al actualizar Versiones",Exclamation!)
	END IF
end if

anyo = year(today())
contador = string(dec(sle_valor.text),"####")
update lab_param
set prueba = :contador
where empresa = :codigo_empresa and
		anyo    = :anyo;
IF SQLCA.SQLCode = -1 THEN
	rollback;
	messagebox("Atención","Error al actualizar Contadores",Exclamation!)
END IF		

inserta_aplicacion = "N"
CALL Super::ue_actualiza_dw
end event

event activate;call super::activate;wi_mant_labpruebas_esmaltes = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_labpruebas_esmaltes
integer x = 78
integer y = 328
integer width = 3479
integer height = 244
integer taborder = 110
string dataobject = "dw_prod_esmaltes"
end type

event dw_1::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "cliente"
		if cbx_com.checked then
			bus_datawindow = "dw_ayuda_clientes"
			bus_titulo     = "VENTANA SELECCION DE CLIENTES COMERCIAL"
		else
			bus_datawindow = "dw_ayuda_venclientes_lab"
			bus_titulo     = "VENTANA SELECCION DE CLIENTES LABORATORIO"
		end if	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::Key		
end event

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "cliente"
 	   if cbx_com.checked then
			bus_datawindow = "dw_ayuda_clientes"
			bus_titulo     = "VENTANA SELECCION DE CLIENTES COMERCIAL"
		else
			bus_datawindow = "dw_ayuda_venclientes_lab"
			bus_titulo     = "VENTANA SELECCION DE CLIENTES LABORATORIO"
		end if	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown		
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_labpruebas_esmaltes
integer x = 55
integer y = 156
integer width = 279
integer height = 84
string text = "Prueba :"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_labpruebas_esmaltes
integer x = 951
integer y = 152
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_labpruebas_esmaltes
integer x = 1385
integer y = 152
end type

event cb_borrar::clicked;integer li_opcion
Long    prueba,prueba_aux,bien,anyo

// Control permisos bajas por usuarios
IF Not f_control_bajas_usuario(codigo_empresa,nombre_usuario) Then
	f_mensaje("Control de permisos por usuario","Usted No tiene permiso de bajas")
	f_grabar_incidencia("Control de bajas","El usuario  "+ nombre_usuario + " Control de bajas (Permiso denegado")
	f_activar_campo(sle_valor)
	return
END IF
  
IF trim(sle_valor.text)<> ""  AND Not IsNull(sle_valor.text) AND   Not f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) THEN
	li_opcion = MessageBox("Proceso de Borrado", "Desea dar de baja la prueba", Question!, YesNo!,2)
	IF li_opcion=1 THEN
		IF NOT f_bloquear(tabla,seleccion,titulo) THEN
			bien = 0
			anyo = year(today())
			prueba = dec(sle_valor.text)
						
			DELETE FROM prod_esmaltes
			WHERE empresa = :codigo_empresa AND prueba = :sle_valor.text
			USING sqlca;	  
			if sqlca.sqlcode = -1 then bien = 1
			
			DELETE FROM prod_esmaltes_versiones
			WHERE empresa = :codigo_empresa AND prueba = :sle_valor.text
			USING sqlca;	 
			if sqlca.sqlcode = -1 then bien = 1
			
			DELETE FROM prod_esmaltes_detalle
			WHERE empresa = :codigo_empresa AND prueba = :sle_valor.text
			USING sqlca;	
			if sqlca.sqlcode = -1 then bien = 1
			
			DELETE FROM prod_esmaltes_detalle_formula
			WHERE empresa = :codigo_empresa AND prueba = :sle_valor.text
			USING sqlca;
			if sqlca.sqlcode = -1 then bien = 1
			
			DELETE FROM prod_esmaltes_formato
			WHERE empresa = :codigo_empresa AND prueba = :sle_valor.text
			USING sqlca;
			if sqlca.sqlcode = -1 then bien = 1
			
			SELECT prueba
			INTO  :prueba_aux
			FROM  lab_param
			WHERE empresa = :codigo_empresa
			AND   anyo    = :anyo;
			IF sqlca.sqlcode = 0 then
				if prueba_aux = prueba then prueba = prueba -1
			
				UPDATE lab_param
				SET prueba = :prueba
				WHERE empresa = :codigo_empresa
				AND   anyo    = :anyo;
				if sqlca.sqlcode = -1 then bien = 1
			END IF
			
			IF bien = 0 THEN
				Commit using sqlca;
			ELSE		
				RollBack using sqlca;
			END IF
						
			sle_valor.text = ""
			Parent.TriggerEvent("ue_desbloquear")
			cb_insertar.Enabled = FALSE
			cb_borrar.Enabled = FALSE
			Parent.TriggerEvent("ue_recuperar")
		END IF
	END IF
END IF
f_activar_campo(sle_valor)
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_labpruebas_esmaltes
integer x = 361
integer y = 152
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_labesmaltes_2_criterios"
ue_titulo      = "AYUDA SELECCION DE PRUEBAS DE ESMALTES"
ue_filtro      = ""
end event

event sle_valor::modificado;call super::modificado;version_actual = ""
end event

event sle_valor::busqueda;str_parametros param
IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
param.s_titulo_ayuda    = ue_titulo
param.s_nom_datawindow  = ue_datawindow
param.s_filtro          = ue_filtro
param.b_empresa         = valor_empresa
This.text = ue_valor
f_buscar_largo(This,param)
This.TriggerEvent("modificado")
ue_ante_valor = This.text
This.SelectText(1,Len(This.Text))
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_labpruebas_esmaltes
integer x = 1810
integer y = 152
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_labpruebas_esmaltes
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_labpruebas_esmaltes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_labpruebas_esmaltes
integer x = 23
integer width = 3552
end type

type em_observaciones from u_em_campo within wi_mant_labpruebas_esmaltes
integer x = 763
integer y = 660
integer width = 1760
integer taborder = 0
integer textsize = -9
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

event getfocus;call super::getfocus;if not(cb_insertar.enabled) then
//	apartados.triggerevent("pulsar_datawindow")
end if
end event

type pb_calculadora from u_calculadora within wi_mant_labpruebas_esmaltes
integer x = 654
integer y = 660
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
string disabledname = "c:\bmp\calculadisabled.bmp"
end type

event clicked;long      vers,indice,total
string    ultima_version,sel,nueva_version,v_articulo,v_formula
string    v_aplicacion,v_prueba,v_n_aplicacion
dec{0}    v_orden
dec{2}    v_gramaje,v_densidad,v_cantidad,v_temp
datetime  v_fecha
boolean   bien
datastore cursor_version 

if sle_valor.text <> "" then
	bien = true
	em_observaciones.text = ""
	v_articulo = sle_valor.text
	
	Select max(convert(int,version))
	Into   :vers
	From   prod_esmaltes_versiones
	Where  empresa = :codigo_empresa
	and    prueba  = :v_articulo;
	
	IF isnull(vers)  THEN vers = 0
	
	ultima_version = string(vers,"###")
	
	vers ++
	
	nueva_version  = string(vers,"###")
	version_actual = nueva_version	
	
	if ultima_version <> "" then		
		sel = "select * from prod_esmaltes_detalle "+&
				"where empresa  = '"+codigo_empresa+"' "+&
				"and   prueba = '"+sle_valor.text+"' "+&
				"and   version  = '"+ultima_version+"'"
				
		//cursor_version = f_cargar_cursor(sel)
		f_cargar_cursor_nuevo(sel, cursor_version)
		total = cursor_version.rowcount()
		for indice = 1 to total
			v_aplicacion  = cursor_version.object.aplicacion[indice]
			v_n_aplicacion= cursor_version.object.n_aplicacion[indice]
			v_densidad    = cursor_version.object.densidad[indice]
			v_gramaje     = cursor_version.object.gramaje[indice]
			v_temp        = cursor_version.object.temperatura[indice]
			
			insert into prod_esmaltes_detalle
				(empresa,
				 prueba,
				 version,
				 n_aplicacion,
				 aplicacion,
				 densidad,
				 gramaje,
				 temperatura)
			values 
				(:codigo_empresa,
				 :v_articulo,
				 :nueva_version,
				 :v_n_aplicacion,
				 :v_aplicacion,
				 :v_densidad,
				 :v_gramaje,
				 :v_temp);
				 
			if sqlca.sqlcode <> 0 then
				bien = false
			end if
		next
		destroy cursor_version
		
		sel = "select * from prod_esmaltes_detalle_formula "+&
				"where empresa  = '"+codigo_empresa+"' "+&
				"and   prueba = '"+sle_valor.text+"' "+&
				"and   version  = '"+ultima_version+"'"
				
		//cursor_version = f_cargar_cursor(sel)
		f_cargar_cursor_nuevo(sel, cursor_version)
		total = cursor_version.rowcount()
		for indice = 1 to total
			
			v_n_aplicacion= cursor_version.object.n_aplicacion[indice]
			v_orden       = cursor_version.object.orden[indice]
			v_formula     = cursor_version.object.formula[indice]
			v_cantidad    = cursor_version.object.cantidad[indice]
			
			insert into prod_esmaltes_detalle_formula
				(empresa,
				 prueba,
				 version,
				 n_aplicacion,
				 orden,
				 formula,
				 cantidad)			
			values 
				(:codigo_empresa,
				 :v_articulo,
				 :nueva_version,
				 :v_n_aplicacion,
				 :v_orden,
				 :v_formula,
				 :v_cantidad);
				 
			if sqlca.sqlcode <> 0 then
				bien = false
			end if
		next
		destroy cursor_version
		
		v_fecha = datetime(today())
		insert into prod_esmaltes_versiones
			(empresa,
			 prueba,
			 version,
			 observaciones,
			 f_alta)
		values
			(:codigo_empresa,
			 :v_articulo,
			 :nueva_version,
			 '',
			 :v_fecha);
				 
		if sqlca.sqlcode <> 0 then
			bien = false
		end if
		
		if bien then 
			commit;
		else 
			rollback;
			messagebox("Atención","Error al copiar la nueva versión de la prueba")
		end if
	else
		for indice = 1 to 4
			v_n_aplicacion = string(indice -1,"#")
			if trim(v_n_aplicacion) = "" then v_n_aplicacion = "0"
			if indice = 1 then
				v_aplicacion = "2"
			else
				v_aplicacion = ""
			end if
			insert into prod_esmaltes_detalle
					(empresa,
					 prueba,
					 version,
					 n_aplicacion,
					 aplicacion,
					 densidad,
					 gramaje,
					 temperatura)
				values 
					(:codigo_empresa,
					 :v_articulo,
					 :nueva_version,
					 :v_n_aplicacion,
					 :v_aplicacion,
					 0,
					 0,
					 0);
					 
				if sqlca.sqlcode <> 0 then
					bien = false
				end if
			next
			
			
			v_fecha = datetime(today())
			insert into prod_esmaltes_versiones
				(empresa,
				 prueba,
				 version,
				 observaciones,
				 f_alta)
			values
				(:codigo_empresa,
				 :v_articulo,
				 :nueva_version,
				 '',
				 :v_fecha);
			if bien then 
				commit;
			else 
				rollback;
				messagebox("Atención","Error al insertar la nueva versión de la prueba")
			end if
	end if	
	cb_version.text = version_actual
	dw_aplicaciones.retrieve(codigo_empresa,sle_valor.text,version_actual)
	dw_formulas.retrieve(codigo_empresa,sle_valor.text,version_actual)
	dw_versiones.retrieve(codigo_empresa,sle_valor.text,version_actual)
	dw_aplicaciones.Setfocus()
	dw_aplicaciones.SetRow(1)
	dw_aplicaciones.ScrollToRow(1)
	dw_aplicaciones.SetColumn("aplicacion")
	if cb_insertar.enabled = false then
		cb_insertar.enabled = true
	end if
end if
end event

type cb_version from u_boton within wi_mant_labpruebas_esmaltes
integer x = 407
integer y = 660
integer width = 242
integer height = 84
integer taborder = 120
fontcharset fontcharset = ansi!
string pointer = "\bmo\mano.cur"
end type

event clicked;if not(dw_versiones.visible) then
	if dw_versiones.rowcount() > 0 then
		pb_calculadora.enabled = false
		dw_versiones.visible = true
	end if
end if
end event

type gb_6 from groupbox within wi_mant_labpruebas_esmaltes
integer x = 37
integer y = 608
integer width = 352
integer height = 156
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_5 from groupbox within wi_mant_labpruebas_esmaltes
integer x = 2336
integer y = 120
integer width = 1248
integer height = 132
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Búsquedas de Clientes"
end type

type gb_2 from groupbox within wi_mant_labpruebas_esmaltes
integer x = 37
integer y = 252
integer width = 3552
integer height = 356
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
string text = "Datos Generales"
end type

type pb_calculadora_prueba from u_calculadora within wi_mant_labpruebas_esmaltes
integer x = 622
integer y = 152
integer width = 96
integer height = 84
integer taborder = 100
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;Integer registros,anyo
Long    contador

IF cb_insertar.enabled=TRUE THEN Return

Select  count(*) 
Into    :registros
From    prod_esmaltes
Where   prod_esmaltes.empresa = :codigo_empresa;

IF registros=0 THEN
   sle_valor.text="001"
ELSE
	anyo = year(today())
   Select max(convert(int,lab_param.prueba)+1)
   Into   :contador
   From   lab_param
   Where  lab_param.empresa = :codigo_empresa and
			 lab_param.anyo    = anyo;
	
	if isnull(contador) then contador = 0
	sle_valor.text = right("000"+trim(string(contador,"###")),3)
END IF
version_actual = ""
dw_1.triggerEvent("clicked")
end event

type dw_listado_esmaltes from datawindow within wi_mant_labpruebas_esmaltes
boolean visible = false
integer x = 3086
integer y = 648
integer width = 210
integer height = 92
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_imprime_pruebas_esmaltes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_lab from checkbox within wi_mant_labpruebas_esmaltes
integer x = 2382
integer y = 164
integer width = 585
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clientes Laboratorio"
boolean lefttext = true
end type

event clicked;if cbx_lab.checked then
	cbx_com.checked = FALSE
	dw_1.SetItem(1,"tipo_cli","L")
end if
end event

type cbx_com from checkbox within wi_mant_labpruebas_esmaltes
integer x = 3008
integer y = 164
integer width = 549
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clientes Comercial"
boolean lefttext = true
end type

event clicked;if cbx_com.checked then
	cbx_lab.checked = FALSE
	dw_1.SetItem(1,"tipo_cli","C")
end if
end event

type pb_2 from upb_imprimir within wi_mant_labpruebas_esmaltes
integer x = 2693
integer y = 636
integer width = 146
integer height = 120
integer taborder = 20
boolean originalsize = false
string picturename = "c:\bmp\imp32.bmp"
end type

event clicked;Long inicio,fin
tipo_array ent,val

if trim(cb_version.text) <> "" then
	ent.valor[1] = "1"
	ent.valor[2] = "999"
	openWithParm(w_pedir_version,ent)
	val =  message.powerObjectparm
	IF val.valor[1] = "RETURN" Then Return
	inicio = dec(val.valor[1])
	fin    = dec(val.valor[2])
	f_imprimir_pruebas_esmaltes(dw_listado_esmaltes,inicio,fin)
	f_imprimir_datawindow(dw_listado_esmaltes)
end if
end event

type cb_formatos from commandbutton within wi_mant_labpruebas_esmaltes
integer x = 50
integer y = 644
integer width = 325
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string pointer = "\bmp\MANO.CUR"
string text = "Formatos"
end type

event clicked;Long registros_formatos,indice,total,donde

if sle_valor.text <> "" then
	dw_1.enabled = FALSE
	dw_aplicaciones.enabled = FALSE
	dw_formulas.enabled = FALSE
	
	registros_formatos = dw_formatos.RowCount()
	
	if registros_formatos = 0 then
		donde = dw_formatos.insertrow(1)
		dw_formatos.SetItem(1,"empresa",codigo_empresa)
		dw_formatos.SetItem(1,"prueba",sle_valor.text)
		dw_formatos.SetItem(1,"formato","")
		dw_formatos.SetItem(1,"modelo","")
	end if
	dw_formatos.SetRow(1)
	dw_formatos.ScrollToRow(1)
	dw_formatos.SetColumn("formato")
	dw_formatos.visible = TRUE
	dw_formatos.SetFocus()
end if

end event

type pb_borra_version from picturebutton within wi_mant_labpruebas_esmaltes
integer x = 2533
integer y = 644
integer width = 123
integer height = 108
integer taborder = 140
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\delete.bmp"
end type

event clicked;Long respuesta,total_aplicaciones,total_versiones,total_formulas,donde

if trim(cb_version.text) <> "" then
	respuesta = MessageBox("Atención", "Desea borrar la version "+cb_version.text, Exclamation!, OKCancel!, 2)
	if respuesta = 1 then
		borra_version = "S"
		total_aplicaciones = dw_aplicaciones.RowCount()
		total_formulas     = dw_formulas.RowCount()
		total_versiones    = dw_versiones.RowCount()
		
		donde = dw_aplicaciones.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"'",1,total_aplicaciones)
		DO WHILE donde > 0
			dw_aplicaciones.deleterow(donde)
			donde = dw_aplicaciones.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"'",1,total_aplicaciones)
		LOOP
		
		donde = dw_formulas.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"'",1,total_formulas)
		DO WHILE donde > 0
			dw_formulas.deleterow(donde)
			donde = dw_formulas.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"'",1,total_formulas)
		LOOP
		
		donde = dw_versiones.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"'",1,total_versiones)
		DO WHILE donde > 0
			dw_versiones.deleterow(donde)
			donde = dw_formulas.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"'",1,total_versiones)
		LOOP
		cb_version.text = ""
		borra_version = "N"
		cb_insertar.TriggerEvent("clicked")
	end if
end if
end event

type gb_1 from groupbox within wi_mant_labpruebas_esmaltes
integer x = 389
integer y = 608
integer width = 2281
integer height = 156
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
string text = "Versión"
end type

type dw_versiones from datawindow within wi_mant_labpruebas_esmaltes
boolean visible = false
integer x = 389
integer y = 768
integer width = 1216
integer height = 536
integer taborder = 130
string dataobject = "dw_versiones_esmaltes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;choose case f_objeto_datawindow(this)
	case "p_salir"
		pb_calculadora.enabled = true
		this.visible           = false
	case else
	if row > 0 then
		this.selectrow(0,false)
		this.selectrow(row,true)
		this.setrow(row)
	end if
end choose


end event

event doubleclicked;if row > 0 then
	cb_version.text = this.object.version[row]
	version_actual  = this.object.version[row]
	em_observaciones.text = this.object.observaciones[row]
	this.visible = false
	dw_aplicaciones.retrieve(codigo_empresa,sle_valor.text,version_actual)
	dw_formulas.retrieve(codigo_empresa,sle_valor.text,version_actual)
	pb_calculadora.enabled = true
	dw_aplicaciones.Setfocus()
	dw_aplicaciones.SetRow(1)
	dw_aplicaciones.ScrollToRow(1)
	if cb_insertar.enabled = false then
		cb_insertar.enabled = true
	end if
end if
end event

event itemchanged;string var_articulo,var_version,var_revisada
choose case f_objeto_datawindow(this)
case "revisada"
	var_articulo = sle_valor.text
	var_version  = this.object.version[row]
	var_revisada = data
	if var_revisada = "S" then
		insert into labartversionrevisada
		values(:codigo_empresa,:var_articulo,:var_version);
		
		if sqlca.sqlcode <> 0 then
			rollback;
			messagebox("Atención","Error al marcar la versión como revisada")
		else
			commit;
		end if
	else			
		// David 24-08-01
//		if f_version_revisada_art_lab(codigo_empresa,var_articulo,var_version) then
//			delete labartversionrevisada
//			where  empresa  = :codigo_empresa
//			and    articulo = :var_articulo
//			and    version  = :var_version;
//			
//			if sqlca.sqlcode <> 0 then
//				rollback;
//				messagebox("Atención","Error al marcar la versión como no revisada")
//			else
//				commit;
//			end if		
//		end if
	end if	
end choose

end event

event retrieveend;//long   indice,total
//string var_articulo,var_version
//
//total = this.rowcount()
//if total > 0 then
//	var_articulo = sle_valor.text	
//	for indice = 1 to total
//		var_version  = this.object.version[indice]
//		if f_version_revisada_art_lab(codigo_empresa,var_articulo,var_version) then
//			this.object.revisada[indice] = "S"
//		else
//			this.object.revisada[indice] = "N"
//		end if
//	next
//end if
//
end event

type dw_formatos from u_datawindow within wi_mant_labpruebas_esmaltes
boolean visible = false
integer x = 41
integer y = 768
integer width = 1998
integer height = 780
integer taborder = 40
boolean titlebar = true
string title = "Formatos"
string dataobject = "dw_anyade_formatos_esmaltes"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "formato"
		bus_titulo     = "VENTANA SELECCION DE FORMATOS "
		bus_datawindow = "dw_ayuda_formatos"
	CASE "modelo"
		bus_titulo     = "VENTANA SELECCION DE MODELOS "
 		bus_datawindow = "dw_ayuda_modelo"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::Key		
end event

event rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "formato"
		bus_titulo     = "VENTANA SELECCION DE FORMATOS "
		bus_datawindow = "dw_ayuda_formatos"
	CASE "modelo"
		bus_titulo     = "VENTANA SELECCION DE MODELOS "
 		bus_datawindow = "dw_ayuda_modelo"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown		
end event

event clicked;call super::clicked;Long donde

if f_objeto_datawindow(This) = "cb_aceptar" Then
	dw_1.enabled = TRUE
	dw_aplicaciones.enabled = TRUE
	dw_formulas.enabled = TRUE
	dw_formatos.visible = FALSE
end if
if f_objeto_datawindow(This) = "cb_anyadir" Then
	donde = dw_formatos.insertrow(0)
	dw_formatos.SetItem(donde,"empresa",codigo_empresa)
	dw_formatos.SetItem(donde,"prueba",sle_valor.text)
	dw_formatos.SetItem(donde,"formato","")
	dw_formatos.SetItem(donde,"modelo","")
	dw_formatos.SetRow(donde)
	dw_formatos.ScrollToRow(donde)
	dw_formatos.SetColumn("formato")
end if
if f_objeto_datawindow(This) = "cb_borrar" Then
	donde = dw_formatos.GetRow()
	dw_formatos.deleterow(donde)
end if
end event

type dw_anyade_formulas from u_datawindow within wi_mant_labpruebas_esmaltes
boolean visible = false
integer x = 672
integer y = 456
integer width = 2075
integer height = 904
integer taborder = 70
boolean titlebar = true
string dataobject = "dw_anyade_formulas_esmaltes"
borderstyle borderstyle = styleraised!
end type

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULACIONES"
		bus_datawindow = "dw_ayuda_prodformulaciones_laboratorio"
		bus_filtro     = "" 			
	CASE "unidad"
		valor_empresa = FALSE
		bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDADES "
		bus_datawindow = "dw_ayuda_unidades"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULACIONES"
		bus_datawindow = "dw_ayuda_prodformulaciones_laboratorio"
		bus_filtro     = "" 
	CASE "unidad"
		valor_empresa = FALSE
		bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDADES "
		bus_datawindow = "dw_ayuda_unidades"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event clicked;call super::clicked;Long donde,registro,donde_formulas,registros_formulas,i,var_orden_aux,var_orden
String var_n_aplicacion,var_n_aplicacion_aux,var_empresa,var_prueba,var_version
str_parametros lstr_param

if f_objeto_datawindow(This) = "pb_formulacion" then
	lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[1]  = "wi_mant_labpruebas_esmaltes"
	OpenWithParm(wi_mant_formulaciones,lstr_param)		
	This.Setfocus()
	This.SetColumn("formula")
end if

if f_objeto_datawindow(This) = "cb_aceptar" Then
	This.AcceptText()
	if This.title = "Intercalar Fórmulas" Then
		var_orden_aux        = dw_formulas.GetItemNumber(dw_formulas.GetRow(),"orden")
		var_n_aplicacion_aux = dw_formulas.GetItemString(dw_formulas.GetRow(),"n_aplicacion")
		registros_formulas   = dw_formulas.RowCount()
		for i = 1 to registros_formulas
			var_empresa = dw_formulas.GetItemString(i,"empresa")
			var_prueba  = dw_formulas.GetItemString(i,"prueba")
			var_version = dw_formulas.GetItemString(i,"version")
			var_n_aplicacion = dw_formulas.GetItemString(i,"n_aplicacion")
			var_orden  = dw_formulas.GetItemNumber(i,"orden")
			if (var_empresa = codigo_empresa) and (var_prueba = sle_valor.text) and (var_version = cb_version.text) and (var_n_aplicacion = var_n_aplicacion_aux) then
				if var_orden >= var_orden_aux then
					dw_formulas.SetItem(i,"orden",var_orden + 1)
				end if
			end if
		next
	end if
	registro = This.GetRow()
	donde = dw_formulas.insertrow(0)
	dw_formulas.SetItem(donde,"empresa",This.GetItemString(registro,"empresa"))
	dw_formulas.SetItem(donde,"prueba",This.GetItemString(registro,"prueba"))
	dw_formulas.SetItem(donde,"version",This.GetItemString(registro,"version"))
	dw_formulas.SetItem(donde,"n_aplicacion",This.GetItemString(registro,"n_aplicacion"))
	dw_formulas.SetItem(donde,"orden",This.GetItemNumber(registro,"orden"))
	dw_formulas.SetItem(donde,"formula",This.GetItemString(registro,"formula"))
	dw_formulas.SetItem(donde,"cantidad",This.GetItemNumber(registro,"cantidad"))
	dw_formulas.SetItem(donde,"unidad",This.GetItemString(registro,"unidad"))
	dw_formulas.Sort()
	dw_formulas.GroupCalc()
	registros_formulas = dw_formulas.RowCount()
	donde_formulas = dw_formulas.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"' and n_aplicacion = '"+This.GetItemString(registro,"n_aplicacion")+"' and orden = "+string(This.GetItemNumber(registro,"orden"),"####")+"",1,registros_formulas)
	dw_formulas.ScrollToRow(donde_formulas)
	This.Reset()
	dw_1.enabled = TRUE
	dw_aplicaciones.enabled = TRUE
	dw_formulas.enabled = TRUE
	dw_anyade_formulas.visible = FALSE
end if

if f_objeto_datawindow(This) = "cb_cancelar" Then
	This.Reset()
	dw_1.enabled = TRUE
	dw_aplicaciones.enabled = TRUE
	dw_formulas.enabled = TRUE
	dw_anyade_formulas.visible = FALSE
end if

end event

type dw_formulas from u_datawindow within wi_mant_labpruebas_esmaltes
integer x = 1833
integer y = 828
integer width = 1719
integer height = 904
integer taborder = 80
string dataobject = "dw_formulas_esmaltes"
boolean vscrollbar = true
end type

event ue_valores;call super::ue_valores;ue_marca_linea = TRUE
end event

event rowfocuschanged;call super::rowfocuschanged;Long   donde_aplicaciones,registros_aplicaciones,registros
String var_n_aplicacion


if borra_version = "N" then
	registros = This.RowCount()
	if registros > 0 then
		var_n_aplicacion   = This.GetItemString(This.GetRow(),"n_aplicacion")
		registros_aplicaciones = dw_formulas.RowCount()
		donde_aplicaciones = dw_aplicaciones.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"' and n_aplicacion = '"+var_n_aplicacion+"'",1,registros_aplicaciones)
		if donde_aplicaciones > 0 then
		  dw_aplicaciones.SetRow(donde_aplicaciones)
		  dw_aplicaciones.ScrollToRow(donde_aplicaciones)
		end if
	end if
end if



end event

event clicked;call super::clicked;Long   i,donde,var_orden,max_orden,var_orden_aux,donde_formulas,registros_formulas
String var_empresa,var_prueba,var_version,var_n_aplicacion,var_n_aplicacion_aux,var_aplicacion,var_unidad
str_parametros lstr_param

if sle_valor.text <> "" then
	if dwo.name = "cb_anadir" then
		var_n_aplicacion_aux = dw_aplicaciones.GetItemString(dw_aplicaciones.GetRow(),"n_aplicacion")
		var_aplicacion       = dw_aplicaciones.GetItemString(dw_aplicaciones.GetRow(),"aplicacion")
		if isnull(var_aplicacion) or trim(var_aplicacion) = "" then
			messagebox("Atención","Falta el tipo de Aplicación")
			dw_aplicaciones.SetColumn("aplicacion")
			dw_aplicaciones.SetFocus()
			Return
		end if	
		registros_formulas = This.RowCount()
		max_orden = 0
		for i = 1 to registros_formulas
			var_empresa = This.GetItemString(i,"empresa")
			var_prueba  = This.GetItemString(i,"prueba")
			var_version = This.GetItemString(i,"version")
			var_n_aplicacion = This.GetItemString(i,"n_aplicacion")
			var_orden = This.GetItemNumber(i,"orden")
			var_unidad = This.GetItemString(i,"unidad")
			if (var_empresa = codigo_empresa) and (var_prueba = sle_valor.text) and (var_version = cb_version.text) and (var_n_aplicacion = var_n_aplicacion_aux) then
				if var_orden >= max_orden then
					max_orden = var_orden
				end if
			end if
		next
		max_orden ++
		
		dw_1.enabled = FALSE
		dw_aplicaciones.enabled = FALSE
		dw_formulas.enabled = FALSE
		dw_anyade_formulas.title = "Añadir Fórmulas"
		dw_anyade_formulas.insertrow(1)
		dw_anyade_formulas.SetItem(1,"empresa",codigo_empresa)
		dw_anyade_formulas.SetItem(1,"prueba",sle_valor.text)
		dw_anyade_formulas.SetItem(1,"version",cb_version.text)
		dw_anyade_formulas.SetItem(1,"n_aplicacion",var_n_aplicacion_aux)
		dw_anyade_formulas.SetItem(1,"aplicacion",var_aplicacion)
		dw_anyade_formulas.SetItem(1,"orden",max_orden)
		dw_anyade_formulas.SetItem(1,"formula","")
		dw_anyade_formulas.SetItem(1,"cantidad",0)
		dw_anyade_formulas.SetItem(1,"unidad",var_unidad)
		dw_anyade_formulas.ScrollToRow(1)
		dw_anyade_formulas.SetColumn("formula")
		dw_anyade_formulas.visible = TRUE
		dw_anyade_formulas.SetFocus()
	end if
	
	if dwo.name = "cb_intercalar" then
		var_n_aplicacion_aux = dw_aplicaciones.GetItemString(dw_aplicaciones.GetRow(),"n_aplicacion")
		var_aplicacion       = dw_aplicaciones.GetItemString(dw_aplicaciones.GetRow(),"aplicacion")
		registros_formulas = This.RowCount()
		donde = This.GetRow()
		max_orden = This.GetItemNumber(donde,"orden")
		
		dw_1.enabled = FALSE
		dw_aplicaciones.enabled = FALSE
		dw_formulas.enabled = FALSE
		dw_anyade_formulas.title = "Intercalar Fórmulas"
		dw_anyade_formulas.insertrow(1)
		dw_anyade_formulas.SetItem(1,"empresa",codigo_empresa)
		dw_anyade_formulas.SetItem(1,"prueba",sle_valor.text)
		dw_anyade_formulas.SetItem(1,"version",cb_version.text)
		dw_anyade_formulas.SetItem(1,"n_aplicacion",var_n_aplicacion_aux)
		dw_anyade_formulas.SetItem(1,"aplicacion",var_aplicacion)
		dw_anyade_formulas.SetItem(1,"orden",max_orden)
		dw_anyade_formulas.SetItem(1,"formula","")
		dw_anyade_formulas.SetItem(1,"cantidad",0)
		dw_anyade_formulas.ScrollToRow(1)
		dw_anyade_formulas.SetColumn("formula")
		dw_anyade_formulas.visible = TRUE
		dw_anyade_formulas.SetFocus()
	end if
	
	if dwo.name = "cb_borrar" then
		var_orden_aux = This.GetItemNumber(This.GetRow(),"orden")
		var_n_aplicacion_aux = This.GetItemString(This.GetRow(),"n_aplicacion")
		
		donde = This.Getrow()
		This.deleterow(donde)
		
		registros_formulas = This.RowCount()
		
		for i = 1 to registros_formulas
			var_empresa = This.GetItemString(i,"empresa")
			var_prueba  = This.GetItemString(i,"prueba")
			var_version = This.GetItemString(i,"version")
			var_n_aplicacion = This.GetItemString(i,"n_aplicacion")
			var_orden = This.GetItemNumber(i,"orden")
			if (var_empresa = codigo_empresa) and (var_prueba = sle_valor.text) and (var_version = cb_version.text) and (var_n_aplicacion = var_n_aplicacion_aux) then
				if var_orden > var_orden_aux then
					This.SetItem(i,"orden",var_orden - 1)
				end if
			end if
		next
	end if
	
	if dwo.name = "pb_formulacion" then
		lstr_param.i_nargumentos    = 2
		lstr_param.s_argumentos[1]  = "wi_mant_labpruebas_esmaltes"
		OpenWithParm(wi_mant_formulaciones,lstr_param)		
	end if
	
	if dwo.name = "pb_matprimas" then
		lstr_param.i_nargumentos    = 2
		lstr_param.s_argumentos[1]  = "wi_mant_labpruebas_esmaltes"
		OpenWithParm(w_mant_venmprima2,lstr_param)		
	end if
	
end if

end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULACIONES"
		bus_datawindow = "dw_ayuda_prodformulaciones_laboratorio"
		bus_filtro     = "" 	
	CASE "unidad"
		valor_empresa = FALSE
		bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDADES "
		bus_datawindow = "dw_ayuda_unidades"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULACIONES"
		bus_datawindow = "dw_ayuda_prodformulaciones_laboratorio"
		bus_filtro     = "" 		
	CASE "unidad"
		valor_empresa = FALSE
		bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDADES "
		bus_datawindow = "dw_ayuda_unidades"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

type dw_aplicaciones from u_datawindow within wi_mant_labpruebas_esmaltes
integer x = 59
integer y = 828
integer width = 1719
integer height = 904
integer taborder = 90
string dataobject = "dw_aplicaciones_esmaltes"
boolean vscrollbar = true
end type

event key;bus_filtro    = ""
bus_titulo    = ""
bus_campo     = This.GetColumnName()
valor_empresa = TRUE	

CHOOSE CASE bus_campo
	CASE "aplicacion"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_titulo     = "VENTANA SELECCION DE APLICACIONES"
	CASE ELSE
		setnull(bus_campo)
END CHOOSE

CALL SUPER::key
end event

event rbuttondown;bus_filtro    = ""
bus_titulo    = ""
bus_campo     = This.GetColumnName()
valor_empresa = TRUE	

CHOOSE CASE bus_campo
	CASE "aplicacion"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_titulo     = "VENTANA SELECCION DE APLICACIONES"
	CASE ELSE
		setnull(bus_campo)
END CHOOSE

CALL SUPER::rbuttondown
end event

event ue_valores;call super::ue_valores;ue_marca_linea = TRUE
end event

event retrieveend;registros_aplicacion = This.Rowcount()

if registros_aplicacion = 4 then
	This.Modify("cb_anadir.visible = false")
	This.object.n_aplicacion.Protect = 1
else
	This.Modify("cb_anadir.visible = true")
	This.object.n_aplicacion.Protect = 0
end if
This.Modify("cb_borrar.visible = true")

end event

event clicked;call super::clicked;Long   donde,donde_formulas,registros_formulas
String var_n_aplicacion
str_parametros lstr_param

if sle_valor.text <> "" then
	if dwo.name = "cb_anadir" then
		registros_aplicacion ++
		if registros_aplicacion > 4 then
			messagebox("Atención","No se pueden añadir más Nºs de Aplicación")
			This.Modify("cb_anadir.visible = false")
		else
			This.Modify("cb_anadir.visible = true")
			This.object.n_aplicacion.Protect = 0
			inserta_aplicacion = "S"
			donde_inserto_aplicacion = This.insertrow(0)
			This.SetItem(donde_inserto_aplicacion,"empresa",codigo_empresa)
			This.SetItem(donde_inserto_aplicacion,"prueba",sle_valor.text)
			This.SetItem(donde_inserto_aplicacion,"version",cb_version.text)
			This.SetItem(donde_inserto_aplicacion,"n_aplicacion","")
			This.SetItem(donde_inserto_aplicacion,"aplicacion","")
			This.SetItem(donde_inserto_aplicacion,"densidad",0)
			This.SetItem(donde_inserto_aplicacion,"gramaje",0)
			This.Setrow(donde_inserto_aplicacion)
			This.ScrollToRow(donde_inserto_aplicacion)
			This.SetColumn("n_aplicacion")
		end if
		This.Modify("cb_borrar.visible = true")
	end if
	
	if dwo.name = "cb_borrar" then
		var_n_aplicacion   = This.GetItemString(This.GetRow(),"n_aplicacion")
		donde = This.Getrow()
		This.deleterow(donde)
		registros_aplicacion --
		if registros_aplicacion = 4 then
			This.Modify("cb_anadir.visible = false")
		else
			This.Modify("cb_anadir.visible = true")
		end if
		This.Modify("cb_borrar.visible = true")
		registros_formulas = dw_formulas.RowCount()
		donde_formulas = dw_formulas.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"' and n_aplicacion = '"+var_n_aplicacion+"'",1,registros_formulas)
		do while donde_formulas <> 0
			dw_formulas.deleterow(donde_formulas)
			registros_formulas = dw_formulas.RowCount()
			donde_formulas = dw_formulas.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"' and n_aplicacion = '"+var_n_aplicacion+"'",1,registros_formulas)
		loop
		inserta_aplicacion = "N"
	end if
	
	if dwo.name = "pb_aplicacion" then
		lstr_param.i_nargumentos    = 2
		lstr_param.s_argumentos[1]  = "wi_mant_labpruebas_esmaltes"
		OpenWithParm(wi_mant_prodaplicaciones,lstr_param)		
	end if
end if
end event

event itemfocuschanged;call super::itemfocuschanged;String var_n_aplicacion,var_n_aplic
Long   donde_aplicaciones

if dwo.name = "aplicacion" and inserta_aplicacion = "S" then
	This.AcceptText()
	var_n_aplic = This.GetItemString(This.GetRow(),"n_aplicacion")
	donde_aplicaciones = This.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"' and n_aplicacion = '"+var_n_aplic+"'",1,registros_aplicacion)
	if (donde_aplicaciones > 0) and (donde_inserto_aplicacion <> donde_aplicaciones) then
		messagebox("Atención","Este Número de aplicación ya está dado de alta",Exclamation!)
		return
	end if
end if
end event

event rowfocuschanged;call super::rowfocuschanged;Long   donde_formulas,registros_formulas,registros
String var_n_aplicacion

if borra_version = "N" then
	registros = This.RowCount()
	if registros > 0 then
		var_n_aplicacion   = This.GetItemString(This.GetRow(),"n_aplicacion")
		registros_formulas = dw_formulas.RowCount()
		donde_formulas = dw_formulas.find("empresa = '"+codigo_empresa+"' and prueba = '"+sle_valor.text+"' and version = '"+cb_version.text+"' and n_aplicacion = '"+var_n_aplicacion+"'",1,registros_formulas)
		if donde_formulas > 0 then
		  dw_formulas.SetRow(donde_formulas)
		  dw_formulas.ScrollToRow(donde_formulas)
		end if
	end if
end if
end event

event losefocus;if inserta_aplicacion = "S" then
	inserta_aplicacion = "N"
end if
end event

type gb_4 from groupbox within wi_mant_labpruebas_esmaltes
integer x = 1806
integer y = 772
integer width = 1778
integer height = 996
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fórmulas"
end type

type gb_3 from groupbox within wi_mant_labpruebas_esmaltes
integer x = 37
integer y = 772
integer width = 1760
integer height = 996
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Aplicaciones"
end type

