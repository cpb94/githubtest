$PBExportHeader$wi_consulta_venclientes_precios.srw
$PBExportComments$Mant. lineas de tarifas.
forward
global type wi_consulta_venclientes_precios from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_consulta_venclientes_precios
end type
type dw_listado from datawindow within wi_consulta_venclientes_precios
end type
type pb_imprimir from upb_imprimir within wi_consulta_venclientes_precios
end type
type cb_consulta from u_boton within wi_consulta_venclientes_precios
end type
type cb_2 from commandbutton within wi_consulta_venclientes_precios
end type
type uo_tarifa from u_em_campo_2 within wi_consulta_venclientes_precios
end type
type dw_precios_tarifa from u_datawindow within wi_consulta_venclientes_precios
end type
type gb_1 from groupbox within wi_consulta_venclientes_precios
end type
type uo_formatos from u_marca_lista within wi_consulta_venclientes_precios
end type
type uo_submarcas from u_marca_lista within wi_consulta_venclientes_precios
end type
type uo_marcas from u_marca_lista within wi_consulta_venclientes_precios
end type
type uo_familias from u_marca_lista within wi_consulta_venclientes_precios
end type
type uo_pavrev from u_marca_lista within wi_consulta_venclientes_precios
end type
type cb_formatos from commandbutton within wi_consulta_venclientes_precios
end type
type cb_submarcas from commandbutton within wi_consulta_venclientes_precios
end type
type cb_marcas from commandbutton within wi_consulta_venclientes_precios
end type
type cb_familias from commandbutton within wi_consulta_venclientes_precios
end type
type cb_pavrev from commandbutton within wi_consulta_venclientes_precios
end type
type uo_cliente from u_em_campo_2 within wi_consulta_venclientes_precios
end type
type uo_articulo from u_em_campo_2 within wi_consulta_venclientes_precios
end type
type dw_listado_cliente from datawindow within wi_consulta_venclientes_precios
end type
type pb_excel from picturebutton within wi_consulta_venclientes_precios
end type
type gb_5 from groupbox within wi_consulta_venclientes_precios
end type
type gb_2 from groupbox within wi_consulta_venclientes_precios
end type
type gb_3 from groupbox within wi_consulta_venclientes_precios
end type
end forward

global type wi_consulta_venclientes_precios from w_int_con_empresa
integer x = 315
integer y = 32
integer width = 5166
integer height = 2236
long backcolor = 32238571
pb_1 pb_1
dw_listado dw_listado
pb_imprimir pb_imprimir
cb_consulta cb_consulta
cb_2 cb_2
uo_tarifa uo_tarifa
dw_precios_tarifa dw_precios_tarifa
gb_1 gb_1
uo_formatos uo_formatos
uo_submarcas uo_submarcas
uo_marcas uo_marcas
uo_familias uo_familias
uo_pavrev uo_pavrev
cb_formatos cb_formatos
cb_submarcas cb_submarcas
cb_marcas cb_marcas
cb_familias cb_familias
cb_pavrev cb_pavrev
uo_cliente uo_cliente
uo_articulo uo_articulo
dw_listado_cliente dw_listado_cliente
pb_excel pb_excel
gb_5 gb_5
gb_2 gb_2
gb_3 gb_3
end type
global wi_consulta_venclientes_precios wi_consulta_venclientes_precios

type variables
string is_filtro_articulos,is_articulos_seleccionados[]
long   il_ultimo_registro_encontrado
end variables

forward prototypes
public function string f_filtro_articulos ()
public function boolean f_chequear_datos ()
public function string f_filtro_articulos_original ()
end prototypes

public function string f_filtro_articulos ();int li_opciones,li_opciones_marcadas,li_indice
string ls_filtro,ls_texto_seleccion,ls_filtro_pavrev,ls_texto_filtro
string ls_filtro_familias,ls_filtro_marcas,ls_filtro_submarcas,ls_filtro_formatos,ls_filtro_filial
string ls_tarifa,ls_pavrev[],ls_familias[],ls_marcas[],ls_submarcas[],ls_formatos[]
string ls_articulos_seleccionados_blanco[]

uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false

//Filtro de pavrev
li_opciones = uo_pavrev.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_pavrev.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_pavrev[li_opciones_marcadas] = uo_pavrev.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_pavrev.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_pavrev.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') in ("+ls_filtro+") "
	else
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') = "+ls_filtro+" "
	end if
else
	ls_pavrev[1] = ""
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "PAVIMENTO Y REVESTIMIENTO"	
	else
		ls_texto_filtro += "~nPAVIMENTO Y REVESTIMIENTO"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = ls_texto_seleccion
	else
		ls_texto_filtro += "~n"+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de pavrev

//Filtro de familias
li_opciones = uo_familias.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_familias.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_familias[li_opciones_marcadas] = uo_familias.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_familias.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_familias.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_familias = " and articulos.familia in ("+ls_filtro+") "
	else
		ls_filtro_familias = " and articulos.familia = "+ls_filtro+" "
	end if
else
	ls_familias[1] = ""
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS FAMILIAS"	
	else
		ls_texto_filtro += "~nTODAS LAS FAMILIAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FAMILIAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFAMILIAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de familias

//Filtro de marcas
li_opciones = uo_marcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_marcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_marcas[li_opciones_marcadas] = uo_marcas.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_marcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_marcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_marcas = " and articulos.marcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_marcas = " and articulos.marcas_codigo = "+ls_filtro+" "
	end if
else
	ls_marcas[1] = ""
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS MARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS MARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "MARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de marcas

//Filtro de submarcas
li_opciones = uo_submarcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_submarcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_submarcas[li_opciones_marcadas] = uo_submarcas.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_submarcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_submarcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_submarcas = " and articulos.submarcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_submarcas = " and articulos.submarcas_codigo = "+ls_filtro+" "
	end if
else
	ls_submarcas[1] = ""	
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS SUBMARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS SUBMARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "SUBMARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nSUBMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de submarcas

//Filtro de formatos
li_opciones = uo_formatos.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_formatos.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_formatos[li_opciones_marcadas] = uo_formatos.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_formatos.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_formatos.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_formatos = " and articulos.formato in ("+ls_filtro+") "
	else
		ls_filtro_formatos = " and articulos.formato = "+ls_filtro+" "
	end if
else
	ls_formatos[1] = ""	
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODOS LOS FORMATOS"	
	else
		ls_texto_filtro += "~nTODOS LOS FORMATOS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FORMATOS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFORMATOS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de formatos


string ls_sel,ls_articulo
long   ll_indice,ll_total
datastore ds_datos

ls_sel = "SELECT articulos.codigo "+&
			"FROM   articulos,"+&
			"       art_codestadistico "+&
         "WHERE ( articulos.empresa *= art_codestadistico.empresa ) "+&
         "and   ( articulos.codigo  *= art_codestadistico.codigo ) "+&
         "and   ( articulos.empresa = '"+codigo_empresa+"' ) "+&
			"and   ( articulos.uso     = '3' ) "+&
         ls_filtro_pavrev+& 
         ls_filtro_familias+&
         ls_filtro_marcas+&
         ls_filtro_submarcas+&
         ls_filtro_formatos+&
			ls_filtro_filial+&
			"order by articulos.codigo"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

is_articulos_seleccionados = ls_articulos_seleccionados_blanco

is_articulos_seleccionados[upperbound(is_articulos_seleccionados)+1] = ''

for ll_indice = 1 to ll_total
	ls_articulo = ds_datos.object.articulos_codigo[ll_indice]
	
	if ll_indice = 1 then
		ls_filtro = "'"+ls_articulo+"'"
	else
		ls_filtro += ",'"+ls_articulo+"'"
	end if
	
	is_articulos_seleccionados[upperbound(is_articulos_seleccionados)+1] = ls_articulo
	
