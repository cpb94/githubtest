$PBExportHeader$w_con_valor_produccion_comparativo.srw
forward
global type w_con_valor_produccion_comparativo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_valor_produccion_comparativo
end type
type pb_2 from upb_imprimir within w_con_valor_produccion_comparativo
end type
type cb_1 from commandbutton within w_con_valor_produccion_comparativo
end type
type gb_1 from groupbox within w_con_valor_produccion_comparativo
end type
type gb_6 from groupbox within w_con_valor_produccion_comparativo
end type
type dw_informe from datawindow within w_con_valor_produccion_comparativo
end type
type em_fdesde from u_em_campo within w_con_valor_produccion_comparativo
end type
type em_fhasta from u_em_campo within w_con_valor_produccion_comparativo
end type
type sle_semanas from singlelineedit within w_con_valor_produccion_comparativo
end type
type st_1 from statictext within w_con_valor_produccion_comparativo
end type
type cb_2 from commandbutton within w_con_valor_produccion_comparativo
end type
type em_fhasta2 from u_em_campo within w_con_valor_produccion_comparativo
end type
type em_fdesde2 from u_em_campo within w_con_valor_produccion_comparativo
end type
type st_2 from statictext within w_con_valor_produccion_comparativo
end type
type uo_familias from u_marca_lista within w_con_valor_produccion_comparativo
end type
type cb_marcas from commandbutton within w_con_valor_produccion_comparativo
end type
type uo_marcas from u_marca_lista within w_con_valor_produccion_comparativo
end type
type cb_submarcas from commandbutton within w_con_valor_produccion_comparativo
end type
type uo_submarcas from u_marca_lista within w_con_valor_produccion_comparativo
end type
type gb_3 from groupbox within w_con_valor_produccion_comparativo
end type
type cb_familias from commandbutton within w_con_valor_produccion_comparativo
end type
type st_contador from statictext within w_con_valor_produccion_comparativo
end type
end forward

global type w_con_valor_produccion_comparativo from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 3680
integer height = 3396
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
sle_semanas sle_semanas
st_1 st_1
cb_2 cb_2
em_fhasta2 em_fhasta2
em_fdesde2 em_fdesde2
st_2 st_2
uo_familias uo_familias
cb_marcas cb_marcas
uo_marcas uo_marcas
cb_submarcas cb_submarcas
uo_submarcas uo_submarcas
gb_3 gb_3
cb_familias cb_familias
st_contador st_contador
end type
global w_con_valor_produccion_comparativo w_con_valor_produccion_comparativo

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_metros_importe (ref decimal metros, ref decimal importe, ref decimal efectiva, string linea, datetime fecha1, datetime fecha2)
end prototypes

public subroutine f_control (datawindow data);datastore datos
Datetime  fecha1, fecha2, fecha3, fecha4
string sel
long fila_actual, i, total_regs
dec metros, importe, efectiva

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()
data.setredraw(false)		


fecha1 = datetime(date(em_fdesde.text))
fecha2 = datetime(date(em_fhasta.text))
fecha3 = datetime(date(em_fdesde2.text))
fecha4 = datetime(date(em_fhasta2.text))
data.object.periodo.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text
data.object.periodo2.text = "Desde "+em_fdesde2.text+" al "+em_fhasta2.text


sel = " select prodlineas.codigo, prodlineas.resumido, prodlineas.seccion, prodsecciones.descripcion_abr "+&
		" from prodlineas, prodsecciones "+&
		" where prodlineas.empresa = '"+codigo_empresa+"' "+&
		" and	prodlineas.empresa = prodsecciones.empresa "+&
		" and prodlineas.seccion = prodsecciones.codigo "+&
		" and prodlineas.codigo in (select prodpartes_ot.linea "+&
		"                           from   prodpartes_ot, "+&
		"                           		  articulos "+&
		"                           where  prodpartes_ot.empresa = articulos.empresa "+&
		"                           and    prodpartes_ot.articulo = articulos.codigo "+&
		"                           and    prodpartes_ot.empresa = '"+codigo_empresa+"' "+&
		"                           and    articulos.uso         = '3' "+&
		"                           and   (prodpartes_ot.fecha between '"+string(fecha1,gs_formato_fecha_cursores)+"' and '"+string(fecha2,gs_formato_fecha_cursores)+"' "+&
		"                           or     prodpartes_ot.fecha between '"+string(fecha3,gs_formato_fecha_cursores)+"' and '"+string(fecha4,gs_formato_fecha_cursores)+"') "+&
		"                           group by prodpartes_ot.linea) "+&
		" order by prodsecciones.descripcion_abr, prodlineas.resumido "

