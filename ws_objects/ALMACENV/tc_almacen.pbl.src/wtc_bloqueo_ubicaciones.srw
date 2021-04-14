$PBExportHeader$wtc_bloqueo_ubicaciones.srw
forward
global type wtc_bloqueo_ubicaciones from wt_consultas_padre
end type
type st_reservado from statictext within wtc_bloqueo_ubicaciones
end type
type pb_grabar_obs from picturebutton within wtc_bloqueo_ubicaciones
end type
type st_1 from statictext within wtc_bloqueo_ubicaciones
end type
type cb_1 from commandbutton within wtc_bloqueo_ubicaciones
end type
type st_clasificacion from statictext within wtc_bloqueo_ubicaciones
end type
type ddlb_clasificacion from dropdownlistbox within wtc_bloqueo_ubicaciones
end type
type st_2 from statictext within wtc_bloqueo_ubicaciones
end type
type st_3 from statictext within wtc_bloqueo_ubicaciones
end type
type st_alto from statictext within wtc_bloqueo_ubicaciones
end type
type em_largo from editmask within wtc_bloqueo_ubicaciones
end type
type em_ancho from editmask within wtc_bloqueo_ubicaciones
end type
type em_alto from editmask within wtc_bloqueo_ubicaciones
end type
type st_peso from statictext within wtc_bloqueo_ubicaciones
end type
type em_peso from editmask within wtc_bloqueo_ubicaciones
end type
type st_largo_unidad from statictext within wtc_bloqueo_ubicaciones
end type
type st_ancho_unidad from statictext within wtc_bloqueo_ubicaciones
end type
type st_alto_unidad from statictext within wtc_bloqueo_ubicaciones
end type
type st_peso_unidad from statictext within wtc_bloqueo_ubicaciones
end type
type cbx_clasificacion from checkbox within wtc_bloqueo_ubicaciones
end type
type cbx_largo from checkbox within wtc_bloqueo_ubicaciones
end type
type cbx_ancho from checkbox within wtc_bloqueo_ubicaciones
end type
type cbx_alto from checkbox within wtc_bloqueo_ubicaciones
end type
type cbx_peso from checkbox within wtc_bloqueo_ubicaciones
end type
type dw_etiquetas_bultos_100 from datawindow within wtc_bloqueo_ubicaciones
end type
type pb_imprimir_bultos from picturebutton within wtc_bloqueo_ubicaciones
end type
type st_4 from statictext within wtc_bloqueo_ubicaciones
end type
type st_5 from statictext within wtc_bloqueo_ubicaciones
end type
type cb_2 from commandbutton within wtc_bloqueo_ubicaciones
end type
type uo_ubicacion from u_em_campo_2 within wtc_bloqueo_ubicaciones
end type
type gb_1 from groupbox within wtc_bloqueo_ubicaciones
end type
type gb_3 from groupbox within wtc_bloqueo_ubicaciones
end type
type r_1 from rectangle within wtc_bloqueo_ubicaciones
end type
end forward

global type wtc_bloqueo_ubicaciones from wt_consultas_padre
integer width = 5074
integer height = 3844
string title = "Consulta Material por Ubicación"
st_reservado st_reservado
pb_grabar_obs pb_grabar_obs
st_1 st_1
cb_1 cb_1
st_clasificacion st_clasificacion
ddlb_clasificacion ddlb_clasificacion
st_2 st_2
st_3 st_3
st_alto st_alto
em_largo em_largo
em_ancho em_ancho
em_alto em_alto
st_peso st_peso
em_peso em_peso
st_largo_unidad st_largo_unidad
st_ancho_unidad st_ancho_unidad
st_alto_unidad st_alto_unidad
st_peso_unidad st_peso_unidad
cbx_clasificacion cbx_clasificacion
cbx_largo cbx_largo
cbx_ancho cbx_ancho
cbx_alto cbx_alto
cbx_peso cbx_peso
dw_etiquetas_bultos_100 dw_etiquetas_bultos_100
pb_imprimir_bultos pb_imprimir_bultos
st_4 st_4
st_5 st_5
cb_2 cb_2
uo_ubicacion uo_ubicacion
gb_1 gb_1
gb_3 gb_3
r_1 r_1
end type
global wtc_bloqueo_ubicaciones wtc_bloqueo_ubicaciones

type variables
string sql_inicial, sql_final, orden_seleccionado
boolean ib_ubicaciones_activas,ib_apilado_en_bloque
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_consulta ()
public function string f_construir_group_by ()
public subroutine f_cargar_datawindow (string new_sql)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Filtros mediante DW
	if pos(dw_montaje_filtro.object.linea[j], "Existencias") = 0 then
	
		if montaje = '' then
			montaje = dw_montaje_filtro.object.filtro[j]
		else
			montaje = montaje +' AND '+ dw_montaje_filtro.object.filtro[j]
		end if
	end if
next
if montaje <> '' then
	montaje = consulta_inicial + " AND " + montaje
else
	montaje = consulta_inicial
end if
return montaje


end function

public function string f_construir_consulta ();string cadena
datastore ds_datos

