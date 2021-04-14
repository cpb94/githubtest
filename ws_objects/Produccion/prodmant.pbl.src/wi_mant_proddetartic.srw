$PBExportHeader$wi_mant_proddetartic.srw
$PBExportComments$No se utiliza
forward
global type wi_mant_proddetartic from w_int_con_empresa
end type
type st_1 from statictext within wi_mant_proddetartic
end type
type cb_aceptar from u_boton within wi_mant_proddetartic
end type
type cb_cancelar from u_boton within wi_mant_proddetartic
end type
type pb_1 from upb_salir within wi_mant_proddetartic
end type
type dw_listado from datawindow within wi_mant_proddetartic
end type
type pb_2 from upb_imprimir within wi_mant_proddetartic
end type
type dw_costes from datawindow within wi_mant_proddetartic
end type
type pb_calculadora from u_calculadora within wi_mant_proddetartic
end type
type uo_articulo from u_em_campo_2 within wi_mant_proddetartic
end type
type st_2 from statictext within wi_mant_proddetartic
end type
type dw_aplicaciones from u_datawindow within wi_mant_proddetartic
end type
type cb_version from u_boton within wi_mant_proddetartic
end type
type em_observaciones from u_em_campo within wi_mant_proddetartic
end type
type pb_3 from upb_imprimir within wi_mant_proddetartic
end type
type st_3 from statictext within wi_mant_proddetartic
end type
type r_1 from rectangle within wi_mant_proddetartic
end type
type cb_listar from u_boton within wi_mant_proddetartic
end type
type dw_listado_creados from datawindow within wi_mant_proddetartic
end type
type dw_observaciones from datawindow within wi_mant_proddetartic
end type
type dw_versiones from datawindow within wi_mant_proddetartic
end type
end forward

global type wi_mant_proddetartic from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 3195
integer height = 2304
st_1 st_1
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
pb_1 pb_1
dw_listado dw_listado
pb_2 pb_2
dw_costes dw_costes
pb_calculadora pb_calculadora
uo_articulo uo_articulo
st_2 st_2
dw_aplicaciones dw_aplicaciones
cb_version cb_version
em_observaciones em_observaciones
pb_3 pb_3
st_3 st_3
r_1 r_1
cb_listar cb_listar
dw_listado_creados dw_listado_creados
dw_observaciones dw_observaciones
dw_versiones dw_versiones
end type
global wi_mant_proddetartic wi_mant_proddetartic

type variables
boolean ver_notas = false
boolean ver_costes = true
boolean modificando = false
string version_actual
datetime fecha_version
end variables

forward prototypes
public subroutine f_imprimir (datawindow data, string convertir)
end prototypes

public subroutine f_imprimir (datawindow data, string convertir);datastore formulas
datastore linformulas
string seleccion1,seleccion2,seleccion3,filtro,var_version
long indice1,indice2,indice3,lineas,indice4,lineas2,empieza_columna2
long total1,total2,total3,lineas_reales
string articulo,familia,formato,calidad,formula
real cantidad,cant_formula
datetime fecha,fmin	
long donde
real densidad,viscosidad,hilospantalla,cantidad_mp
real gramaje_aplicacion,kg_formula,porc_mp
string mp,numaplic,aplicacion,ubicacion_pantalla
string formato_gramaje_aplicacion,var_titulo
long total_lineas = 41 //Antes 47
BOOLEAN COLUMNA2 = FALSE
int lineas_notas

data.Reset()
data.SetRedraw(FALSE)
if convertir = "S" then
	var_titulo = "APLICACIÓN"
else
	var_titulo = "COMPROBACIÓN"
END IF

lineas_reales = 0

lineas = 0
articulo = uo_articulo.em_codigo.text
familia = f_familia_articulo(codigo_empresa,articulo)
formato = f_formato_articulo(codigo_empresa,articulo)
var_version = cb_version.text

data.retrieve(codigo_empresa,var_version,var_titulo)

seleccion2 ="select numaplic,aplicacion,formulacion,gramaje,"+&
				"densidad,viscosidad,hilospantalla,ubicacion_pantalla "+&
				"from proddetartic "+&
				"where empresa = '"+codigo_empresa+"' and "+&
				"articulo = '"+articulo+"' "+&
				"and version ='"+var_version+"' "+&
				"order by convert(int,numaplic)"
				