f_cargar_cursor_nuevo (sel, datos)
st_contador.visible = true
total_regs = datos.rowcount() 
for i = 1 to total_regs
	fila_actual = data.insertrow(0)
	dw_informe.object.seccion[i] = datos.object.prodsecciones_descripcion_abr[fila_actual]
	dw_informe.object.linea[i] = datos.object.prodlineas_resumido[fila_actual]
	metros = 0
	importe = 0
	efectiva = 0
	f_metros_importe ( metros, importe, efectiva, datos.object.prodlineas_codigo[i], fecha1, fecha2 )
	dw_informe.object.metros[i] = metros
	dw_informe.object.importe[i] = importe
	dw_informe.object.efectiva[i] = efectiva
	metros = 0
	importe = 0
	efectiva = 0
	f_metros_importe ( metros, importe, efectiva, datos.object.prodlineas_codigo[i], fecha3, fecha4 )
	dw_informe.object.metros2[i] = metros
	dw_informe.object.importe2[i] = importe
	dw_informe.object.efectiva2[i] = efectiva
	
	st_contador.text = string(round( i * 100 / total_regs, 0 ) )+ " %"
next
st_contador.visible = false
data.sort()
data.groupcalc()
data.setredraw(true)

destroy datos
end subroutine

public subroutine f_metros_importe (ref decimal metros, ref decimal importe, ref decimal efectiva, string linea, datetime fecha1, datetime fecha2);string v_seccion, v_linea, familia,ls_familias[],ls_marcas[],ls_submarcas,ls_sel
dec    total_metros
int    li_opciones,li_opciones_marcadas,li_indice
long   ll_indice,ll_total
datastore ds_datos


//Nuevo Proceso
uo_familias.visible = false
uo_marcas.visible = false
uo_submarcas.visible = false

//Filtro de familias
li_opciones = uo_familias.dw_marca.RowCount()
li_opciones_marcadas = 0

for li_indice = 1 to li_opciones
	if uo_familias.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_familias[li_opciones_marcadas] = uo_familias.dw_marca.object.codigo[li_indice]
	end if
next

if li_opciones_marcadas = 0 then
	ls_familias[1] = ""
end if

//Fin de filtro de familias

//Filtro de marcas
li_opciones = uo_marcas.dw_marca.RowCount()
li_opciones_marcadas = 0

for li_indice = 1 to li_opciones
	if uo_marcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_marcas[li_opciones_marcadas] = uo_marcas.dw_marca.object.codigo[li_indice]
	end if
next

if li_opciones_marcadas = 0 then
	ls_marcas[1] = ""
end if

//Fin de filtro de marcas

//Filtro de submarcas
li_opciones = uo_submarcas.dw_marca.RowCount()
li_opciones_marcadas = 0

for li_indice = 1 to li_opciones
	if uo_submarcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas = 1 then
			ls_submarcas = "'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
		else
			ls_submarcas += ",'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
		end if		
	end if
next

if li_opciones_marcadas = 0 then
	ls_submarcas = "''"
end if
//Fin de filtro de submarcas

