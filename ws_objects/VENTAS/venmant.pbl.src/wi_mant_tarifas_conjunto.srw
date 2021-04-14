$PBExportHeader$wi_mant_tarifas_conjunto.srw
$PBExportComments$Mant. lineas de tarifas.
forward
global type wi_mant_tarifas_conjunto from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_mant_tarifas_conjunto
end type
type dw_listado from datawindow within wi_mant_tarifas_conjunto
end type
type pb_imprimir from upb_imprimir within wi_mant_tarifas_conjunto
end type
type cb_consulta from u_boton within wi_mant_tarifas_conjunto
end type
type cb_2 from commandbutton within wi_mant_tarifas_conjunto
end type
type uo_tarifa from u_em_campo_2 within wi_mant_tarifas_conjunto
end type
type pb_grabar from picturebutton within wi_mant_tarifas_conjunto
end type
type dw_precios_tarifa from u_datawindow within wi_mant_tarifas_conjunto
end type
type dw_precios_clientes from u_datawindow within wi_mant_tarifas_conjunto
end type
type dw_descuentos_clientes from u_datawindow within wi_mant_tarifas_conjunto
end type
type gb_1 from groupbox within wi_mant_tarifas_conjunto
end type
type dw_descuentos_tarifa from u_datawindow within wi_mant_tarifas_conjunto
end type
type uo_formatos from u_marca_lista within wi_mant_tarifas_conjunto
end type
type uo_submarcas from u_marca_lista within wi_mant_tarifas_conjunto
end type
type uo_marcas from u_marca_lista within wi_mant_tarifas_conjunto
end type
type uo_familias from u_marca_lista within wi_mant_tarifas_conjunto
end type
type uo_pavrev from u_marca_lista within wi_mant_tarifas_conjunto
end type
type cb_formatos from commandbutton within wi_mant_tarifas_conjunto
end type
type cb_submarcas from commandbutton within wi_mant_tarifas_conjunto
end type
type cb_marcas from commandbutton within wi_mant_tarifas_conjunto
end type
type cb_familias from commandbutton within wi_mant_tarifas_conjunto
end type
type cb_pavrev from commandbutton within wi_mant_tarifas_conjunto
end type
type cbx_solo_dtos_del_articulo_activo from checkbox within wi_mant_tarifas_conjunto
end type
type uo_cliente from u_em_campo_2 within wi_mant_tarifas_conjunto
end type
type uo_articulo from u_em_campo_2 within wi_mant_tarifas_conjunto
end type
type em_descripcion_a_buscar from u_em_campo within wi_mant_tarifas_conjunto
end type
type p_buscar from picture within wi_mant_tarifas_conjunto
end type
type uo_filial from u_em_campo_2 within wi_mant_tarifas_conjunto
end type
type dw_listado_cliente from datawindow within wi_mant_tarifas_conjunto
end type
type pb_excel from picturebutton within wi_mant_tarifas_conjunto
end type
type cbx_no_filtrar_articulos_cliente from checkbox within wi_mant_tarifas_conjunto
end type
type cbx_imprimir_promocion from checkbox within wi_mant_tarifas_conjunto
end type
type cbx_imprimir_no_promocion from checkbox within wi_mant_tarifas_conjunto
end type
type gb_5 from groupbox within wi_mant_tarifas_conjunto
end type
type gb_2 from groupbox within wi_mant_tarifas_conjunto
end type
type gb_3 from groupbox within wi_mant_tarifas_conjunto
end type
type gb_4 from groupbox within wi_mant_tarifas_conjunto
end type
type gb_6 from groupbox within wi_mant_tarifas_conjunto
end type
end forward

global type wi_mant_tarifas_conjunto from w_int_con_empresa
integer x = 315
integer y = 32
integer width = 7017
integer height = 3844
long backcolor = 32238571
pb_1 pb_1
dw_listado dw_listado
pb_imprimir pb_imprimir
cb_consulta cb_consulta
cb_2 cb_2
uo_tarifa uo_tarifa
pb_grabar pb_grabar
dw_precios_tarifa dw_precios_tarifa
dw_precios_clientes dw_precios_clientes
dw_descuentos_clientes dw_descuentos_clientes
gb_1 gb_1
dw_descuentos_tarifa dw_descuentos_tarifa
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
cbx_solo_dtos_del_articulo_activo cbx_solo_dtos_del_articulo_activo
uo_cliente uo_cliente
uo_articulo uo_articulo
em_descripcion_a_buscar em_descripcion_a_buscar
p_buscar p_buscar
uo_filial uo_filial
dw_listado_cliente dw_listado_cliente
pb_excel pb_excel
cbx_no_filtrar_articulos_cliente cbx_no_filtrar_articulos_cliente
cbx_imprimir_promocion cbx_imprimir_promocion
cbx_imprimir_no_promocion cbx_imprimir_no_promocion
gb_5 gb_5
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_6 gb_6
end type
global wi_mant_tarifas_conjunto wi_mant_tarifas_conjunto

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

//Filtro Filial

if uo_filial.em_codigo.text <> "" then
	ls_filtro_filial = " and ( articulos.cliente = '"+uo_filial.em_codigo.text+"' or articulos.cliente_marca = '"+uo_filial.em_codigo.text+"' ) "
else
	ls_filtro_filial = ""
end if

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

public function boolean f_chequear_datos ();long    ll_indice,ll_total,ll_donde
boolean lb_correcto = true

dw_precios_tarifa.setredraw(false)
dw_precios_tarifa.setfilter("")
dw_precios_tarifa.filter()
ll_total = dw_precios_tarifa.rowcount()

//articulos_codigo
//calidades_codigo
//precio
ll_donde = dw_precios_tarifa.find("articulos_codigo = ''",1,ll_total)

if ll_donde > 0 then
	messagebox('¡Atención!','Ha introducido una linea sin codigo de articulo')
	lb_correcto = false
else
	ll_donde = dw_precios_tarifa.find("calidades_codigo = ''",1,ll_total)
	
	if ll_donde > 0 then
		messagebox('¡Atención!','Ha introducido una linea sin codigo de calidad')
		lb_correcto = false
	else
		ll_donde = dw_precios_tarifa.find("precio = 0",1,ll_total)
		
		if ll_donde > 0 then
			messagebox('¡Atención!','Ha introducido una linea sin precio')
			lb_correcto = false
		end if				
	end if		
end if	

if lb_correcto then
	dw_descuentos_tarifa.setredraw(false)
	dw_descuentos_tarifa.setfilter("")
	dw_descuentos_tarifa.filter()
	ll_total = dw_descuentos_tarifa.rowcount()	
	
	ll_donde = dw_descuentos_tarifa.find("articulos_codigo = ''",1,ll_total)
	
	if ll_donde > 0 then
		messagebox('¡Atención!','Ha introducido una linea sin codigo de articulo')
		lb_correcto = false
	else
		ll_donde = dw_descuentos_tarifa.find("calidades_codigo = ''",1,ll_total)
		
		if ll_donde > 0 then
			messagebox('¡Atención!','Ha introducido una linea sin codigo de calidad')
			lb_correcto = false
		else
			//Se deben de permitir descuentos 0
//			ll_donde = dw_descuentos_tarifa.find("descuento = 0",1,ll_total)
//			
//			if ll_donde > 0 then
//				messagebox('¡Atención!','Ha introducido una linea sin descuento')
//				lb_correcto = false
//			end if				
		end if		
	end if		
end if

if lb_correcto then
	dw_precios_clientes.setredraw(false)
	dw_precios_clientes.setfilter("")
	dw_precios_clientes.filter()
	ll_total = dw_precios_clientes.rowcount()	
	
	ll_donde = dw_precios_clientes.find("venclientes_codigo = ''",1,ll_total)
	
	if ll_donde > 0 then
		messagebox('¡Atención!','Ha introducido una linea sin codigo de cliente')
		lb_correcto = false
	else
		ll_donde = dw_precios_clientes.find("articulos_codigo = ''",1,ll_total)
		
		if ll_donde > 0 then
			messagebox('¡Atención!','Ha introducido una linea sin codigo de articulo por cliente')
			lb_correcto = false
		else
			ll_donde = dw_precios_clientes.find("calidades_codigo = ''",1,ll_total)
			
			if ll_donde > 0 then
				messagebox('¡Atención!','Ha introducido una linea sin codigo de calidad por cliente')
				lb_correcto = false
			else
				ll_donde = dw_precios_clientes.find("precio = 0",1,ll_total)
				
				if ll_donde > 0 then
					messagebox('¡Atención!','Ha introducido una linea sin precio por cliente')
					lb_correcto = false
				end if				
			end if		
		end if				
	end if
	
end if
	
if lb_correcto then
	dw_descuentos_clientes.setredraw(false)
	dw_descuentos_clientes.setfilter("")
	dw_descuentos_clientes.filter()
	ll_total = dw_descuentos_clientes.rowcount()	
	
	ll_donde = dw_descuentos_clientes.find("venclientes_codigo = ''",1,ll_total)
	
	if ll_donde > 0 then
		messagebox('¡Atención!','Ha introducido una linea sin codigo de cliente')
		lb_correcto = false
	else
		ll_donde = dw_descuentos_clientes.find("articulos_codigo = ''",1,ll_total)
		
		if ll_donde > 0 then
			messagebox('¡Atención!','Ha introducido una linea sin codigo de articulo por cliente')
			lb_correcto = false
		else
			ll_donde = dw_descuentos_clientes.find("calidades_codigo = ''",1,ll_total)
			
			if ll_donde > 0 then
				messagebox('¡Atención!','Ha introducido una linea sin codigo de calidad por cliente')
				lb_correcto = false
			else
				//Se deben de permitir descuentos 0
