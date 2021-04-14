$PBExportHeader$wi_mant_formulaciones.srw
forward
global type wi_mant_formulaciones from wc_mantenimientos_tab
end type
type cb_insertar2 from u_boton within pagina_2
end type
type cb_borrar2 from u_boton within pagina_2
end type
type pb_calculadora from u_calculadora within wi_mant_formulaciones
end type
type gb_3 from groupbox within wi_mant_formulaciones
end type
type rb_laboratorio from radiobutton within wi_mant_formulaciones
end type
type rb_produccion from radiobutton within wi_mant_formulaciones
end type
type st_texto from statictext within wi_mant_formulaciones
end type
type dw_coste_mp_por_familia from datawindow within wi_mant_formulaciones
end type
type cb_1 from commandbutton within wi_mant_formulaciones
end type
type pb_1 from picturebutton within wi_mant_formulaciones
end type
type rb_formula_actual from radiobutton within wi_mant_formulaciones
end type
type rb_formula_listado from radiobutton within wi_mant_formulaciones
end type
type em_fecha_listado from editmask within wi_mant_formulaciones
end type
type dw_listado_imprimir from datawindow within wi_mant_formulaciones
end type
type cb_2 from commandbutton within wi_mant_formulaciones
end type
type gb_2 from groupbox within wi_mant_formulaciones
end type
end forward

global type wi_mant_formulaciones from wc_mantenimientos_tab
integer width = 4841
integer height = 2296
string menuname = ""
boolean minbox = false
boolean maxbox = false
windowtype windowtype = response!
pb_calculadora pb_calculadora
gb_3 gb_3
rb_laboratorio rb_laboratorio
rb_produccion rb_produccion
st_texto st_texto
dw_coste_mp_por_familia dw_coste_mp_por_familia
cb_1 cb_1
pb_1 pb_1
rb_formula_actual rb_formula_actual
rb_formula_listado rb_formula_listado
em_fecha_listado em_fecha_listado
dw_listado_imprimir dw_listado_imprimir
cb_2 cb_2
gb_2 gb_2
end type
global wi_mant_formulaciones wi_mant_formulaciones

type variables
boolean ver_coste = true
string resultado[50]
boolean similares_comprobados = false
String formula_estandar = '0'
Dec metros2_pieza
end variables

forward prototypes
public function boolean f_buscar_formulas_iguales ()
public function boolean f_buscar_formulas_iguales_vieja ()
end prototypes

public function boolean f_buscar_formulas_iguales ();datastore D_form
string sel1,sel2,articulos,articulo,formula,formulacion
long indice1,total1,indice2,total2,indice3,total3,total9


total1  = apartados.pagina_2.dw_pagina2.rowcount()
total2 = 0

if total1 > 0 then
	for indice1 = 1 to total1
		if indice1 = 1 then
			articulos = "'"+apartados.pagina_2.dw_pagina2.getitemstring(indice1,"mp")+"'"
		else
			articulos = articulos+",'"+apartados.pagina_2.dw_pagina2.getitemstring(indice1,"mp")+"'"
		end if
	next
	
	formula = apartados.pagina_1.dw_pagina1.getitemstring(1,"formula")
	sel1 ="SELECT COUNT(MP) COINCIDENCIAS,FORMULACION "+&
			"FROM PRODDETFORMULA "+&
			"WHERE EMPRESA = '"+codigo_empresa+"' "+&
			"AND MP IN ("+articulos+") "+&
			"AND FORMULACION IN ( "+&
			"SELECT FORMULACION "+&
			"FROM PRODDETFORMULA "+&
			"WHERE EMPRESA = '"+codigo_empresa+"' "+&
			"AND FORMULACION <> '"+formula+"' "+&
			"GROUP BY FORMULACION "+&
			"HAVING COUNT(*) = "+STRING(TOTAL1,"##")+" )"+&		
			"GROUP BY FORMULACION "
			
//	D_form = f_cargar_cursor(sel1)
	f_cargar_cursor_nuevo(sel1, d_form)
	
	D_form.setfilter("COINCIDENCIAS = "+string(TOTAL1,"##"))
	D_form.filter()
	total2 = D_form.rowcount()
	if total2 > 0 then
		if total2 > 50 then total2 = 50
		for indice2 = 1 to total2
			formulacion   = D_form.getitemstring(indice2,"formulacion")
			resultado[indice2] = formulacion
		next
	end if