/*

cadena = "SELECT almubimapa_codbar.id, "+&
			"       almubimapa_codbar.empresa, "+&
			"       almubimapa_codbar.almacen, "+&
			"       almubimapa_codbar.zona, "+&
			"       almubimapa_codbar.fila, "+&
			"       almubimapa_codbar.altura, "+& 
			"       almubimapa_codbar.code39, "+&
			"       almubimapa_codbar.color_fondo, "+&
			"       almubimapa_codbar.color_texto, "+&
			"       'N' as marcado, "+&
			"       almubimapa_codbar.ean13, "+&
			"       almubimapa_codbar.activo, "+&
			"       almubimapa_codbar.clasificacion_abc, "+&
			"       almubimapa_codbar.largo_cm, "+&
			"       almubimapa_codbar.ancho_cm, "+&
			"       almubimapa_codbar.alto_cm, "+&
			"       almubimapa_codbar.peso_maximo_kg, "+&
         "       almubimapa_codbar.apilado_en_bloque "+&
			"FROM almubimapa_codbar "+&
			"WHERE ( almubimapa_codbar.empresa = '"+codigo_empresa+"' )"
			
*/

cadena = "  SELECT almubimapa_codbar.id,  "+& 
       "  almubimapa_codbar.empresa,   "+& 
       "  almubimapa_codbar.almacen,   "+& 
       "  almubimapa_codbar.zona,   "+& 
       "  almubimapa_codbar.fila,   "+& 
       "  almubimapa_codbar.altura,   "+& 
       "  almubimapa_codbar.code39,   "+& 
       "  almubimapa_codbar.color_fondo,  "+&  
       "  almubimapa_codbar.color_texto,   "+& 
       "  'N' as marcado,   "+& 
       "  almubimapa_codbar.ean13, "+&   
       "  almubimapa_codbar.activo,   "+& 
       "  almubimapa_codbar.clasificacion_abc, "+&   
       "  almubimapa_codbar.largo_cm,   "+& 
       "  almubimapa_codbar.ancho_cm,   "+& 
       "  almubimapa_codbar.alto_cm,   "+& 
       "  almubimapa_codbar.peso_maximo_kg, "+&   
       "  almubimapa_codbar.apilado_en_bloque, "+& 
		 "	almalmacen.descripcion, "+& 
		 "	tipo_ubicacion.descripcion "+& 
   " FROM almubimapa_codbar "+& 
	" inner join almalmacen on almubimapa_codbar.empresa = almalmacen.empresa and almubimapa_codbar.almacen = almalmacen.codigo "+& 
	" left outer join tipo_ubicacion on almubimapa_codbar.empresa = tipo_ubicacion.empresa and almubimapa_codbar.tipo_ubicacion = tipo_ubicacion.codigo "+& 
		"WHERE ( almubimapa_codbar.empresa = '"+codigo_empresa+"' )"

return cadena





end function

public function string f_construir_group_by ();string cadena

cadena = ""

return cadena
end function

public subroutine f_cargar_datawindow (string new_sql);long ll_indice,ll_total

datastore registros

dw_datos.reset()

f_cargar_cursor_nuevo (new_sql, registros)

if registros.rowcount() > 0 then
	
	dw_datos.object.data = registros.object.data
	
	ll_total = dw_datos.rowcount()
	
	for ll_indice = 1 to ll_total
		dw_datos.SetItemStatus(ll_indice, 0, Primary!, NotModified!)
	next
	
end if

destroy registros
end subroutine

on wtc_bloqueo_ubicaciones.create
int iCurrent
call super::create
this.st_reservado=create st_reservado
this.pb_grabar_obs=create pb_grabar_obs
this.st_1=create st_1
this.cb_1=create cb_1
this.st_clasificacion=create st_clasificacion
this.ddlb_clasificacion=create ddlb_clasificacion
this.st_2=create st_2
this.st_3=create st_3
this.st_alto=create st_alto
this.em_largo=create em_largo
this.em_ancho=create em_ancho
this.em_alto=create em_alto
this.st_peso=create st_peso
this.em_peso=create em_peso
this.st_largo_unidad=create st_largo_unidad
this.st_ancho_unidad=create st_ancho_unidad
this.st_alto_unidad=create st_alto_unidad
this.st_peso_unidad=create st_peso_unidad
this.cbx_clasificacion=create cbx_clasificacion
this.cbx_largo=create cbx_largo
this.cbx_ancho=create cbx_ancho
this.cbx_alto=create cbx_alto
this.cbx_peso=create cbx_peso
this.dw_etiquetas_bultos_100=create dw_etiquetas_bultos_100
this.pb_imprimir_bultos=create pb_imprimir_bultos
this.st_4=create st_4
this.st_5=create st_5
this.cb_2=create cb_2
this.uo_ubicacion=create uo_ubicacion
this.gb_1=create gb_1
this.gb_3=create gb_3
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_reservado
this.Control[iCurrent+2]=this.pb_grabar_obs
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.st_clasificacion
this.Control[iCurrent+6]=this.ddlb_clasificacion
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_alto
this.Control[iCurrent+10]=this.em_largo
this.Control[iCurrent+11]=this.em_ancho
this.Control[iCurrent+12]=this.em_alto
this.Control[iCurrent+13]=this.st_peso
this.Control[iCurrent+14]=this.em_peso
this.Control[iCurrent+15]=this.st_largo_unidad
this.Control[iCurrent+16]=this.st_ancho_unidad
this.Control[iCurrent+17]=this.st_alto_unidad
this.Control[iCurrent+18]=this.st_peso_unidad
this.Control[iCurrent+19]=this.cbx_clasificacion
this.Control[iCurrent+20]=this.cbx_largo
this.Control[iCurrent+21]=this.cbx_ancho
this.Control[iCurrent+22]=this.cbx_alto
this.Control[iCurrent+23]=this.cbx_peso
this.Control[iCurrent+24]=this.dw_etiquetas_bultos_100
this.Control[iCurrent+25]=this.pb_imprimir_bultos
this.Control[iCurrent+26]=this.st_4
this.Control[iCurrent+27]=this.st_5
this.Control[iCurrent+28]=this.cb_2
this.Control[iCurrent+29]=this.uo_ubicacion
this.Control[iCurrent+30]=this.gb_1
this.Control[iCurrent+31]=this.gb_3
this.Control[iCurrent+32]=this.r_1
end on