//formulas = f_cargar_cursor (seleccion2)
f_cargar_cursor_nuevo(seleccion2, formulas)
total2 = formulas.rowcount()
if total2 > 0 then
	for indice2 = 1 to total2
		numaplic = formulas.Object.numaplic[indice2]
		aplicacion = formulas.Object.aplicacion[indice2]
		formula = formulas.Object.formulacion[indice2]
		cant_formula = formulas.Object.gramaje[indice2]
		densidad = formulas.Object.densidad[indice2]
		viscosidad = formulas.Object.viscosidad[indice2]
		hilospantalla = formulas.Object.hilospantalla[indice2]
		ubicacion_pantalla = formulas.Object.ubicacion_pantalla[indice2]
		donde = data.insertrow(0)
		lineas = lineas + 1
		lineas_reales = lineas_reales + 1
		data.Object.empresa[donde] = codigo_empresa
		data.Object.articulo[donde] = articulo
		data.Object.familia[donde] = familia
		data.Object.formato[donde] = formato
		data.Object.formula[donde] = formula
		data.Object.numaplic[donde] = numaplic
		data.Object.aplicacion[donde] = aplicacion
		
		formato_gramaje_aplicacion  = f_formato_gramaje_aplicacion(codigo_empresa,aplicacion)
		if formato_gramaje_aplicacion = "" then
			data.Object.gramaje[donde] = dec(string(cant_formula,"###,##0.000"))							
		else
			// Realizamos la conversion del gramaje
			data.Object.gramaje_aplicacion[donde] = dec(string(cant_formula,"###,##0.000"))							
			data.Object.gramaje[donde] = dec(string((cant_formula/f_superficie_formato(codigo_empresa,formato_gramaje_aplicacion))*f_superficie_formato(codigo_empresa,f_formato_articulo(codigo_empresa,articulo)),"###,##0.000"))				
		end if
		data.Object.ubicacion_pantalla[donde] = ubicacion_pantalla
		
		data.Object.densidad[donde] = densidad
		data.Object.viscosidad[donde] = viscosidad
		data.Object.hilospantalla[donde] = hilospantalla
		data.Object.fecha_prod[donde] = fecha
		data.Object.linea[donde] = "S"
	next
	donde = data.insertrow(0)
	lineas = lineas + 1
	lineas_reales = lineas_reales + 1
	data.Object.empresa[donde] = codigo_empresa
	data.Object.articulo[donde] = articulo

	empieza_columna2 = lineas_reales + 1
	
	for indice2 = 1 to total2
		aplicacion = formulas.Object.aplicacion[indice2]
		formula = formulas.Object.formulacion[indice2]
		numaplic = formulas.Object.numaplic[indice2]
		aplicacion = formulas.Object.aplicacion[indice2]
		cant_formula = formulas.Object.gramaje[indice2]
		seleccion3 ="select mp,cantidad "+&
						"from proddetformula "+&
						"where empresa = '"+codigo_empresa+"' and "+&
						"formulacion = '"+formula+"'"

		//linformulas = f_cargar_cursor (seleccion3)
		f_cargar_cursor_nuevo(seleccion3, linformulas)
		total3 = linformulas.rowcount()
		
		If trim(f_nota_aplicacion_articulo(codigo_empresa,articulo,var_version,numaplic)) <> "" then
			lineas_notas = 1
		else
			lineas_notas = 0
		end if
		
		if (lineas + 1) + (total3 + lineas_notas) > total_lineas then
			if not columna2 then
				for indice4 = lineas to  total_lineas
					donde = data.insertrow(0)
					lineas_reales = lineas_reales + 1
					data.Object.empresa[donde] = codigo_empresa
					data.Object.articulo[donde] = articulo													
				next
				columna2 = true
				lineas2 = empieza_columna2
				lineas = total_lineas
			end if
		end if
		if not columna2 then//insercion en columna 1
			donde = data.insertrow(0)
			lineas = lineas + 1
			lineas_reales = lineas_reales + 1
			data.Object.empresa[donde] = codigo_empresa
			data.Object.articulo[donde] = articulo
			data.Object.familia[donde] = familia
			data.Object.formato[donde] = formato
			data.Object.cabecera_numaplic[donde] = numaplic
			data.Object.cabecera_formula[donde] = formula
			data.Object.linea2[donde] = "S"
			
			//Inserción de observaciones por aplicación
			If trim(f_nota_aplicacion_articulo(codigo_empresa,articulo,var_version,numaplic)) <> "" then
				donde = data.insertrow(0)
				lineas = lineas + 1
				lineas_reales = lineas_reales + 1
				data.Object.empresa[donde] = codigo_empresa
				data.Object.articulo[donde] = articulo
				data.Object.familia[donde] = familia
				data.Object.formato[donde] = formato
				data.Object.observaciones_aplicacion[donde] = trim(f_nota_aplicacion_articulo(codigo_empresa,articulo,var_version,numaplic))
				data.Object.linea3[donde] = "S"				
			end if
			
			if total3 > 0 then
				for indice3 = 1 to total3				
					mp = linformulas.Object.mp[indice3]
					cantidad_mp = linformulas.Object.cantidad[indice3]
					donde = data.insertrow(0)
					lineas = lineas + 1
					lineas_reales = lineas_reales + 1
					data.Object.empresa[donde] = codigo_empresa
					data.Object.articulo[donde] = articulo
					data.Object.mp[donde] = mp								
					kg_formula = cant_formula 
					porc_mp = (cantidad_mp / f_peso_total_formula(codigo_empresa,formula)) * 100								
					data.Object.cantidad_mp[donde] = porc_mp
					if convertir = "S" then
						data.Object.consumo_mp[donde] = (cantidad_mp / f_peso_total_formula(codigo_empresa,formula)) * 1000
					else
						data.Object.consumo_mp[donde] = cantidad_mp
					end if
					
				next
				data.Object.linea3[donde] = "S"
			end if
		else//insercion en columna 2
			donde = lineas2			
			lineas2 = lineas2 + 1
			data.Object.empresa[donde] = codigo_empresa
			data.Object.articulo[donde] = articulo
			data.Object.familia[donde] = familia
			data.Object.formato[donde] = formato
			data.Object.cabecera_numaplic2[donde] = numaplic
			data.Object.cabecera_formula2[donde] = formula
			
			//Inserción de observaciones por aplicación
			If trim(f_nota_aplicacion_articulo(codigo_empresa,articulo,var_version,numaplic)) <> "" then
				donde = lineas2
				lineas2 = lineas2 + 1
				data.Object.empresa[donde] = codigo_empresa
				data.Object.articulo[donde] = articulo
				data.Object.familia[donde] = familia
				data.Object.formato[donde] = formato
				data.Object.observaciones_aplicacion2[donde] = trim(f_nota_aplicacion_articulo(codigo_empresa,articulo,var_version,numaplic))
				data.Object.linea4[donde] = "S"				
			end if
			
			if total3 > 0 then
				for indice3 = 1 to total3				
					mp = linformulas.Object.mp[indice3]
					cantidad_mp = linformulas.Object.cantidad[indice3]
					donde = lineas2
					lineas2 = lineas2 + 1
					data.Object.empresa[donde] = codigo_empresa
					data.Object.articulo[donde] = articulo
					data.Object.mp2[donde] = mp								
					kg_formula = cant_formula 
					porc_mp = (cantidad_mp / f_peso_total_formula(codigo_empresa,formula)) * 100								
					data.Object.cantidad_mp2[donde] = porc_mp					
					if convertir = "S" then
						data.Object.consumo_mp2[donde] = (cantidad_mp / f_peso_total_formula(codigo_empresa,formula)) * 1000
					else
						data.Object.consumo_mp2[donde] = cantidad_mp
					end if
					
				next
				data.Object.linea4[donde] = "S"
			end if
			
		end if
	next			
	 