end if

destroy D_form

if total2 > 0 then
	if total2 < 50 then
		for indice1 = total2 + 1 to 50
			resultado[indice1] = resultado[total2]
		next
	end if
	return true
else
	return false
end if
end function

public function boolean f_buscar_formulas_iguales_vieja ();datastore D_form,D_linform
string sel1,sel2,articulos,articulo,formula,formulacion
long indice1,total1,indice2,total2,indice3,total3,total9
int coincidencias,indice0


//SELECT COUNT(MP) COINCIDENCIAS,FORMULACION
//FROM PRODDETFORMULA
//WHERE EMPRESA = "1"
//AND  MP IN("1","4","13","A","999")
//GROUP BY FORMULACION
//HAVING COUNT(MP) = 5;
//

indice0 = 1
total1 = apartados.pagina_2.dw_pagina2.rowcount()

if total1 > 0 then
	for indice1 = 1 to total1
		if indice1 = 1 then
			articulos = "'"+apartados.pagina_2.dw_pagina2.getitemstring(1,"mp")+"'"
		else
			articulos = articulos+",'"+apartados.pagina_2.dw_pagina2.getitemstring(1,"mp")+"'"
		end if
	next
	
	formula = apartados.pagina_1.dw_pagina1.getitemstring(1,"formula")
	sel1 ="select distinct(formulacion) from proddetformula "+&
			"where mp 	in ("+articulos+") and "+&
			"formulacion <> '"+formula+"'"
//	D_form = f_cargar_cursor(sel1)
	f_cargar_cursor_nuevo(sel1, d_form)
	total2 = D_form.rowcount()
	if total2 > 0 then
		for indice2 = 1 to total2
			formulacion = D_form.getitemstring(indice2,"formulacion")
			sel2 ="select mp from proddetformula "+&
					"where formulacion ='"+formulacion+"'"
//			D_linform = f_cargar_cursor(sel2)
			f_cargar_cursor_nuevo(sel2, d_linform)
			total3 = D_linform.rowcount()
			if total3 = total1 then
				coincidencias = 0
				for indice3 = 1 to total3
					articulo = apartados.pagina_2.dw_pagina2.getitemstring(indice3,"mp")
					if D_linform.Find ("mp = '"+articulo+"'", 1, total3) > 0 then
						coincidencias = coincidencias + 1
					end if
				next
				if coincidencias = total3 then
					resultado[indice0] = formulacion
					indice0 = indice0 + 1
					if indice0 > 50 then
						indice0 = 50
					end if
				end if
			end if 
		next
	end if
end if

destroy d_linform

if indice0 > 1 then
	if indice0 < 50 then
		for indice1 = indice0+1 to 50
			resultado[indice1] = resultado[indice0]
		next
	end if
	return true
else
	return false
end if

end function

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Formulaciones"

This.title = istr_parametros.s_titulo_ventana

apartados.pagina_1.dw_pagina1.SetTransObject(sqlca)
apartados.pagina_2.dw_pagina2.SetTransObject(sqlca)
dw_listado_imprimir.SetTransObject(sqlca)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	formula_estandar=istr_parametros.s_argumentos[3]
	metros2_pieza=Dec(istr_parametros.s_argumentos[4])
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		apartados.pagina_1.dw_pagina1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

em_fecha_listado.text = String(Today(),"dd-mm-yy")
end event

on wi_mant_formulaciones.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_3=create gb_3
this.rb_laboratorio=create rb_laboratorio
this.rb_produccion=create rb_produccion
this.st_texto=create st_texto
this.dw_coste_mp_por_familia=create dw_coste_mp_por_familia
this.cb_1=create cb_1
this.pb_1=create pb_1
this.rb_formula_actual=create rb_formula_actual
this.rb_formula_listado=create rb_formula_listado
this.em_fecha_listado=create em_fecha_listado
this.dw_listado_imprimir=create dw_listado_imprimir
this.cb_2=create cb_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.rb_laboratorio
this.Control[iCurrent+4]=this.rb_produccion
this.Control[iCurrent+5]=this.st_texto
this.Control[iCurrent+6]=this.dw_coste_mp_por_familia
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.rb_formula_actual
this.Control[iCurrent+10]=this.rb_formula_listado
this.Control[iCurrent+11]=this.em_fecha_listado
this.Control[iCurrent+12]=this.dw_listado_imprimir
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.gb_2
end on