ls_sel = " SELECT isnull(prodpartes_ot.seccion,'') as seccion "+&
			"       	, isnull(prodpartes_ot.linea,'') as linea "+&
			"       , isnull(sum (prodpartes_ot.buenas * formatos.ancho  * formatos.largo / 10000 ),0) AS metros  "+&
			"       , isnull(sum (	CASE WHEN articulos.unidad  = 0 then prodpartes_ot.buenas * prodpartes_ot.factor    "+&
			"							ELSE  prodpartes_ot.buenas  * prodpartes_ot.factor * ((formatos.ancho * formatos.largo) /10000) "+&
			"							END )   "+&
			"	 								*	CASE WHEN ventarifas_precios_packs.precio is null or ventarifas_precios_packs.precio = 0 "+&
			" 										THEN isnull(ventarifas_precios.precio,0)  "+&
			" 										ELSE isnull(ventarifas_precios_packs.precio,0)  "+&
			" 										END  "+&
			"							, 0) AS importe "+&
			" FROM  	prodpartes_ot, "+&
			"       		formatos, "+&
			"       		prodsecciones, "+&
			"       		prodlineas, "+&
			"       		art_ver_operaciones, "+&
			"       		articulos "+&
			" LEFT OUTER JOIN ventarifas_precios ON ventarifas_precios.articulos_codigo = articulos.codigo and ventarifas_precios.empresa = articulos.empresa "+&
			" LEFT OUTER JOIN ventarifas_precios_packs ON ventarifas_precios_packs.articulos_codigo = articulos.codigo and ventarifas_precios_packs.empresa = articulos.empresa "+&
			" WHERE prodpartes_ot.empresa = '"+codigo_empresa+"' "+&
			" AND formatos.empresa =  '"+codigo_empresa+"' "+&
			" AND prodsecciones.empresa =  '"+codigo_empresa+"' "+&
			" AND prodlineas.empresa =  '"+codigo_empresa+"' "+&
			" AND art_ver_operaciones.empresa =  '"+codigo_empresa+"' "+&
			" AND prodpartes_ot.empresa = articulos.empresa "+&
			" AND prodpartes_ot.articulo = articulos.codigo "+&
			" AND prodpartes_ot.articulo = art_ver_operaciones.articulo "+&
			" AND prodpartes_ot.version = art_ver_operaciones.version "+&
			" AND prodpartes_ot.ordenoperacion = art_ver_operaciones.orden "+&
			" AND prodpartes_ot.fecha >= '"+string(fecha1,gs_formato_fecha_cursores)+"' "+&
			" AND prodpartes_ot.fecha <= '"+string(fecha2,gs_formato_fecha_cursores)+"' "+&
			" AND  ( ventarifas_precios.ventarifas_codigo = 			 (	SELECT top 1 ventarifas_precios.ventarifas_codigo "+&
			"																			FROM ventarifas_precios "+&
			"																			WHERE ventarifas_precios.articulos_codigo = articulos.codigo "+&
			"																			AND ventarifas_precios.empresa = articulos.empresa "+&
			"																			AND ventarifas_precios.ventarifas_codigo <> '5' "+&
			"																			AND ventarifas_precios.calidades_codigo = '1' "+&
			"																			ORDER BY ventarifas_precios.precio asc)  "+&
			"																			OR ventarifas_precios.ventarifas_codigo IS NULL)  "+&
			" AND  ( ventarifas_precios_packs.ventarifas_codigo = ( 	SELECT top 1 ventarifas_precios_packs.ventarifas_codigo "+&
			"																			FROM ventarifas_precios_packs  "+&
			"																			WHERE ventarifas_precios_packs.articulos_codigo = articulos.codigo "+&
			"																			AND ventarifas_precios_packs.empresa = articulos.empresa "+&
			"																			AND ventarifas_precios_packs.ventarifas_codigo <> '5' "+&
			"																			AND ventarifas_precios_packs.calidades_codigo = '1' "+&
			"																			ORDER BY ventarifas_precios_packs.precio asc)  "+&
			"																			OR ventarifas_precios_packs.ventarifas_codigo IS NULL)  "+&
			" AND prodpartes_ot.linea = prodlineas.codigo "+&
			" AND prodpartes_ot.seccion = prodsecciones.codigo "+&
			" AND prodpartes_ot.formato = formatos.codigo "+&
			" AND prodpartes_ot.art_terminado = 'S' "+&
			" AND prodpartes_ot.ajuste <> 'S' "+&
			" AND prodpartes_ot.linea = '"+linea+"' "+&
			" AND isnull(articulos.submarcas_codigo,'') IN ("+ls_submarcas+") "+&
			" GROUP BY prodpartes_ot.seccion "+&
			"			, prodsecciones.descripcion_abr "+&
			"			, prodpartes_ot.linea "+&
			"			, prodlineas.resumido "+&
			"			, ventarifas_precios.precio "+&
			"			, ventarifas_precios_packs.precio "+&
			" ORDER BY prodsecciones.descripcion_abr "+&
			"			, prodlineas.resumido"


