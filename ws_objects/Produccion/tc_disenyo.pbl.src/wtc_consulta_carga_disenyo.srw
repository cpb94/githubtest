$PBExportHeader$wtc_consulta_carga_disenyo.srw
forward
global type wtc_consulta_carga_disenyo from wt_consultas_padre
end type
type dw_imagen from u_dw_imagen within wtc_consulta_carga_disenyo
end type
type dw_carga from u_datawindow within wtc_consulta_carga_disenyo
end type
type dw_carga_clientes from datawindow within wtc_consulta_carga_disenyo
end type
type dw_archivo from u_dw within wtc_consulta_carga_disenyo
end type
type st_1 from statictext within wtc_consulta_carga_disenyo
end type
type st_2 from statictext within wtc_consulta_carga_disenyo
end type
type pb_imprimir2 from picturebutton within wtc_consulta_carga_disenyo
end type
type gb_1 from groupbox within wtc_consulta_carga_disenyo
end type
end forward

global type wtc_consulta_carga_disenyo from wt_consultas_padre
integer width = 5637
integer height = 3780
string title = "Carga de Trabajos de Diseño"
dw_imagen dw_imagen
dw_carga dw_carga
dw_carga_clientes dw_carga_clientes
dw_archivo dw_archivo
st_1 st_1
st_2 st_2
pb_imprimir2 pb_imprimir2
gb_1 gb_1
end type
global wtc_consulta_carga_disenyo wtc_consulta_carga_disenyo

type variables
string sql_inicial
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public subroutine f_carga ()
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje, montaje2, montaje3
int j

montaje = ''
montaje2 =	" SELECT trabajo_archivo.empresa,   "+&
				" 		trabajo_archivo.codigo,   "+&
				" 		trabajo_archivo.descripcion,   "+&
				" 		trabajo_archivo.tecnico_dis,   "+&
				" 		trabajo_archivo.numero_modelos,   "+&
				" 		trabajo_archivo.fecha_necesidad,   "+&
				" 		tecnico_dis.descripcion  "+&
				" FROM trabajo_archivo,   "+&
				" 		 tecnico_dis  "+&
				" WHERE ( trabajo_archivo.empresa = tecnico_dis.empresa ) and  "+&
				" 		  ( trabajo_archivo.tecnico_dis = tecnico_dis.codigo ) and  "+&
				" 		  ( ( trabajo_archivo.empresa = '"+codigo_empresa+"' ) )"
				
montaje3 =	"   SELECT genter.razon,   "+&
				" 		COUNT(*) AS trabajos,   "+&
				" 		SUM(numero_piezas) as piezas  "+&
				"   FROM modelo_trabajo LEFT OUTER JOIN tecnico_dis ON modelo_trabajo.empresa = tecnico_dis.empresa AND modelo_trabajo.tecnico_dis = tecnico_dis.codigo LEFT OUTER JOIN comercial ON modelo_trabajo.empresa = comercial.empresa AND modelo_trabajo.comercial = comercial.codigo,   "+&
				" 		genter,   "+&
				" 		modelo_propuesta  "+&
				" 	 WHERE ( modelo_trabajo.empresa = genter.empresa ) and  "+&
				" 		( modelo_trabajo.cliente = genter.codigo ) and  "+&
				" 		( modelo_trabajo.empresa = modelo_propuesta.empresa ) and  "+&
				" 		( modelo_trabajo.modelo = modelo_propuesta.modelo ) and  "+&
				" 		( modelo_trabajo.cliente = modelo_propuesta.cliente ) and  "+&
				" 		( modelo_trabajo.propuesta = modelo_propuesta.codigo ) and  "+&
				" 		( ( genter.tipoter = 'C' ) AND  "+&
				" 		( modelo_trabajo.fecha_fin is null ) ) AND "+&
				" 		( ( modelo_trabajo.empresa = '"+codigo_empresa+"' ) )"
				
				