on wi_mant_formulaciones.destroy
call super::destroy
destroy(this.pb_calculadora)
destroy(this.gb_3)
destroy(this.rb_laboratorio)
destroy(this.rb_produccion)
destroy(this.st_texto)
destroy(this.dw_coste_mp_por_familia)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.rb_formula_actual)
destroy(this.rb_formula_listado)
destroy(this.em_fecha_listado)
destroy(this.dw_listado_imprimir)
destroy(this.cb_2)
destroy(this.gb_2)
end on

event ue_recuperar;string mp_equivalente

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]
tabla[1]         = "prodformula"

apartados.pagina_1.dw_pagina1.Retrieve(codigo_empresa,sle_valor.Text)
//apartados.pagina_3.dw_pagina3.Retrieve(codigo_empresa,sle_valor.Text)
apartados.pagina_2.dw_pagina2.Retrieve(codigo_empresa,sle_valor.Text)
//apartados.pagina_2.dw_primas.Retrieve(codigo_empresa,sle_valor.Text)

//if apartados.pagina_1.dw_pagina1.rowcount() > 0 then
//	mp_equivalente = apartados.pagina_1.dw_pagina1.object.mp_equivalente[1]
//	if isnull(mp_equivalente) then mp_equivalente = ""
//	
//	if trim(mp_equivalente) <> "" then
//		apartados.pagina_2.dw_pagina2.enabled   = false
//		apartados.pagina_2.cb_insertar2.enabled = false
//		apartados.pagina_2.cb_borrar2.enabled   = false
//	else
//		apartados.pagina_2.dw_pagina2.enabled   = true
//		apartados.pagina_2.cb_insertar2.enabled = true
//		apartados.pagina_2.cb_borrar2.enabled   = true		
//	end if
//else
	apartados.pagina_2.dw_pagina2.enabled   = true
	apartados.pagina_2.cb_insertar2.enabled = true
	apartados.pagina_2.cb_borrar2.enabled   = true		
//end if
CALL Super::ue_recuperar
end event

event ue_inserta_fila;call super::ue_inserta_fila;apartados.pagina_1.dw_pagina1.setitem(dw_pag1.getrow(),"empresa",codigo_empresa)
apartados.pagina_1.dw_pagina1.setitem(dw_pag1.getrow(),"formula",sle_valor.text)
apartados.pagina_1.dw_pagina1.setitem(dw_pag1.getrow(),"mp_equivalente","") 
apartados.pagina_1.dw_pagina1.object.fecha_alta[apartados.pagina_1.dw_pagina1.getrow()] = today()

long i

for i=1 to apartados.pagina_2.dw_pagina2.rowcount()
	apartados.pagina_2.dw_pagina2.setitem(1,"empresa",codigo_empresa)
	apartados.pagina_2.dw_pagina2.setitem(1,"formulacion",sle_valor.text)	
next
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

event ue_valores;call super::ue_valores;pag1 = TRUE
pag2 = TRUE
//pag3 = TRUE

pag_act1 = TRUE
pag_act2 = TRUE
//pag_act3 = FALSE


prin_pag1 = TRUE
prin_pag2 = TRUE
//prin_pag3 = TRUE
end event

event ue_borra_fila;pag_act2 = False

delete from proddetformula
where empresa    = :codigo_empresa
and  formulacion = :sle_valor.text;

if sqlca.sqlcode <> 0 then
	rollback;
	messagebox("Error","Atención "+nombre_usuario+"~nSe ha producido un error al borrar el detalle de la formula.")
else
//	delete from prodformula
//	where empresa = :codigo_empresa
//	and   formula = :sle_valor.text;
//	
//	if sqlca.sqlcode <> 0 then
//		rollback;
//		messagebox("Error","Atención "+nombre_usuario+"~nSe ha producido un error al borrar la formula.")
//	else
//	   commit;
//		sle_valor.text = ""
//		sle_valor.triggerevent("modificado")
//	end if
	call super::ue_borra_fila
