$PBExportHeader$wi_con_ordenes.srw
$PBExportComments$No se utiliza
forward
global type wi_con_ordenes from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_con_ordenes
end type
type dw_1 from datawindow within wi_con_ordenes
end type
type dw_listado from datawindow within wi_con_ordenes
end type
type pb_imprimir from upb_imprimir within wi_con_ordenes
end type
type cb_1 from commandbutton within wi_con_ordenes
end type
type gb_2 from groupbox within wi_con_ordenes
end type
type gb_1 from groupbox within wi_con_ordenes
end type
type em_fechadesde from u_em_campo within wi_con_ordenes
end type
type em_fechahasta from u_em_campo within wi_con_ordenes
end type
type cb_detalle from commandbutton within wi_con_ordenes
end type
type rb_1 from radiobutton within wi_con_ordenes
end type
type rb_todas from radiobutton within wi_con_ordenes
end type
end forward

global type wi_con_ordenes from w_int_con_empresa
integer width = 2807
integer height = 2180
pb_1 pb_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_detalle cb_detalle
rb_1 rb_1
rb_todas rb_todas
end type
global wi_con_ordenes wi_con_ordenes

forward prototypes
public subroutine f_procesar (datawindow data)
public subroutine f_imprimir (datawindow data)
public subroutine f_imprimir2 (datawindow data)
end prototypes

public subroutine f_procesar (datawindow data);datastore articulos
datastore formulas
string seleccion1,seleccion2,seleccion3,var_version
long indice1,indice2,indice3
long total1,total2,total3
string articulo,familia,formato,calidad,formula,filtro,aplicacion
real cantidad,cant_formula
datetime fecha,fmin	
long donde

data.Reset()
data.SetRedraw(FALSE)
if not(rb_todas.checked) then
	filtro = " and impresa <> 'S' order by fecha,articulo,familia,formato" 
else
	filtro = " order by fecha,articulo,familia,formato"
end if
seleccion1 ="select articulo,familia,formato,cantidad,fecha from proddiaria "+&
				"where empresa = '"+codigo_empresa+"' and "+&
				"fecha between '"+STring(Date(em_fechadesde.text),"mm/dd/yy")+"' and '"+STring(Date(em_fechahasta.text),"mm/dd/yy")+"'"
				
seleccion1 = seleccion1 + filtro				
	
//articulos = f_cargar_cursor(seleccion1)
f_cargar_cursor_nuevo(seleccion1, articulos)

total1 = articulos.rowcount()
	
if total1 > 0 then
	for indice1 = 1 to total1
		articulo = articulos.getitemstring(indice1,"articulo")
		familia = articulos.getitemstring(indice1,"familia")
		formato = articulos.getitemstring(indice1,"formato")
		cantidad = articulos.getitemdecimal(indice1,"cantidad")
		fecha = articulos.getitemdatetime(indice1,"fecha")
		var_version = f_version_activa_articulo(codigo_empresa,articulo)
		seleccion2 ="select aplicacion,formulacion,gramaje from proddetartic "+&
						"where empresa = '"+codigo_empresa+"' and "+&
						"articulo = '"+articulo+"' "+&
						"and version = '"+var_version+"'"
		
		//formulas = f_cargar_cursor (seleccion2)
		f_cargar_cursor_nuevo(seleccion2, formulas)
		total2 = formulas.rowcount()
		if total2 > 0 then
			for indice2 = 1 to total2
				aplicacion = formulas.getitemstring(indice2,"aplicacion")
				formula = formulas.getitemstring(indice2,"formulacion")
				cant_formula = formulas.getitemdecimal(indice2,"gramaje")
				donde = data.insertrow(0)
				data.setitem(donde,"empresa",codigo_empresa)
				data.setitem(donde,"articulo",articulo)
				data.setitem(donde,"familia",familia)
				data.setitem(donde,"formato",formato)
				data.setitem(donde,"formula",formula)
				data.setitem(donde,"cant_dia",f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000))
				data.setitem(donde,"aplicacion",f_nombre_aplicacion_abr(codigo_empresa,aplicacion))
				data.setitem(donde,"dia",fecha)
			next
		end if
   next