on wtc_bloqueo_ubicaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_reservado)
destroy(this.pb_grabar_obs)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_clasificacion)
destroy(this.ddlb_clasificacion)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_alto)
destroy(this.em_largo)
destroy(this.em_ancho)
destroy(this.em_alto)
destroy(this.st_peso)
destroy(this.em_peso)
destroy(this.st_largo_unidad)
destroy(this.st_ancho_unidad)
destroy(this.st_alto_unidad)
destroy(this.st_peso_unidad)
destroy(this.cbx_clasificacion)
destroy(this.cbx_largo)
destroy(this.cbx_ancho)
destroy(this.cbx_alto)
destroy(this.cbx_peso)
destroy(this.dw_etiquetas_bultos_100)
destroy(this.pb_imprimir_bultos)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.cb_2)
destroy(this.uo_ubicacion)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.r_1)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)


/*
sql_inicial = "select almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura,  "+&
"		alm_bultos_lineas.articulo, articulos.descripcion, formatos.abreviado, genter.razon,  "+&
"		alm_bultos_lineas.calidad, alm_bultos_lineas.tono, alm_bultos_lineas.calibre, alm_bultos_lineas.caja,  "+&
"		sum (alm_bultos_lineas.cantidad), alm_bultos.anyo_orden_carga, alm_bultos.codigo_orden_carga, alm_bultos.observaciones "+&
" from alm_bultos_lineas "+&
" inner join articulos on alm_bultos_lineas.empresa = articulos.empresa and alm_bultos_lineas.articulo = articulos.codigo "+&
" inner join formatos on articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo "+&
" inner join alm_bultos on alm_bultos_lineas.empresa = alm_bultos.empresa and alm_bultos_lineas.id_alm_bultos = alm_bultos.id  "+&
" inner join almubimapa_codbar on alm_bultos.empresa = almubimapa_codbar.empresa and alm_bultos.id_ubicacion = almubimapa_codbar.id "+&
" left outer join orden_carga on  orden_carga.empresa = alm_bultos.empresa and orden_carga.anyo = alm_bultos.anyo_orden_carga  and orden_carga.codigo = alm_bultos.codigo_orden_carga   "+&
" left outer join genter on genter.empresa = orden_carga.empresa and genter.codigo = orden_carga.cliente and genter.tipoter = 'C' "+&
"WHERE almacenmovimientos.empresa = '"+codigo_empresa+"' "

sql_final = "group by genter.razon, almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura, "+&
"		alm_bultos_lineas.articulo, articulos.descripcion, formatos.abreviado, genter.razon,  "+&
"		alm_bultos_lineas.calidad, alm_bultos_lineas.tono, alm_bultos_lineas.calibre, alm_bultos_lineas.caja, "+&
" 	alm_bultos.anyo_orden_carga, alm_bultos.codigo_orden_carga, alm_bultos.observaciones "+&
" order by almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura "

*/

/*
select almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura, 
		alm_bultos_lineas.articulo, articulos.descripcion, formatos.abreviado, genter.razon, 
		alm_bultos_lineas.calidad, alm_bultos_lineas.tono, alm_bultos_lineas.calibre, alm_bultos_lineas.caja, 
		sum (alm_bultos_lineas.cantidad), alm_bultos.anyo_orden_carga, alm_bultos.codigo_orden_carga, alm_bultos.observaciones
from alm_bultos_lineas
inner join articulos on alm_bultos_lineas.empresa = articulos.empresa and alm_bultos_lineas.articulo = articulos.codigo
inner join formatos on articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo
inner join alm_bultos on alm_bultos_lineas.empresa = alm_bultos.empresa and alm_bultos_lineas.id_alm_bultos = alm_bultos.id 
inner join almubimapa_codbar on alm_bultos.empresa = almubimapa_codbar.empresa and alm_bultos.id_ubicacion = almubimapa_codbar.id
left outer join orden_carga on  orden_carga.empresa = alm_bultos.empresa and orden_carga.anyo = alm_bultos.anyo_orden_carga  and orden_carga.codigo = alm_bultos.codigo_orden_carga  
left outer join genter on genter.empresa = orden_carga.empresa and genter.codigo = orden_carga.cliente and genter.tipoter = 'C'
group by genter.razon, almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura,
		alm_bultos_lineas.articulo, articulos.descripcion, formatos.abreviado, genter.razon, 
		alm_bultos_lineas.calidad, alm_bultos_lineas.tono, alm_bultos_lineas.calibre, alm_bultos_lineas.caja,
 	alm_bultos.anyo_orden_carga, alm_bultos.codigo_orden_carga, alm_bultos.observaciones
order by almubimapa_codbar.almacen, almubimapa_codbar.zona, almubimapa_codbar.fila, almubimapa_codbar.altura;

*/