end if
if lineas < total_lineas then
	for indice4 = lineas to  total_lineas
		donde = data.insertrow(0)
		lineas_reales = lineas_reales + 1
		data.Object.empresa[donde] = codigo_empresa
		data.Object.articulo[donde] = articulo						
	next
end if
lineas = 0
columna2 = false
data.SetRedraw(TRUE)
data.GroupCalc()

destroy formulas
destroy linformulas

end subroutine

on wi_mant_proddetartic.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.dw_costes=create dw_costes
this.pb_calculadora=create pb_calculadora
this.uo_articulo=create uo_articulo
this.st_2=create st_2
this.dw_aplicaciones=create dw_aplicaciones
this.cb_version=create cb_version
this.em_observaciones=create em_observaciones
this.pb_3=create pb_3
this.st_3=create st_3
this.r_1=create r_1
this.cb_listar=create cb_listar
this.dw_listado_creados=create dw_listado_creados
this.dw_observaciones=create dw_observaciones
this.dw_versiones=create dw_versiones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.dw_costes
this.Control[iCurrent+8]=this.pb_calculadora
this.Control[iCurrent+9]=this.uo_articulo
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.dw_aplicaciones
this.Control[iCurrent+12]=this.cb_version
this.Control[iCurrent+13]=this.em_observaciones
this.Control[iCurrent+14]=this.pb_3
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.r_1
this.Control[iCurrent+17]=this.cb_listar
this.Control[iCurrent+18]=this.dw_listado_creados
this.Control[iCurrent+19]=this.dw_observaciones
this.Control[iCurrent+20]=this.dw_versiones
end on

on wi_mant_proddetartic.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.dw_costes)
destroy(this.pb_calculadora)
destroy(this.uo_articulo)
destroy(this.st_2)
destroy(this.dw_aplicaciones)
destroy(this.cb_version)
destroy(this.em_observaciones)
destroy(this.pb_3)
destroy(this.st_3)
destroy(this.r_1)
destroy(this.cb_listar)
destroy(this.dw_listado_creados)
destroy(this.dw_observaciones)
destroy(this.dw_versiones)
end on