next

if ll_total = 1 then
	ls_filtro = "#4 = "+ls_filtro+" or #4 = ''"
else
	if ll_total > 1 then
		ls_filtro = "#4 in ('',"+ls_filtro+")"
	else
		ls_filtro = "#4 = ''"
	end if
end if

destroy ds_datos

return ls_filtro
end function

public function boolean f_chequear_datos ();return false
end function

public function string f_filtro_articulos_original ();int li_opciones,li_opciones_marcadas,li_indice
string ls_filtro,ls_texto_seleccion,ls_filtro_pavrev,ls_texto_filtro
string ls_filtro_familias,ls_filtro_marcas,ls_filtro_submarcas,ls_filtro_formatos,ls_filtro_filial
string ls_tarifa,ls_pavrev[],ls_familias[],ls_marcas[],ls_submarcas[],ls_formatos[]

uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false

//Filtro de pavrev
li_opciones = uo_pavrev.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_pavrev.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_pavrev[li_opciones_marcadas] = uo_pavrev.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_pavrev.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_pavrev.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') in ("+ls_filtro+") "
	else
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') = "+ls_filtro+" "
	end if
else
	ls_pavrev[1] = ""
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "PAVIMENTO Y REVESTIMIENTO"	
	else
		ls_texto_filtro += "~nPAVIMENTO Y REVESTIMIENTO"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = ls_texto_seleccion
	else
		ls_texto_filtro += "~n"+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de pavrev

//Filtro de familias
li_opciones = uo_familias.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_familias.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_familias[li_opciones_marcadas] = uo_familias.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_familias.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_familias.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_familias = " and articulos.familia in ("+ls_filtro+") "
	else
		ls_filtro_familias = " and articulos.familia = "+ls_filtro+" "
	end if
else
	ls_familias[1] = ""
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS FAMILIAS"	
	else
		ls_texto_filtro += "~nTODAS LAS FAMILIAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FAMILIAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFAMILIAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de familias

//Filtro de marcas
li_opciones = uo_marcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_marcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_marcas[li_opciones_marcadas] = uo_marcas.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_marcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_marcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_marcas = " and articulos.marcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_marcas = " and articulos.marcas_codigo = "+ls_filtro+" "
	end if
else
	ls_marcas[1] = ""
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS MARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS MARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "MARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de marcas

//Filtro de submarcas
li_opciones = uo_submarcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_submarcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_submarcas[li_opciones_marcadas] = uo_submarcas.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_submarcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_submarcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_submarcas = " and articulos.submarcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_submarcas = " and articulos.submarcas_codigo = "+ls_filtro+" "
	end if
else
	ls_submarcas[1] = ""	
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS SUBMARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS SUBMARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "SUBMARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nSUBMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de submarcas

//Filtro de formatos
li_opciones = uo_formatos.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_formatos.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_formatos[li_opciones_marcadas] = uo_formatos.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_formatos.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_formatos.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_formatos = " and articulos.formato in ("+ls_filtro+") "
	else
		ls_filtro_formatos = " and articulos.formato = "+ls_filtro+" "
	end if
else
	ls_formatos[1] = ""	
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODOS LOS FORMATOS"	
	else
		ls_texto_filtro += "~nTODOS LOS FORMATOS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FORMATOS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFORMATOS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de formatos



string ls_sel,ls_articulo
long   ll_indice,ll_total
datastore ds_datos