end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_bloqueo_ubicaciones
integer x = 3456
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_bloqueo_ubicaciones
integer x = 3698
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_bloqueo_ubicaciones
integer x = 3899
integer y = 96
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_bloqueo_ubicaciones
integer x = 4055
integer y = 96
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_bloqueo_ubicaciones
integer width = 4210
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_bloqueo_ubicaciones
integer x = 3749
integer y = 96
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

st_reservado.text = ''

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
if dw_montaje_filtro.rowcount() > 0 then
	new_sql = f_montar_filtro(sql_inicial)  + sql_final
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
else
	dw_datos.reset()
end if

//Filtros mediante Datawindow
filtro_dw = "1 = 1"
For j = 1 To dw_montaje_filtro.rowcount()
	if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
		filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
	end if
Next
dw_datos.setfilter(filtro_dw)
dw_datos.filter()

//if dw_montaje_filtro.rowcount() > 3 then
//	dw_montaje_filtro.height = dw_montaje_filtro.height -75
//	dw_datos.y = dw_datos.y - 75
//	dw_datos.height = dw_datos.height + 75
//else
//	dw_datos.y = 512
//	dw_datos.height = 2192
//	dw_montaje_filtro.height = 225
//end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_bloqueo_ubicaciones
integer x = 4210
integer y = 96
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_bloqueo_ubicaciones
integer x = 3598
integer y = 96
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, filas,ll_indice,ll_total
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw
boolean crear_filtro

sql_inicial = f_construir_consulta ()
sql_final = f_construir_group_by ()
st_reservado.text = ''

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Almacen"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almubimapa_codbar.almacen = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Almacen = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almubimapa_codbar.almacen = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 		
	
		case "Zona"
			if cadena_or = '' then
				cadena_or = " almubimapa_codbar.zona "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Zona "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Fila"
			if cadena_or = '' then
				cadena_or = " almubimapa_codbar.fila "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Fila "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Altura"
			if cadena_or = '' then
				cadena_or = " almubimapa_codbar.altura "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Altura "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Zona Estanteria"
			ll_total = lb_lista.totalitems()

			for ll_indice = 1 to ll_total
				if cadena_or = '' then
					if lb_lista.state(ll_indice) = 1 then
						if lb_lista.text(ll_indice) = "Izquierda" then
							cadena_or = " almubimapa_codbar.fila in (1,4,7,10,13,16,19,22,25,28,31,34,37,40,43,46,49,52,55,58,61,64,67,70,73,76,79,82,85,88,91,94,97,100) "
						else
							if lb_lista.text(ll_indice) = "Central" then
								cadena_or = " almubimapa_codbar.fila in (2,5,8,11,14,17,20,23,26,29,32,35,38,41,44,47,50,53,56,59,62,65,68,71,74,77,80,83,86,89,92,95,98,101) "
							else
								//"Derecha"
								cadena_or = " almubimapa_codbar.fila in (3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,60,63,66,69,72,75,78,81,84,87,90,93,96,99,102) "
							end if					
						end if
						cadena_or_visible = " Zona Estanteria "+ddlb_operador.text+" '"+lb_lista.text(ll_indice)+"' "
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
			
			new_sql = f_montar_filtro(sql_inicial) + sql_final
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		else
			new_sql = sql_inicial + sql_final
		end if
	else
		new_sql = sql_inicial + sql_final
	end if
	
	f_cargar_datawindow (new_sql)
	
//	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if	
	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	
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
	
	
	/*
	
	//Para evitar solapamiento con otros datawindows
	dw_filtro.Height = 260
	
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
	end if
	
	*/
	

	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
else
	
	new_sql = f_montar_filtro(sql_inicial) + sql_final
	
	f_cargar_datawindow (new_sql)
	
	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
	
/*	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
	*/
end if


//Al hacer más quieren que se restablezca el orden
//orden_seleccionado = "articulos_descripcion A"
//dw_datos.setsort("integer(almacen) A, zona A, fila A, altura A")

pb_grabar_obs.visible = false

dw_datos.sort()