end if
pag_act2 =True
end event

event close;call super::close;
String codigo

codigo = (sle_valor.text)
Message.StringParm = sle_valor.text



Dec resultado_gramaje
if formula_estandar = '1' then
	//if apartados.pagina_2.dw_pagina2.getrow() > 0 then
	resultado_gramaje = (Dec(apartados.pagina_2.dw_pagina2.object.gramaje_m2[1]) * metros2_pieza)
	Message.DoubleParm = resultado_gramaje
end if

end event

type cb_salir from wc_mantenimientos_tab`cb_salir within wi_mant_formulaciones
integer x = 4375
integer y = 204
integer taborder = 70
end type

event cb_salir::clicked;//gramaje_festandar
Call Super::Clicked
end event

type cb_borrar from wc_mantenimientos_tab`cb_borrar within wi_mant_formulaciones
integer x = 3968
integer y = 204
integer taborder = 80
end type

event cb_borrar::clicked;long cuantos

select count(formulacion) into :cuantos from proddetartic
where empresa = :codigo_empresa 
and formulacion = :sle_valor.text;

if cuantos <> 0 and not (IsNull(cuantos)) then
	messagebox("Atención","No  es  posible  borrar  una formula~nque esta incluida en la composición~nde uno o más articulos")
else
	Call Super::clicked
end if
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within wi_mant_formulaciones
integer x = 3561
integer y = 204
integer taborder = 90
end type

event cb_insertar::clicked;long   i, bien, total
string var_mp
dec{6} coste_formula 


//if apartados.pagina_1.dw_pagina1.object.activa_en_produccion[1] = 'N' then
	
	if cb_insertar.enabled = TRUE then
		if apartados.pagina_2.dw_pagina2.rowcount()=0 then
			messagebox("Introducción de Productos","Introduzca un Producto")
			return
		else		
			bien = 0
			total = apartados.pagina_2.dw_pagina2.rowcount()
			if total = 1 then
				var_mp = apartados.pagina_2.dw_pagina2.object.mp[1]
				if isnull(var_mp) then 
					var_mp = ""
				end if
				apartados.pagina_1.dw_pagina1.object.mp_equivalente[1] = trim(var_mp)
			end if
			
	
			for i=1 to total
				apartados.pagina_2.dw_pagina2.object.proddetformula_coste_mp[i] = apartados.pagina_2.dw_pagina2.object.coste_mp[i]
				apartados.pagina_2.dw_pagina2.accepttext()		
				
				if apartados.pagina_2.dw_pagina2.getitemstring(i,"nom_proveedor") = "" then
					messagebox("Introducción de Productos","Proveedor Inexistente, no se puede calcular el coste de la fórmula. " )
					bien = 1
					//exit
				end if
			next
			if bien = 1 then return
		end if
	end if
	
	
	// Añado el cáculo del coste de la oper. de los artículos que utilizan esa fórmula. David 29-09-06
	if apartados.pagina_2.dw_pagina2.rowcount() > 0 then
		connect using sqlca;
		coste_formula = apartados.pagina_2.dw_pagina2.object.coste_formula[1]
		
		update prodformula 
		set coste_kg_formula = :coste_formula
		where empresa = :codigo_empresa
		and formula = :sle_valor.text;
		
		st_texto.text = "Calculando coste por operación ..."
		f_recalculo_coste_mp_operacion (sle_valor.text) 
		st_texto.text = ''
		commit using sqlca;
	end if
	Call Super::clicked
//else
//	messagebox("Atención!", "No se puede grabar una fórmula activa en producción")
//end if

end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within wi_mant_formulaciones
integer x = 1509
integer y = 120
integer taborder = 100
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within wi_mant_formulaciones
integer width = 4745
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19474154
long backcolor = 16777215
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within wi_mant_formulaciones
integer x = 265
integer y = 184
integer width = 302
end type

event sle_valor::getfocus;call super::getfocus;
//if rb_laboratorio.checked then
//	ue_datawindow  = "dw_ayuda_prodformulaciones_laboratorio"
//else
//	ue_datawindow  = "dw_ayuda_prodformulaciones_produccion"
//end if
ue_datawindow  = "dw_ayuda_prodformulaciones"