ls_sel = "SELECT articulos.codigo "+&
			"FROM   articulos,"+&
			"       art_codestadistico "+&
         "WHERE ( articulos.empresa *= art_codestadistico.empresa ) "+&
         "and   ( articulos.codigo  *= art_codestadistico.codigo ) "+&
         "and   ( articulos.empresa = '"+codigo_empresa+"' ) "+&
			"and   ( articulos.uso     = '3' ) "+&
         ls_filtro_pavrev+& 
         ls_filtro_familias+&
         ls_filtro_marcas+&
         ls_filtro_submarcas+&
         ls_filtro_formatos+&
			ls_filtro_filial+&
			"order by articulos.codigo"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	ls_articulo = ds_datos.object.articulos_codigo[ll_indice]
	
	if ll_indice = 1 then
		ls_filtro = "'"+ls_articulo+"'"
	else
		ls_filtro += ",'"+ls_articulo+"'"
	end if
next

if ll_total = 1 then
	ls_filtro = "articulos_codigo = "+ls_filtro+" or articulos_codigo = ''"
else
	if ll_total > 1 then
		ls_filtro = "articulos_codigo in ('',"+ls_filtro+")"
	else
		ls_filtro = "articulos_codigo = ''"
	end if
end if

destroy ds_datos

return ls_filtro
end function

on wi_consulta_venclientes_precios.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.cb_consulta=create cb_consulta
this.cb_2=create cb_2
this.uo_tarifa=create uo_tarifa
this.dw_precios_tarifa=create dw_precios_tarifa
this.gb_1=create gb_1
this.uo_formatos=create uo_formatos
this.uo_submarcas=create uo_submarcas
this.uo_marcas=create uo_marcas
this.uo_familias=create uo_familias
this.uo_pavrev=create uo_pavrev
this.cb_formatos=create cb_formatos
this.cb_submarcas=create cb_submarcas
this.cb_marcas=create cb_marcas
this.cb_familias=create cb_familias
this.cb_pavrev=create cb_pavrev
this.uo_cliente=create uo_cliente
this.uo_articulo=create uo_articulo
this.dw_listado_cliente=create dw_listado_cliente
this.pb_excel=create pb_excel
this.gb_5=create gb_5
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.uo_tarifa
this.Control[iCurrent+7]=this.dw_precios_tarifa
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.uo_formatos
this.Control[iCurrent+10]=this.uo_submarcas
this.Control[iCurrent+11]=this.uo_marcas
this.Control[iCurrent+12]=this.uo_familias
this.Control[iCurrent+13]=this.uo_pavrev
this.Control[iCurrent+14]=this.cb_formatos
this.Control[iCurrent+15]=this.cb_submarcas
this.Control[iCurrent+16]=this.cb_marcas
this.Control[iCurrent+17]=this.cb_familias
this.Control[iCurrent+18]=this.cb_pavrev
this.Control[iCurrent+19]=this.uo_cliente
this.Control[iCurrent+20]=this.uo_articulo
this.Control[iCurrent+21]=this.dw_listado_cliente
this.Control[iCurrent+22]=this.pb_excel
this.Control[iCurrent+23]=this.gb_5
this.Control[iCurrent+24]=this.gb_2
this.Control[iCurrent+25]=this.gb_3
end on

on wi_consulta_venclientes_precios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.cb_consulta)
destroy(this.cb_2)
destroy(this.uo_tarifa)
destroy(this.dw_precios_tarifa)
destroy(this.gb_1)
destroy(this.uo_formatos)
destroy(this.uo_submarcas)
destroy(this.uo_marcas)
destroy(this.uo_familias)
destroy(this.uo_pavrev)
destroy(this.cb_formatos)
destroy(this.cb_submarcas)
destroy(this.cb_marcas)
destroy(this.cb_familias)
destroy(this.cb_pavrev)
destroy(this.uo_cliente)
destroy(this.uo_articulo)
destroy(this.dw_listado_cliente)
destroy(this.pb_excel)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;

istr_parametros.s_titulo_ventana =   "Lista precios especiales"
//istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_precios_tarifa.SetTransObject(SQLCA)

uo_tarifa.em_codigo.text="120"

uo_tarifa.triggerevent("modificado")