event open;call super::open;this.title = "Mantenimiento Detalles Artículos"

dw_aplicaciones.SetTransObject (sqlca)
dw_listado.SetTransObject (sqlca)
dw_listado_creados.SetTransObject (sqlca)
dw_versiones.SetTransObject (sqlca)
dw_observaciones.SetTransObject (sqlca)
dw_costes.SetTransObject (sqlca)


IF istr_parametros.i_nargumentos>1 THEN
	uo_articulo.em_codigo.text = istr_parametros.s_argumentos[2]	
	uo_articulo.TriggerEvent("modificado")
END IF

f_activar_campo (uo_articulo.em_campo)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_proddetartic
integer y = 612
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_proddetartic
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_proddetartic
integer y = 20
end type

type st_1 from statictext within wi_mant_proddetartic
integer x = 87
integer y = 196
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
boolean focusrectangle = false
end type

type cb_aceptar from u_boton within wi_mant_proddetartic
integer x = 1166
integer y = 200
integer width = 352
integer height = 84
integer taborder = 70
boolean bringtotop = true
string text = "&Aceptar"
end type

event clicked;string articulo,observaciones
long cuantos,donde
boolean continuar

if modificando then
	if f_pedir_clave("5") then
		continuar = true
	else
		continuar = false
	end if
else
	continuar = true
end if

if continuar then
	dw_aplicaciones.AcceptText()
	if dw_aplicaciones.update() = 1 then
		commit;
		
		observaciones = trim(em_observaciones.text)
		articulo = uo_articulo.em_codigo.text
		
		if dw_observaciones.rowcount() > 0 then
			dw_observaciones.object.observaciones[1] = observaciones
		else
			dw_observaciones.retrieve(codigo_empresa,articulo,version_actual)
			if dw_observaciones.rowcount() = 0 then
				if observaciones <> "" then
					donde = dw_observaciones.insertrow(0)
					dw_observaciones.object.empresa[donde] = codigo_empresa
					dw_observaciones.object.articulo[donde] = uo_articulo.em_codigo.text
					dw_observaciones.object.version[donde] = version_actual
					dw_observaciones.object.observaciones[donde] = observaciones
				end if
			else
				dw_observaciones.object.observaciones[1] = observaciones
			end if	
		end if
		
		if dw_observaciones.rowcount() > 0 then
			if dw_observaciones.update() = 1 then
				commit;
			else
				rollback;
				messagebox("Error","Error actualizando las observaciones")
			end if
		end if
		
	//	if observaciones <> "" then
	//		
	//		select count(*) into :cuantos
	//		from prodobsversionart
	//		where empresa = :codigo_empresa
	//		and  articulo = :articulo
	//		and   version = :version_actual;
	//		
	//		if isnull(cuantos) then cuantos = 0
	//		
	//		if cuantos > 0 then
	//			update prodobsversionart
	//			set observaciones = :observaciones 
	//			where empresa = :codigo_empresa
	//			and  articulo = :articulo
	//			and   version = :version_actual;
	//		else
	//			insert into prodobsversionart
	//			values(:codigo_empresa,:articulo,:version_actual,:observaciones);				
	//		end if
	
//			if sqlca.sqlcode = 0 then
//				commit;
//			else
//				rollback;
//				messagebox("Atención","Se ha producido un error al actualizar las observaciones")
//			end if
	//	end if
		if f_version_activa_articulo(codigo_empresa,articulo) = "" then
			insert into prodartversionactiva 
			values(:codigo_empresa,:articulo,:version_actual);
			
			if sqlca.sqlcode <> 0 then
				rollback;
				messagebox("Atención","Error al activar la versión")
			else
				commit;
			end if	
		end if
	else
		messagebox("Error","Error al actualizar la versión")
	end if
end if

dw_aplicaciones.retrieve(codigo_empresa, uo_articulo.em_codigo.text,version_actual)
dw_costes.retrieve(codigo_empresa, uo_articulo.em_codigo.text,version_actual)
dw_aplicaciones.setsort("number(numaplic) asc")
dw_costes.setsort("number(numaplic) asc")
dw_aplicaciones.sort()
dw_costes.sort()
modificando = true


end event

type cb_cancelar from u_boton within wi_mant_proddetartic
integer x = 1522
integer y = 200
integer width = 352
integer height = 84
integer taborder = 90
boolean bringtotop = true
string text = "&Cancelar"
end type

event clicked;em_observaciones.text = f_observaciones_version_articulo(codigo_empresa,uo_articulo.em_codigo.text,version_actual)
dw_aplicaciones.retrieve(codigo_empresa, uo_articulo.em_codigo.text,version_actual)
end event