for j = 1 to dw_montaje_filtro.rowcount()
	if pos(String(dw_montaje_filtro.object.linea[j]),"Diseñador") <> 0 then
		//Filtro para trabajos archivo dw_archivo, solo afecta diseñador
		montaje2 = montaje2 +' AND '+ dw_montaje_filtro.object.filtro[j]
		montaje3 = montaje3 +' AND '+ dw_montaje_filtro.object.filtro[j]
	end if
	if montaje = '' then
		montaje = dw_montaje_filtro.object.filtro[j]
	else
		montaje = montaje +' AND '+ dw_montaje_filtro.object.filtro[j]
	end if
next
if montaje <> '' then
	montaje = consulta_inicial + " AND " + montaje
else
	montaje = consulta_inicial
end if

montaje3 = montaje3 + " 		GROUP BY genter.razon "

dw_archivo.SetSQLSelect(montaje2)
dw_archivo.retrieve()
dw_carga_clientes.SetSQLSelect(montaje3)
dw_carga_clientes.retrieve()
return montaje


end function

public subroutine f_carga ();Datastore disenyadores
String sel, disenyador, disenyador_nombre
Long fila, i, trabajos_cliente, trabajos_tencer, trabajos_archivo, piezas_totales, piezas_parcial

// CARGA TOTAL
dw_carga.setredraw(false)
dw_carga.reset()
sel = "SELECT tecnico_dis.codigo, tecnico_dis.descripcion "+&
		"FROM tecnico_dis "+&
		"WHERE tecnico_dis.empresa = '"+codigo_empresa+"' AND activo = 'S'"+&
		"ORDER BY tecnico_dis.descripcion"
		
f_cargar_cursor_trans (SQLCA,  sel,  disenyadores)
i = 1
do while (i <= disenyadores.RowCount()) 
	disenyador = disenyadores.object.codigo[i]
	disenyador_nombre = disenyadores.object.descripcion[i]
	trabajos_cliente = 0
	trabajos_tencer = 0
	trabajos_archivo = 0
	piezas_totales = 0
	
	SELECT COUNT(*) INTO :trabajos_cliente FROM modelo_trabajo 
	WHERE modelo_trabajo.empresa = :codigo_empresa AND modelo_trabajo.tecnico_dis = :disenyador AND modelo_trabajo.fecha_fin IS NULL;
	/*
	SELECT COUNT(*) INTO :trabajos_cliente FROM modelo_trabajo 
	WHERE modelo_trabajo.empresa = :codigo_empresa AND modelo_trabajo.tecnico_dis = :disenyador AND modelo_trabajo.fecha_fin IS NULL AND modelo_trabajo.cliente <> '87';
	
	SELECT COUNT(*) INTO :trabajos_tencer FROM modelo_trabajo 
	WHERE modelo_trabajo.empresa = :codigo_empresa AND modelo_trabajo.tecnico_dis = :disenyador AND modelo_trabajo.fecha_fin IS NULL AND modelo_trabajo.cliente = '87';
	*/
	SELECT COUNT(*) INTO :trabajos_archivo FROM trabajo_archivo 
	WHERE trabajo_archivo.empresa = :codigo_empresa AND trabajo_archivo.tecnico_dis = :disenyador;
	
	piezas_parcial = 0
	SELECT SUM(ISNULL(modelo_propuesta.numero_piezas, 0)) INTO :piezas_parcial FROM modelo_trabajo INNER JOIN modelo_propuesta ON modelo_trabajo.empresa = modelo_propuesta.empresa AND modelo_trabajo.modelo = modelo_propuesta.modelo AND modelo_trabajo.cliente = modelo_propuesta.cliente AND modelo_trabajo.propuesta = modelo_propuesta.codigo 
	WHERE modelo_trabajo.empresa = :codigo_empresa AND modelo_trabajo.tecnico_dis = :disenyador AND modelo_trabajo.fecha_fin IS NULL AND modelo_trabajo.cliente <> '87';
	if isnull(piezas_parcial) then 
		piezas_parcial = 0
	end if
	piezas_totales = piezas_totales + piezas_parcial
	
	piezas_parcial = 0
	SELECT SUM(ISNULL(modelo_propuesta.numero_piezas, 0)) INTO :piezas_parcial FROM modelo_trabajo INNER JOIN modelo_propuesta ON modelo_trabajo.empresa = modelo_propuesta.empresa AND modelo_trabajo.modelo = modelo_propuesta.modelo AND modelo_trabajo.cliente = modelo_propuesta.cliente AND modelo_trabajo.propuesta = modelo_propuesta.codigo 
	WHERE modelo_trabajo.empresa = :codigo_empresa AND modelo_trabajo.tecnico_dis = :disenyador AND modelo_trabajo.fecha_fin IS NULL AND modelo_trabajo.cliente = '87';
	if isnull(piezas_parcial) then 
		piezas_parcial = 0
	end if
	piezas_totales = piezas_totales + piezas_parcial
	
	piezas_parcial = 0
	SELECT SUM(ISNULL(trabajo_archivo.numero_modelos, 0)) INTO :piezas_parcial FROM trabajo_archivo 
	WHERE trabajo_archivo.empresa = :codigo_empresa AND trabajo_archivo.tecnico_dis = :disenyador;
	if isnull(piezas_parcial) then 
		piezas_parcial = 0
	end if
	piezas_totales = piezas_totales + piezas_parcial
	
	//if trabajos_cliente + trabajos_archivo > 0 then
		fila = dw_carga.insertrow(0)
		dw_carga.object.tecnico_dis[fila] = disenyador_nombre
		dw_carga.object.trabajos_cliente[fila] = trabajos_cliente
		dw_carga.object.trabajos_tencer[fila] = trabajos_tencer
		dw_carga.object.trabajos_archivo[fila] = trabajos_archivo
		dw_carga.object.piezas[fila] = piezas_totales
	//end if
	i++	