uo_familias.f_cargar_datos("dw_ayuda_familias","%","","Familia","Descripción")
uo_formatos.f_cargar_datos("dw_ayuda_formatos","%","","Formato","Descripción")
uo_marcas.f_cargar_datos("dw_ayuda_marcas","%","","Marca","Descripción")
uo_pavrev.f_cargar_datos("dw_ayuda_pavrev","%","","PavRev","Descripción")
uo_submarcas.f_cargar_datos("dw_ayuda_Submarcas","%","","Submarca","Descripción")

f_activar_campo(uo_tarifa.em_campo)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_precios_tarifa)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_precios_tarifa)
end event

event activate;call super::activate;w_con_historia_articulo = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_consulta_venclientes_precios
integer taborder = 90
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_consulta_venclientes_precios
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_tarifa.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_consulta_venclientes_precios
integer width = 5051
integer height = 84
end type

type pb_1 from upb_salir within wi_consulta_venclientes_precios
integer x = 4667
integer y = 136
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\tencer_PB12\Log Out_24x24.png"
string powertiptext = "Salir"
end type

type dw_listado from datawindow within wi_consulta_venclientes_precios
boolean visible = false
integer x = 6862
integer width = 146
integer height = 128
boolean bringtotop = true
string dataobject = "report_mant_tarifas_conjunto"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_consulta_venclientes_precios
event clicked pbm_bnclicked
integer x = 4384
integer y = 136
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = false
string picturename = "C:\tencer_PB12\printer-icon2_24x24.png"
string powertiptext = "Imprimir"
end type

event clicked;call super::clicked;if dw_precios_tarifa.rowcount() > 0 then
	
	f_imprimir_datawindow(dw_precios_tarifa)
	
end if
end event

type cb_consulta from u_boton within wi_consulta_venclientes_precios
integer x = 3813
integer y = 136
integer width = 462
integer height = 128
integer taborder = 30
boolean bringtotop = true
string text = "Consultar"
end type

event clicked;call super::clicked;string ls_tarifa,ls_moneda_tarifa,ls_mascara,ls_mascara_descuentos,ls_mascara_fechas, filtro
datetime ldt_ventarifas_activa


filtro = ''

if uo_tarifa.em_codigo.text <> '' then
	
	is_filtro_articulos = f_filtro_articulos()
	
	ls_tarifa = uo_tarifa.em_codigo.text
	
	if Trim(uo_articulo.em_campo.text) <> '' then filtro = "codigo_articulo = '"+uo_articulo.em_codigo.text+"'"
		
	if Trim(uo_cliente.em_campo.text) <> '' then 
		
		if filtro = '' then 
			
			filtro = "codigo_cliente = '"+uo_cliente.em_codigo.text+"'"
		
		else 
			
			filtro += "and codigo_cliente = '"+uo_cliente.em_codigo.text+"'"
			
		end if
		
	end if	
		
	dw_precios_tarifa.retrieve(codigo_empresa,ls_tarifa,is_articulos_seleccionados)	
	
	dw_precios_tarifa.setfilter(filtro)
	
	dw_precios_tarifa.filter()
	
else
	
	dw_precios_tarifa.reset()
	
end if



end event

type cb_2 from commandbutton within wi_consulta_venclientes_precios
boolean visible = false
integer x = 4887
integer width = 786
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SQLS PARA IMPORTAR DATOS"
end type

event clicked;//  SELECT venlintarifas.empresa,   
//         venlintarifas.tarifa,   
//         venlintarifas.fecha,   
//         isnull(venlintarifas.articulo,'') as articulo,   
//         isnull(venlintarifas.calidad,'') as calidad,   
//         isnull(venlintarifas.precio ,0) as precio 
//    FROM venlintarifas  
//   WHERE venlintarifas.empresa = '1'   ;