end if
data.SetRedraw(TRUE)
data.Sort()
data.GroupCalc()



end subroutine

public subroutine f_imprimir (datawindow data);datastore articulos
datastore formulas
datastore linformulas
string seleccion1,seleccion2,seleccion3,filtro,var_version
long indice1,indice2,indice3,lineas,indice4,lineas2,empieza_columna2
long total1,total2,total3,lineas_reales,indice
string articulo,familia,formato,calidad,formula
string ubicacion_pantalla,formato_gramaje_aplicacion
real cantidad,cant_formula
datetime fecha,fmin	
long donde
real densidad,viscosidad,hilospantalla,cantidad_mp,kg_formula,porc_mp
string mp,numaplic,aplicacion
long total_lineas = 41 //Antes 47
long lineas_notas
BOOLEAN COLUMNA2 = FALSE
data.Reset()
data.SetRedraw(FALSE)
data.retrieve(codigo_empresa,em_fechadesde.text,em_fechahasta.text)
if not(rb_todas.checked) then
	filtro = " and impresa <> 'S'  group by articulo,familia,formato order by fecha,articulo,familia,formato" 
else
	filtro = " group by articulo,familia,formato order by fecha,articulo,familia,formato"
end if
seleccion1 ="select articulo,familia,formato,sum(cantidad) cantidad,min(fecha) fecha from proddiaria "+&
				"where empresa = '"+codigo_empresa+"' and "+&
				"fecha between '"+STring(Date(em_fechadesde.text),"mm/dd/yy")+"' and '"+STring(Date(em_fechahasta.text),"mm/dd/yy")+"'"
			
seleccion1 = seleccion1 + filtro				
	
//articulos = f_cargar_cursor(seleccion1)
f_cargar_cursor_nuevo(seleccion1, articulos)

total1 = articulos.rowcount()
	
if total1 > 0 then
	lineas_reales = 0
	for indice1 = 1 to total1
		lineas = 0
		articulo = articulos.getitemstring(indice1,"articulo")
		familia = articulos.getitemstring(indice1,"familia")
		formato = articulos.getitemstring(indice1,"formato")
		cantidad = articulos.getitemdecimal(indice1,"cantidad")
		fecha = articulos.getitemdatetime(indice1,"fecha")
		var_version = f_version_activa_articulo(codigo_empresa,articulo)
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
				//////////
				formato_gramaje_aplicacion  = f_formato_gramaje_aplicacion(codigo_empresa,aplicacion)
				if formato_gramaje_aplicacion = "" then
					data.Object.gramaje[donde] = dec(string(cant_formula,"###,##0.000"))				
				else
					// Realizamos la conversion del gramaje
					data.Object.gramaje_aplicacion[donde] = dec(string(cant_formula,"###,##0.000"))							
					data.Object.gramaje[donde] = dec(string((cant_formula/f_superficie_formato(codigo_empresa,formato_gramaje_aplicacion))*f_superficie_formato(codigo_empresa,f_formato_articulo(codigo_empresa,articulo)),"###,##0.000"))				
				end if
				data.Object.ubicacion_pantalla[donde] = ubicacion_pantalla
				//////////
				
				data.Object.densidad[donde] = densidad
				data.Object.viscosidad[donde] = viscosidad
				data.Object.hilospantalla[donde] = hilospantalla