/*
ls_sel = " SELECT isnull(prodpartes_ot.seccion,'') as seccion "+&
			"       	, isnull(prodpartes_ot.linea,'') as linea "+&
			"       , isnull(sum (prodpartes_ot.buenas * formatos.ancho  * formatos.largo / 10000 ),0) AS metros  "+&
			"       , isnull(sum (	CASE WHEN articulos.unidad  = 0 then prodpartes_ot.buenas * prodpartes_ot.factor * ventarifas_precios.precio   "+&
			"							ELSE ( ( prodpartes_ot.buenas  * prodpartes_ot.factor * ((formatos.ancho * formatos.largo) /10000) )  * ventarifas_precios.precio )  "+&
			"							END),0) as importe "+&
			" FROM  	prodpartes_ot, "+&
			"       		formatos, "+&
			"       		prodsecciones, "+&
			"       		prodlineas, "+&
			"       		art_ver_operaciones, "+&
			"       		articulos "+&
			" LEFT OUTER JOIN ventarifas_precios ON ventarifas_precios.articulos_codigo = articulos.codigo and ventarifas_precios.empresa = articulos.empresa "+&
			" LEFT OUTER JOIN ventarifas_precios_packs ON ventarifas_precios_packs.articulos_codigo = articulos.codigo and ventarifas_precios_packs.empresa = articulos.empresa "+&
			" WHERE prodpartes_ot.empresa = '"+codigo_empresa+"' "+&
			" AND formatos.empresa =  '"+codigo_empresa+"' "+&
			" AND prodsecciones.empresa =  '"+codigo_empresa+"' "+&
			" AND prodlineas.empresa =  '"+codigo_empresa+"' "+&
			" AND art_ver_operaciones.empresa =  '"+codigo_empresa+"' "+&
			" AND prodpartes_ot.empresa = articulos.empresa "+&
			" AND prodpartes_ot.articulo = articulos.codigo "+&
			" AND prodpartes_ot.articulo = art_ver_operaciones.articulo "+&
			" AND prodpartes_ot.version = art_ver_operaciones.version "+&
			" AND prodpartes_ot.ordenoperacion = art_ver_operaciones.orden "+&
			" AND prodpartes_ot.fecha >= '"+string(fecha1,gs_formato_fecha_cursores)+"' "+&
			" AND prodpartes_ot.fecha <= '"+string(fecha2,gs_formato_fecha_cursores)+"' "+&
			" AND  ( ventarifas_precios.ventarifas_codigo = 			 (	SELECT top 1 ventarifas_precios.ventarifas_codigo "+&
			"																			FROM ventarifas_precios "+&
			"																			WHERE ventarifas_precios.articulos_codigo = articulos.codigo "+&
			"																			AND ventarifas_precios.empresa = articulos.empresa "+&
			"																			AND ventarifas_precios.ventarifas_codigo <> '5' "+&
			"																			AND ventarifas_precios.calidades_codigo = '1' "+&
			"																			ORDER BY ventarifas_precios.precio asc)  "+&
			"																			OR ventarifas_precios.ventarifas_codigo IS NULL)  "+&
			" AND  ( ventarifas_precios_packs.ventarifas_codigo = ( 	SELECT top 1 ventarifas_precios_packs.ventarifas_codigo "+&
			"																			FROM ventarifas_precios_packs  "+&
			"																			WHERE ventarifas_precios_packs.articulos_codigo = articulos.codigo "+&
			"																			AND ventarifas_precios_packs.empresa = articulos.empresa "+&
			"																			AND ventarifas_precios_packs.ventarifas_codigo <> '5' "+&
			"																			AND ventarifas_precios_packs.calidades_codigo = '1' "+&
			"																			ORDER BY ventarifas_precios_packs.precio asc)  "+&
			"																			OR ventarifas_precios_packs.ventarifas_codigo IS NULL)  "+&
			" AND prodpartes_ot.linea = prodlineas.codigo "+&
			" AND prodpartes_ot.seccion = prodsecciones.codigo "+&
			" AND prodpartes_ot.formato = formatos.codigo "+&
			" AND prodpartes_ot.art_terminado = 'S' "+&
			" AND prodpartes_ot.ajuste <> 'S' "+&
			" AND prodpartes_ot.linea = '"+linea+"' "+&
			" AND isnull(articulos.submarcas_codigo,'') IN ("+ls_submarcas+") "+&
			" GROUP BY prodpartes_ot.seccion "+&
			"			, prodsecciones.descripcion_abr "+&
			"			, prodpartes_ot.linea "+&
			"			, prodlineas.resumido "+&
			" ORDER BY prodsecciones.descripcion_abr "+&
			"			, prodlineas.resumido"

*/

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