ue_titulo      = "AYUDA SELECCION DE FORMULACIONES"
ue_filtro      =""

IF istr_parametros.i_nargumentos>1 THEN
	
	  sle_valor.text=istr_parametros.s_argumentos[2]
 	  istr_parametros.i_nargumentos = 0
       	  
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
			This.TriggerEvent("modificado")
			Parent.TriggerEvent("ue_recuperar")
     END IF  
  	  		
END IF
end event

type st_1 from wc_mantenimientos_tab`st_1 within wi_mant_formulaciones
integer x = 27
integer y = 188
end type

type apartados from wc_mantenimientos_tab`apartados within wi_mant_formulaciones
integer x = 23
integer y = 348
integer width = 4741
integer height = 1824
fontcharset fontcharset = ansi!
end type

event apartados::selectionchanged;call super::selectionchanged;//if newindex = 3 then
//	apartados.pagina_3.dw_pagina3.Retrieve(codigo_empresa,sle_valor.Text)
//end if
end event

event apartados::pulsar_datawindow;call super::pulsar_datawindow;similares_comprobados = false
end event

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 4704
integer height = 1696
string text = "Formulación"
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 503
integer y = 136
integer width = 2967
integer height = 932
string dataobject = "dw_prodformulaciones"
boolean border = true
end type

event dw_pagina1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_texturas"

CHOOSE CASE f_objeto_datawindow(This)
	
	CASE "pb_unidad"
		lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"unidad_coste")
		OpenWithParm(w_mant_comunimedida,lstr_param)  
	
END CHOOSE
end event

event dw_pagina1::key;String desc_formula
long existe

bus_filtro=""
valor_empresa = TRUE	
bus_titulo=""
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "empleado"
		bus_datawindow = "dw_ayuda_empleados"
		bus_titulo = "VENTANA SELECCION DE EMPLEADOS"
		bus_filtro      =""		
		valor_empresa = true
	CASE "textura"
		bus_datawindow = "dw_ayuda_texturas"
		bus_titulo = "VENTANA SELECCION DE TEXTURAS"
		bus_filtro      =""		
		valor_empresa = false
	CASE "unidad_coste"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::key
end event

event dw_pagina1::rbuttondown;call super::rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "empleado"
 		bus_datawindow = "dw_ayuda_empleados"
		bus_titulo = "VENTANA SELECCION DE EMPLEADOS"
		bus_filtro      =""		
		valor_empresa = true
	CASE "textura"
 		bus_datawindow = "dw_ayuda_texturas"
		bus_titulo = "VENTANA SELECCION DE TEXTURAS"
		bus_filtro      =""		
		valor_empresa = false
	CASE "unidad_coste"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::key
end event

event dw_pagina1::itemchanged;string desc_formula 
long   existe

if trim(data) <> "" then
	CHOOSE CASE dwo.name	
		CASE "descripcion_laboratorio"
			
			desc_formula = data
			
			select count(*)
			into :existe
			from prodformula
			where empresa               = :codigo_empresa
			and descripcion_laboratorio = :desc_formula;
			
			if isnull(existe) then existe = 0
			if existe > 0 then
				messagebox("Atención "+nombre_usuario,"Existen formulas con esta descripción")
			end if
			
		CASE "descripcion_produccion"
			
			desc_formula = data
			
			select count(*)
			into   :existe
			from   prodformula
			where  empresa               = :codigo_empresa
			and    descripcion_produccion = :desc_formula;
			
			if isnull(existe) then existe = 0
			if existe > 0 then
				messagebox("Atención "+nombre_usuario,"Existen formulas con esta descripción")
			end if
			
	end choose
end if
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 4704
integer height = 1696
string text = "Componentes"
cb_insertar2 cb_insertar2
cb_borrar2 cb_borrar2
end type

on pagina_2.create
this.cb_insertar2=create cb_insertar2
this.cb_borrar2=create cb_borrar2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_insertar2
this.Control[iCurrent+2]=this.cb_borrar2
end on

on pagina_2.destroy
call super::destroy
destroy(this.cb_insertar2)
destroy(this.cb_borrar2)
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 0
integer y = 4
integer width = 4672
integer height = 1692
string dataobject = "dw_proddetalleformulas"
boolean vscrollbar = true
boolean border = true
end type