//				data.setitem(donde,"cant_dia",(cant_formula * cantidad)/1000)
				data.Object.fecha_prod[donde] = fecha
				data.Object.linea[donde] = "S"
			next
			donde = data.insertrow(0)
			lineas = lineas + 1
			lineas_reales = lineas_reales + 1
			data.Object.empresa[donde] = codigo_empresa
			data.Object.articulo[donde] = articulo
			data.Object.pz_producir[donde] = cantidad
			empieza_columna2 = lineas_reales + 1
			
			for indice2 = 1 to total2
				aplicacion = formulas.Object.aplicacion[indice2]
				formula = formulas.Object.formulacion[indice2]
				numaplic = formulas.Object.numaplic[indice2]
				aplicacion = formulas.Object.aplicacion[indice2]
				cant_formula = formulas.Object.gramaje[indice2]
				//////////
				formato_gramaje_aplicacion  = f_formato_gramaje_aplicacion(codigo_empresa,aplicacion)
				if formato_gramaje_aplicacion = "" then
					cant_formula = formulas.Object.gramaje[indice2]
				else
					// Realizamos la conversion del gramaje
					cant_formula = (formulas.Object.gramaje[indice2]/f_superficie_formato(codigo_empresa,formato_gramaje_aplicacion))*f_superficie_formato(codigo_empresa,f_formato_articulo(codigo_empresa,articulo))
				end if
				//////////
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
					data.Object.consumo_formula[donde]= f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)
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
							//kg_formula = (cant_formula * cantidad)/1000
							kg_formula = f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)
							porc_mp = (cantidad_mp / f_peso_total_formula(codigo_empresa,formula)) * 100								
							data.Object.cantidad_mp[donde] = porc_mp
							data.Object.consumo_mp[donde] = (kg_formula / 100) * porc_mp
							
						next
						data.Object.linea3[donde] = "S"
//						donde = data.insertrow(0)
//						lineas = lineas + 1
//						lineas_reales = lineas_reales + 1
//						data.Object.empresa[donde] = codigo_empresa
//						data.Object.articulo[donde] = articulo
//						data.Object.consumo_formula[donde]= f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)
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
					data.Object.consumo_formula2[donde]= f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)					
					
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
							//kg_formula = (cant_formula * cantidad)/1000
							kg_formula = f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)
							porc_mp = (cantidad_mp / f_peso_total_formula(codigo_empresa,formula)) * 100								
							data.Object.cantidad_mp2[donde] = porc_mp
							data.Object.consumo_mp2[donde] = (kg_formula / 100) * porc_mp
							
						next
						data.Object.linea4[donde] = "S"
//						donde = lineas2						
//						lineas2 = lineas2 + 1
//						data.Object.empresa[donde] = codigo_empresa
//						data.Object.articulo[donde] = articulo
//						data.Object.consumo_formula2[donde] = f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)						
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
   next
end if
for indice = 1 to data.rowcount()
	data.object.total_paginas[indice] = round(lineas_reales / total_lineas,0)
next
data.SetRedraw(TRUE)
data.GroupCalc()

destroy articulos
destroy formulas
destroy linformulas

end subroutine

public subroutine f_imprimir2 (datawindow data);datastore articulos
datastore formulas
datastore linformulas
string seleccion1,seleccion2,seleccion3,filtro,var_version
long indice1,indice2,indice3,lineas,indice4,lineas2,empieza_columna2
long total1,total2,total3,lineas_reales
string articulo,familia,formato,calidad,formula
real cantidad,cant_formula
datetime fecha,fmin	
long donde
real densidad,viscosidad,hilospantalla,cantidad_mp,kg_formula,porc_mp
string mp,numaplic,aplicacion
long total_lineas = 47
BOOLEAN COLUMNA2 = FALSE
data.Reset()
data.SetRedraw(FALSE)
data.retrieve(codigo_empresa,em_fechadesde.text,em_fechahasta.text)
if not(rb_todas.checked) then
	filtro = " and impresa <> 'S'  group by articulo,familia,formato order by fecha,articulo,familia,formato" 
else
	filtro = " group by articulo,familia,formato order by fecha,articulo,familia,formato"