metros  = 0
importe = 0

for ll_indice = 1 to ll_total
	metros  += ds_datos.object.metros[ll_indice]
	importe += ds_datos.object.importe[ll_indice]
next

destroy ds_datos
//into :v_seccion, :v_linea, :total_metros

ls_sel = "select isnull(prodpartes_ot.seccion,'') as seccion, "+&
			"       isnull(prodpartes_ot.linea,'') as linea, "+&
			"       isnull(sum (prodpartes_ot.buenas * formatos.ancho  * formatos.largo / 10000 ),0) as total_metros "+&
			"from   prodpartes_ot, "+&
			"       formatos, "+&
			"       prodsecciones, "+&
			"       prodlineas, "+&
			"       art_ver_operaciones, "+&
			"       articulos "+&
			"where prodpartes_ot.empresa = '"+codigo_empresa+"' "+&
			"and formatos.empresa =  '"+codigo_empresa+"' "+&
			"and prodsecciones.empresa =  '"+codigo_empresa+"' "+&
			"and prodlineas.empresa =  '"+codigo_empresa+"' "+&
			"and art_ver_operaciones.empresa =  '"+codigo_empresa+"' "+&
			"and prodpartes_ot.articulo = art_ver_operaciones.articulo "+&
			"and prodpartes_ot.empresa = articulos.empresa "+&
			"and prodpartes_ot.articulo = articulos.codigo "+&
			"and prodpartes_ot.version = art_ver_operaciones.version "+&
			"and prodpartes_ot.ordenoperacion = art_ver_operaciones.orden "+&
			"and prodpartes_ot.fecha >= '"+string(fecha1,gs_formato_fecha_cursores)+"' "+&
			"and prodpartes_ot.fecha <= '"+string(fecha2,gs_formato_fecha_cursores)+"' "+&
			"and prodpartes_ot.linea = prodlineas.codigo "+&
			"and prodpartes_ot.seccion = prodsecciones.codigo "+&
			"and prodpartes_ot.formato = formatos.codigo "+&
			"and prodpartes_ot.linea = '"+linea+"' "+&
			"and prodpartes_ot.ajuste <> 'S' "+&
			"and isnull(articulos.submarcas_codigo,'') IN ("+ls_submarcas+") "+&
			"group by prodpartes_ot.seccion, prodsecciones.descripcion_abr, prodpartes_ot.linea, prodlineas.resumido "+&
			"order by prodsecciones.descripcion_abr, prodlineas.resumido"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

total_metros  = 0

for ll_indice = 1 to ll_total
	total_metros  += ds_datos.object.total_metros[ll_indice]
next

destroy ds_datos

if total_metros <> 0 then
	efectiva = ( metros / total_metros ) * 100
else
	efectiva = 0
end if

end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;long   ll_donde
string mes
integer permiso

istr_parametros.s_titulo_ventana="Informe Valor de la Producción (Comparativo)"
This.title=istr_parametros.s_titulo_ventana

em_fhasta.text = string(RelativeDate(today(), -1),"dd-mm-yy")
em_fhasta2.text = string(RelativeDate(today(), -1),"dd-mm-yy")
sle_semanas.text = '1'
em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")
em_fdesde2.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")

uo_familias.f_cargar_datos("dw_ayuda_familias","%","","Familia","Descripción")
uo_marcas.f_cargar_datos("dw_ayuda_marcas","%","","Marca","Descripción")
uo_submarcas.f_cargar_datos("dw_ayuda_Submarcas","%","","Submarca","Descripción")