loop

dw_carga.setsort("total DESC")
dw_carga.sort()
dw_carga.setredraw(true)

Destroy disenyadores
end subroutine

on wtc_consulta_carga_disenyo.create
int iCurrent
call super::create
this.dw_imagen=create dw_imagen
this.dw_carga=create dw_carga
this.dw_carga_clientes=create dw_carga_clientes
this.dw_archivo=create dw_archivo
this.st_1=create st_1
this.st_2=create st_2
this.pb_imprimir2=create pb_imprimir2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagen
this.Control[iCurrent+2]=this.dw_carga
this.Control[iCurrent+3]=this.dw_carga_clientes
this.Control[iCurrent+4]=this.dw_archivo
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.pb_imprimir2
this.Control[iCurrent+8]=this.gb_1
end on

on wtc_consulta_carga_disenyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_imagen)
destroy(this.dw_carga)
destroy(this.dw_carga_clientes)
destroy(this.dw_archivo)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.pb_imprimir2)
destroy(this.gb_1)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_archivo.SetTransObject(SQLCA);
dw_carga_clientes.SetTransObject(SQLCA);
dw_carga_clientes.retrieve()
		
sql_inicial = "  SELECT DISTINCT modelo_trabajo.modelo,     "+&
         " modelo.coleccion,     "+&
         " modelo_trabajo.propuesta,     "+&
         " modelo_trabajo.codigo,     "+&
         " desserie.descripcion,     "+&
         " formatos.abreviado,     "+&
         " genter.codigo,     "+&
         " genter.razon,     "+&
         " tecnico_dis.codigo,    "+& 
         " tecnico_dis.descripcion,    "+& 
         " comercial.codigo,     "+&
         " comercial.descripcion,     "+&
         " modelo_trabajo.fecha_solicitud,     "+&
         " modelo_trabajo.fecha_necesidad,     "+&
         " tecnico_lab.codigo,     "+&
         " tecnico_lab.descripcion,    "+&
			" modelo_propuesta.numero_piezas    "+&
    " FROM modelo "+&
	 " LEFT OUTER JOIN descoleccionsol ON modelo.empresa = descoleccionsol.empresa AND modelo.coleccion = descoleccionsol.codigo     "+&
	 " LEFT OUTER JOIN tecnico_lab ON descoleccionsol.empresa = tecnico_lab.empresa AND descoleccionsol.tecnico_lab = tecnico_lab.codigo,     "+&
         " modelo_trabajo,     "+&
         " desserie,     "+&
         " formatos,     "+&
         " genter,     "+&
         " tecnico_dis,     "+&
         " comercial,     "+&
         " modelo_propuesta    "+&
   " WHERE ( modelo_trabajo.empresa = modelo.empresa ) and    "+&
         " ( modelo_trabajo.modelo = modelo.modelo ) and    "+&
         " ( modelo_trabajo.empresa = desserie.empresa ) and    "+&
         " ( modelo_trabajo.serie = desserie.codigo ) and    "+&
         " ( modelo_trabajo.empresa = genter.empresa ) and    "+&
         " ( modelo_trabajo.cliente = genter.codigo ) and    "+&
         " ( modelo_trabajo.empresa = tecnico_dis.empresa ) and    "+&
         " ( modelo_trabajo.tecnico_dis = tecnico_dis.codigo ) and    "+&
         " ( modelo_trabajo.empresa = comercial.empresa ) and    "+&
         " ( modelo_trabajo.comercial = comercial.codigo ) and    "+&
         " ( modelo_trabajo.empresa = modelo_propuesta.empresa ) and    "+&
         " ( modelo_trabajo.modelo = modelo_propuesta.modelo ) and    "+&
         " ( modelo_trabajo.cliente = modelo_propuesta.cliente ) and    "+&
         " ( modelo_trabajo.propuesta = modelo_propuesta.codigo ) and    "+&
			" ( modelo_trabajo.fecha_fin IS NULL ) and    "+&
         " ( modelo_propuesta.empresa = formatos.empresa ) and    "+&
         " ( modelo_propuesta.formato = formatos.codigo ) and    "+&
         " ( ( genter.tipoter = 'C' ) )  and   "+&
			" ( ( modelo_trabajo.empresa = '"+codigo_empresa+"' ) )  "  