//  SELECT LTRIM(RTRIM(vendtotarifa.empresa)) as empresa,   
//          LTRIM(RTRIM(vendtotarifa.tarifa)) as tarifa,   
//         ventarifas.activa,   
//          LTRIM(RTRIM(vendtotarifa.articulo)) as articulo,   
//          LTRIM(RTRIM(vendtotarifa.calidad)) as calidad,   
//         1 as cantidad,   
//         'PLT' as tipo_cantidad,   
//         vendtotarifa.dto,   
//         '' as fecha_inicio_descuento,   
//         '' as fecha_fin_descuento  
//    FROM vendtotarifa,   
//         ventarifas  
//   WHERE ( vendtotarifa.empresa = ventarifas.empresa ) and  
//         ( vendtotarifa.tarifa = ventarifas.codigo )   ;


//  SELECT ltrim(rtrim(venprecesp.empresa)) as empresa,   
//         ltrim(rtrim(venprecesp.cliente)) as cliente,   
//         ltrim(rtrim(venprecesp.articulo)) as articulo,   
//         ltrim(rtrim(venprecesp.calidad)) as calidad,   
//         isnull(venprecesp.precio,0) as precio  
//    FROM venprecesp  
//   WHERE venprecesp.empresa = '1'
//	and   isnull(venprecesp.precio,0) <> 0;

//select ltrim(rtrim(empresa)) as empresa,
//		 ltrim(rtrim(cliente)) as cliente,
//		 ltrim(rtrim(articulo)) as articulo,
//		 ltrim(rtrim(calidad)) as calidad,
//		 cantidad,
//		 'PZS',
// 		 isnull(dto,0) as descuento,
//		 '' as inicio_descuento,
//       '' as fin_descuento,
//     0 as descuento2
//from   vendtoartcli
//where  empresa = '1'
//and    isnull(cliente,'') <> ''
//union all
//select ltrim(rtrim(empresa)) as empresa,
//		 ltrim(rtrim(cliente)) as cliente,
//		 ltrim(rtrim(articulo)) as articulo,
//		 '1' as calidad,
//		 0 as cantidad,
//		 'PZS' as tipo_cantidad,
// 		 isnull(dto,0) as descuento,
//		 '' as inicio_descuento,
//       fecha as fin_descuento,
//     0 as descuento2
//from tarifaartclifecha 
//where empresa = '1' 
//and    isnull(cliente,'') <> ''
//and dateadd(dd,+2,fecha) >= getdate();

//update venclientes_descuentos set fecha_fin_descuento = fecha_inicio_descuento where fecha_fin_descuento = '01-01-1900';

//update venclientes_descuentos set se_acumula_a_dto_tarifa = 'N';

//update venclientes_precios set no_aplicar_dtos_tarifa = 'N';
end event

type uo_tarifa from u_em_campo_2 within wi_consulta_venclientes_precios
integer x = 9
integer y = 140
integer width = 1678
integer taborder = 10
boolean bringtotop = true
boolean border = true
long backcolor = 32238571
borderstyle borderstyle = stylelowered!
end type

event modificado;string ls_moneda_empresa,ls_moneda_tarifa,ls_mascara_moneda_empresa,ls_mascara_moneda_tarifa
int    li_decimales_precio

uo_tarifa.em_campo.text=f_nombre_ventarifa(codigo_empresa,uo_tarifa.em_codigo.text)

If Trim(uo_tarifa.em_campo.text)="" then
	uo_tarifa.em_campo.text=""
	uo_tarifa.em_codigo.text=""
	

end if 

dw_precios_tarifa.reset()

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Tarifas"
ue_datawindow ="dw_ayuda_ventarifas"
ue_filtro = ""
end event

on uo_tarifa.destroy
call u_em_campo_2::destroy
end on

type dw_precios_tarifa from u_datawindow within wi_consulta_venclientes_precios
integer y = 388
integer width = 5129
integer height = 1640
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Precios Especiales por Cliente"
string dataobject = "dwi_consulta_venclientes_precios"
boolean vscrollbar = true
end type

type gb_1 from groupbox within wi_consulta_venclientes_precios
integer y = 84
integer width = 1696
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 32238571
string text = "Tarifa"
end type