end if
seleccion1 ="select articulo,familia,formato,sum(cantidad) cantidad,min(fecha) fecha from proddiaria "+&
				"where empresa = '"+codigo_empresa+"' and "+&
				"fecha between '"+STring(Date(em_fechadesde.text),"mm/dd/yy")+"' and '"+STring(Date(em_fechahasta.text),"mm/dd/yy")+"'"
			
seleccion1 = seleccion1 + filtro				
	
//articulos = f_cargar_cursor(seleccion1)
f_cargar_cursor_nuevo(seleccion1, articulos)

total1 = articulos.rowcount()
	
if total1 > 0 then
	lineas_reales = 0
	for indice1 = 1 to total1
		lineas = 0
		articulo = articulos.getitemstring(indice1,"articulo")
		familia = articulos.getitemstring(indice1,"familia")
		formato = articulos.getitemstring(indice1,"formato")
		cantidad = articulos.getitemdecimal(indice1,"cantidad")
		fecha = articulos.getitemdatetime(indice1,"fecha")
		var_version = f_version_activa_articulo(codigo_empresa,articulo)
		seleccion2 ="select numaplic,aplicacion,formulacion,gramaje,"+&
						"densidad,viscosidad,hilospantalla from proddetartic "+&
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
				data.Object.gramaje[donde] = dec(string(cant_formula,"###,###,##0"))				
				data.Object.densidad[donde] = densidad
				data.Object.viscosidad[donde] = viscosidad
				data.Object.hilospantalla[donde] = hilospantalla
//				data.setitem(donde,"cant_dia",(cant_formula * cantidad)/1000)
				data.Object.fecha_prod[donde] = fecha
				data.Object.linea[donde] = "S"
			next
			donde = data.insertrow(0)
			lineas = lineas + 1
			lineas_reales = lineas_reales + 1
			data.Object.empresa[donde] = codigo_empresa
			data.Object.articulo[donde] = articulo
			data.Object.pz_producir[donde] = cantidad
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
				if (lineas + 1) + total3 > total_lineas then
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
					//data.Object.consumo_formula[donde]= (cant_formula * cantidad)/1000
					data.Object.consumo_formula[donde]= f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)
					data.Object.linea2[donde] = "S"
	
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
							//kg_formula = (cant_formula * cantidad)/1000
							kg_formula = f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)
							porc_mp = (cantidad_mp / f_peso_total_formula(codigo_empresa,formula)) * 100								
							data.Object.cantidad_mp[donde] = porc_mp
							data.Object.consumo_mp[donde] = (kg_formula / 100) * porc_mp
							
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
					//data.Object.consumo_formula2[donde]= (cant_formula * cantidad)/1000
					data.Object.consumo_formula2[donde]= f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)
					if total3 > 0 then
						for indice3 = 1 to total3				
							mp = linformulas.Object.mp[indice3]
							cantidad_mp = linformulas.Object.cantidad[indice3]
							donde = lineas2
							
							lineas2 = lineas2 + 1
							data.Object.empresa[donde] = codigo_empresa
							data.Object.articulo[donde] = articulo
							data.Object.mp2[donde] = mp								
							//kg_formula = (cant_formula * cantidad)/1000
							kg_formula = f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000)
							porc_mp = (cantidad_mp / f_peso_total_formula(codigo_empresa,formula)) * 100								
							data.Object.cantidad_mp2[donde] = porc_mp
							data.Object.consumo_mp2[donde] = (kg_formula / 100) * porc_mp
							
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
   next
end if
data.SetRedraw(TRUE)
data.GroupCalc()

destroy articulos
destroy formulas
destroy linformulas

end subroutine

on wi_con_ordenes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_detalle=create cb_detalle
this.rb_1=create rb_1
this.rb_todas=create rb_todas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.em_fechadesde
this.Control[iCurrent+9]=this.em_fechahasta
this.Control[iCurrent+10]=this.cb_detalle
this.Control[iCurrent+11]=this.rb_1
this.Control[iCurrent+12]=this.rb_todas
end on