event dw_pagina2::key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "mp"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_venmprima"
		bus_titulo = "VENTANA SELECCION DE PRODUCTOS"
	CASE "proveedor"
		bus_filtro     = "comartpro_mprima = '"+this.GetItemString(this.GetRow(),"mp")+"'" 	
		//bus_filtro = ""
		bus_datawindow = "dw_ayuda_comartpro"
		//bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo     = "AYUDA SELECCION PROVEEDORES"		
		
	CASE "unidad_u_m_mp"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event dw_pagina2::rbuttondown;bus_filtro = ""
bus_titulo = ""
bus_datawindow = ""
bus_campo  = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "mp"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_venmprima"
		bus_titulo = "VENTANA SELECCION DE PRODUCTOS"
	CASE "proveedor"
		bus_filtro     = "comartpro_mprima = '"+this.GetItemString(this.GetRow(),"mp")+"'" 	
		//bus_filtro = ""
		bus_datawindow = "dw_ayuda_comartpro"
		//bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo     = "AYUDA SELECCION PROVEEDORES"	
	CASE "unidad_u_m_mp"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown

end event

event dw_pagina2::ue_valores;call super::ue_valores;ue_marca_linea = True
end event

event dw_pagina2::itemchanged;this.accepttext()
this.object.proddetformula_coste_mp[row] = this.object.coste_mp[row]

if dwo.name = "mp" then
	this.object.proveedor[row]  = ''
end if
	
/*
string mp,unidad_alternativa,unidad_mp
dec{4} factor_corrector, cantidad_mp,cantidad_gr_mp,densidad

if dwo.name = "cantidad_u_m_mp" or dwo.name = "mp" or dwo.name = "unidad_u_m_mp" then
	mp = this.object.mp[row]
	unidad_mp = f_unimedida_mprima(codigo_empresa,mp)
	
	unidad_alternativa = this.object.unidad_u_m_mp[row]
	if isnull(mp) then mp = ""
	if trim(mp) <> "" then
		factor_corrector = f_equivalencia_kg_mp(codigo_empresa,mp)
		densidad        = f_densidad_mp(codigo_empresa,mp)
	else
		factor_corrector = 1
	end if
	cantidad_mp = dec(this.object.cantidad_u_m_mp[row])
	if isnull(cantidad_mp) then cantidad_mp = 0
	
	// Sólo funciona cuando la unidad origen son kg
	
	choose case unidad_alternativa
		case "kg"
			//Kilogramos
			cantidad_gr_mp = cantidad_mp * 1000	* factor_corrector			
		case "lt"
			//Litros
			cantidad_gr_mp = cantidad_mp * densidad * factor_corrector			
		case else
			//Gramos
			cantidad_gr_mp = cantidad_mp * factor_corrector			
	end choose
	this.object.cantidad[row] = cantidad_gr_mp
end if
*/
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 4704
integer height = 1696
string text = "Componentes/Kg"
end type

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 27
integer y = 12
integer width = 3017
integer height = 1156
string dataobject = "dw_proddetalleformulas_kg"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_pagina3::clicked;call super::clicked;if f_objeto_datawindow(this) = "boton_ver_coste" then
	if ver_coste then
		if f_pedir_clave("3") then 
	 	 	this.Modify("texto_coste.visible = 1")
		 	this.Modify("s_coste.visible = 1")	
		 	this.Modify("coste_total_s.visible = 1")	
		 	this.Modify("boton_ver_coste.text = 'Ocultar Coste'")
			ver_coste = false
		end if
	else
 	 	 this.Modify("texto_coste.visible = 0")
		 this.Modify("s_coste.visible = 0")	
		 this.Modify("coste_total_s.visible = 0")	
		 this.Modify("boton_ver_coste.text = 'Ver Coste'")
		 ver_coste = true
	end if
	
end if

end event

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer width = 4704
integer height = 1696
end type

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
end type

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 4704
integer height = 1696
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
end type

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 4704
integer height = 1696
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
end type

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 4704
integer height = 1696
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
end type

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 4704
integer height = 1696
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
end type