type uo_formatos from u_marca_lista within wi_consulta_venclientes_precios
event destroy ( )
boolean visible = false
integer x = 2231
integer y = 236
integer taborder = 160
boolean bringtotop = true
boolean border = false
end type

on uo_formatos.destroy
call u_marca_lista::destroy
end on

type uo_submarcas from u_marca_lista within wi_consulta_venclientes_precios
event destroy ( )
boolean visible = false
integer x = 1856
integer y = 236
integer taborder = 170
boolean bringtotop = true
boolean border = false
end type

on uo_submarcas.destroy
call u_marca_lista::destroy
end on

type uo_marcas from u_marca_lista within wi_consulta_venclientes_precios
event destroy ( )
boolean visible = false
integer x = 1481
integer y = 236
integer taborder = 180
boolean bringtotop = true
boolean border = false
end type

on uo_marcas.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;//Aqui vamos a filtrar las submarcas que debemos ver
long ll_indice,ll_total,ll_indice2,ll_total2
string ls_sel,ls_submarcas_a_mostrar,ls_submarca
datastore ds_datos

ll_total = this.dw_marca.RowCount()

for ll_indice = 1 to ll_total
	if (this.dw_marca.object.marca[ll_indice] = 'S' or (ll_indice = row and data = 'S')) and not(ll_indice = row and data = 'N') then
		ls_sel = "select submarcas.codigo from submarcas where empresa = '"+codigo_empresa+"' and marcas_codigo = '"+this.dw_marca.object.codigo[ll_indice]+"'"
		
		ll_total2 = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice2 = 1 to ll_total2
			ls_submarca = ds_datos.object.codigo[ll_indice2]
			
			if ls_submarcas_a_mostrar = "" then
				ls_submarcas_a_mostrar = "'"+ls_submarca+"'"
			else
				ls_submarcas_a_mostrar += ",'"+ls_submarca+"'"
			end if
		next
		
		destroy ds_datos
		
	end if
next

if ls_submarcas_a_mostrar <> "" then
	uo_submarcas.dw_marca.setfilter("codigo in ("+ls_submarcas_a_mostrar+")")
else
	uo_submarcas.dw_marca.setfilter("0 = 1")
end if
uo_submarcas.dw_marca.filter()
uo_submarcas.event itemchanged(0,dwo,"")

end event

type uo_familias from u_marca_lista within wi_consulta_venclientes_precios
event destroy ( )
boolean visible = false
integer x = 1106
integer y = 236
integer taborder = 190
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;//Aqui vamos a filtrar las marcas que debemos ver
long ll_indice,ll_total,ll_indice2,ll_total2
string ls_sel,ls_marcas_a_mostrar,ls_marca
datastore ds_datos

ll_total = this.dw_marca.RowCount()

for ll_indice = 1 to ll_total
	if (this.dw_marca.object.marca[ll_indice] = 'S' or (ll_indice = row and data = 'S')) and not(ll_indice = row and data = 'N') then
		ls_sel = "select marcas.codigo from marcas where empresa = '"+codigo_empresa+"' and familias_codigo = '"+this.dw_marca.object.codigo[ll_indice]+"'"
		
		ll_total2 = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice2 = 1 to ll_total2
			ls_marca = ds_datos.object.codigo[ll_indice2]
			
			if ls_marcas_a_mostrar = "" then
				ls_marcas_a_mostrar = "'"+ls_marca+"'"
			else
				ls_marcas_a_mostrar += ",'"+ls_marca+"'"
			end if
		next
		
		destroy ds_datos
		
	end if
next

if ls_marcas_a_mostrar <> "" then
	uo_marcas.dw_marca.setfilter("codigo in ("+ls_marcas_a_mostrar+")")
else
	uo_marcas.dw_marca.setfilter("0 = 1")