//ll_donde = uo_familias.dw_marca.find("codigo = '1'",1,uo_familias.dw_marca.rowcount())
//
//if ll_donde > 0 then
//	uo_familias.dw_marca.object.marca[ll_donde] = 'N'
//	
//	uo_familias.dw_marca.event itemchanged(ll_donde,uo_familias.dw_marca.object.marca,'N')
//end if

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 0
		MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
		close(this)
		return
end choose
end event

on w_con_valor_produccion_comparativo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.sle_semanas=create sle_semanas
this.st_1=create st_1
this.cb_2=create cb_2
this.em_fhasta2=create em_fhasta2
this.em_fdesde2=create em_fdesde2
this.st_2=create st_2
this.uo_familias=create uo_familias
this.cb_marcas=create cb_marcas
this.uo_marcas=create uo_marcas
this.cb_submarcas=create cb_submarcas
this.uo_submarcas=create uo_submarcas
this.gb_3=create gb_3
this.cb_familias=create cb_familias
this.st_contador=create st_contador
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.sle_semanas
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.em_fhasta2
this.Control[iCurrent+13]=this.em_fdesde2
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.uo_familias
this.Control[iCurrent+16]=this.cb_marcas
this.Control[iCurrent+17]=this.uo_marcas
this.Control[iCurrent+18]=this.cb_submarcas
this.Control[iCurrent+19]=this.uo_submarcas
this.Control[iCurrent+20]=this.gb_3
this.Control[iCurrent+21]=this.cb_familias
this.Control[iCurrent+22]=this.st_contador
end on

on w_con_valor_produccion_comparativo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.sle_semanas)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.em_fhasta2)
destroy(this.em_fdesde2)
destroy(this.st_2)
destroy(this.uo_familias)
destroy(this.cb_marcas)
destroy(this.uo_marcas)
destroy(this.cb_submarcas)
destroy(this.uo_submarcas)
destroy(this.gb_3)
destroy(this.cb_familias)
destroy(this.st_contador)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_valor_produccion_comparativo
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_valor_produccion_comparativo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_valor_produccion_comparativo
integer x = 5
integer y = 8
integer width = 3575
integer height = 84
end type

type pb_1 from upb_salir within w_con_valor_produccion_comparativo
integer x = 3529
integer y = 132
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_valor_produccion_comparativo
integer x = 3392
integer y = 132
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_valor_produccion_comparativo
integer x = 3095
integer y = 132
integer width = 288
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "@Yu Gothic UI Semibold"
string text = "Continuar"
end type

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_con_valor_produccion_comparativo
integer y = 96
integer width = 763
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Período 1"
end type

type gb_6 from groupbox within w_con_valor_produccion_comparativo
integer x = 3072
integer y = 88
integer width = 594
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_informe from datawindow within w_con_valor_produccion_comparativo
integer x = 5
integer y = 272
integer width = 3584
integer height = 2876
boolean bringtotop = true
string dataobject = "dw_con_valor_produccion_comparativo"
boolean vscrollbar = true
boolean livescroll = true
end type

type em_fdesde from u_em_campo within w_con_valor_produccion_comparativo
integer x = 14
integer y = 156
integer width = 352
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_valor_produccion_comparativo
integer x = 384
integer y = 156
integer width = 352
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type sle_semanas from singlelineedit within w_con_valor_produccion_comparativo
boolean visible = false
integer x = 1042
integer y = 144
integer width = 201
integer height = 84
integer taborder = 60
boolean bringtotop = true
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

event losefocus;if long(sle_semanas.text) = 1 then
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")
else
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), ( -7 * ( long( sle_semanas.text ) -1 ) ) - 6 ),"dd-mm-yy")
end if

end event

type st_1 from statictext within w_con_valor_produccion_comparativo
boolean visible = false
integer x = 736
integer y = 152
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Semanas:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_valor_produccion_comparativo
boolean visible = false
integer x = 2464
integer y = 2124
integer width = 709
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Factor"
end type

event clicked;string sel
string operario, linea, turno
long contador, i
decimal factor
datetime fecha
datastore partes
boolean  error_actualizando 