//				ll_donde = dw_descuentos_clientes.find("descuento = 0",1,ll_total)
//				
//				if ll_donde > 0 then
//					messagebox('¡Atención!','Ha introducido una linea sin descuento por cliente')
//					lb_correcto = false
//				end if				
			end if		
		end if				
	end if
	
end if

IF Trim(uo_articulo.em_campo.text) = "" THEN 
	dw_precios_tarifa.setfilter(is_filtro_articulos)
	dw_precios_tarifa.filter()
	
	dw_descuentos_tarifa.setfilter(is_filtro_articulos)
	dw_descuentos_tarifa.filter()		
else
	dw_precios_tarifa.setfilter("articulos_codigo = '"+uo_articulo.em_codigo.text+"'")
	dw_precios_tarifa.filter()
	
	dw_descuentos_tarifa.setfilter("articulos_codigo = '"+uo_articulo.em_codigo.text+"'")
	dw_descuentos_tarifa.filter()		
END IF	

dw_precios_tarifa.setredraw(true)
dw_descuentos_tarifa.setredraw(true)
dw_precios_clientes.setredraw(true)
dw_descuentos_clientes.setredraw(true)

if dw_precios_tarifa.rowcount() > 0 then
	dw_precios_tarifa.event rowfocuschanged(1)
else
	dw_precios_tarifa.event rowfocuschanged(0)
end if

return lb_correcto
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

//Filtro Filial

if uo_filial.em_codigo.text <> "" then
	ls_filtro_filial = " and articulos.cliente_marca = '"+uo_filial.em_codigo.text+"' "
else
	ls_filtro_filial = ""
end if

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

on wi_mant_tarifas_conjunto.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.cb_consulta=create cb_consulta
this.cb_2=create cb_2
this.uo_tarifa=create uo_tarifa
this.pb_grabar=create pb_grabar
this.dw_precios_tarifa=create dw_precios_tarifa
this.dw_precios_clientes=create dw_precios_clientes
this.dw_descuentos_clientes=create dw_descuentos_clientes
this.gb_1=create gb_1
this.dw_descuentos_tarifa=create dw_descuentos_tarifa
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
this.cbx_solo_dtos_del_articulo_activo=create cbx_solo_dtos_del_articulo_activo
this.uo_cliente=create uo_cliente
this.uo_articulo=create uo_articulo
this.em_descripcion_a_buscar=create em_descripcion_a_buscar
this.p_buscar=create p_buscar
this.uo_filial=create uo_filial
this.dw_listado_cliente=create dw_listado_cliente
this.pb_excel=create pb_excel
this.cbx_no_filtrar_articulos_cliente=create cbx_no_filtrar_articulos_cliente
this.cbx_imprimir_promocion=create cbx_imprimir_promocion
this.cbx_imprimir_no_promocion=create cbx_imprimir_no_promocion
this.gb_5=create gb_5
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.uo_tarifa
this.Control[iCurrent+7]=this.pb_grabar
this.Control[iCurrent+8]=this.dw_precios_tarifa
this.Control[iCurrent+9]=this.dw_precios_clientes
this.Control[iCurrent+10]=this.dw_descuentos_clientes
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.dw_descuentos_tarifa
this.Control[iCurrent+13]=this.uo_formatos
this.Control[iCurrent+14]=this.uo_submarcas
this.Control[iCurrent+15]=this.uo_marcas
this.Control[iCurrent+16]=this.uo_familias
this.Control[iCurrent+17]=this.uo_pavrev
this.Control[iCurrent+18]=this.cb_formatos
this.Control[iCurrent+19]=this.cb_submarcas
this.Control[iCurrent+20]=this.cb_marcas
this.Control[iCurrent+21]=this.cb_familias
this.Control[iCurrent+22]=this.cb_pavrev
this.Control[iCurrent+23]=this.cbx_solo_dtos_del_articulo_activo
this.Control[iCurrent+24]=this.uo_cliente
this.Control[iCurrent+25]=this.uo_articulo
this.Control[iCurrent+26]=this.em_descripcion_a_buscar
this.Control[iCurrent+27]=this.p_buscar
this.Control[iCurrent+28]=this.uo_filial
this.Control[iCurrent+29]=this.dw_listado_cliente
this.Control[iCurrent+30]=this.pb_excel
this.Control[iCurrent+31]=this.cbx_no_filtrar_articulos_cliente
this.Control[iCurrent+32]=this.cbx_imprimir_promocion
this.Control[iCurrent+33]=this.cbx_imprimir_no_promocion
this.Control[iCurrent+34]=this.gb_5
this.Control[iCurrent+35]=this.gb_2
this.Control[iCurrent+36]=this.gb_3
this.Control[iCurrent+37]=this.gb_4
this.Control[iCurrent+38]=this.gb_6
end on

on wi_mant_tarifas_conjunto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.cb_consulta)
destroy(this.cb_2)
destroy(this.uo_tarifa)
destroy(this.pb_grabar)
destroy(this.dw_precios_tarifa)
destroy(this.dw_precios_clientes)
destroy(this.dw_descuentos_clientes)
destroy(this.gb_1)
destroy(this.dw_descuentos_tarifa)
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
destroy(this.cbx_solo_dtos_del_articulo_activo)
destroy(this.uo_cliente)
destroy(this.uo_articulo)
destroy(this.em_descripcion_a_buscar)
destroy(this.p_buscar)
destroy(this.uo_filial)
destroy(this.dw_listado_cliente)
destroy(this.pb_excel)
destroy(this.cbx_no_filtrar_articulos_cliente)
destroy(this.cbx_imprimir_promocion)
destroy(this.cbx_imprimir_no_promocion)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_6)
end on

event open;call super::open;

istr_parametros.s_titulo_ventana =   "Introducción Tarifas"
//istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_precios_tarifa.SetTransObject(SQLCA)
dw_descuentos_tarifa.SetTransObject(SQLCA)
dw_precios_clientes.SetTransObject(SQLCA)
dw_descuentos_clientes.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_listado_cliente.SetTransObject(SQLCA)

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

event closequery;call super::closequery;boolean resultado

dw_precios_tarifa.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco

if dw_precios_tarifa.DeletedCount() + dw_precios_tarifa.ModifiedCount() > 0 then
	resultado = true
end if


if resultado and permiso_ventana > 1 then
	if MessageBox("Atención", "¿Desea grabar las modificaciones?", Exclamation!, YesNo!, 2) = 1 then
		pb_grabar.triggerevent(clicked!)
	end if
end if
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_tarifas_conjunto
integer taborder = 90
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_tarifas_conjunto
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_tarifa.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_tarifas_conjunto
integer width = 4608
integer height = 84
end type

type pb_1 from upb_salir within wi_mant_tarifas_conjunto
integer x = 6848
integer y = 108
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\tencer_PB12\Log Out_24x24.png"
string powertiptext = "Salir"
end type

type dw_listado from datawindow within wi_mant_tarifas_conjunto
boolean visible = false
integer x = 6862
integer width = 146
integer height = 128
boolean bringtotop = true
string dataobject = "report_mant_tarifas_conjunto"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_mant_tarifas_conjunto
event clicked pbm_bnclicked
integer x = 6565
integer y = 108
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = false
string picturename = "C:\tencer_PB12\printer-icon2_24x24.png"
string powertiptext = "Imprimir"
end type

event clicked;call super::clicked;string ls_tarifa,ls_moneda_tarifa,ls_mascara,ls_mascara_descuentos,ls_mascara_fechas,ls_mascara_moneda_tarifa,ls_promocion[]
datetime ldt_ventarifas_activa
int      li_decimales_precio

if uo_tarifa.em_codigo.text <> '' then
	is_filtro_articulos = f_filtro_articulos()
	
	ls_tarifa = uo_tarifa.em_codigo.text

	select ventarifas.moneda,
			 ventarifas.activa
	into   :ls_moneda_tarifa,
			 :ldt_ventarifas_activa
	from   ventarifas
	where  ventarifas.empresa = :codigo_empresa
	and    ventarifas.codigo  = :ls_tarifa;
	
	ls_mascara = f_mascara_moneda(ls_moneda_tarifa)
	ls_mascara_descuentos = f_mascara_decimales(2)
	ls_mascara_fechas = 'dd-mm-yy'
	
	li_decimales_precio       = f_ventarifas_decimales_precios(codigo_empresa,ls_tarifa)

	ls_mascara_moneda_tarifa  = f_mascara_decimales(li_decimales_precio)	
	
	if cbx_imprimir_promocion.checked and cbx_imprimir_no_promocion.checked then
		ls_promocion[1] = "S"
		ls_promocion[2] = "N"
	else
		if cbx_imprimir_promocion.checked then
			ls_promocion[1] = "S"
		else
			if cbx_imprimir_no_promocion.checked then
				ls_promocion[1] = "N"	
			else
				ls_promocion[1] = ""
			end if
		end if		
	end if
	
	if trim(uo_cliente.em_codigo.text) = '' then	
		f_mascara_columna(dw_listado,'precio',ls_mascara_moneda_tarifa)
	
//		dw_listado.setfilter(is_filtro_articulos)
//		dw_listado.filter()
	
		dw_listado.retrieve(codigo_empresa,ls_tarifa,ldt_ventarifas_activa,is_articulos_seleccionados,ls_promocion)	
		f_imprimir_datawindow(dw_listado)

	else				
		f_mascara_columna(dw_listado_cliente,'precio',ls_mascara_moneda_tarifa)
	