type pb_1 from upb_salir within wi_mant_proddetartic
integer x = 2459
integer y = 156
integer height = 136
integer taborder = 110
boolean bringtotop = true
end type

type dw_listado from datawindow within wi_mant_proddetartic
boolean visible = false
integer x = 9
integer y = 112
integer width = 494
integer height = 356
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_proddetartic"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within wi_mant_proddetartic
integer x = 1888
integer y = 148
integer width = 155
integer height = 136
integer taborder = 150
boolean bringtotop = true
boolean originalsize = false
string picturename = "PRINT!"
end type

event clicked;
if trim(uo_articulo.em_codigo.text) <> "" then
	if trim(cb_version.text) <> "" then
		f_imprimir(dw_listado,"S")
		f_imprimir_datawindow(dw_listado)
	end if
end if
end event

type dw_costes from datawindow within wi_mant_proddetartic
boolean visible = false
integer x = 1381
integer y = 396
integer width = 1152
integer height = 956
integer taborder = 140
boolean bringtotop = true
string dataobject = "dw_proddetartic_costes"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type pb_calculadora from u_calculadora within wi_mant_proddetartic
integer x = 622
integer y = 284
integer width = 114
integer height = 100
integer taborder = 50
boolean originalsize = false
end type

event clicked;long    vers,indice,total
string  version_activa,sel,nueva_version,v_articulo
string  v_numaplic,v_aplicacion,v_formulacion,v_notas
string  v_ubicacion_pantalla
dec{4}  v_gramaje,v_densidad,v_viscosidad
datetime v_fecha
long    v_hilospantalla
boolean bien
datastore cursor_version 
if uo_articulo.em_codigo.text <> "" then
	bien = true
	em_observaciones.text = ""
	v_articulo = uo_articulo.em_codigo.text
	
	Select max(convert(int,proddetartic.version)+1) Into :vers
	From   proddetartic
	Where  proddetartic.empresa = :codigo_empresa
	and    proddetartic.articulo = :v_articulo;
	
	IF isnull(vers)  THEN vers = 1
	
	nueva_version = string(vers,"###")
	version_actual = nueva_version
	fecha_version  = datetime(today())
	
	version_activa = f_version_activa_articulo(codigo_empresa,v_articulo)
	
	if version_activa <> "" then
		v_fecha = datetime(today())
		sel = "SELECT * FROM PRODDETARTIC "+&
				"WHERE EMPRESA = '"+CODIGO_EMPRESA+"' "+&
				"AND ARTICULO  = '"+uo_articulo.em_codigo.text+"' "+&
				"AND VERSION   = '"+version_activa+"'"
				
		//cursor_version = f_cargar_cursor(sel)
		f_cargar_cursor_nuevo(sel, cursor_version)
		total = cursor_version.rowcount()
		for indice = 1 to total
			v_numaplic      = cursor_version.object.numaplic[indice]
			v_aplicacion    = cursor_version.object.aplicacion[indice]
			v_formulacion   = cursor_version.object.formulacion[indice]
			v_gramaje       = cursor_version.object.gramaje[indice]
			v_densidad      = cursor_version.object.densidad[indice]
			v_viscosidad    = cursor_version.object.viscosidad[indice]
			v_hilospantalla = cursor_version.object.hilospantalla[indice]
			v_ubicacion_pantalla = cursor_version.object.ubicacion_pantalla[indice]
			v_notas         = cursor_version.object.notas[indice]
			
			
			// Comentado provisionalmente porque da error
//			insert into proddetartic
//			values (
//			:codigo_empresa,
//			:v_articulo,
//			:nueva_version,
//			:v_numaplic,
//			:v_aplicacion,
//			:v_formulacion,
//			:v_gramaje,
//			:v_densidad,
//			:v_viscosidad,
//			:v_hilospantalla,
//			:v_notas,
//			:v_fecha,
//			:v_ubicacion_pantalla);
			if sqlca.sqlcode <> 0 then
				bien = false
			end if
		next
		if bien then 
			commit;
		else 
			rollback;
			messagebox("Atención","Error al copiar formulación activa")
		end if
	
	end if	
	cb_version.text = version_actual
	dw_aplicaciones.retrieve(codigo_empresa, uo_articulo.em_codigo.text,version_actual)
	dw_costes.retrieve(codigo_empresa, uo_articulo.em_codigo.text,version_actual)
	dw_aplicaciones.setsort("number(numaplic) asc")
	dw_costes.setsort("number(numaplic) asc")
	dw_aplicaciones.sort()
	dw_costes.sort()
	modificando = false
end if	
	
  
end event