type cb_insertar2 from u_boton within pagina_2
integer x = 3227
integer y = 1552
integer width = 265
integer height = 84
integer taborder = 11
boolean bringtotop = true
string text = "Añadir"
end type

event clicked;wc_index = 2
apartados.TriggerEvent("pulsar_datawindow")

long donde
donde=dw_pag2.insertrow(0)
dw_pag2.setitem(donde,"empresa",codigo_empresa)
dw_pag2.setitem(donde,"formulacion",sle_valor.text)
dw_pag2.setfocus()
dw_pag2.setrow(donde)
dw_pag2.setcolumn("mp")

end event

type cb_borrar2 from u_boton within pagina_2
integer x = 3497
integer y = 1552
integer width = 265
integer height = 84
integer taborder = 11
boolean bringtotop = true
string text = "Borrar"
end type

event clicked;wc_index = 2
apartados.TriggerEvent("pulsar_datawindow")

dw_pag2.deleterow(dw_pag2.getrow())
end event

type pb_calculadora from u_calculadora within wi_mant_formulaciones
integer x = 571
integer y = 180
integer width = 114
integer height = 92
integer taborder = 60
boolean originalsize = false
end type

event clicked;long registros,nuevo_registro

IF cb_insertar.enabled = TRUE THEN Return
 
 Select count(*) Into :registros
 From   prodformula
 Where  prodformula.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,prodformula.formula)+1)
  Into   :nuevo_registro
  From   prodformula
  Where  prodformula.empresa = :codigo_empresa;
  
  sle_valor.text = string(nuevo_registro)
END IF
apartados.pagina_1.dw_pagina1.triggerEvent("clicked")
  
end event

type gb_3 from groupbox within wi_mant_formulaciones
integer x = 3552
integer y = 172
integer width = 1239
integer height = 132
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type rb_laboratorio from radiobutton within wi_mant_formulaciones
integer x = 722
integer y = 180
integer width = 507
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Buscar Laboratorio"
end type

type rb_produccion from radiobutton within wi_mant_formulaciones
integer x = 722
integer y = 228
integer width = 507
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Buscar Producción"
boolean checked = true
end type

type st_texto from statictext within wi_mant_formulaciones
integer x = 2949
integer y = 88
integer width = 1243
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 65535
long backcolor = 12632256
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_coste_mp_por_familia from datawindow within wi_mant_formulaciones
boolean visible = false
integer x = 5
integer y = 980
integer width = 4261
integer height = 1856
integer taborder = 30
boolean dragauto = true
boolean bringtotop = true
string title = "none"
string dataobject = "dw_coste_mp_por_familia"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_1 from commandbutton within wi_mant_formulaciones
boolean visible = false
integer x = 1248
integer y = 164
integer width = 558
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Coste por familia"
end type

event clicked;dw_coste_mp_por_familia.visible = true
dw_coste_mp_por_familia.SetTransObject(SQLCA)
dw_coste_mp_por_familia.retrieve( codigo_empresa, datetime(date('01-01-2008')), datetime(date('31-01-2008')))
end event

type pb_1 from picturebutton within wi_mant_formulaciones
integer x = 2725
integer y = 172
integer width = 146
integer height = 128
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
alignment htextalign = left!
end type

event clicked;if rb_formula_actual.checked then
	f_imprimir_datawindow(apartados.pagina_2.dw_pagina2)
else
	dw_listado_imprimir.retrieve(Datetime(em_fecha_listado.text))
	f_imprimir_datawindow(dw_listado_imprimir)
end if

end event

type rb_formula_actual from radiobutton within wi_mant_formulaciones
integer x = 1874
integer y = 148
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Esta Fórmula"
boolean checked = true
end type

event clicked;rb_formula_actual.checked = true
rb_formula_listado.checked = false
end event

type rb_formula_listado from radiobutton within wi_mant_formulaciones
integer x = 1874
integer y = 228
integer width = 430
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Listado desde"
end type

event clicked;rb_formula_actual.checked = false
rb_formula_listado.checked = true
end event

type em_fecha_listado from editmask within wi_mant_formulaciones
integer x = 2350
integer y = 204
integer width = 311
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean dropdowncalendar = true
end type