//		dw_listado_cliente.setfilter(is_filtro_articulos)
//		dw_listado_cliente.filter()
	
		dw_listado_cliente.retrieve(codigo_empresa,ls_tarifa,ldt_ventarifas_activa,uo_cliente.em_codigo.text,is_articulos_seleccionados,ls_promocion)	
		f_imprimir_datawindow(dw_listado_cliente)		
	end if
end if

dw_listado.reset()
dw_listado_cliente.reset()
end event

type cb_consulta from u_boton within wi_mant_tarifas_conjunto
integer x = 5966
integer y = 108
integer width = 462
integer height = 128
integer taborder = 30
boolean bringtotop = true
string text = "Consultar"
end type

event clicked;call super::clicked;string ls_tarifa,ls_moneda_tarifa,ls_mascara,ls_mascara_descuentos,ls_mascara_fechas
datetime ldt_ventarifas_activa

if uo_tarifa.em_codigo.text <> '' then
	is_filtro_articulos = f_filtro_articulos()
	
	ls_tarifa = uo_tarifa.em_codigo.text

	select ventarifas.moneda,
			 ventarifas.activa
	into   :ls_moneda_tarifa,
			 :ldt_ventarifas_activa
	from   ventarifas
	where  ventarifas.empresa = :codigo_empresa
	and    ventarifas.codigo  = :ls_tarifa;
	
	ls_mascara = f_mascara_moneda(ls_moneda_tarifa)
	ls_mascara_descuentos = f_mascara_decimales(2)
	ls_mascara_fechas = 'dd-mm-yyyy'
	
//	f_mascara_columna(dw_precios_tarifa,'precio',ls_mascara)
//	f_mascara_columna(dw_precios_clientes,'precio',ls_mascara)
	f_mascara_columna(dw_descuentos_tarifa,'descuento',ls_mascara_descuentos)
	f_mascara_columna(dw_descuentos_tarifa,'descuento2',ls_mascara_descuentos)
	f_mascara_columna(dw_descuentos_clientes,'descuento',ls_mascara_descuentos)
	f_mascara_columna(dw_descuentos_clientes,'descuento2',ls_mascara_descuentos)	
	f_mascara_columna(dw_descuentos_tarifa,'fecha_inicio_descuento',ls_mascara_fechas)
	f_mascara_columna(dw_descuentos_tarifa,'fecha_fin_descuento',ls_mascara_fechas)
	f_mascara_columna(dw_descuentos_clientes,'fecha_inicio_descuento',ls_mascara_fechas)
	f_mascara_columna(dw_descuentos_clientes,'fecha_fin_descuento',ls_mascara_fechas)	
	//

	//
	IF Trim(uo_articulo.em_campo.text) = "" THEN 
//		dw_precios_tarifa.setfilter(is_filtro_articulos)
//		dw_precios_tarifa.filter()
//		
//		dw_descuentos_tarifa.setfilter(is_filtro_articulos)
//		dw_descuentos_tarifa.filter()
		dw_precios_tarifa.setfilter("")
		dw_precios_tarifa.filter()
		
		dw_descuentos_tarifa.setfilter("")
		dw_descuentos_tarifa.filter()		
	else
		dw_precios_tarifa.setfilter("articulos_codigo = '"+uo_articulo.em_codigo.text+"'")
		dw_precios_tarifa.filter()
		
		dw_descuentos_tarifa.setfilter("articulos_codigo = '"+uo_articulo.em_codigo.text+"'")
		dw_descuentos_tarifa.filter()		
	END IF	
	

	dw_precios_tarifa.retrieve(codigo_empresa,ls_tarifa,ldt_ventarifas_activa,is_articulos_seleccionados)	
	dw_descuentos_tarifa.retrieve(codigo_empresa,ls_tarifa,ldt_ventarifas_activa, is_articulos_seleccionados)
	
	dw_precios_clientes.setredraw(false)
	dw_descuentos_clientes.setredraw(false)
	dw_precios_clientes.setfilter("")
	dw_precios_clientes.filter()
	dw_descuentos_clientes.setfilter("")
	dw_descuentos_clientes.filter()
	
	dw_precios_clientes.retrieve(codigo_empresa,is_articulos_seleccionados,ls_tarifa)
	dw_descuentos_clientes.retrieve(codigo_empresa,is_articulos_seleccionados,ls_tarifa)
	
	if dw_precios_tarifa.rowcount() > 0 then
		dw_precios_tarifa.event rowfocuschanged(1)
	else
		dw_precios_tarifa.event rowfocuschanged(0)
	end if
	
	dw_precios_clientes.setredraw(true)
	dw_descuentos_clientes.setredraw(true)
	
else	
	dw_precios_tarifa.reset()
	dw_descuentos_tarifa.reset()
	dw_precios_tarifa.reset()
	dw_descuentos_clientes.reset()
end if


end event

type cb_2 from commandbutton within wi_mant_tarifas_conjunto
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

type uo_tarifa from u_em_campo_2 within wi_mant_tarifas_conjunto
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
	
else	
	ls_moneda_empresa         = f_moneda_empresa(codigo_empresa)
	ls_moneda_tarifa          = f_moneda_ventarifas(codigo_empresa,uo_tarifa.em_codigo.text)
	li_decimales_precio       = f_ventarifas_decimales_precios(codigo_empresa,uo_tarifa.em_codigo.text)
	ls_mascara_moneda_empresa = f_mascara_precios_moneda(ls_moneda_empresa)
	ls_mascara_moneda_tarifa  = f_mascara_decimales(li_decimales_precio)
	
	f_mascara_columna(dw_precios_tarifa,"precio",ls_mascara_moneda_tarifa)
	f_mascara_columna(dw_precios_tarifa,"precio_euros",ls_mascara_moneda_empresa)
	
	f_mascara_columna(dw_precios_clientes,"precio",ls_mascara_moneda_tarifa)
	f_mascara_columna(dw_precios_clientes,"precio_euros",ls_mascara_moneda_empresa)
	
//	f_mascara_columna(dw_descuentos_tarifa,"precio",ls_mascara_moneda_tarifa)
//	f_mascara_columna(dw_descuentos_tarifa,"precio_euros",ls_mascara_moneda_empresa)
	
//	f_mascara_columna(dw_descuentos_cliente,"precio",ls_mascara_moneda_tarifa)
//	f_mascara_columna(dw_descuentos_cliente,"precio_euros",ls_mascara_moneda_empresa)	
	
end if 

dw_precios_tarifa.reset()
dw_descuentos_tarifa.reset()
dw_precios_clientes.reset()
dw_descuentos_clientes.reset()
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Tarifas"
ue_datawindow ="dw_ayuda_ventarifas"
ue_filtro = ""
end event

on uo_tarifa.destroy
call u_em_campo_2::destroy
end on

type pb_grabar from picturebutton within wi_mant_tarifas_conjunto
integer x = 6423
integer y = 108
integer width = 146
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\tencer_PB12\Save_24x24.png"
alignment htextalign = left!
string powertiptext = "Grabar"
end type

event clicked;integer rtn

//CONNECT USING SQLCA;
//Primero vamos a chequear si se han introducido todos los datos
if f_chequear_datos() then
	rtn = dw_precios_tarifa.Update()
	
	IF rtn = 1 THEN        
		rtn = dw_descuentos_tarifa.Update()
		
		IF rtn = 1 THEN        
			rtn = dw_precios_clientes.Update()
			
			IF rtn = 1 THEN        
				rtn = dw_descuentos_clientes.Update()
				
				IF rtn = 1 THEN        
					COMMIT USING SQLCA;
				ELSE  
					messagebox('Error al actualizar descuentos por cliente',sqlca.sqlerrtext)
					ROLLBACK USING SQLCA;
				END IF
			ELSE  
				messagebox('Error al actualizar precios por cliente',sqlca.sqlerrtext)
				ROLLBACK USING SQLCA;
			END IF
		ELSE  
			messagebox('Error al actualizar descuentos tarifa',sqlca.sqlerrtext)
			ROLLBACK USING SQLCA;
		END IF
	ELSE  
		messagebox('Error al actualizar precios tarifa',sqlca.sqlerrtext)
		ROLLBACK USING SQLCA;
	END IF
end if
end event

type dw_precios_tarifa from u_datawindow within wi_mant_tarifas_conjunto
integer y = 388
integer width = 3493
integer height = 1620
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Precios Tarifa"
string dataobject = "dwi_mant_tarifas_conjunto_1"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_articulo,ls_calidad
long   ll_donde

this.selectrow(0,false)

if currentrow = 0 then
	if cbx_solo_dtos_del_articulo_activo.checked then
		if is_filtro_articulos <> "" then
			dw_descuentos_tarifa.setfilter("articulos_codigo = '' and calidades_codigo = '' and "+is_filtro_articulos)	
		else
			dw_descuentos_tarifa.setfilter("articulos_codigo = '' and calidades_codigo = ''")	
		end if
		dw_descuentos_tarifa.filter()
	end if	
	if cbx_no_filtrar_articulos_cliente.checked then
		dw_precios_clientes.setfilter("")	
		dw_descuentos_clientes.setfilter("")			
	else
		dw_precios_clientes.setfilter("articulos_codigo = '' and calidades_codigo = ''")	
		dw_descuentos_clientes.setfilter("articulos_codigo = '' and calidades_codigo = ''")	
	end if