end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_bloqueo_ubicaciones
integer x = 951
integer taborder = 0
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_bloqueo_ubicaciones
integer width = 878
integer height = 1308
integer taborder = 0
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Almacen","Zona","Fila","Altura","Zona Estanteria","","","","","","","","","","","",""}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Almacen"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from almalmacen where empresa = '"+codigo_empresa+"' order by codigo ASC"

	CASE "Promoción"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("S")
		lb_lista.AddItem ("N")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="	
		
	CASE "Articulo (Descripción)"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select distinct almacenmovimientos.articulo as Código, CONVERT(char(60),articulos.descripcion) as Descripción, formatos.abreviado as Formato, art_ver_tipooperacion.descripcion_abr as Operación, CONVERT(char(10),almusos.descripcion) AS Uso, genter.razon "+&
						"from almacenmovimientos LEFT OUTER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
						"LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
						"LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
						"LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
						"LEFT OUTER JOIN genter ON articulos.empresa = genter.empresa AND articulos.cliente = genter.codigo AND genter.tipoter = 'C' "+&
						"where almacenmovimientos.empresa = '"+codigo_empresa+"' order by CONVERT(char(60), articulos.descripcion)"
	CASE "Artículo (Código)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="		
	CASE "Formato"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
//		consulta = "Select formatos.codigo as Código, formatos.abreviado as Descripción "+&
//						"from formatos "+&
//						"where formatos.empresa = '"+codigo_empresa+"' order by formatos.descripcion ASC"		
		consulta = "Select formatos.codigo as Código, CONVERT(char(10), formatos.descripcion) as Descripcion, CONVERT(decimal(5,2), formatos.ancho) as Ancho, CONVERT(decimal(5,2),formatos.largo) as Largo, formatos.abreviado as Comercial "+&
						"from formatos "+&
						"where formatos.empresa = '"+codigo_empresa+"' order by formatos.descripcion ASC"	
	CASE "Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where empresa = '"+codigo_empresa+"' AND tipoter = 'C' order by razon ASC"
	CASE "Zona"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
	CASE "Zona Estanteria"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("Izquierda")
		lb_lista.AddItem ("Central")
		lb_lista.AddItem ("Derecha")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="	
	CASE "Existencias", "Fila", "Altura"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem (">")
		ddlb_operador.AddItem ("<")
		ddlb_operador.AddItem (">=")
		ddlb_operador.AddItem ("<=")
		ddlb_operador.AddItem ("=")
		
		ddlb_operador.text = ">="
	CASE "Ubicado Muelle", "Ubicado M.Distribución", "Ubicado Anulaciones/Abonos", "Pendiente de Preparar"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("S")
		lb_lista.SetState ( 1, true)
		
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		pb_anyadir1.triggerevent("clicked")


	CASE "Uso"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from almusos WHERE empresa = '"+codigo_empresa+"' "
	CASE "Familia"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from familias where empresa = '"+codigo_empresa+"' order by codigo ASC"
	CASE "Calidad"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from calidades where empresa = '"+codigo_empresa+"' order by codigo ASC"
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_bloqueo_ubicaciones
integer y = 512
integer width = 3822
integer height = 3068
integer taborder = 40
string dataobject = "dw_bloqueo_ubicaciones"
end type

event dw_datos::itemchanged;call super::itemchanged;//if dwo.name = "activo" then
	pb_grabar_obs.visible = true
	this.SetItemStatus(row, 0, Primary!, DataModified!)
//end if
end event

event dw_datos::retrieveend;call super::retrieveend;
f_mascara_columna(this,"largo_cm","###,##0")
f_mascara_columna(this,"ancho_cm","###,##0")
f_mascara_columna(this,"alto_cm","###,##0")
f_mascara_columna(this,"peso_maximo_kg","###,##0")

ib_ubicaciones_activas = true
ib_apilado_en_bloque   = false
end event

event dw_datos::clicked;call super::clicked;long ll_donde

if dwo.name = 't_activo' then
	for ll_donde = 1 to this.rowcount()
		//this.SetItemStatus(ll_donde, 0, Primary!, DataModified!)
		if ib_ubicaciones_activas then
			this.event itemchanged(ll_donde,this.object.activo,'N')
			this.object.activo[ll_donde] = 'N' 			
		else
			this.event itemchanged(ll_donde,this.object.activo,'S')
			this.object.activo[ll_donde] = 'S'
		end if	
	next
	ib_ubicaciones_activas = not(ib_ubicaciones_activas)	
else
	if dwo.name = 't_apilado_en_bloque' then
		for ll_donde = 1 to this.rowcount()
			//this.SetItemStatus(ll_donde, 0, Primary!, DataModified!)
			if ib_apilado_en_bloque then
				this.event itemchanged(ll_donde,this.object.apilado_en_bloque,'N')
				this.object.apilado_en_bloque[ll_donde] = 'N' 
			else
				this.event itemchanged(ll_donde,this.object.apilado_en_bloque,'S')
				this.object.apilado_en_bloque[ll_donde] = 'S'
			end if	
		next
		ib_apilado_en_bloque = not(ib_apilado_en_bloque)
	end if	
end if		
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_bloqueo_ubicaciones
integer x = 4366
integer y = 96
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_bloqueo_ubicaciones
end type