f_carga()
pb_anyadir1.triggerevent(clicked!)
end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_carga_disenyo
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_carga_disenyo
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_carga_disenyo
integer x = 4795
integer y = 276
integer width = 110
integer height = 96
end type

event pb_imprimir::clicked;if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_carga_disenyo
integer x = 5120
integer y = 96
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_carga_disenyo
integer width = 3269
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_carga_disenyo
integer x = 3163
integer y = 112
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql
long fila

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)
dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 1788
	dw_montaje_filtro.height = 225
end if

dw_datos.setsort("modelo_trabajo_fecha_necesidad ASC")
dw_datos.sort()
dw_datos.setfocus()
if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if

//dw_carga_clientes.retrieve()
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_carga_disenyo
integer x = 5275
integer y = 96
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_carga_disenyo
integer x = 3013
integer y = 112
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible
string new_sql, filtro
boolean crear_filtro

String sel, disenyador, disenyador_nombre
Long trabajos_cliente, trabajos_tencer, trabajos_archivo, piezas_totales, piezas_parcial
Datastore disenyadores

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Diseñador Trabajo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " tecnico_dis.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Diseñador = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR tecnico_dis.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Comercial Trabajo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " comercial.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Comercial Trabajo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR comercial.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Técnico Modelo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " tecnico_lab.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Técnico Modelo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR tecnico_lab.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " genter.tipoter = 'C' and genter.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR genter.tipoter = 'C' and genter.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Trabajo Pasar Pieza"
			//modelo_trabajo
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' and k = 1 then
						cadena_or = " modelo_trabajo.modelo_version IS NOT NULL "
						cadena_or_visible = " PASADO A PIEZA = SI "
					elseif cadena_or = '' and k = 2 then
						cadena_or = " modelo_trabajo.modelo_version IS NULL or modelo_trabajo.modelo_version = ''"
						cadena_or_visible = " PASADO A PIEZA = NO "
					end if
			
				end if
			next
	end choose
	
	
	// Comprobamos que rellene algo en los objetos de filtro
	crear_filtro = false
	if ddlb_campo.text <> '' and ddlb_operador.text <> '' then
		if dw_filtro.visible then
			if dw_filtro.GetSelectedRow(0) >0 then
				crear_filtro = true
			end if
		end if
		if em_fecha1.visible then
			if not isnull (em_fecha1) and em_fecha1.text <> '' then
				crear_filtro = true
			end if
		end if
		if sle_valor1.visible then
			if sle_valor1.text <> '' then
				crear_filtro = true
			end if
		end if
	
		if lb_lista.visible then
			if lb_lista.selectedindex() <> -1 then
				crear_filtro = true
			end if
		end if
		
	end if
	
	if crear_filtro then
		if cadena_or <> '' then
			cadena_or = " ( "+cadena_or+" ) "
			fila = dw_montaje_filtro.insertrow(0)
			dw_montaje_filtro.object.filtro[fila] = cadena_or
			dw_montaje_filtro.object.linea[fila] = cadena_or_visible
			
			new_sql = f_montar_filtro(sql_inicial)
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		end if
	else
		new_sql = f_montar_filtro(sql_inicial)
		
	end if
	
	dw_datos.SetSQLSelect ( new_sql+" order by modelo_trabajo.fecha_necesidad " )
	dw_datos.retrieve()
	
	em_fecha1.visible = false
	sle_valor1.visible = false
	dw_filtro.visible = false
	pb_buscar.visible = false
	sle_texto.visible = false
	lb_lista.visible = false
	
	sle_texto.text = ''
	
	sle_valor1.text = ''
	dw_filtro.reset()
	ddlb_campo.selectitem(0) 
	ddlb_operador.selectitem(0) 
	
	//Para evitar solapamiento con otros datawindows
	dw_filtro.Height = 260
	
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
	end if
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
	