else
	ls_articulo = this.object.articulos_codigo[currentrow]
	if isnull(ls_articulo) then ls_articulo = ""
	ls_calidad  = this.object.calidades_codigo[currentrow]
	if isnull(ls_calidad) then ls_calidad = ""
	
	if uo_cliente.em_codigo.text = '' then
		if cbx_no_filtrar_articulos_cliente.checked then
			dw_precios_clientes.setfilter("")	
			dw_descuentos_clientes.setfilter("")			
		else		
			dw_precios_clientes.setfilter("articulos_codigo = '"+ls_articulo+"' and calidades_codigo = '"+ls_calidad+"'")			
			dw_descuentos_clientes.setfilter("articulos_codigo = '"+ls_articulo+"' and calidades_codigo = '"+ls_calidad+"'")
		end if
	else
		if cbx_no_filtrar_articulos_cliente.checked then
			dw_precios_clientes.setfilter("venclientes_codigo = '"+uo_cliente.em_codigo.text+"'")			
			dw_descuentos_clientes.setfilter("venclientes_codigo = '"+uo_cliente.em_codigo.text+"'")		
		else				
			dw_precios_clientes.setfilter("venclientes_codigo = '"+uo_cliente.em_codigo.text+"' and articulos_codigo = '"+ls_articulo+"' and calidades_codigo = '"+ls_calidad+"'")			
			dw_descuentos_clientes.setfilter("venclientes_codigo = '"+uo_cliente.em_codigo.text+"' and articulos_codigo = '"+ls_articulo+"' and calidades_codigo = '"+ls_calidad+"'")		
		end if
	end if
	
	if cbx_solo_dtos_del_articulo_activo.checked then
		dw_descuentos_tarifa.setfilter("articulos_codigo = '"+ls_articulo+"' and calidades_codigo = '"+ls_calidad+"'")
		dw_descuentos_tarifa.filter()
	else	
		dw_descuentos_tarifa.setfilter(is_filtro_articulos)
		dw_descuentos_tarifa.filter()
		
		ll_donde = dw_descuentos_tarifa.find("articulos_codigo = '"+ls_articulo+"' and calidades_codigo = '"+ls_calidad+"'",1,dw_descuentos_tarifa.rowcount())	
		
		if ll_donde > 0 then
			dw_descuentos_tarifa.setrow(ll_donde)
			dw_descuentos_tarifa.scrolltorow(ll_donde)
			
			dw_descuentos_tarifa.event rowfocuschanged(ll_donde)
		else
			dw_descuentos_tarifa.event rowfocuschanged(0)
			//dw_descuentos_clientes.setfilter("articulos_codigo = '"+ls_articulo+"' and calidades_codigo = '"+ls_calidad+"'")
		end if
	end if
	
	this.selectrow(currentrow,true)
end if

dw_precios_clientes.filter()
dw_precios_clientes.sort()

dw_descuentos_clientes.filter()
dw_descuentos_clientes.sort()
end event

event clicked;call super::clicked;long     ll_row,ll_donde
string   ls_tarifa,ls_ventarifas_moneda
datetime ldt_ventarifas_activa

if dwo.name = 'b_anyadir' then
	ls_tarifa = uo_tarifa.em_codigo.text
	
	SELECT ventarifas.moneda, 
			 ventarifas.activa
	INTO   :ls_ventarifas_moneda,
			 :ldt_ventarifas_activa
	FROM   ventarifas
	WHERE  ventarifas.empresa = :codigo_empresa
	AND    ventarifas.codigo  = :ls_tarifa;
	
	ll_row = this.getrow()
	
	ll_donde = this.insertrow(ll_row+1)

	this.object.empresa[ll_donde]               = codigo_empresa
	this.object.ventarifas_codigo[ll_donde]     = ls_tarifa
	this.object.ventarifas_activa[ll_donde]     = ldt_ventarifas_activa
	this.object.articulos_codigo[ll_donde]      = ""
	this.object.calidades_codigo[ll_donde]      = ""
	this.object.precio[ll_donde]                = 0
	this.object.ventarifas_moneda[ll_donde]     = ls_ventarifas_moneda
	
	this.setrow(ll_donde)
	this.scrolltorow(ll_donde)		
	
end if

if dwo.name = 'b_borrar' then
	
	ll_row = this.getrow()
	
	if ll_row > 0 then
		if MessageBox("Atención", "¿Desea borrar la linea?", Question!, YesNo!, 2) = 1 then
			this.deleterow(ll_row)
			
			ll_row --
			
			this.setrow(ll_row)
			this.scrolltorow(ll_row)				
			
		end if		
	end if
	
end if
end event

event rbuttondown;
bus_filtro = ""
bus_campo  = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "articulos_codigo"
		bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
		bus_datawindow = "dw_ayuda_articulos"
		
		if uo_articulo.em_codigo.text <> "" then
			bus_filtro     = "#1 = '"+uo_articulo.em_codigo.text+"'"			
		else		
			if is_filtro_articulos <> "" then
				string ls_filtro_articulos
				
				ls_filtro_articulos = is_filtro_articulos	
				ls_filtro_articulos = f_sustituir(ls_filtro_articulos,'articulos_codigo','#1')
				bus_filtro     = "articulos_uso = '3' and "+ls_filtro_articulos
			else
				bus_filtro     = "articulos_uso = '3'"			
			end if
		end if
	CASE "calidades_codigo"
		bus_titulo     = "VENTANA SELECCION DE CALIDADES "
		bus_datawindow = "dw_ayuda_calidades"
		bus_filtro     = ""		

	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event key;string ls_filtro_articulos

IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	bus_filtro=""
	bus_campo = This.GetColumnName()
	
	CHOOSE CASE bus_campo
		CASE "articulos_codigo"
			bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
			bus_datawindow = "dw_ayuda_articulos"
			
			if uo_articulo.em_codigo.text <> "" then
				bus_filtro     = "#1 = '"+uo_articulo.em_codigo.text+"'"			
			else		
				if is_filtro_articulos <> "" then
					
					ls_filtro_articulos = is_filtro_articulos	
					ls_filtro_articulos = f_sustituir(ls_filtro_articulos,'articulos_codigo','#1')
					bus_filtro     = "articulos_uso = '3' and "+ls_filtro_articulos
				else
					bus_filtro     = "articulos_uso = '3'"			
				end if
			end if			
						
		CASE "calidades_codigo"
			bus_titulo     = "VENTANA SELECCION DE CALIDADES "
			bus_datawindow = "dw_ayuda_calidades"
			bus_filtro     = ""		

		CASE ELSE
			SetNull(bus_campo)
	END CHOOSE
	CALL Super::Key
END IF

end event

event itemchanged;call super::itemchanged;string ls_articulo,ls_calidad,ls_nombre_articulo,ls_nombre_calidad
string ls_montajeartcal,ls_familia,ls_fomato,ls_modelo,ls_sub_familia,ls_nombre_formato
string ls_con_misma_clave
int    li_con_misma_clave

choose case dwo.name
	case "articulos_codigo"
		if isnumber(data) then
			if pos(is_filtro_articulos,"'"+data+"'") = 0 then
				messagebox("Atención","El articulo no está incluido en el filtro seleccionado.")
				this.object.articulos_codigo[row] = ""
				return 2				
			else
				if Trim(uo_articulo.em_campo.text) <> "" and uo_articulo.em_codigo.text <> data then
					messagebox("Atención","El articulo no está incluido en el filtro seleccionado.")
					this.object.articulos_codigo[row] = ""
					return 2									
				else
					ls_articulo        = data
					ls_calidad         = this.object.calidades_codigo[row]
					ls_nombre_articulo = f_nombre_articulo(codigo_empresa,ls_articulo)
					
					ls_con_misma_clave = this.describe('evaluate("sum(if (articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~',1,0) for all)",1)')
					li_con_misma_clave = integer(ls_con_misma_clave)		
					
					if li_con_misma_clave >= 1 then
						messagebox("Atención","Se está duplicando la clave.")
						this.object.articulos_codigo[row] = ""
						return 2				
					else
						if trim(ls_nombre_articulo) = "" then
							this.object.articulos_codigo[row] = ""
							return 2
						else
							ls_calidad = this.object.calidades_codigo[row]
							
						end if						
					end if			
				end if
			end if			
		end if
	case "calidades_codigo"
		if isnumber(data) then
			ls_calidad        = data
			ls_articulo       = this.object.articulos_codigo[row]	
	
			ls_nombre_calidad = f_nombre_calidad_abr(codigo_empresa,ls_calidad)		
			
			ls_con_misma_clave = this.describe('evaluate("sum(if (articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~',1,0) for all)",1)')
			li_con_misma_clave = integer(ls_con_misma_clave)		
			
			if li_con_misma_clave >= 1 then
				messagebox("Atención","Se está duplicando la clave.")
				this.object.calidades_codigo[row] = ""
				return 2
			else
				if trim(ls_nombre_calidad) = "" then
					this.object.calidades_codigo[row] = ""
					return 2				
				else

				end if
			end if
		end if
end choose
end event

type dw_precios_clientes from u_datawindow within wi_mant_tarifas_conjunto
integer x = 3502
integer y = 388
integer width = 3493
integer height = 1620
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Precios Clientes"
string dataobject = "dwi_mant_tarifas_conjunto_3"
boolean vscrollbar = true
end type

event clicked;call super::clicked;long     ll_row,ll_donde,ll_row_tarifa
string   ls_tarifa,ls_ventarifas_moneda,ls_articulo,ls_calidad