type uo_articulo from u_em_campo_2 within wi_mant_proddetartic
integer x = 357
integer y = 196
integer width = 786
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo      = "AYUDA SELECCION DE ARTICULOS"
ue_datawindow  = "dw_ayuda_articulos"
ue_filtro     = ""


end event

event modificado;uo_articulo.em_campo.text = f_nombre_articulo (codigo_empresa, uo_articulo.em_codigo.text)

if IsNull(uo_articulo.em_campo.text) or Trim(uo_articulo.em_campo.text) = "" then
	uo_articulo.em_campo.text = ""
	uo_articulo.em_codigo.text = ""
	f_activar_campo(uo_articulo.em_campo)
end if
	
cb_version.text = ""
em_observaciones.text = ""
version_actual  = ""
setnull(fecha_version)
dw_aplicaciones.reset()
dw_costes.reset()
dw_observaciones.reset()
dw_observaciones.visible = false

end event

type st_2 from statictext within wi_mant_proddetartic
integer x = 87
integer y = 304
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Versión:"
boolean focusrectangle = false
end type

type dw_aplicaciones from u_datawindow within wi_mant_proddetartic
integer y = 392
integer width = 2615
integer height = 1484
integer taborder = 130
string dataobject = "dw_proddetartic1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;long maxi,i,num,donde
str_parametros lstr_param

choose case f_objeto_datawindow(this) 
	case "cb_anyadir"
		if not ver_costes then
			this.Modify("cb_costes.text = 'Ver Costes'")
 			dw_costes.visible = false
	   	ver_costes = true
		end if
		donde = this.InsertRow(0)
		this.SetItem(donde,"empresa",codigo_empresa)
		this.SetItem(donde,"articulo",uo_articulo.em_codigo.text)
		this.SetItem(donde,"version",version_actual)
		this.SetItem(donde,"f_alta",fecha_version)
		if this.RowCount() = 0 then
			maxi = 0
		else
			maxi = 0
			for i = 1 to this.rowcount()
				num = Dec(this.GetItemString(i,"numaplic"))
				if IsNull(num) then num = 0
				if num > maxi then maxi = num
			next
			
		end if
		maxi = maxi + 1
		this.SetItem(donde,"numaplic",String(maxi))
		this.SetRow(donde)
		this.SetColumn("aplicacion")
	case "cb_intercalar"
		if not ver_costes then
			this.Modify("cb_costes.text = 'Ver Costes'")
 			dw_costes.visible = false
	   	ver_costes = true
		end if

		donde = this.GetRow()
		donde = this.InsertRow(donde)
		
		this.SetItem(donde,"empresa",codigo_empresa)
		this.SetItem(donde,"articulo",uo_articulo.em_codigo.text)
		this.SetItem(donde,"version",version_actual)
		this.SetItem(donde,"f_alta",fecha_version)
		for i = 1 to this.rowcount()
			this.SetItem(i,"numaplic",String(i))
		next
		this.SetRow(donde)
		this.SetColumn("aplicacion")
	case "cb_borrar"
		if not ver_costes then
			this.Modify("cb_costes.text = 'Ver Costes'")
 			dw_costes.visible = false
	   	ver_costes = true
		end if
		if this.RowCOunt() > 0 then
			this.DeleteRow(this.GetRow())
			this.SetRow(1)
		end if
		for i = 1 to this.rowcount()
			this.SetItem(i,"numaplic",String(i))
		next

	case "cb_notas"
		if ver_notas then
		 	 this.Modify("datawindow.detail.height = 72")
			 dw_listado.Modify("datawindow.header.1.height = 72")
			 dw_costes.Modify("datawindow.detail.height = 72")
			 This.SetTabOrder("notas",0)
			 this.Modify("cb_notas.text = 'Ver Notas'")
			 ver_notas = false
		else
 		 	 this.Modify("datawindow.detail.height = 160")
			 dw_listado.Modify("datawindow.header.1.height = 160")
			 dw_costes.Modify("datawindow.detail.height = 160")
			 This.SetTabOrder("notas",70)
			 this.Modify("cb_notas.text = 'Ocultar Notas'")
			 ver_notas = true
		end if
		case "cb_costes"
		if ver_costes then
			if f_pedir_clave("3") then 
		 	 	this.Modify("cb_costes.text = 'Ocultar Costes'")
				dw_listado.Modify("titulo_coste.visible = 1")
				dw_listado.Modify("coste.visible = 1")
				dw_listado.Modify("coste_total.visible = 1")
				dw_listado.Modify("texto_pts.visible = 1")
				dw_listado.Modify("texto_total_pts.visible = 1")
			 	dw_costes.visible = true
			 	ver_costes = false
			end if
		else
			this.Modify("cb_costes.text = 'Ver Costes'")
			dw_listado.Modify("titulo_coste.visible = 0")
			dw_listado.Modify("coste.visible = 0")
			dw_listado.Modify("coste_total.visible = 0")
			dw_listado.Modify("texto_pts.visible = 0")
			dw_listado.Modify("texto_total_pts.visible = 0")
 		   dw_costes.visible = false
			ver_costes = true
		end if
	case "cb_observaciones"
		if dw_observaciones.visible then
			dw_observaciones.visible = false
		else
			dw_observaciones.retrieve(codigo_empresa,uo_articulo.em_codigo.text,version_actual)
			if dw_observaciones.rowcount() = 0 then
				donde = dw_observaciones.insertrow(0)
				dw_observaciones.object.empresa[donde] = codigo_empresa
				dw_observaciones.object.articulo[donde] = uo_articulo.em_codigo.text
				dw_observaciones.object.version[donde] = version_actual
			end if
			dw_observaciones.visible = true
			dw_observaciones.setfocus()
		end if
	case "pb_aplicacion"
		OpenWithParm(wi_mant_prodaplicaciones, lstr_param)
		
	case "pb_formulacion"
		OpenWithParm(wi_mant_formulaciones, lstr_param)

