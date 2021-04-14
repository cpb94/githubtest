$PBExportHeader$wtc_consulta_aplicaciones_sin_gramaje.srw
forward
global type wtc_consulta_aplicaciones_sin_gramaje from wt_consultas_padre
end type
type dw_imagen_grande from u_dw_imagen within wtc_consulta_aplicaciones_sin_gramaje
end type
type dw_datos2 from datawindow within wtc_consulta_aplicaciones_sin_gramaje
end type
end forward

global type wtc_consulta_aplicaciones_sin_gramaje from wt_consultas_padre
integer width = 5019
integer height = 3480
string title = "Consulta Laboratorio"
dw_imagen_grande dw_imagen_grande
dw_datos2 dw_datos2
end type
global wtc_consulta_aplicaciones_sin_gramaje wtc_consulta_aplicaciones_sin_gramaje

type variables
string sql_inicial, sql_auxiliar
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
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
return montaje


end function

on wtc_consulta_aplicaciones_sin_gramaje.create
int iCurrent
call super::create
this.dw_imagen_grande=create dw_imagen_grande
this.dw_datos2=create dw_datos2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagen_grande
this.Control[iCurrent+2]=this.dw_datos2
end on

on wtc_consulta_aplicaciones_sin_gramaje.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_imagen_grande)
destroy(this.dw_datos2)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_datos2.SetTransObject(SQLCA)

sql_inicial =   "SELECT art_ver_op_aplicaciones.articulo,  "+& 
       "  articulos.descripcion,   "+&
       "  articulos.fecha_alta,   "+&
       "  art_ver_op_aplicaciones.tipoaplicacion,   "+&
       "  prodaplicaciones.resumido,   "+&
       "  formatos.abreviado  "+&
     " FROM art_ver_op_aplicaciones,   "+&
        "  articulos,   "+&
         " formatos,   "+&
         " prodaplicaciones  "+&
    " WHERE ( art_ver_op_aplicaciones.empresa = articulos.empresa ) and  "+&
       	"   ( art_ver_op_aplicaciones.articulo = articulos.codigo ) and  "+&
       	"  ( articulos.empresa = formatos.empresa ) and  "+&
       	"  ( articulos.formato = formatos.codigo ) and  "+&
       	"  ( art_ver_op_aplicaciones.empresa = prodaplicaciones.empresa ) and  "+&
       	"  ( art_ver_op_aplicaciones.tipoaplicacion = prodaplicaciones.codigo )   and "+&
		"  ( gramaje is null  )"
			 
		 
		 
/*		 
and articulo in (select articulo from prodpartes_ot where fecha >= '01-01-2013')
	*/	 

end event

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_aplicaciones_sin_gramaje
integer x = 4247
integer y = 120
integer taborder = 0
end type

event pb_imprimir::clicked;f_imprimir_datawindow(dw_datos)

end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_aplicaciones_sin_gramaje
integer x = 4453
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_aplicaciones_sin_gramaje
integer width = 4891
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_aplicaciones_sin_gramaje
integer x = 4041
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
	
	//dw_imagen.height = dw_imagen.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 2328
	dw_montaje_filtro.height = 225
	
	
	//dw_imagen.height = 2328
end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_aplicaciones_sin_gramaje
integer x = 4608
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_aplicaciones_sin_gramaje
integer x = 3890
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible
string new_sql, filtro
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Aplicación"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " art_ver_op_aplicaciones.tipoaplicacion = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Aplicación = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR  art_ver_op_aplicaciones.tipoaplicacion = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 			
	
		case "Fecha Partes"
			if cadena_or = '' then

				cadena_or = " articulo in (select articulo from prodpartes_ot where fecha" +ddlb_operador.text+" '"+em_fecha1.text+"') "
//				cadena_or = " prodpartes_ot.fecha "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Partes "+ddlb_operador.text+" "+em_fecha1.text
			end if
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
		new_sql = sql_inicial
	end if
	
	dw_datos.SetSQLSelect ( new_sql )
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
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_aplicaciones_sin_gramaje
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_aplicaciones_sin_gramaje
integer width = 878
integer height = 1308
integer taborder = 10
integer weight = 700
long textcolor = 24076881
string item[] = {"Fecha Partes","Aplicación"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Fecha Partes"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = true
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem (">")
		ddlb_operador.AddItem ("<")
		ddlb_operador.AddItem (">=")
		ddlb_operador.AddItem ("<=")
		ddlb_operador.text = ">="
		
	CASE "Aplicación"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, resumido as Descripción from prodaplicaciones where empresa = '"+codigo_empresa+"'  order by resumido "
		
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_aplicaciones_sin_gramaje
integer x = 37
integer y = 524
integer width = 4891
integer height = 2744
integer taborder = 60
string dataobject = "dwtc_consulta_aplicaciones_sin_gramaje"
end type

event dw_datos::clicked;call super::clicked;String pieza, activa
if row > 0 then
	if dwo.name = "modelo_pieza_activo" then
		pieza = this.object.modelo_pieza_codigo_lab[row]
		activa = this.object.modelo_pieza_activo[row]
		if isnull(activa) or activa = "" or activa = "N" then
			activa = "S"
		else
			activa = "N"
		end if
		UPDATE modelo_pieza SET activo = :activa WHERE empresa = :codigo_empresa AND codigo_lab = :pieza USING SQLCA;
	end if
end if
end event

event dw_datos::doubleclicked;call super::doubleclicked;Long id_ventana
str_parametros lstr_param 

if row > 0 then	
	
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(row,"modelo_pieza_codigo_lab")
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_consulta_disenyo"
	lstr_param.resultado = ''
	id_ventana = f_menu_ventana_esta_abierta("wtc_mant_pruebas")
	if id_ventana <> -1 then
		close(wtc_mant_pruebas)
		OpenWithParm(wtc_mant_pruebas, lstr_param)
	else
		OpenWithParm(wtc_mant_pruebas,lstr_param)
	end if
	
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_aplicaciones_sin_gramaje
integer x = 4763
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_aplicaciones_sin_gramaje
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_aplicaciones_sin_gramaje
integer x = 4407
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_aplicaciones_sin_gramaje
integer x = 1298
integer y = 232
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_aplicaciones_sin_gramaje
integer x = 2871
integer y = 132
integer taborder = 90
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_aplicaciones_sin_gramaje
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_aplicaciones_sin_gramaje
integer x = 1307
integer height = 96
integer taborder = 110
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_aplicaciones_sin_gramaje
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_aplicaciones_sin_gramaje
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
integer taborder = 80
long textcolor = 24076881
end type

type dw_imagen_grande from u_dw_imagen within wtc_consulta_aplicaciones_sin_gramaje
boolean visible = false
integer x = 41
integer y = 508
integer width = 4800
integer height = 2748
integer taborder = 70
string dataobject = "dw_aux_imagen2"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;if dwo.name = "cerrar" then
	dw_imagen_grande.visible = false
end if
end event

type dw_datos2 from datawindow within wtc_consulta_aplicaciones_sin_gramaje
boolean visible = false
integer x = 3936
integer y = 1256
integer width = 686
integer height = 400
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_consulta_laboratorio_impresion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