on wi_con_ordenes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_detalle)
destroy(this.rb_1)
destroy(this.rb_todas)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Necesidades Formulación y LIstado de Ordenes"
istr_parametros.s_listado        =   "report_formatos_familias"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(em_fechadesde)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_ordenes
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_ordenes
integer x = 1586
integer y = 24
integer width = 352
integer height = 312
fontcharset fontcharset = ansi!
end type

event getfocus;//f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_con_ordenes
integer width = 837
end type

type pb_1 from upb_salir within wi_con_ordenes
integer x = 2533
integer y = 40
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type dw_1 from datawindow within wi_con_ordenes
integer x = 78
integer y = 360
integer width = 2546
integer height = 1472
boolean bringtotop = true
string dataobject = "dw_con_cant_form_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_listado from datawindow within wi_con_ordenes
boolean visible = false
integer y = 4
integer width = 329
integer height = 160
boolean bringtotop = true
string dataobject = "report_ordenes_produccion"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_con_ordenes
event clicked pbm_bnclicked
integer x = 2427
integer y = 248
integer taborder = 50
end type

event clicked;date fechad,fechah 
long cuantos
if rb_todas.checked then	
	fechad = date(em_fechadesde.text)
	fechah = date(em_fechahasta.text)
			select count(*) into :cuantos from proddiaria 
			where empresa = :codigo_empresa
			and fecha between :fechad and :fechah
			and impresa = "S";
			
	if isnull(cuantos) then cuantos = 0
	if cuantos > 0 then
		messagebox("Atención","Algunas de las lineas de producción~nde este listado ya han sido impresas.")
	end if
end if
f_imprimir(dw_listado)
if dw_listado.rowcount() > 0 then
	if f_imprimir_datawindow(dw_listado) then
		update proddiaria set impresa = "S"
		where empresa = :codigo_empresa
		and fecha between :fechad and :fechah;
		commit;
	end if
end if


end event

type cb_1 from commandbutton within wi_con_ordenes
integer x = 1376
integer y = 192
integer width = 293
integer height = 148
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;
if trim(em_fechadesde.text)<>"" then
	if trim(em_fechahasta.text)<>"" then
			f_procesar (dw_1)
	else
		messagebox ("Error","Debe introducir el valor de la fecha tope")
		setfocus(em_fechahasta)
	end if
else
	messagebox ("Error","Debe introducir el valor de la fecha inicio")
	setfocus(em_fechadesde)
end if


end event

type gb_2 from groupbox within wi_con_ordenes
integer x = 823
integer y = 160
integer width = 485
integer height = 180
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Opciones"
end type

type gb_1 from groupbox within wi_con_ordenes
integer x = 82
integer y = 160
integer width = 736
integer height = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fechas"
end type

type em_fechadesde from u_em_campo within wi_con_ordenes
integer x = 105
integer y = 232
integer width = 320
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within wi_con_ordenes
integer x = 475
integer y = 232
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_detalle from commandbutton within wi_con_ordenes
integer x = 1801
integer y = 256
integer width = 622
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ocultar detalle dias"
end type

event clicked;if this.text = "Ver detalle dias" then
	this.text = "Ocultar detalle dias"
	dw_1.modify("datawindow.detail.height=72")
	dw_listado.modify("datawindow.detail.height=72")

else
	this.text = "Ver detalle dias"
	dw_1.modify("datawindow.detail.height=0")
	dw_listado.modify("datawindow.detail.height=0")

end if

end event

type rb_1 from radiobutton within wi_con_ordenes
integer x = 841
integer y = 220
integer width = 448
integer height = 48
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "No impresas"
boolean checked = true
end type

type rb_todas from radiobutton within wi_con_ordenes
integer x = 841
integer y = 272
integer width = 256
integer height = 48
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todas"
end type