if MessageBox("Atencion", "¿Desea Continuar? ", Exclamation!, YesNo!, 2) = 1 then

	sel =  " select prodpartes_ot.empresa, prodpartes_ot.operario, prodpartes_ot.linea, prodpartes_ot.fecha, "+& 
					  " prodpartes_ot.turno, prodpartes_ot.contador, art_ver_operaciones.factor "+&
			 " from prodpartes_ot, art_ver_operaciones "+&
			 " where prodpartes_ot.empresa = '1' "+&
			 " and art_ver_operaciones.empresa = '1' "+&
			 " and prodpartes_ot.articulo = art_ver_operaciones.articulo " +&
			 " and prodpartes_ot.version = art_ver_operaciones.version "+&
			 " and prodpartes_ot.ordenoperacion = art_ver_operaciones.orden "
	
	f_cargar_cursor_nuevo (sel, partes)
	
	error_actualizando = false
	for i = 1 to partes.rowcount()
		operario = partes.object.prodpartes_ot_operario[i]
		linea = partes.object.prodpartes_ot_linea[i]
		fecha = partes.object.prodpartes_ot_fecha[i]
		turno = partes.object.prodpartes_ot_turno[i]
		contador = partes.object.prodpartes_ot_contador[i]
		factor = partes.object.art_ver_operaciones_factor[i]
		
		update prodpartes_ot set factor = :factor 
		where empresa =:codigo_empresa
		and operario = :operario
		and linea = :linea
		and fecha = :fecha
		and turno = :turno
		and contador = :contador
		using SQLCA;
		
		IF SQLCA.SQLCode = -1 THEN 
			  error_actualizando = true
			  MessageBox("SQL error", SQLCA.SQLErrText)
		END IF
	
		f_mensaje_proceso ("Partes:", i, partes.rowcount())
		
	next
	
	if error_actualizando then
		rollback using SQLCA;
	else
		commit using SQLCA;
	end if

end if
end event

type em_fhasta2 from u_em_campo within w_con_valor_produccion_comparativo
integer x = 1166
integer y = 156
integer width = 352
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fdesde2 from u_em_campo within w_con_valor_produccion_comparativo
integer x = 795
integer y = 156
integer width = 352
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_con_valor_produccion_comparativo
integer x = 2510
integer y = 148
integer width = 549
integer height = 96
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
string text = "Variación = ( ( P2- P1 ) x 100 / P1"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_familias from u_marca_lista within w_con_valor_produccion_comparativo
event destroy ( )
boolean visible = false
integer x = 1559
integer y = 280
integer taborder = 110
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

type cb_marcas from commandbutton within w_con_valor_produccion_comparativo
integer x = 1870
integer y = 148
integer width = 297
integer height = 96
integer taborder = 160
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcas"
end type

event clicked;
uo_familias.visible = false

uo_marcas.visible = not(uo_marcas.visible)

uo_submarcas.visible = false

uo_marcas.BringToTop = TRUE
end event

type uo_marcas from u_marca_lista within w_con_valor_produccion_comparativo
event destroy ( )
boolean visible = false
integer x = 1847
integer y = 280
integer taborder = 110
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

type cb_submarcas from commandbutton within w_con_valor_produccion_comparativo
integer x = 2162
integer y = 148
integer width = 338
integer height = 96
integer taborder = 170
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubMarcas"
end type

event clicked;
uo_familias.visible = false

uo_marcas.visible = false

uo_submarcas.visible = not(uo_submarcas.visible)

uo_submarcas.BringToTop = TRUE
end event

type uo_submarcas from u_marca_lista within w_con_valor_produccion_comparativo
event destroy ( )
boolean visible = false
integer x = 2135
integer y = 280
integer taborder = 110
boolean bringtotop = true
boolean border = false
end type

on uo_submarcas.destroy
call u_marca_lista::destroy
end on

type gb_3 from groupbox within w_con_valor_produccion_comparativo
integer x = 782
integer y = 96
integer width = 763
integer height = 160
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Período 2"
end type

type cb_familias from commandbutton within w_con_valor_produccion_comparativo
integer x = 1573
integer y = 148
integer width = 302
integer height = 96
integer taborder = 150
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;
uo_familias.visible = not(uo_familias.visible)

uo_marcas.visible = false

uo_submarcas.visible = false

uo_familias.BringToTop = TRUE
end event

type st_contador from statictext within w_con_valor_produccion_comparativo
boolean visible = false
integer x = 3104
integer y = 140
integer width = 526
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