end if
uo_marcas.dw_marca.filter()
uo_marcas.event itemchanged(0,dwo,"")

end event

type uo_pavrev from u_marca_lista within wi_consulta_venclientes_precios
event destroy ( )
boolean visible = false
integer x = 731
integer y = 236
integer taborder = 200
boolean bringtotop = true
boolean border = false
end type

on uo_pavrev.destroy
call u_marca_lista::destroy
end on

type cb_formatos from commandbutton within wi_consulta_venclientes_precios
integer x = 3209
integer y = 140
integer width = 379
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;
uo_familias.visible = false
uo_formatos.visible = not(uo_formatos.visible)
uo_marcas.visible = false

uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_submarcas from commandbutton within wi_consulta_venclientes_precios
integer x = 2834
integer y = 140
integer width = 379
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubMarcas"
end type

event clicked;
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false

uo_pavrev.visible = false
uo_submarcas.visible = not(uo_submarcas.visible)
end event

type cb_marcas from commandbutton within wi_consulta_venclientes_precios
integer x = 2459
integer y = 140
integer width = 379
integer height = 84
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcas"
end type

event clicked;
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = not(uo_marcas.visible)

uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_familias from commandbutton within wi_consulta_venclientes_precios
integer x = 2085
integer y = 140
integer width = 379
integer height = 84
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;
uo_familias.visible = not(uo_familias.visible)
uo_formatos.visible = false
uo_marcas.visible = false

uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_pavrev from commandbutton within wi_consulta_venclientes_precios
integer x = 1710
integer y = 140
integer width = 379
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pav./Rev."
end type

event clicked;
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false

uo_pavrev.visible = not(uo_pavrev.visible)
uo_submarcas.visible = false
end event

type uo_cliente from u_em_campo_2 within wi_consulta_venclientes_precios
event destroy ( )
integer x = 1710
integer y = 280
integer width = 1902
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,'C',uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
end if
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro      = ""
valor_empresa = true

end event

type uo_articulo from u_em_campo_2 within wi_consulta_venclientes_precios
event destroy ( )
integer x = 9
integer y = 284
integer width = 1678
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
		
if is_filtro_articulos <> "" then
	string ls_filtro_articulos
	
	ls_filtro_articulos = is_filtro_articulos	
	ls_filtro_articulos = f_sustituir(ls_filtro_articulos,'articulos_codigo','#1')
	ue_filtro     = "articulos_uso = '3' and "+ls_filtro_articulos
else
	ue_filtro     = "articulos_uso = '3'"			
end if
end event

event modificado;call super::modificado;String descripcion,articulo

articulo = this.em_codigo.text

Select descripcion
Into   :descripcion
From   articulos
Where  articulos.empresa = :codigo_empresa
And    articulos.codigo  = :articulo;

this.em_campo.text=descripcion



end event

type dw_listado_cliente from datawindow within wi_consulta_venclientes_precios
boolean visible = false
integer x = 6679
integer width = 146
integer height = 128
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_mant_tarifas_conjunto_cliente"
boolean livescroll = true
end type

type pb_excel from picturebutton within wi_consulta_venclientes_precios
integer x = 4526
integer y = 136
integer width = 146
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom043!"
alignment htextalign = left!
end type

event clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_precios_tarifa.rowcount()

if ll_registros > 0 then
	
	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then

		uf_save_dw_as_excel(dw_precios_tarifa,ls_ruta_fichero)
		
	end if

end if

end event

type gb_5 from groupbox within wi_consulta_venclientes_precios
integer x = 1701
integer y = 84
integer width = 1897
integer height = 148
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Filtro Articulos"
end type

type gb_2 from groupbox within wi_consulta_venclientes_precios
integer x = 1701
integer y = 228
integer width = 1934
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Cliente"
end type

type gb_3 from groupbox within wi_consulta_venclientes_precios
integer y = 228
integer width = 1696
integer height = 148
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 32238571
string text = "Filtrar Articulo"
end type