else
	
	new_sql = f_montar_filtro(sql_inicial)
			
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
end if

//dw_archivo.Retrieve(codigo_empresa)

f_carga()

dw_datos.setsort("modelo_trabajo_fecha_necesidad ASC")
dw_datos.sort()

//dw_carga_clientes.retrieve()


end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_carga_disenyo
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_carga_disenyo
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Diseñador Trabajo","Comercial Trabajo","Técnico Modelo","Cliente","Trabajo Pasar Pieza"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Diseñador Trabajo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_dis where activo = 'S' and empresa = '"+codigo_empresa+"' order by descripcion "
	CASE "Comercial Trabajo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from comercial where empresa = '"+codigo_empresa+"' and activo = '1' order by descripcion "
	CASE "Técnico Modelo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_lab where empresa = '"+codigo_empresa+"' order by descripcion "
	CASE "Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where tipoter = 'C' and empresa = '"+codigo_empresa+"' order by razon "
	case "Trabajo Pasar Pieza"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("SI")
		lb_lista.AddItem ("NO")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
END CHOOSE


//Creación del data window de búsqueda
new_syntax = SQLCA.SyntaxFromSQL(consulta, 'Style(Type=Grid)', error_syntaxfromSQL)

IF Len(error_syntaxfromSQL) > 0 THEN
	// Display errors
	mensaje_error = "Error en la consulta de la búsqueda. Avise al administrador."+error_syntaxfromSQL
ELSE
	// Generate new DataWindow
	dw_filtro.Create(new_syntax, error_create)
	IF Len(error_create) > 0 THEN
		mensaje_error  = "Error en la creación del DW de búsqueda. Avise al administrador."+error_create
	END IF