if dwo.name = 'b_anyadir' then
	ls_tarifa = uo_tarifa.em_codigo.text
	
	ll_row_tarifa = dw_precios_tarifa.getrow()
	if ll_row_tarifa > 0 then
		ls_articulo = dw_precios_tarifa.object.articulos_codigo[ll_row_tarifa]
		ls_calidad  = dw_precios_tarifa.object.calidades_codigo[ll_row_tarifa]
	else
		ls_articulo = ""
		ls_calidad  = ""
	end if
	
	SELECT ventarifas.moneda
	INTO   :ls_ventarifas_moneda
	FROM   ventarifas
	WHERE  ventarifas.empresa = :codigo_empresa
	AND    ventarifas.codigo  = :ls_tarifa;
	
	ll_row = this.getrow()
	
	ll_donde = this.insertrow(ll_row+1)

	this.object.empresa[ll_donde]               = codigo_empresa
	this.object.venclientes_codigo[ll_donde]    = uo_cliente.em_codigo.text
	this.object.articulos_codigo[ll_donde]      = ls_articulo
	this.object.calidades_codigo[ll_donde]      = ls_calidad
	this.object.precio[ll_donde]                = 0
	this.object.ventarifas_moneda[ll_donde]     = ls_ventarifas_moneda
	
	this.setrow(ll_donde)
	this.scrolltorow(ll_donde)		
	
end if

if dwo.name = 'b_borrar' then
	
	ll_row = this.getrow()
	
	if ll_row > 0 then
		if MessageBox("Atención", "¿Desea borrar la linea?", Question!, YesNo!, 2) = 1 then
			this.deleterow(ll_row)
			
			ll_row --
			
			this.setrow(ll_row)
			this.scrolltorow(ll_row)				
			
		end if		
	end if
	
end if
end event

event itemchanged;call super::itemchanged;string ls_cliente,ls_articulo,ls_calidad,ls_nombre_articulo,ls_nombre_calidad,ls_nombre_cliente
string ls_montajeartcal,ls_familia,ls_fomato,ls_modelo,ls_sub_familia,ls_nombre_formato
string ls_con_misma_clave
int    li_con_misma_clave

choose case dwo.name
	case "venclientes_codigo"
		if isnumber(data) then
			ls_cliente         = data
			ls_articulo        = this.object.articulos_codigo[row]
			ls_calidad         = this.object.calidades_codigo[row]
			ls_nombre_cliente = f_razon_genter(codigo_empresa,'C',ls_cliente)
			
			ls_con_misma_clave = this.describe('evaluate("sum(if (venclientes_codigo = ~''+ls_cliente+'~' and articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~',1,0) for all)",1)')
			li_con_misma_clave = integer(ls_con_misma_clave)		
			
			if li_con_misma_clave >= 1 then
				messagebox("Atención","Se está duplicando la clave.")
				this.object.venclientes_codigo[row] = ""
				return 2				
			else
				if trim(ls_nombre_cliente) = "" then
					this.object.venclientes_codigo[row] = ""
					return 2
				else
					ls_calidad = this.object.calidades_codigo[row]
					
				end if						
			end if			
			
		end if		
	case "articulos_codigo"
		if isnumber(data) then
			ls_cliente         = this.object.venclientes_codigo[row]
			ls_articulo        = data
			ls_calidad         = this.object.calidades_codigo[row]
			ls_nombre_articulo = f_nombre_articulo(codigo_empresa,ls_articulo)
			
			ls_con_misma_clave = this.describe('evaluate("sum(if (venclientes_codigo = ~''+ls_cliente+'~' and articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~',1,0) for all)",1)')
			li_con_misma_clave = integer(ls_con_misma_clave)		
			
			if li_con_misma_clave >= 1 then
				messagebox("Atención","Se está duplicando la clave.")
				this.object.articulos_codigo[row] = ""
				return 2				
			else
				if trim(ls_nombre_articulo) = "" then
					this.object.articulos_codigo[row] = ""
					return 2
				else
					ls_calidad = this.object.calidades_codigo[row]
					
				end if						
			end if			
			
		end if
	case "calidades_codigo"
		if isnumber(data) then
			ls_cliente        = this.object.venclientes_codigo[row]			
			ls_articulo       = this.object.articulos_codigo[row]	
			ls_calidad        = data
	
			ls_nombre_calidad = f_nombre_calidad_abr(codigo_empresa,ls_calidad)		
			
			ls_con_misma_clave = this.describe('evaluate("sum(if (venclientes_codigo = ~''+ls_cliente+'~' and articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~',1,0) for all)",1)')
			li_con_misma_clave = integer(ls_con_misma_clave)		
			
			if li_con_misma_clave >= 1 then
				messagebox("Atención","Se está duplicando la clave.")
				this.object.calidades_codigo[row] = ""
				return 2
			else
				if trim(ls_nombre_calidad) = "" then
					this.object.calidades_codigo[row] = ""
					return 2				
				else

				end if
			end if
		end if
end choose
end event

event key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	bus_filtro=""
	bus_campo = This.GetColumnName()
	
	CHOOSE CASE bus_campo
		CASE "venclientes_codigo"
			bus_titulo     = "VENTANA SELECCION DE CLIENTES "
			bus_datawindow = "dw_ayuda_clientes"
			bus_filtro     = ""							
		CASE "articulos_codigo"
			bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
			bus_datawindow = "dw_ayuda_articulos"
			
			if uo_articulo.em_codigo.text <> "" then
				bus_filtro     = "#1 = '"+uo_articulo.em_codigo.text+"'"			
			else		
				if is_filtro_articulos <> "" then
					string ls_filtro_articulos
					
					ls_filtro_articulos = is_filtro_articulos	
					ls_filtro_articulos = f_sustituir(ls_filtro_articulos,'articulos_codigo','#1')
					bus_filtro     = "articulos_uso = '3' and "+ls_filtro_articulos
				else
					bus_filtro     = "articulos_uso = '3'"			
				end if
			end if
		CASE "calidades_codigo"
			bus_titulo     = "VENTANA SELECCION DE CALIDADES "
			bus_datawindow = "dw_ayuda_calidades"
			bus_filtro     = ""		

		CASE ELSE
			SetNull(bus_campo)
	END CHOOSE
	CALL Super::Key
END IF
end event

event rbuttondown;bus_filtro = ""
bus_campo  = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "venclientes_codigo"
		bus_titulo     = "VENTANA SELECCION DE CLIENTES "
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""				
	CASE "articulos_codigo"
			bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
			bus_datawindow = "dw_ayuda_articulos"
			
			if uo_articulo.em_codigo.text <> "" then
				bus_filtro     = "#1 = '"+uo_articulo.em_codigo.text+"'"			
			else		
				if is_filtro_articulos <> "" then
					string ls_filtro_articulos
					
					ls_filtro_articulos = is_filtro_articulos	
					ls_filtro_articulos = f_sustituir(ls_filtro_articulos,'articulos_codigo','#1')
					bus_filtro     = "articulos_uso = '3' and "+ls_filtro_articulos
				else
					bus_filtro     = "articulos_uso = '3'"			
				end if
			end if
	CASE "calidades_codigo"
		bus_titulo     = "VENTANA SELECCION DE CALIDADES "
		bus_datawindow = "dw_ayuda_calidades"
		bus_filtro     = ""		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event rowfocuschanged;call super::rowfocuschanged;this.selectrow(0,false)

if currentrow > 0 then	
	this.selectrow(currentrow,true)
end if
end event

type dw_descuentos_clientes from u_datawindow within wi_mant_tarifas_conjunto
integer x = 3502
integer y = 2020
integer width = 3493
integer height = 1660
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "Descuentos Cliente"
string dataobject = "dwi_mant_tarifas_conjunto_4"
boolean vscrollbar = true
end type

event clicked;call super::clicked;long     ll_row,ll_donde,ll_row_tarifa
string   ls_tarifa,ls_ventarifas_moneda,ls_articulo,ls_calidad

if dwo.name = 'b_anyadir' then
	ls_tarifa = uo_tarifa.em_codigo.text
	
	ll_row_tarifa = dw_precios_tarifa.getrow()
	if ll_row_tarifa > 0 then
		ls_articulo = dw_precios_tarifa.object.articulos_codigo[ll_row_tarifa]
		ls_calidad  = dw_precios_tarifa.object.calidades_codigo[ll_row_tarifa]
	else
		ls_articulo = ""
		ls_calidad  = ""
	end if
	
	SELECT ventarifas.moneda
	INTO   :ls_ventarifas_moneda
	FROM   ventarifas
	WHERE  ventarifas.empresa = :codigo_empresa
	AND    ventarifas.codigo  = :ls_tarifa;
	
	ll_row = this.getrow()
	
	ll_donde = this.insertrow(ll_row+1)

	this.object.empresa[ll_donde]               = codigo_empresa
	this.object.venclientes_codigo[ll_donde]    = uo_cliente.em_codigo.text
	this.object.articulos_codigo[ll_donde]      = ls_articulo
	this.object.calidades_codigo[ll_donde]      = ls_calidad
	this.object.descuento[ll_donde]             = 0
	this.object.descuento2[ll_donde]            = 0
	this.object.ventarifas_moneda[ll_donde]     = ls_ventarifas_moneda
	this.object.cantidad[ll_donde]              = 0
	this.object.tipo_cantidad[ll_donde]         = "PZS"	
	this.object.fecha_inicio_descuento[ll_donde] = datetime(today())
	
	this.setrow(ll_donde)
	this.scrolltorow(ll_donde)		
	
end if