type p_logo from wt_consultas_padre`p_logo within wtc_bloqueo_ubicaciones
integer x = 3995
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_bloqueo_ubicaciones
integer x = 46
integer width = 4457
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_bloqueo_ubicaciones
integer x = 2871
integer y = 132
integer taborder = 150
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_bloqueo_ubicaciones
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 10
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_bloqueo_ubicaciones
integer x = 1307
integer height = 96
integer taborder = 160
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_bloqueo_ubicaciones
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_bloqueo_ubicaciones
integer x = 1312
integer y = 132
integer width = 462
integer height = 356
integer taborder = 140
long textcolor = 24076881
end type

type st_reservado from statictext within wtc_bloqueo_ubicaciones
integer x = 3109
integer y = 356
integer width = 1006
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type pb_grabar_obs from picturebutton within wtc_bloqueo_ubicaciones
boolean visible = false
integer x = 3442
integer y = 96
integer width = 146
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;if dw_datos.update(true) = -1 then
	MessageBox("SQL error " + String(SQLCA.SQLDBCode),  SQLCA.SQLErrText )
	rollback using SQLCA;
else
	commit using SQLCA;
end if

pb_grabar_obs.visible = false

end event

type st_1 from statictext within wtc_bloqueo_ubicaciones
integer x = 2272
integer y = 16
integer width = 910
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_1 from commandbutton within wtc_bloqueo_ubicaciones
integer x = 4078
integer y = 1344
integer width = 736
integer height = 112
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aplicar"
end type

event clicked;long ll_indice,ll_total,ll_largo,ll_ancho,ll_alto,ll_peso
string ls_clasificacion

ls_clasificacion = ddlb_clasificacion.text
ll_largo         = long(em_largo.text)
ll_ancho         = long(em_ancho.text)
ll_alto          = long(em_alto.text)
ll_peso          = long(em_peso.text)

ll_total = dw_datos.rowcount()

if ll_total > 0 and (cbx_clasificacion.checked or cbx_largo.checked or cbx_ancho.checked or cbx_alto.checked or cbx_peso.checked) then
	pb_grabar_obs.visible = true
	
	for ll_indice = 1 to ll_total
		f_mensaje_proceso("",ll_indice,ll_total)
		dw_datos.SetItemStatus(ll_indice, 0, Primary!, DataModified!)
		
		if cbx_clasificacion.checked then
			dw_datos.object.clasificacion_abc[ll_indice] = ls_clasificacion
		end if
		
		if cbx_largo.checked then
			dw_datos.object.largo_cm[ll_indice] = ll_largo
		end if
		
		if cbx_ancho.checked then
			dw_datos.object.ancho_cm[ll_indice] = ll_ancho
		end if
		
		if cbx_alto.checked then
			dw_datos.object.alto_cm[ll_indice] = ll_alto
		end if
		
		if cbx_peso.checked then
			dw_datos.object.peso_maximo_kg[ll_indice] = ll_peso
		end if
		
	next
end if
end event

type st_clasificacion from statictext within wtc_bloqueo_ubicaciones
integer x = 4087
integer y = 740
integer width = 402
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clasificacion:"
boolean focusrectangle = false
end type

type ddlb_clasificacion from dropdownlistbox within wtc_bloqueo_ubicaciones
integer x = 4494
integer y = 724
integer width = 265
integer height = 392
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
string text = "B"
string item[] = {"A+","A","B","C"}
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within wtc_bloqueo_ubicaciones
integer x = 4087
integer y = 856
integer width = 315
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Largo:"
boolean focusrectangle = false
end type

type st_3 from statictext within wtc_bloqueo_ubicaciones
integer x = 4087
integer y = 972
integer width = 315
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ancho:"
boolean focusrectangle = false
end type

type st_alto from statictext within wtc_bloqueo_ubicaciones
integer x = 4087
integer y = 1088
integer width = 315
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Alto:"
boolean focusrectangle = false
end type

type em_largo from editmask within wtc_bloqueo_ubicaciones
integer x = 4411
integer y = 840
integer width = 238
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####0"
end type

type em_ancho from editmask within wtc_bloqueo_ubicaciones
integer x = 4411
integer y = 956
integer width = 238
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####0"
end type

type em_alto from editmask within wtc_bloqueo_ubicaciones
integer x = 4411
integer y = 1072
integer width = 238
integer height = 96
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####0"
end type

type st_peso from statictext within wtc_bloqueo_ubicaciones
integer x = 4087
integer y = 1204
integer width = 315
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Peso Max:"
boolean focusrectangle = false
end type

type em_peso from editmask within wtc_bloqueo_ubicaciones
integer x = 4411
integer y = 1188
integer width = 238
integer height = 96
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####0"
end type

type st_largo_unidad from statictext within wtc_bloqueo_ubicaciones
integer x = 4654
integer y = 856
integer width = 105
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cm"
boolean focusrectangle = false
end type

type st_ancho_unidad from statictext within wtc_bloqueo_ubicaciones
integer x = 4654
integer y = 972
integer width = 105
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cm"
boolean focusrectangle = false
end type

type st_alto_unidad from statictext within wtc_bloqueo_ubicaciones
integer x = 4654
integer y = 1088
integer width = 105
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cm"
boolean focusrectangle = false
end type

type st_peso_unidad from statictext within wtc_bloqueo_ubicaciones
integer x = 4654
integer y = 1204
integer width = 105
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Kg"
boolean focusrectangle = false
end type

type cbx_clasificacion from checkbox within wtc_bloqueo_ubicaciones
integer x = 4763
integer y = 720
integer width = 82
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cbx_largo from checkbox within wtc_bloqueo_ubicaciones
integer x = 4763
integer y = 840
integer width = 82
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cbx_ancho from checkbox within wtc_bloqueo_ubicaciones
integer x = 4763
integer y = 956
integer width = 82
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cbx_alto from checkbox within wtc_bloqueo_ubicaciones
integer x = 4763
integer y = 1072
integer width = 82
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cbx_peso from checkbox within wtc_bloqueo_ubicaciones
integer x = 4763
integer y = 1188
integer width = 82
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_etiquetas_bultos_100 from datawindow within wtc_bloqueo_ubicaciones
boolean visible = false
integer x = 3950
integer y = 2156
integer width = 1001
integer height = 756
integer taborder = 41
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiquetas_bultos_ubicaciones_100x60"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_imprimir_bultos from picturebutton within wtc_bloqueo_ubicaciones
integer x = 4667
integer y = 1484
integer width = 151
integer height = 128
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;string ls_ean_13,ls_almacen,ls_zona,ls_sel,ls_descripcion_bulto
long ll_donde,ll_desde,ll_hasta,ll_indice,ll_total,ll_lineas_bulto
int  li_row_etiqueta,li_fila,li_altura
str_alm_bultos lstr_alm_bultos

datastore ds_datos

ll_desde = 1
ll_hasta = dw_datos.rowcount()

dw_etiquetas_bultos_100.reset()

for ll_donde = 1 to ll_hasta		
	ls_almacen = dw_datos.object.almacen[ll_donde]
	ls_zona    = dw_datos.object.zona[ll_donde]
	li_fila    = dw_datos.object.fila[ll_donde]
	li_altura  = dw_datos.object.altura[ll_donde]
	
	ls_sel = "SELECT alm_bultos.id "+&
				"FROM   alm_bultos, "+& 
				"       alm_bultos_lineas, "+& 
				"		  almubimapa_codbar "+&
				"WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
				"AND   ( alm_bultos.id_ubicacion = almubimapa_codbar.id ) "+&
				"and ( ( alm_bultos.empresa        = '"+codigo_empresa+"' ) "+&
				"AND   ( almubimapa_codbar.almacen = '"+ls_almacen+"' ) "+&
				"AND   ( almubimapa_codbar.zona    = '"+ls_zona+"' ) "+&
				"AND   ( almubimapa_codbar.fila    = "+string(li_fila,"###0")+" ) "+&
				"AND   ( almubimapa_codbar.altura  = "+string(li_altura,"##0")+" ) ) "+&   
				"ORDER BY alm_bultos.id ASC"
	
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total
		lstr_alm_bultos.id = ds_datos.object.alm_bultos_id[ll_indice]
		
		if f_cargar_str_alm_bultos(lstr_alm_bultos.id,lstr_alm_bultos) then
			ls_descripcion_bulto = ''
			ll_lineas_bulto = 0
			
			select isnull(count(*),0)
			into   :ll_lineas_bulto
			from   alm_bultos_lineas
			where  alm_bultos_lineas.id_alm_bultos = :lstr_alm_bultos.id;
			
			if ll_lineas_bulto = 1 then
				select 'B '+ltrim(rtrim(isnull(articulos.descripcion,'')))+' '+ltrim(rtrim(isnull(formatos.descripcion,'')))+' '+ltrim(rtrim(convert(char(10),isnull(convert(dec(16,0),alm_bultos_lineas.cantidad),0))))+' UDS'
				into   :ls_descripcion_bulto 
				from   alm_bultos_lineas,
						 articulos,
						 formatos 
				where  alm_bultos_lineas.empresa  = articulos.empresa 
				and    alm_bultos_lineas.articulo = articulos.codigo 
				and    alm_bultos_lineas.empresa  = formatos.empresa 
				and    articulos.formato          = formatos.codigo 
				and    alm_bultos_lineas.id_alm_bultos = :lstr_alm_bultos.id;					
			else
				ls_descripcion_bulto = 'B MULTIREFERENCIA'
			end if
			
			ls_ean_13 = lstr_alm_bultos.ean13
			if isnull(ls_ean_13) then ls_ean_13 = ""
		
			if trim(ls_ean_13) = "" then
				ls_ean_13 = "25"+string(lstr_alm_bultos.id,"0000000000")
				ls_ean_13 = f_calcula_ean13(ls_ean_13)
			end if
			
			li_row_etiqueta = dw_etiquetas_bultos_100.insertrow(0)
		
			dw_etiquetas_bultos_100.object.codigo_barras[li_row_etiqueta] = f_imprimir_ean_13(ls_ean_13)
			dw_etiquetas_bultos_100.object.descripcion[li_row_etiqueta]   = ls_ean_13//"B"+string(lstr_alm_bultos.id,"0000000000")
			dw_etiquetas_bultos_100.object.almacen[li_row_etiqueta]       = ls_descripcion_bulto
			dw_etiquetas_bultos_100.object.zona[li_row_etiqueta]          = ""
			dw_etiquetas_bultos_100.object.fila[li_row_etiqueta]          = ""
			dw_etiquetas_bultos_100.object.altura[li_row_etiqueta]        = ""
			dw_etiquetas_bultos_100.object.color_fondo[li_row_etiqueta]   = rgb(255,255,255)//dw_datos.object.color_fondo[ll_donde] //
			dw_etiquetas_bultos_100.object.color_texto[li_row_etiqueta]   = rgb(0,0,0)//dw_datos.object.color_texto[ll_donde] //
			dw_etiquetas_bultos_100.object.texto_control[li_row_etiqueta] = ls_almacen+'-'+ls_zona+'-'+string(li_fila,"###0")+'-'+string(li_altura,"##0")
		
			dw_etiquetas_bultos_100.object.flecha_abajo[li_row_etiqueta]  = 'N'
			dw_etiquetas_bultos_100.object.flecha_arriba[li_row_etiqueta] = 'N'												
		end if
	next
	
	destroy ds_datos
next

if li_row_etiqueta > 0 then
	dw_etiquetas_bultos_100.setredraw(false)
	//dw_etiquetas_bultos_100.Object.DataWindow.Zoom = 100
	dw_etiquetas_bultos_100.groupcalc()
	f_imprimir_datawindow(dw_etiquetas_bultos_100)
	//dw_etiquetas_bultos_100.Object.DataWindow.Zoom = 50
	dw_etiquetas_bultos_100.setredraw(true)
	
	dw_etiquetas_bultos_100.reset()
end if
end event

type st_4 from statictext within wtc_bloqueo_ubicaciones
integer x = 4096
integer y = 1500
integer width = 558
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bultos Ubicaciones"
boolean focusrectangle = false
end type

type st_5 from statictext within wtc_bloqueo_ubicaciones
integer x = 4073
integer y = 1752
integer width = 791
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 21642288
long backcolor = 67108864
string text = "Actualizar tipo ubicación"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within wtc_bloqueo_ubicaciones
integer x = 4603
integer y = 1908
integer width = 306
integer height = 88
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;
string ubicacion
integer ubicacion_numero
long i, id
boolean exito



if (dw_datos.rowcount() = 0) then
	
	messagebox ("Error", "No hay seleccionada ninguna ubicación")
	
	
else
	
	if uo_ubicacion.em_campo.text = "" then
		
		messagebox("Error", "No ha seleccionado ningún tipo de ubicación")
		
	else
		
		exito = true

		ubicacion = uo_ubicacion.em_codigo.text
		
		ubicacion_numero = integer(ubicacion)
				
		for i = 1 to dw_datos.rowcount()
			
			id = dw_datos.object.id[i]
			
			update almubimapa_codbar set tipo_ubicacion = :ubicacion_numero where id = :id using SQLCA;
			
			IF SQLCA.SQLCode <>0 THEN 
				
				exito = false
				
			end if
						
		next
		
		if exito = true then
			
			messagebox("Éxito","Éxito al actualizar el tipo de ubicación")
			
			commit;
			
			pb_anyadir1.triggerevent("clicked")
			
		else
			
			rollback;
			messagebox("Error","Ha habido un error al actualizar el tipo de ubicación")
				
		end if
				
	end if
		
end if
end event

type uo_ubicacion from u_em_campo_2 within wtc_bloqueo_ubicaciones
event destroy ( )
integer x = 4014
integer y = 1924
integer width = 489
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_ubicacion.destroy
call u_em_campo_2::destroy
end on

event modificado;//uo_ubicacion.em_campo.text=f_nombre_pallet(codigo_empresa,uo_ubicacion.em_codigo.text)

string descripcion

select descripcion into :descripcion from tipo_ubicacion where empresa = :codigo_empresa and codigo = :uo_ubicacion.em_codigo.text using SQLCA;

uo_ubicacion.em_campo.text = descripcion

IF Trim(uo_ubicacion.em_campo.text)="" THEN 
 IF Trim(uo_ubicacion.em_codigo.text)<>"" Then uo_ubicacion.em_campo.SetFocus()
 uo_ubicacion.em_campo.text=""
 uo_ubicacion.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de tipos de ubicacion"
ue_datawindow = "dw_ayuda_tipo_ubicacion"
ue_filtro     = ""

end event

type gb_1 from groupbox within wtc_bloqueo_ubicaciones
integer x = 4064
integer y = 668
integer width = 773
integer height = 804
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within wtc_bloqueo_ubicaciones
integer x = 3959
integer y = 1864
integer width = 603
integer height = 156
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Nueva ubicación"
end type

type r_1 from rectangle within wtc_bloqueo_ubicaciones
integer linethickness = 4
long fillcolor = 16777215
integer x = 3950
integer y = 1700
integer width = 1006
integer height = 376
end type