END IF

//dw_filtro.visible = true

dw_filtro.SetTransObject(SQLCA)
dw_filtro.Retrieve(codigo_empresa)

end event

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_carga_disenyo
integer y = 512
integer width = 5531
integer height = 1908
integer taborder = 60
string dataobject = "dwtc_consulta_carga_disenyo"
end type

event dw_datos::doubleclicked;call super::doubleclicked;Long id_ventana
str_parametros lstr_param 

if row > 0 then	
	
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(row,"modelo_trabajo_modelo")
	lstr_param.s_argumentos[2] = dw_datos.GetItemString(row,"genter_codigo")
	lstr_param.i_nargumentos = 2
	lstr_param.nombre_ventana = "wtc_con_carga_disenyo"
	lstr_param.resultado = ''
	id_ventana = f_menu_ventana_esta_abierta("wtc_trabajos_disenyo_nuevo")
	if id_ventana <> -1 then
		close(wtc_trabajos_disenyo_nuevo)
		OpenWithParm(wtc_trabajos_disenyo_nuevo, lstr_param)
	else
		OpenWithParm(wtc_trabajos_disenyo_nuevo,lstr_param)
	end if
	
end if
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;//CON RUTAS
string codigo_archivo, codigo_coleccion, modelo, ruta, tamanyo
Long min_codigo_archivo

if currentrow <= 0 then
	return
end if

SELECT tamanyo INTO :tamanyo FROM archivo_resolucion WHERE empresa = :codigo_empresa AND codigo = 1;

dw_imagen.visible = false // para evitar efectos raros en pantalla.

codigo_coleccion = dw_datos.object.modelo_coleccion[dw_datos.getrow()]
modelo = dw_datos.object.modelo_trabajo_modelo[dw_datos.getrow()]

if not isnull(codigo_coleccion) and codigo_coleccion <> "" and not isnull(modelo) and modelo <> "" then
		
	ruta = ftc_imagen_ruta("2", codigo_coleccion, modelo, "")
		
	if not isnull(ruta) and ruta <> "" then
		dw_imagen.Object.datawindow.picture.File = ruta
		dw_imagen.visible = true
	else
		dw_imagen.visible = false
	end if
else
	dw_imagen.visible = false
end if

end event

event dw_datos::clicked;call super::clicked;if row <= 0 then
	if dwo.name = "t_solicitud" then
		this.setsort("modelo_trabajo_fecha_solicitud A")
		this.sort()
	elseif dwo.name = "descoleccionsol_tecnico_lab_t" then
		this.setsort("tecnico_lab_descripcion A")
		this.sort()
	elseif dwo.name = "descoleccionsol_comercial_t" then
		this.setsort("comercial_descripcion A")
		this.sort()
	elseif dwo.name = "descoleccionsol_disenyador_t" then
		this.setsort("tecnico_dis_descripcion A")
		this.sort()
	elseif dwo.name = "t_cliente" then
		this.setsort("genter_razon A")
		this.sort()
	elseif dwo.name = "t_serie" then
		this.setsort("desserie_descripcion A")
		this.sort()
	elseif dwo.name = "t_formato" then
		this.setsort("formatos_abreviado A")
		this.sort()
	elseif dwo.name = "descoleccionsol_codigo_t" then
		this.setsort("dec(modelo_coleccion) A")
		this.sort()
	elseif dwo.name = "t_modelo" then
		this.setsort("dec(modelo_trabajo_modelo) A")
		this.sort()
	else
		this.setsort("modelo_trabajo_fecha_necesidad A")
		this.sort()
	end if
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_carga_disenyo
integer x = 5431
integer y = 96
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_carga_disenyo
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_carga_disenyo
integer x = 5074
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_carga_disenyo
integer x = 1298
integer y = 232
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_carga_disenyo
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_carga_disenyo
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_carga_disenyo
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_carga_disenyo
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_carga_disenyo
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
long textcolor = 24076881
end type