if dwo.name = 'b_borrar' then
	
	ll_row = this.getrow()
	
	if ll_row > 0 then
		if MessageBox("Atención", "¿Desea borrar la linea?", Question!, YesNo!, 2) = 1 then
			this.deleterow(ll_row)
			
			ll_row --
			
			this.setrow(ll_row)
			this.scrolltorow(ll_row)				
			
		end if		
	end if
	
end if
end event

event itemchanged;call super::itemchanged;string ls_cliente,ls_articulo,ls_calidad,ls_nombre_articulo,ls_nombre_calidad,ls_tipo_cantidad,ls_nombre_cliente
string ls_montajeartcal,ls_familia,ls_fomato,ls_modelo,ls_sub_familia,ls_nombre_formato
string ls_con_misma_clave
int    li_con_misma_clave
long   ll_cantidad
choose case dwo.name
	case "venclientes_codigo"
		if isnumber(data) then
			ls_cliente         = data
			ls_articulo        = this.object.articulos_codigo[row]
			ls_calidad         = this.object.calidades_codigo[row]
			ls_nombre_cliente = f_razon_genter(codigo_empresa,'C',ls_cliente)
			
			ls_con_misma_clave = this.describe('evaluate("sum(if (venclientes_codigo = ~''+ls_cliente+'~' and articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~' and cantidad = '+string(ll_cantidad,'####0')+' and tipo_cantidad = ~''+ls_tipo_cantidad+'~',1,0) for all)",1)')
			li_con_misma_clave = integer(ls_con_misma_clave)		
			
			if li_con_misma_clave >= 1 then
				messagebox("Atención","Se está duplicando la clave.")
				this.object.venclientes_codigo[row] = ""
				return 2				
			else
				if trim(ls_nombre_cliente) = "" then
					this.object.venclientes_codigo[row] = ""
					return 2
				else
					ls_calidad = this.object.calidades_codigo[row]					
				end if						
			end if			
			
		end if				
	case "articulos_codigo"
		if isnumber(data) then
			ls_cliente         = this.object.venclientes_codigo[row]
			ls_articulo        = data
			ls_calidad         = this.object.calidades_codigo[row]
			ll_cantidad        = this.object.cantidad[row]
			ls_tipo_cantidad   = this.object.tipo_cantidad[row]
			
			ls_nombre_articulo = f_nombre_articulo(codigo_empresa,ls_articulo)
			
			ls_con_misma_clave = this.describe('evaluate("sum(if (venclientes_codigo = ~''+ls_cliente+'~' and articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~' and cantidad = '+string(ll_cantidad,'####0')+' and tipo_cantidad = ~''+ls_tipo_cantidad+'~',1,0) for all)",1)')
			li_con_misma_clave = integer(ls_con_misma_clave)		
			
			if li_con_misma_clave >= 1 then
				messagebox("Atención","Se está duplicando la clave.")
				this.object.articulos_codigo[row] = ""
				return 2				
			else
				if trim(ls_nombre_articulo) = "" then
					this.object.articulos_codigo[row] = ""
					return 2
				else
					ls_calidad = this.object.calidades_codigo[row]					
				end if						
			end if			
			
		end if
	case "calidades_codigo"
		if isnumber(data) then
			ls_cliente         = this.object.venclientes_codigo[row]
			ls_calidad        = data
			ls_articulo       = this.object.articulos_codigo[row]	
			ll_cantidad       = this.object.cantidad[row]
			ls_tipo_cantidad  = this.object.tipo_cantidad[row]
			
			ls_nombre_calidad = f_nombre_calidad_abr(codigo_empresa,ls_calidad)		
			
			ls_con_misma_clave = this.describe('evaluate("sum(if (venclientes_codigo = ~''+ls_cliente+'~' and articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~' and cantidad = '+string(ll_cantidad,'####0')+' and tipo_cantidad = ~''+ls_tipo_cantidad+'~',1,0) for all)",1)')
			li_con_misma_clave = integer(ls_con_misma_clave)		
			
			if li_con_misma_clave >= 1 then
				messagebox("Atención","Se está duplicando la clave.")
				this.object.calidades_codigo[row] = ""
				return 2
			else
				if trim(ls_nombre_calidad) = "" then
					this.object.calidades_codigo[row] = ""
					return 2				
				else

				end if
			end if
		end if
	case "cantidad"
		ls_cliente        = this.object.venclientes_codigo[row]
		ls_calidad        = this.object.calidades_codigo[row]
		ls_articulo       = this.object.articulos_codigo[row]	
		ll_cantidad       = dec(data)
		ls_tipo_cantidad  = this.object.tipo_cantidad[row]
				
		ls_con_misma_clave = this.describe('evaluate("sum(if (venclientes_codigo = ~''+ls_cliente+'~' and articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~' and cantidad = '+string(ll_cantidad,'####0')+' and tipo_cantidad = ~''+ls_tipo_cantidad+'~',1,0) for all)",1)')
		li_con_misma_clave = integer(ls_con_misma_clave)		
		
		if li_con_misma_clave >= 1 then
			messagebox("Atención","Se está duplicando la clave.")
			return 2
		else

		end if
	case "tipo_cantidad"
		ls_cliente        = this.object.venclientes_codigo[row]
		ls_calidad        = this.object.calidades_codigo[row]
		ls_articulo       = this.object.articulos_codigo[row]	
		ll_cantidad       = this.object.cantidad[row]
		ls_tipo_cantidad  = data
		
		ls_con_misma_clave = this.describe('evaluate("sum(if (venclientes_codigo = ~''+ls_cliente+'~' and articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~' and cantidad = '+string(ll_cantidad,'####0')+' and tipo_cantidad = ~''+ls_tipo_cantidad+'~',1,0) for all)",1)')
		li_con_misma_clave = integer(ls_con_misma_clave)		
		
		if li_con_misma_clave >= 1 then
			messagebox("Atención","Se está duplicando la clave.")
			return 2
		else

		end if

end choose
end event

event key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	bus_filtro=""
	bus_campo = This.GetColumnName()
	
	CHOOSE CASE bus_campo
		CASE "venclientes_codigo"
			bus_titulo     = "VENTANA SELECCION DE CLIENTES "
			bus_datawindow = "dw_ayuda_clientes"
			bus_filtro     = ""							
		CASE "articulos_codigo"
			bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
			bus_datawindow = "dw_ayuda_articulos"
			
			if uo_articulo.em_codigo.text <> "" then
				bus_filtro     = "#1 = '"+uo_articulo.em_codigo.text+"'"			
			else		
				if is_filtro_articulos <> "" then
					string ls_filtro_articulos
					
					ls_filtro_articulos = is_filtro_articulos	
					ls_filtro_articulos = f_sustituir(ls_filtro_articulos,'articulos_codigo','#1')
					bus_filtro     = "articulos_uso = '3' and "+ls_filtro_articulos
				else
					bus_filtro     = "articulos_uso = '3'"			
				end if
			end if
		CASE "calidades_codigo"
			bus_titulo     = "VENTANA SELECCION DE CALIDADES "
			bus_datawindow = "dw_ayuda_calidades"
			bus_filtro     = ""		

		CASE ELSE
			SetNull(bus_campo)
	END CHOOSE
	CALL Super::Key
END IF
end event

event rbuttondown;bus_filtro = ""
bus_campo  = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "venclientes_codigo"
		bus_titulo     = "VENTANA SELECCION DE CLIENTES "
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""				
	CASE "articulos_codigo"
			bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
			bus_datawindow = "dw_ayuda_articulos"
			
			if uo_articulo.em_codigo.text <> "" then
				bus_filtro     = "#1 = '"+uo_articulo.em_codigo.text+"'"			
			else		
				if is_filtro_articulos <> "" then
					string ls_filtro_articulos
					
					ls_filtro_articulos = is_filtro_articulos	
					ls_filtro_articulos = f_sustituir(ls_filtro_articulos,'articulos_codigo','#1')
					bus_filtro     = "articulos_uso = '3' and "+ls_filtro_articulos
				else
					bus_filtro     = "articulos_uso = '3'"			
				end if
			end if
	CASE "calidades_codigo"
		bus_titulo     = "VENTANA SELECCION DE CALIDADES "
		bus_datawindow = "dw_ayuda_calidades"
		bus_filtro     = ""		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event rowfocuschanged;call super::rowfocuschanged;this.selectrow(0,false)

if currentrow > 0 then	
	this.selectrow(currentrow,true)
end if
end event

type gb_1 from groupbox within wi_mant_tarifas_conjunto
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

type dw_descuentos_tarifa from u_datawindow within wi_mant_tarifas_conjunto
integer y = 2020
integer width = 3493
integer height = 1660
integer taborder = 50
boolean titlebar = true
string title = "Descuentos Tarifa"
string dataobject = "dwi_mant_tarifas_conjunto_2"
boolean vscrollbar = true
end type

event clicked;call super::clicked;long     ll_row,ll_donde,ll_row_tarifa
string   ls_tarifa,ls_ventarifas_moneda,ls_articulo,ls_calidad
datetime ldt_ventarifas_activa

if dwo.name = 'b_anyadir' then
	ls_tarifa = uo_tarifa.em_codigo.text
	
	ll_row_tarifa = dw_precios_tarifa.getrow()
	if ll_row_tarifa > 0 then
		ls_articulo = dw_precios_tarifa.object.articulos_codigo[ll_row_tarifa]
		ls_calidad  = dw_precios_tarifa.object.calidades_codigo[ll_row_tarifa]
	else
		ls_articulo = ""
		ls_calidad  = ""
	end if	
	
	SELECT ventarifas.moneda, 
			 ventarifas.activa
	INTO   :ls_ventarifas_moneda,
			 :ldt_ventarifas_activa
	FROM   ventarifas
	WHERE  ventarifas.empresa = :codigo_empresa
	AND    ventarifas.codigo  = :ls_tarifa;
	
	ll_row = this.getrow()
	
	ll_donde = this.insertrow(ll_row+1)

	this.object.empresa[ll_donde]               = codigo_empresa
	this.object.ventarifas_codigo[ll_donde]     = ls_tarifa
	this.object.ventarifas_activa[ll_donde]     = ldt_ventarifas_activa
	this.object.articulos_codigo[ll_donde]      = ls_articulo
	this.object.calidades_codigo[ll_donde]      = ls_calidad
	this.object.descuento[ll_donde]             = 0
	this.object.descuento2[ll_donde]            = 0
	this.object.ventarifas_moneda[ll_donde]     = ls_ventarifas_moneda
	this.object.cantidad[ll_donde]              = 0
	this.object.tipo_cantidad[ll_donde]         = "PZS"
	this.object.fecha_inicio_descuento[ll_donde] = datetime(today())
	
	this.setrow(ll_donde)
	this.scrolltorow(ll_donde)		
	
end if

if dwo.name = 'b_borrar' then
	
	ll_row = this.getrow()
	
	if ll_row > 0 then
		if MessageBox("Atención", "¿Desea borrar la linea?", Question!, YesNo!, 2) = 1 then
			this.deleterow(ll_row)
			
			ll_row --
			
			this.setrow(ll_row)
			this.scrolltorow(ll_row)				
			
		end if		
	end if
	
end if
end event

event key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	bus_filtro=""
	bus_campo = This.GetColumnName()
	
	CHOOSE CASE bus_campo
		CASE "articulos_codigo"
			bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
			bus_datawindow = "dw_ayuda_articulos"
			
			if uo_articulo.em_codigo.text <> "" then
				bus_filtro     = "#1 = '"+uo_articulo.em_codigo.text+"'"			
			else		
				if is_filtro_articulos <> "" then
					string ls_filtro_articulos
					
					ls_filtro_articulos = is_filtro_articulos	
					ls_filtro_articulos = f_sustituir(ls_filtro_articulos,'articulos_codigo','#1')
					bus_filtro     = "articulos_uso = '3' and "+ls_filtro_articulos
				else
					bus_filtro     = "articulos_uso = '3'"			
				end if
			end if
		CASE "calidades_codigo"
			bus_titulo     = "VENTANA SELECCION DE CALIDADES "
			bus_datawindow = "dw_ayuda_calidades"
			bus_filtro     = ""		

		CASE ELSE
			SetNull(bus_campo)
	END CHOOSE
	CALL Super::Key
END IF

end event

event rbuttondown;bus_filtro = ""
bus_campo  = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "articulos_codigo"
			bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
			bus_datawindow = "dw_ayuda_articulos"
			
			if uo_articulo.em_codigo.text <> "" then
				bus_filtro     = "#1 = '"+uo_articulo.em_codigo.text+"'"			
			else		
				if is_filtro_articulos <> "" then
					string ls_filtro_articulos
					
					ls_filtro_articulos = is_filtro_articulos	
					ls_filtro_articulos = f_sustituir(ls_filtro_articulos,'articulos_codigo','#1')
					bus_filtro     = "articulos_uso = '3' and "+ls_filtro_articulos
				else
					bus_filtro     = "articulos_uso = '3'"			
				end if
			end if
	CASE "calidades_codigo"
		bus_titulo     = "VENTANA SELECCION DE CALIDADES "
		bus_datawindow = "dw_ayuda_calidades"
		bus_filtro     = ""		

	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_articulo,ls_calidad

this.selectrow(0,false)

if currentrow = 0 then
	//dw_descuentos_clientes.setfilter("articulos_codigo = '' and calidades_codigo = ''")	
else
	ls_articulo = this.object.articulos_codigo[currentrow]
	if isnull(ls_articulo) then ls_articulo = ""
	ls_calidad  = this.object.calidades_codigo[currentrow]
	if isnull(ls_calidad) then ls_calidad = ""
	
//	dw_descuentos_clientes.setfilter("articulos_codigo = '"+ls_articulo+"' and calidades_codigo = '"+ls_calidad+"'")	
	
	this.selectrow(currentrow,true)
end if

//dw_descuentos_clientes.filter()
//dw_descuentos_clientes.sort()
end event

event itemchanged;call super::itemchanged;string ls_articulo,ls_calidad,ls_nombre_articulo,ls_nombre_calidad,ls_tipo_cantidad
string ls_montajeartcal,ls_familia,ls_fomato,ls_modelo,ls_sub_familia,ls_nombre_formato
string ls_con_misma_clave
int    li_con_misma_clave
long   ll_cantidad
choose case dwo.name
	case "articulos_codigo"
		if isnumber(data) then
			ls_articulo        = data
			ls_calidad         = this.object.calidades_codigo[row]
			ll_cantidad        = this.object.cantidad[row]
			ls_tipo_cantidad   = this.object.tipo_cantidad[row]
			
			ls_nombre_articulo = f_nombre_articulo(codigo_empresa,ls_articulo)
			
			ls_con_misma_clave = this.describe('evaluate("sum(if (articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~' and cantidad = '+string(ll_cantidad,'####0')+' and tipo_cantidad = ~''+ls_tipo_cantidad+'~',1,0) for all)",1)')
			li_con_misma_clave = integer(ls_con_misma_clave)		
			
			if li_con_misma_clave >= 1 then
				messagebox("Atención","Se está duplicando la clave.")
				this.object.articulos_codigo[row] = ""
				return 2				
			else
				if trim(ls_nombre_articulo) = "" then
					this.object.articulos_codigo[row] = ""
					return 2
				else
					ls_calidad = this.object.calidades_codigo[row]					
				end if						
			end if			
			
		end if
	case "calidades_codigo"
		if isnumber(data) then
			ls_calidad        = data
			ls_articulo       = this.object.articulos_codigo[row]	
			ll_cantidad       = this.object.cantidad[row]
			ls_tipo_cantidad  = this.object.tipo_cantidad[row]
			
			ls_nombre_calidad = f_nombre_calidad_abr(codigo_empresa,ls_calidad)		
			
			ls_con_misma_clave = this.describe('evaluate("sum(if (articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~' and cantidad = '+string(ll_cantidad,'####0')+' and tipo_cantidad = ~''+ls_tipo_cantidad+'~',1,0) for all)",1)')
			li_con_misma_clave = integer(ls_con_misma_clave)		
			
			if li_con_misma_clave >= 1 then
				messagebox("Atención","Se está duplicando la clave.")
				this.object.calidades_codigo[row] = ""
				return 2
			else
				if trim(ls_nombre_calidad) = "" then
					this.object.calidades_codigo[row] = ""
					return 2				
				else

				end if
			end if
		end if
	case "cantidad"

		ls_calidad        = this.object.calidades_codigo[row]
		ls_articulo       = this.object.articulos_codigo[row]	
		ll_cantidad       = dec(data)
		ls_tipo_cantidad  = this.object.tipo_cantidad[row]
		
		ls_nombre_calidad = f_nombre_calidad_abr(codigo_empresa,ls_calidad)		
		
		ls_con_misma_clave = this.describe('evaluate("sum(if (articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~' and cantidad = '+string(ll_cantidad,'####0')+' and tipo_cantidad = ~''+ls_tipo_cantidad+'~',1,0) for all)",1)')
		li_con_misma_clave = integer(ls_con_misma_clave)		
		
		if li_con_misma_clave >= 1 then
			messagebox("Atención","Se está duplicando la clave.")
			return 2
		else

		end if
	case "tipo_cantidad"

		ls_calidad        = this.object.calidades_codigo[row]
		ls_articulo       = this.object.articulos_codigo[row]	
		ll_cantidad       = this.object.cantidad[row]
		ls_tipo_cantidad  = data
		
		ls_nombre_calidad = f_nombre_calidad_abr(codigo_empresa,ls_calidad)		
		
		ls_con_misma_clave = this.describe('evaluate("sum(if (articulos_codigo = ~''+ls_articulo+'~' and calidades_codigo = ~''+ls_calidad+'~' and cantidad = '+string(ll_cantidad,'####0')+' and tipo_cantidad = ~''+ls_tipo_cantidad+'~',1,0) for all)",1)')
		li_con_misma_clave = integer(ls_con_misma_clave)		
		
		if li_con_misma_clave >= 1 then
			messagebox("Atención","Se está duplicando la clave.")
			return 2
		else

		end if

end choose
end event

type uo_formatos from u_marca_lista within wi_mant_tarifas_conjunto
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

type uo_submarcas from u_marca_lista within wi_mant_tarifas_conjunto
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

type uo_marcas from u_marca_lista within wi_mant_tarifas_conjunto
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

type uo_familias from u_marca_lista within wi_mant_tarifas_conjunto
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

type uo_pavrev from u_marca_lista within wi_mant_tarifas_conjunto
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

type cb_formatos from commandbutton within wi_mant_tarifas_conjunto
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

type cb_submarcas from commandbutton within wi_mant_tarifas_conjunto
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

type cb_marcas from commandbutton within wi_mant_tarifas_conjunto
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

type cb_familias from commandbutton within wi_mant_tarifas_conjunto
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

type cb_pavrev from commandbutton within wi_mant_tarifas_conjunto
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

type cbx_solo_dtos_del_articulo_activo from checkbox within wi_mant_tarifas_conjunto
integer x = 23
integer y = 2036
integer width = 1422
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Mostrar únicamente los descuentos del artículo seleccionado"
boolean checked = true
end type

event clicked;dw_precios_tarifa.event rowfocuschanged(dw_precios_tarifa.getrow())
end event

type uo_cliente from u_em_campo_2 within wi_mant_tarifas_conjunto
event destroy ( )
integer x = 3621
integer y = 140
integer width = 2322
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
else
	string ls_tarifa_cliente
	
	ls_tarifa_cliente = f_tarifa_venclientes(codigo_empresa,uo_cliente.em_codigo.text)
	
	if ls_tarifa_cliente <> uo_tarifa.em_codigo.text then
		messagebox("¡Atención!","La el cliente no está asociado a la tarifa.")
		uo_cliente.em_campo.text=""
		uo_cliente.em_codigo.text=""		
	end if	
END IF

dw_precios_tarifa.event rowfocuschanged(dw_precios_tarifa.getrow())
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro      = ""
valor_empresa = true

end event

type uo_articulo from u_em_campo_2 within wi_mant_tarifas_conjunto
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

IF Trim(this.em_campo.text) = "" THEN 
	IF Trim(this.em_codigo.text) <> "" Then this.em_campo.SetFocus()
	this.em_campo.text  = ""
	this.em_codigo.text = ""
	
	dw_precios_tarifa.setfilter(is_filtro_articulos)
	dw_precios_tarifa.filter()
	
	dw_descuentos_tarifa.setfilter(is_filtro_articulos)
	dw_descuentos_tarifa.filter()		
else
	dw_precios_tarifa.setfilter("articulos_codigo = '"+this.em_codigo.text+"'")
	dw_precios_tarifa.filter()
	
	dw_descuentos_tarifa.setfilter("articulos_codigo = '"+this.em_codigo.text+"'")
	dw_descuentos_tarifa.filter()		
END IF

if dw_precios_tarifa.rowcount() > 0 then
	dw_precios_tarifa.event rowfocuschanged(1)
else
	dw_precios_tarifa.event rowfocuschanged(0)
end if

end event

type em_descripcion_a_buscar from u_em_campo within wi_mant_tarifas_conjunto
integer x = 1714
integer y = 284
integer width = 1778
integer taborder = 130
boolean bringtotop = true
end type

event tecla_enter;call super::tecla_enter;//f_control()
end event

event modificado;call super::modificado;il_ultimo_registro_encontrado = 0
end event

type p_buscar from picture within wi_mant_tarifas_conjunto
integer x = 3502
integer y = 292
integer width = 82
integer height = 68
boolean bringtotop = true
string picturename = "C:\bmp\FIND.BMP"
boolean border = true
boolean focusrectangle = false
end type

event clicked;long ll_registro_encontrado

if em_descripcion_a_buscar.text <> "" then
	ll_registro_encontrado = dw_precios_tarifa.find("nombre_articulo like '%"+em_descripcion_a_buscar.text+"%'",il_ultimo_registro_encontrado+1,dw_precios_tarifa.rowcount())
	
	if ll_registro_encontrado = 0 and il_ultimo_registro_encontrado = 0 then
		messagebox("Atención","No hay coincidencias")
	else
		if ll_registro_encontrado = 0 then
			messagebox("Atención","No hay mas coincidencias.~nEn la siguiente busqueda se buscará desde el primer registro.")
			il_ultimo_registro_encontrado = 0
		else
			il_ultimo_registro_encontrado = ll_registro_encontrado
			
			dw_precios_tarifa.event rowfocuschanged(il_ultimo_registro_encontrado)
			dw_precios_tarifa.scrolltorow(il_ultimo_registro_encontrado)
		end if
	end if
end if
end event

type uo_filial from u_em_campo_2 within wi_mant_tarifas_conjunto
integer x = 3621
integer y = 284
integer width = 2322
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes_filial"
ue_filtro      = ""
valor_empresa = true

//dw_ayuda_clientes_filial
end event

event modificado;call super::modificado;this.em_campo.text = f_nombre_cliente(codigo_empresa,'C',this.em_codigo.text)

IF Trim(this.em_campo.text)="" THEN 
	IF Trim(this.em_codigo.text)<>"" Then this.em_campo.SetFocus()
	this.em_campo.text=""
	this.em_codigo.text=""
END IF

uo_articulo.em_campo.text  = ""
uo_articulo.em_codigo.text = ""

is_filtro_articulos = f_filtro_articulos()

dw_precios_tarifa.setfilter(is_filtro_articulos)
dw_precios_tarifa.filter()

dw_descuentos_tarifa.setfilter(is_filtro_articulos)
dw_descuentos_tarifa.filter()		

if dw_precios_tarifa.rowcount() > 0 then
	dw_precios_tarifa.event rowfocuschanged(1)
else
	dw_precios_tarifa.event rowfocuschanged(0)
end if

end event

on uo_filial.destroy
call u_em_campo_2::destroy
end on

type dw_listado_cliente from datawindow within wi_mant_tarifas_conjunto
boolean visible = false
integer x = 6679
integer width = 146
integer height = 128
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_mant_tarifas_conjunto_cliente"
boolean livescroll = true
end type

type pb_excel from picturebutton within wi_mant_tarifas_conjunto
integer x = 6706
integer y = 108
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

event clicked;string ls_nombre_fichero,ls_ruta_fichero, ls_promocion[] 
long ll_registros 
string ls_tarifa,ls_moneda_tarifa,ls_mascara,ls_mascara_descuentos,ls_mascara_fechas
datetime ldt_ventarifas_activa

if uo_tarifa.em_codigo.text <> '' then
	is_filtro_articulos = f_filtro_articulos()
	
	ls_tarifa = uo_tarifa.em_codigo.text

	select ventarifas.moneda,
			 ventarifas.activa
	into   :ls_moneda_tarifa,
			 :ldt_ventarifas_activa
	from   ventarifas
	where  ventarifas.empresa = :codigo_empresa
	and    ventarifas.codigo  = :ls_tarifa;
	
	ls_mascara = f_mascara_moneda(ls_moneda_tarifa)
	ls_mascara_descuentos = f_mascara_decimales(2)
	ls_mascara_fechas = 'dd-mm-yy'
	
	if cbx_imprimir_promocion.checked and cbx_imprimir_no_promocion.checked then
		ls_promocion[1] = "S"
		ls_promocion[2] = "N"
	else
		if cbx_imprimir_promocion.checked then
			ls_promocion[1] = "S"
		else
			if cbx_imprimir_no_promocion.checked then
				ls_promocion[1] = "N"	
			else
				ls_promocion[1] = ""
			end if
		end if		
	end if	
	if trim(uo_cliente.em_codigo.text) = '' then	
		f_mascara_columna(dw_listado,'precio',ls_mascara)
	
//		dw_listado.setfilter(is_filtro_articulos)
//		dw_listado.filter()
	
		dw_listado.retrieve(codigo_empresa,ls_tarifa,ldt_ventarifas_activa,is_articulos_seleccionados, ls_promocion)	
		ll_registros = dw_listado.rowcount()

	else				
		f_mascara_columna(dw_listado_cliente,'precio',ls_mascara)
	
//		dw_listado_cliente.setfilter(is_filtro_articulos)
//		dw_listado_cliente.filter()
	
		dw_listado_cliente.retrieve(codigo_empresa,ls_tarifa,ldt_ventarifas_activa,uo_cliente.em_codigo.text,is_articulos_seleccionados, ls_promocion)	
		ll_registros = dw_listado_cliente.rowcount()		
	end if
end if

if ll_registros > 0 then
	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then		
		if trim(uo_cliente.em_codigo.text) = '' then	
			uf_save_dw_as_excel(dw_listado,ls_ruta_fichero)
		else
			uf_save_dw_as_excel(dw_listado_cliente,ls_ruta_fichero)
		end if
	end if
end if

dw_listado.reset()
dw_listado_cliente.reset()
end event

type cbx_no_filtrar_articulos_cliente from checkbox within wi_mant_tarifas_conjunto
integer x = 5966
integer y = 312
integer width = 736
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No filtrar articulos cliente"
end type

event clicked;dw_precios_tarifa.event rowfocuschanged(dw_precios_tarifa.getrow())
end event

type cbx_imprimir_promocion from checkbox within wi_mant_tarifas_conjunto
integer x = 5966
integer y = 248
integer width = 603
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir : Promoción"
boolean lefttext = true
end type

type cbx_imprimir_no_promocion from checkbox within wi_mant_tarifas_conjunto
integer x = 6578
integer y = 248
integer width = 421
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Promoción"
boolean checked = true
boolean lefttext = true
end type

type gb_5 from groupbox within wi_mant_tarifas_conjunto
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

type gb_2 from groupbox within wi_mant_tarifas_conjunto
integer x = 3602
integer y = 84
integer width = 2354
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Precios especiales y dtos especiales del cliente"
end type

type gb_3 from groupbox within wi_mant_tarifas_conjunto
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

type gb_4 from groupbox within wi_mant_tarifas_conjunto
integer x = 1701
integer y = 228
integer width = 1897
integer height = 148
integer taborder = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 32238571
string text = "Buscar Descripción"
end type

type gb_6 from groupbox within wi_mant_tarifas_conjunto
integer x = 3602
integer y = 228
integer width = 2354
integer height = 148
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Articulos de la Marca/Filial:"
end type