end choose

call super::clicked
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "aplicacion"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_titulo = "VENTANA SELECCION DE APLICACIONES"
	CASE "formulacion"
		bus_titulo     = "AYUDA SELECCION FORMULACIONES"
		bus_datawindow = "dw_ayuda_prodformulaciones"
		bus_filtro     = "" 	
		
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
	CASE "aplicacion"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_titulo = "VENTANA SELECCION DE APLICACIONES"
	CASE "formulacion"
		bus_titulo     = "AYUDA SELECCION FORMULACIONES"
		bus_datawindow = "dw_ayuda_prodformulaciones"
		bus_filtro     = "" 	
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event doubleclicked;string v_formula
str_parametros lstr_param
if row <> 0 then
	v_formula = this.getitemstring(row,"formulacion")
	if not (IsNull(v_formula)) or not(v_formula = "") then
		lstr_param.i_nargumentos    = 2
		lstr_param.s_argumentos[2]= v_formula
		OpenWithParm(wi_mant_formulaciones, lstr_param)
	end if
end if
end event

type cb_version from u_boton within wi_mant_proddetartic
integer x = 366
integer y = 284
integer width = 256
integer height = 100
integer taborder = 40
boolean bringtotop = true
end type

event clicked;
if not(dw_versiones.visible) then
	dw_versiones.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
	if dw_versiones.rowcount() > 0 then
		cb_aceptar.enabled = false
		cb_cancelar.enabled = false
		pb_calculadora.enabled = false
		uo_articulo.enabled = false
		dw_versiones.visible = true
	end if
end if
end event

type em_observaciones from u_em_campo within wi_mant_proddetartic
integer x = 741
integer y = 296
integer width = 1760
integer taborder = 60
integer textsize = -9
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type pb_3 from upb_imprimir within wi_mant_proddetartic
integer x = 2217
integer y = 184
integer width = 119
integer height = 100
integer taborder = 160
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;
if trim(uo_articulo.em_codigo.text) <> "" then
	if trim(cb_version.text) <> "" then
		f_imprimir(dw_listado,"N")
		f_imprimir_datawindow(dw_listado)
	end if
end if
end event

type st_3 from statictext within wi_mant_proddetartic
integer x = 2130
integer y = 140
integer width = 297
integer height = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Comprobación"
alignment alignment = center!
boolean focusrectangle = false
end type

type r_1 from rectangle within wi_mant_proddetartic
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 12632256
integer x = 2126
integer y = 132
integer width = 311
integer height = 156
end type

type cb_listar from u_boton within wi_mant_proddetartic
integer x = 1166
integer y = 124
integer width = 709
integer height = 76
integer taborder = 20
boolean bringtotop = true
string text = "Listar Creados"
end type

event clicked;dw_listado_creados.retrieve(codigo_empresa)
f_imprimir_datawindow(dw_listado_creados)
end event

type dw_listado_creados from datawindow within wi_mant_proddetartic
boolean visible = false
integer x = 18
integer y = 20
integer width = 302
integer height = 212
integer taborder = 21
boolean bringtotop = true
string dataobject = "dw_list_proddetartic_creados"
boolean livescroll = true
end type

type dw_observaciones from datawindow within wi_mant_proddetartic
boolean visible = false
integer y = 572
integer width = 2619
integer height = 504
integer taborder = 120
string dataobject = "dw_observaciones_version_articulo"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;
choose case f_objeto_datawindow(this)
case "p_salir"
	this.visible = false
end choose

end event