type dw_listado_imprimir from datawindow within wi_mant_formulaciones
boolean visible = false
integer x = 4073
integer y = 48
integer width = 242
integer height = 252
integer taborder = 30
boolean bringtotop = true
string dataobject = "dwtc_listado_prodformulas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within wi_mant_formulaciones
integer x = 1271
integer y = 176
integer width = 549
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Duplicar Fórmula"
end type

event clicked;str_colisiones param_colisiones
str_param_transaccion param_transaccion
transaction transaccion
string codigo
int rtn
datetime fecha_alta

if sle_valor.text <> "" then

	fecha_alta = datetime (today())
	
	param_colisiones.empresa = codigo_empresa
	param_colisiones.tabla = "prodformula"
	param_colisiones.campo = "formula"
	param_colisiones.filtro = ""
	param_colisiones.buscar_huecos = false
	
	setnull(param_transaccion.dbms)
	setnull(param_transaccion.database)
	setnull(param_transaccion.servername)
	setnull(param_transaccion.logid)
	setnull(param_transaccion.userid)
	setnull(param_transaccion.logpass)
	setnull(param_transaccion.autocommit)
	setnull(param_transaccion.lock)
	setnull(param_transaccion.dbparm)
	
	param_transaccion.lock = "TS"
	
	rtn = 1
	
	ftc_crear_transaccion (transaccion, param_transaccion)
	CONNECT USING transaccion;
	
	codigo = String(f_colisiones ( transaccion, param_colisiones))
	
	if isnull(codigo) OR codigo = '0'  then
		messagebox("ERROR", "No se puede asignar un código.")
		rtn = -1
		ROLLBACK USING transaccion;
		DISCONNECT USING transaccion;
	else
		rtn = 1
	//	sle_valor.text = String(Long(codigo))
	
		//  AQUÍ HAREMOS EL DUPLICADO DE TODOS LOS DATOS DE LA FÓRMULA
		
		INSERT INTO prodformula ( 
			 empresa
			,formula
			,descripcion_produccion
			,descripcion_laboratorio
			,fecha_alta
			,empleado
			,paletacolor
			,colorimetro
			,coste_kg_formula
			,textura
			,activa_en_produccion
			,mp_equivalente
			,referencia_general
			,unidad_coste
			,L
			,A
			,B )
		SELECT empresa
			,:codigo
			,descripcion_produccion
			,descripcion_laboratorio
			,:fecha_alta
			,empleado
			,paletacolor
			,colorimetro
			,coste_kg_formula
			,textura
			,'N'
			,mp_equivalente
			,referencia_general
			,unidad_coste
			,0
			,0
			,0
		FROM prodformula
		WHERE formula = :sle_valor.text USING transaccion;
		
		IF SQLCA.SQLCode = -1 THEN 
			MessageBox("SQL error", SQLCA.SQLErrText)
			rtn = -1
		END IF
	
		if rtn = 1 then
			INSERT INTO proddetformula (
				 empresa
				,formulacion
				,mp
				,cantidad
				,unidadmedida
				,proveedor
				,cantidad_u_m_mp
				,unidad_u_m_mp
				,coste_mp )
			SELECT empresa
				,:codigo
				,mp
				,cantidad
				,unidadmedida
				,proveedor
				,cantidad_u_m_mp
				,unidad_u_m_mp
				,coste_mp
			FROM proddetformula
			WHERE formulacion = :sle_valor.text USING transaccion;
			
			IF SQLCA.SQLCode = -1 THEN 
				MessageBox("SQL error", SQLCA.SQLErrText)
				rtn = -1
			END IF
		end if
	
		//  FIN DEL DUPLICADO DE TODOS LOS DATOS DE LA FÓRMULA
	end if
	
	IF rtn = 1 THEN
		sle_valor.text = codigo
		COMMIT USING transaccion;
	ELSE
		ROLLBACK USING transaccion;
	END IF
	DISCONNECT USING transaccion;
	
	destroy transaccion
else
	messagebox("Atención", "Debe intoducir una fórmula para poder duplicar")
end if

/*

string a

select * 
into :a
from prodformulaciones
where empresa = :codigo_empresa
and fromula = :sle_valor.text;
*/
end event

type gb_2 from groupbox within wi_mant_formulaciones
integer x = 1851
integer y = 84
integer width = 1047
integer height = 228
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Impresión"
end type