type dw_imagen from u_dw_imagen within wtc_consulta_carga_disenyo
integer x = 3346
integer y = 32
integer width = 1371
integer height = 460
integer taborder = 110
boolean bringtotop = true
end type

type dw_carga from u_datawindow within wtc_consulta_carga_disenyo
integer x = 2391
integer y = 2456
integer width = 1641
integer height = 1112
integer taborder = 100
boolean bringtotop = true
string dataobject = "dwtc_total_carga_disenyo"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
end type

event clicked;str_parametros lstr_param

If row=0 Then Return



//IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
//END IF


end event

event itemchanged;/*
string disenyador, solicitud, coleccion, pieza
long trabajo
datetime fecha

dw_1.update()
IF dwo.Name = "descoleccionsol_disenyador" THEN
	select descripcion
	into :disenyador
	from tecnico_dis
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_1.object.tecnico_dis_descripcion[row] = disenyador
END IF

IF dwo.Name = "destrabajo_fecha_necesidad" THEN
	solicitud = dw_1.object.destrabajo_solicitud[row]
	coleccion = dw_1.object.destrabajo_coleccion[row]
	pieza = dw_1.object.destrabajo_pieza[row]
	trabajo = dw_1.object.destrabajo_trabajo[row]
	fecha = dw_1.object.destrabajo_fecha_necesidad[row]
//	messagebox("", "SOLICITUD: "+SOLICITUD+"   COLECCION: "+COLECCION+&
//						"      PIEZA:"+PIEZA+ "      TRABAJO: "+STRING(TRABAJO)+"       FECHA: "+STRING(fecha))
	update destrabajo
	set fecha_necesidad = :fecha
	where empresa = :codigo_empresa
	and solicitud = :solicitud
	and coleccion = :coleccion
	and pieza = :pieza
	and trabajo = :trabajo;
	commit;
END IF

*/
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "descoleccionsol_disenyador"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "descoleccionsol_disenyador"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_carga_clientes from datawindow within wtc_consulta_carga_disenyo
integer x = 4046
integer y = 2448
integer width = 1513
integer height = 1112
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_total_carga_clientes2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_archivo from u_dw within wtc_consulta_carga_disenyo
integer x = 59
integer y = 2456
integer width = 2322
integer height = 1112
integer taborder = 70
string dataobject = "dwtc_trabajos_archivo"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;Long esta_abierta
str_parametros lstr_param 
if row > 0 then
	lstr_param.s_argumentos[1] = this.object.codigo[row]
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_consulta_carga_disenyo"
	lstr_param.resultado = ''
	esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_trabajo_archivo")
	if esta_abierta <> -1 then
		close(wtc_mant_trabajo_archivo)
		OpenWithParm(wtc_mant_trabajo_archivo,lstr_param)
	else
		OpenWithParm(wtc_mant_trabajo_archivo,lstr_param)
	end if	
end if
end event

type st_1 from statictext within wtc_consulta_carga_disenyo
integer x = 4919
integer y = 400
integer width = 640
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carga Diseñador/Cliente"
boolean focusrectangle = false
end type

type st_2 from statictext within wtc_consulta_carga_disenyo
integer x = 4923
integer y = 292
integer width = 480
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carga Trabajos"
boolean focusrectangle = false
end type

type pb_imprimir2 from picturebutton within wtc_consulta_carga_disenyo
integer x = 4795
integer y = 388
integer width = 110
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
end type

event clicked;if dw_carga.rowcount() > 0 then
	f_imprimir_datawindow(dw_carga)
end if
if dw_carga_clientes.rowcount() > 0 then
	f_imprimir_datawindow(dw_carga_clientes)
end if
end event

type gb_1 from groupbox within wtc_consulta_carga_disenyo
integer x = 4750
integer y = 204
integer width = 818
integer height = 296
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir"
end type