type dw_versiones from datawindow within wi_mant_proddetartic
boolean visible = false
integer x = 366
integer y = 384
integer width = 832
integer height = 536
integer taborder = 100
string dataobject = "dw_ayuda_version_articulo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;string var_articulo,var_version,var_ant_version
long numero_registro
datetime fecha
if row > 0 then
	var_articulo = uo_articulo.em_codigo.text
	var_version  = this.object.version[row]
	if not(f_version_activa_articulo_boolean(codigo_empresa,var_articulo,var_version)) then
		If f_pedir_clave("4") then		
			
			select max(registro) into :numero_registro
			from prodregcambioversion
			where empresa = :codigo_empresa;
			
			if isnull(numero_registro) then numero_registro = 0
			
			numero_registro = numero_registro + 1 
			var_ant_version = f_version_activa_articulo(codigo_empresa,var_articulo)
			fecha = datetime(today())
			insert into prodregcambioversion
			values(:codigo_empresa,:numero_registro,:var_articulo,
						:var_version,:var_ant_version,:nombre_usuario,:fecha);
			if sqlca.sqlcode = 0 then
				commit;
				if f_version_activa_articulo(codigo_empresa,var_articulo) <> "" then
					
					update prodartversionactiva 
					set   version = :var_version
					where empresa =  :codigo_empresa
					and   articulo = :var_articulo;
					
					if sqlca.sqlcode <> 0 then
						rollback;
						messagebox("Atención","Error al cambiar la versión activa")
					else
						commit;
					end if
				else
					insert into prodartversionactiva 
					values(:codigo_empresa,:var_articulo,:var_version);
					
					if sqlca.sqlcode <> 0 then
						rollback;
						messagebox("Atención","Error al activar la versión")
					else
						commit;
					end if
					
				end if
			else
				rollback;
				messagebox("Atención","Error al activar la versión")
			end if
		end if
		dw_versiones.retrieve(codigo_empresa,uo_articulo.em_codigo.text)	
	end if		
end if
end event

event doubleclicked;if row > 0 then
	cb_version.text = this.object.version[row]
	version_actual  = this.object.version[row]
	fecha_version   = this.object.f_alta[row]
	em_observaciones.text = f_observaciones_version_articulo(codigo_empresa,uo_articulo.em_codigo.text,version_actual)
	cb_aceptar.enabled = true
	cb_cancelar.enabled = true
	pb_calculadora.enabled = true
	uo_articulo.enabled = true
	this.visible = false
	dw_aplicaciones.retrieve(codigo_empresa, uo_articulo.em_codigo.text,version_actual)
	dw_costes.retrieve(codigo_empresa, uo_articulo.em_codigo.text,version_actual)
	dw_aplicaciones.setsort("number(numaplic) asc")
	dw_costes.setsort("number(numaplic) asc")
	dw_aplicaciones.sort()
	dw_costes.sort()
	dw_observaciones.reset()
	dw_observaciones.visible = false
	modificando = true
end if
end event

event clicked;
choose case f_objeto_datawindow(this)
case "p_salir"
	cb_aceptar.enabled = true
	cb_cancelar.enabled = true
	pb_calculadora.enabled = true
	uo_articulo.enabled = true
	this.visible = false
case "revisada"
	
case else
	if row > 0 then
		this.selectrow(0,false)
		this.selectrow(row,true)
		this.setrow(row)
	end if
end choose

end event

event retrieveend;long   indice,total
string var_articulo,var_version

total = this.rowcount()
if total > 0 then
	var_articulo = uo_articulo.em_codigo.text	
	for indice = 1 to total
		var_version  = this.object.version[indice]
		if f_version_revisada_art(codigo_empresa,var_articulo,var_version) then
			this.object.revisada[indice] = "S"
		else
			this.object.revisada[indice] = "N"
		end if
	next
end if

end event

event itemchanged;string var_articulo,var_version,var_revisada
choose case f_objeto_datawindow(this)
case "revisada"
	var_articulo = uo_articulo.em_codigo.text
	var_version  = this.object.version[row]
	var_revisada = data
	if var_revisada = "S" then
		insert into prodartversionrevisada
		values(:codigo_empresa,:var_articulo,:var_version);
		
		if sqlca.sqlcode <> 0 then
			rollback;
			messagebox("Atención","Error al marcar la versión como revisada")
		else
			commit;
		end if
	else			
		if f_version_revisada_art(codigo_empresa,var_articulo,var_version) then
			delete prodartversionrevisada
			where  empresa  = :codigo_empresa
			and    articulo = :var_articulo
			and    version  = :var_version;
			
			if sqlca.sqlcode <> 0 then
				rollback;
				messagebox("Atención","Error al marcar la versión como no revisada")
			else
				commit;
			end if		
		end if
	end if	
end choose

end event

