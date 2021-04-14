$PBExportHeader$wtc_consulta_disenyo.srw
forward
global type wtc_consulta_disenyo from wt_consultas_padre
end type
type dw_historico from u_dw within wtc_consulta_disenyo
end type
type dw_imagen from u_dw_imagen within wtc_consulta_disenyo
end type
type dw_imagen_marco from datawindow within wtc_consulta_disenyo
end type
type pb_email from picturebutton within wtc_consulta_disenyo
end type
type pb_descarga from picturebutton within wtc_consulta_disenyo
end type
type cbx_ambientes from checkbox within wtc_consulta_disenyo
end type
type cb_1 from commandbutton within wtc_consulta_disenyo
end type
type cb_2 from commandbutton within wtc_consulta_disenyo
end type
type barra from hprogressbar within wtc_consulta_disenyo
end type
type dw_datos2 from datawindow within wtc_consulta_disenyo
end type
type dw_imagenes_modelo from datawindow within wtc_consulta_disenyo
end type
type dw_imagenes_coleccion from datawindow within wtc_consulta_disenyo
end type
type cb_cerrar_expo from commandbutton within wtc_consulta_disenyo
end type
type pb_ocultar from picturebutton within wtc_consulta_disenyo
end type
end forward

global type wtc_consulta_disenyo from wt_consultas_padre
integer width = 5637
integer height = 3480
string title = "Consulta Diseño"
dw_historico dw_historico
dw_imagen dw_imagen
dw_imagen_marco dw_imagen_marco
pb_email pb_email
pb_descarga pb_descarga
cbx_ambientes cbx_ambientes
cb_1 cb_1
cb_2 cb_2
barra barra
dw_datos2 dw_datos2
dw_imagenes_modelo dw_imagenes_modelo
dw_imagenes_coleccion dw_imagenes_coleccion
cb_cerrar_expo cb_cerrar_expo
pb_ocultar pb_ocultar
end type
global wtc_consulta_disenyo wtc_consulta_disenyo

type variables
string sql_inicial, sql_auxiliar
String filtro_anterior
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

on wtc_consulta_disenyo.create
int iCurrent
call super::create
this.dw_historico=create dw_historico
this.dw_imagen=create dw_imagen
this.dw_imagen_marco=create dw_imagen_marco
this.pb_email=create pb_email
this.pb_descarga=create pb_descarga
this.cbx_ambientes=create cbx_ambientes
this.cb_1=create cb_1
this.cb_2=create cb_2
this.barra=create barra
this.dw_datos2=create dw_datos2
this.dw_imagenes_modelo=create dw_imagenes_modelo
this.dw_imagenes_coleccion=create dw_imagenes_coleccion
this.cb_cerrar_expo=create cb_cerrar_expo
this.pb_ocultar=create pb_ocultar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_historico
this.Control[iCurrent+2]=this.dw_imagen
this.Control[iCurrent+3]=this.dw_imagen_marco
this.Control[iCurrent+4]=this.pb_email
this.Control[iCurrent+5]=this.pb_descarga
this.Control[iCurrent+6]=this.cbx_ambientes
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.barra
this.Control[iCurrent+10]=this.dw_datos2
this.Control[iCurrent+11]=this.dw_imagenes_modelo
this.Control[iCurrent+12]=this.dw_imagenes_coleccion
this.Control[iCurrent+13]=this.cb_cerrar_expo
this.Control[iCurrent+14]=this.pb_ocultar
end on

on wtc_consulta_disenyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_historico)
destroy(this.dw_imagen)
destroy(this.dw_imagen_marco)
destroy(this.pb_email)
destroy(this.pb_descarga)
destroy(this.cbx_ambientes)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.barra)
destroy(this.dw_datos2)
destroy(this.dw_imagenes_modelo)
destroy(this.dw_imagenes_coleccion)
destroy(this.cb_cerrar_expo)
destroy(this.pb_ocultar)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_datos2.SetTransObject(SQLCA)
dw_historico.SetTransObject(SQLCA)
dw_imagenes_coleccion.SetTransObject(SQLCA)
dw_imagenes_modelo.SetTransObject(SQLCA)

sql_inicial =  " SELECT DISTINCT descoleccionsol.codigo,   "+&
 "        modelo.modelo,   "+&
 "        descoleccionsol.ambiente,   "+&
 "        descoleccionsol.disenyador,   "+&
 "        descoleccionsol.comercial,   "+&
 "        descoleccionsol.fecha_coleccion,   "+&
 "        descoleccionsol.tecnico_lab,   "+&
 "        descoleccionsol.destino,   "+&
 "        descoleccionsol.grafica,   "+&
 "        tecnico_dis.descripcion,   "+&
 "        comercial.descripcion,   "+&
 "        tecnico_lab.descripcion,   "+&
 "        ambiente.descripcion,   "+&
 "        modelo.pavrev,   "+&
 "        descoleccionsol.estado,  "+&
 "			 0 as seleccionado, "+&
 "			 '' as imagen_modelo, "+&
 "			 '' as imagen_coleccion, "+&
 "		descoleccionsol.descripcion "+&
 "   FROM descoleccionsol LEFT OUTER JOIN tecnico_lab ON descoleccionsol.empresa = tecnico_lab.empresa AND descoleccionsol.tecnico_lab = tecnico_lab.codigo,   "+&
 "        modelo,   "+&
 "        tecnico_dis, "+&  
 "        comercial,   "+&
 "        ambiente,   "+&
 "        modelo_cliente,   "+&
 "        modelo_propuesta,   "+&
 "        modelo_trabajo  "+&
 "  WHERE ( descoleccionsol.empresa = modelo.empresa ) and  "+&
 "        ( descoleccionsol.codigo = modelo.coleccion ) and  "+&
 "        ( descoleccionsol.empresa = tecnico_dis.empresa ) and  "+&
 "        ( descoleccionsol.disenyador = tecnico_dis.codigo ) and  "+&
 "        ( descoleccionsol.empresa = comercial.empresa ) and  "+&
 "        ( descoleccionsol.comercial = comercial.codigo ) and  "+&
 "        ( descoleccionsol.ambiente = ambiente.codigo ) and  "+&
 "        ( descoleccionsol.empresa = ambiente.empresa ) and  "+&
 "        ( modelo.empresa = modelo_cliente.empresa ) and  "+&
 "        ( modelo.modelo = modelo_cliente.modelo ) and  "+&
 "        ( modelo_cliente.empresa = modelo_propuesta.empresa ) and  "+&
 "        ( modelo_cliente.modelo = modelo_propuesta.modelo ) and  "+&
 "        ( modelo_cliente.cliente = modelo_propuesta.cliente ) and  "+&
 "        ( modelo_propuesta.empresa = modelo_trabajo.empresa ) and  "+&
 "        ( modelo_propuesta.modelo = modelo_trabajo.modelo ) and  "+&
 "        ( modelo_propuesta.cliente = modelo_trabajo.cliente ) and  "+&
 "        ( modelo_propuesta.codigo = modelo_trabajo.propuesta ) and   "+&
         " ( ( descoleccionsol.empresa = '"+codigo_empresa+"' ) )  "  
			
sql_auxiliar = " SELECT DISTINCT descoleccionsol.codigo,   "+&
 "        modelo.modelo,   "+&
 "        descoleccionsol.ambiente,   "+&
 "        descoleccionsol.disenyador,   "+&
 "        descoleccionsol.comercial,   "+&
 "        descoleccionsol.fecha_coleccion,   "+&
 "        descoleccionsol.tecnico_lab,   "+&
 "        descoleccionsol.destino,   "+&
 "        descoleccionsol.grafica,   "+&
 "        tecnico_dis.descripcion,   "+&
 "        comercial.descripcion,   "+&
 "        tecnico_lab.descripcion,   "+&
 "        ambiente.descripcion,   "+&
 "        modelo.pavrev,   "+&
 "        descoleccionsol.estado,  "+&
 "			 0 as seleccionado, "+&
 "			 '' as imagen_modelo, "+&
 "			 '' as imagen_coleccion, "+&
 "			 REPLACE((SELECT ruta_archivos_exposicion FROM empresas WHERE empresa = '1') + ruta+ (SELECT tamanyo FROM archivo_resolucion WHERE empresa = '1' AND codigo = '5')+'\'+fichero, ' ','') AS ruta_imagen    "+&
 "   FROM descoleccionsol LEFT OUTER JOIN tecnico_lab ON descoleccionsol.empresa = tecnico_lab.empresa AND descoleccionsol.tecnico_lab = tecnico_lab.codigo,   "+&
 "        modelo LEFT OUTER JOIN modelo_archivo_expo ON modelo.empresa = modelo_archivo_expo.empresa AND modelo.modelo = modelo_archivo_expo.modelo AND modelo.coleccion = modelo_archivo_expo.coleccion,   "+&
 "        tecnico_dis, "+&  
 "        comercial,   "+&
 "        ambiente,   "+&
 "        modelo_cliente,   "+&
 "        modelo_propuesta,   "+&
 "        modelo_trabajo  "+&
 "  WHERE ( descoleccionsol.empresa = modelo.empresa ) and  "+&
 "        ( descoleccionsol.codigo = modelo.coleccion ) and  "+&
 "        ( descoleccionsol.empresa = tecnico_dis.empresa ) and  "+&
 "        ( descoleccionsol.disenyador = tecnico_dis.codigo ) and  "+&
 "        ( descoleccionsol.empresa = comercial.empresa ) and  "+&
 "        ( descoleccionsol.comercial = comercial.codigo ) and  "+&
 "        ( descoleccionsol.ambiente = ambiente.codigo ) and  "+&
 "        ( descoleccionsol.empresa = ambiente.empresa ) and  "+&
 "        ( modelo.empresa = modelo_cliente.empresa ) and  "+&
 "        ( modelo.modelo = modelo_cliente.modelo ) and  "+&
 "        ( modelo_cliente.empresa = modelo_propuesta.empresa ) and  "+&
 "        ( modelo_cliente.modelo = modelo_propuesta.modelo ) and  "+&
 "        ( modelo_cliente.cliente = modelo_propuesta.cliente ) and  "+&
 "        ( modelo_propuesta.empresa = modelo_trabajo.empresa ) and  "+&
 "        ( modelo_propuesta.modelo = modelo_trabajo.modelo ) and  "+&
 "        ( modelo_propuesta.cliente = modelo_trabajo.cliente ) and  "+&
 "        ( modelo_propuesta.codigo = modelo_trabajo.propuesta ) and   "+&
 "			 ( descoleccionsol.empresa = '"+codigo_empresa+"' ) and "+&
 "  		 ( ( modelo_archivo_expo.codigo is null ) OR  "+&
 "			 ( modelo_archivo_expo.codigo = (SELECT MIN(E.codigo) FROM modelo_archivo_expo E WHERE E.empresa = modelo.empresa AND E.coleccion = modelo.coleccion AND E.modelo = modelo.modelo) ) ) "
end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_disenyo
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_disenyo
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_disenyo
integer x = 4914
integer y = 120
end type

event pb_imprimir::clicked;String new_sql
Int respuesta, respuesta2

if dw_datos.rowcount() > 0 then
	respuesta = MessageBox("Impresión de Imágenes de los Modelos", "¿Desea que se impriman las imágenes de los modelos?", Question!, YesNo!, 2)
	respuesta2 = MessageBox("Impresión de líneas seleccionadas", "¿Desea que se impriman solo los modelos/colecciones seleccionados?", Question!, YesNo!, 2)
	
	if respuesta = 1 then
//		new_sql = f_montar_filtro(sql_auxiliar)
//		dw_datos2.SetSQLSelect ( new_sql )
//		dw_datos2.retrieve()
		if respuesta2 = 1 then 
			dw_datos2.setfilter("seleccionado = 1")
			dw_datos2.filter()
		end if
		f_imprimir_datawindow(dw_datos2)
		dw_datos2.setfilter("")
		dw_datos2.filter()
	else
		if respuesta2 = 1 then 
			dw_datos.setfilter("seleccionado = 1")
			dw_datos.filter()
		end if
		f_imprimir_datawindow(dw_datos)
		dw_datos.setfilter("")
		dw_datos.filter()
	end if
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_disenyo
integer x = 5074
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_disenyo
integer width = 5504
integer height = 312
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_disenyo
integer x = 4315
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, new_sql2
long fila

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)
new_sql2 = f_montar_filtro(sql_auxiliar)
dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()
dw_datos2.SetSQLSelect ( new_sql2 )
dw_datos2.retrieve()

if dw_montaje_filtro.rowcount() > 3 then
//	dw_montaje_filtro.height = dw_montaje_filtro.height -75
//	dw_datos.y = dw_datos.y - 75
//	dw_datos.height = dw_datos.height + 75
//	
//	dw_imagen.y = dw_imagen.y - 75
//	dw_imagen.height = dw_imagen.height + 75
//	dw_imagen_marco.y = dw_imagen_marco.y - 75
//	dw_imagen_marco.height = dw_imagen_marco.height + 75
else
//	dw_datos.y = 512
//	dw_datos.height = 2228
//	
//	dw_imagen.y = 512
//	dw_imagen.height = 2240
//	dw_imagen_marco.y = 512
//	dw_imagen_marco.height = 2240
//	
//	dw_montaje_filtro.height = 225
end if

dw_datos.setfocus()
if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_disenyo
integer x = 5230
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_disenyo
integer x = 4165
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible
string new_sql, new_sql2, filtro
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Ambiente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.ambiente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Ambiente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.ambiente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Relieve"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo.relieve = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Relieve = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo.relieve = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Diseñador Colección"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.disenyador = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Diseñador Colección = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.disenyador = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Diseñador Trabajo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_trabajo.tecnico_dis = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Diseñador Trabajo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_trabajo.tecnico_dis = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Comercial Colección"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.comercial = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Comercial Creador Colección = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.comercial = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next
		case "Comercial Histórico"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.comercial IS NOT NULL AND deshistorico.comercial = '"+dw_filtro.object.#1[i]+"') "
						cadena_or_visible = " Comercial Histórico = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.comercial IS NOT NULL AND deshistorico.comercial = '"+dw_filtro.object.#1[i]+"') "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Cliente Histórico"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente IS NOT NULL AND deshistorico.cliente = '"+dw_filtro.object.#1[i]+"') "
						cadena_or_visible = " Cliente Histórico = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente IS NOT NULL AND deshistorico.cliente = '"+dw_filtro.object.#1[i]+"') "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Pendiente Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente IS NOT NULL AND deshistorico.cliente = '"+dw_filtro.object.#1[i]+"' and deshistorico.estado = 'Pendiente') "
						cadena_or_visible = " Pendiente Cliente  = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente IS NOT NULL AND deshistorico.cliente = '"+dw_filtro.object.#1[i]+"' and deshistorico.estado = 'Pendiente') "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Rechazado Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente IS NOT NULL AND deshistorico.cliente = '"+dw_filtro.object.#1[i]+"' and deshistorico.estado = 'Rechazado') "
						cadena_or_visible = " Rechazado Cliente  = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente IS NOT NULL AND deshistorico.cliente = '"+dw_filtro.object.#1[i]+"' and deshistorico.estado = 'Rechazado') "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Pendiente Comercial"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.comercial IS NOT NULL AND deshistorico.comercial = '"+dw_filtro.object.#1[i]+"' and deshistorico.estado = 'Pendiente') "
						cadena_or_visible = " Pendiente Comercial  = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.comercial IS NOT NULL AND deshistorico.comercial = '"+dw_filtro.object.#1[i]+"' and deshistorico.estado = 'Pendiente') "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Técnico Colección"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.tecnico_lab = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Técnico Colección = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.tecnico_lab = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Destino"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.destino = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Base Destino = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.destino = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Fecha Colección"
			if cadena_or = '' then
				cadena_or = " CONVERT(date,descoleccionsol.fecha_coleccion) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha colección "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Fecha Solicitud Trabajo"
			if cadena_or = '' then
				cadena_or = " CONVERT(date,modelo_trabajo.fecha_solicitud) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Solicitud Trabajo "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Fecha Presentación"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.codigo IN (SELECT coleccion FROM deshistorico WHERE f_resp IS NULL AND CONVERT(date, f_pres) "+ddlb_operador.text+" '"+em_fecha1.text+"') "
				cadena_or_visible = " Fecha Presentación "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Colección"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.codigo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Colección "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Colecciones"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Colecciones = "+dw_filtro.object.#1[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#1[i]
					end if
				end if
			next 
		case "Cliente Propuesta"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_propuesta.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente Propuesta = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_propuesta.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Estado"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.estado = '"+lb_lista.Text (k)+"' "
						cadena_or_visible = " Estado = "+lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR descoleccionsol.estado = '"+lb_lista.Text (k)+"' "
						cadena_or_visible = cadena_or_visible+", "+lb_lista.Text (k)
					end if
				end if
			next
		case "Pavimento/Revestimiento"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " modelo.pavrev = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR modelo.pavrev = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = cadena_or_visible+", "+lb_lista.Text (k)
					end if
				end if
			next
		case "Serie"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_trabajo.serie = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Serie = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_trabajo.serie = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Exposición"
			cadena_or = " descoleccionsol.codigo IN (select coleccion FROM coleccion_archivo WHERE activo = 1) "
			cadena_or_visible = " SOLO EXPOSICIÓN "
		case "Formato"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_propuesta.formato = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Formato = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_propuesta.formato = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Colección Descripción"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.descripcion LIKE '%"+sle_valor1.text+"%' "
				cadena_or_visible = " Colección Descripción "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Colección Grupo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.grupo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Colección Grupo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.grupo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
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
		if filtro_anterior = ddlb_campo.text then
			dw_montaje_filtro.deleterow(dw_montaje_filtro.rowcount())
		end if
		
		if cadena_or <> '' then
			cadena_or = " ( "+cadena_or+" ) "
			fila = dw_montaje_filtro.insertrow(0)
			dw_montaje_filtro.object.filtro[fila] = cadena_or
			dw_montaje_filtro.object.linea[fila] = cadena_or_visible
			
			new_sql = f_montar_filtro(sql_inicial)
			new_sql2 = f_montar_filtro(sql_auxiliar)
			
			//ddlb_campo.text = ''
			//dw_filtro.visible = false
			
			//dw_filtro.height = 137
		end if
	else
		new_sql = sql_inicial
		new_sql2 = sql_auxiliar
	end if
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos2.SetSQLSelect ( new_sql2 )
	dw_datos.retrieve()
	dw_datos2.retrieve()
	dw_datos.setsort("integer(descoleccionsol_codigo) DESC, integer(modelo_modelo) DESC")
	dw_datos.sort()
	dw_datos2.setsort("integer(descoleccionsol_codigo) DESC, integer(modelo_modelo) DESC")
	dw_datos2.sort()
	
	/*
	em_fecha1.visible = false
	sle_valor1.visible = false
	dw_filtro.visible = false
	pb_buscar.visible = false
	sle_texto.visible = false
	lb_lista.visible = false
	
	sle_texto.text = ''
	
	sle_valor1.text = ''
	ddlb_campo.selectitem(0) 
	ddlb_operador.selectitem(0) 
	dw_filtro.reset()
	*/
	
	
	//Para evitar solapamiento con otros datawindows
	dw_filtro.Height = 360
	
	//Tamaños DW en función del número de filtros
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		
//		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
//		
//		dw_datos.y = dw_datos.y + 75
//		dw_datos.height = dw_datos.height - 75
//		
//		dw_imagen.y = dw_imagen.y + 75
//		dw_imagen.height = dw_imagen.height - 75
//		dw_imagen_marco.y = dw_imagen_marco.y + 75
//		dw_imagen_marco.height = dw_imagen_marco.height - 75
		
	end if
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
	
	filtro_anterior = ddlb_campo.text
else
	
	new_sql = f_montar_filtro(sql_inicial)
	new_sql2 = f_montar_filtro(sql_auxiliar)
			
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	dw_datos2.SetSQLSelect ( new_sql2 )
	dw_datos2.retrieve()
	dw_datos.setsort("integer(descoleccionsol_codigo) DESC, integer(modelo_modelo) DESC")
	dw_datos.sort()
	dw_datos2.setsort("integer(descoleccionsol_codigo) DESC, integer(modelo_modelo) DESC")
	dw_datos2.sort()
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
	
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_disenyo
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_disenyo
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
string item[] = {"Ambiente","Diseñador Colección","Diseñador Trabajo","Comercial Histórico","Comercial Colección","Técnico Colección","Destino","Fecha Colección","Colección","Cliente Propuesta","Fecha Solicitud Trabajo","Estado","Pavimento/Revestimiento","Serie","Exposición","Cliente Histórico","Pendiente Cliente","Pendiente Comercial","Formato","Rechazado Cliente","Colecciones","Colección Descripción","Colección Grupo","Relieve"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Ambiente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from ambiente where empresa = '"+codigo_empresa+"' "
	CASE "Relieve"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from art_tipomoldura where empresa = '"+codigo_empresa+"' ORDER BY descripcion"	
	CASE "Colecciones"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from descoleccionsol where empresa = '"+codigo_empresa+"' AND codigo IN (SELECT coleccion FROM modelo) order by convert(integer, codigo) DESC"
	CASE "Diseñador Colección", "Diseñador Trabajo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_dis where empresa = '"+codigo_empresa+"' order by descripcion "
	CASE "Comercial Colección", "Comercial Histórico", "Pendiente Comercial"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from comercial where empresa = '"+codigo_empresa+"' order by descripcion "
	CASE "Técnico Colección"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_lab where empresa = '"+codigo_empresa+"' order by descripcion "
	CASE "Destino"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tipobase where empresa = '"+codigo_empresa+"' "
	CASE "Fecha Colección", "Fecha Solicitud Trabajo"
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
		ddlb_operador.AddItem ("=")
		
		ddlb_operador.text = ">="
	CASE "Colección", "Colección Descripción"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
	CASE "Cliente Propuesta", "Cliente Histórico", "Pendiente Cliente", "Rechazado Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where empresa = '"+codigo_empresa+"' and tipoter = 'C' order by razon"

	CASE "Estado"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("Libre")
		lb_lista.AddItem ("Reservado")
		lb_lista.AddItem ("Aceptado")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="

	CASE "Pavimento/Revestimiento"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("Pavimento")
		lb_lista.AddItem ("Revestimiento")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="

	CASE "Serie"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from desserie where empresa = '"+codigo_empresa+"' "
	CASE "Exposición"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("SI")
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
		consulta = "Select codigo as Código, descripcion as Descripción from formatos where empresa = '"+codigo_empresa+"' order by descripcion asc"
	CASE "Colección Grupo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from descoleccionsol_grupo where empresa = '"+codigo_empresa+"' "
	
END CHOOSE

pb_ocultar.visible = true


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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_disenyo
integer y = 588
integer width = 5239
integer height = 2152
integer taborder = 60
string dataobject = "dwtc_consulta_disenyo"
end type

event dw_datos::rowfocuschanged;call super::rowfocuschanged;//CON RUTAS 
string codigo_archivo, codigo_coleccion, modelo, ruta, tamanyo, tamanyo2, ruta_mini, imagen_modelo, imagen_coleccion, imagenes_marcadas, expo
Long min_codigo_archivo, numero_imagenes, fila_marcada, posicion_separador

if currentrow <= 0 then
	return
end if

codigo_coleccion = dw_datos.object.descoleccionsol_codigo[dw_datos.getrow()]
modelo = dw_datos.object.modelo_modelo[dw_datos.getrow()]

expo = '%'
if dw_montaje_filtro.rowcount() > 0 then
	if dw_montaje_filtro.find("linea LIKE '%EXPOSICIÓN%'",1,  dw_montaje_filtro.rowcount()) > 0 then
		expo = '1'
	end if
end if

if not isnull(codigo_coleccion) and codigo_coleccion <> "" and not isnull(modelo) and modelo <> "" then
	dw_historico.retrieve(codigo_empresa, codigo_coleccion)
	
	SELECT tamanyo INTO :tamanyo FROM archivo_resolucion WHERE codigo = '5';
	
	dw_imagenes_coleccion.retrieve(codigo_empresa, codigo_coleccion, tamanyo, expo)
	dw_imagenes_modelo.retrieve(codigo_empresa, modelo, tamanyo, expo)
	
	imagen_modelo = dw_datos.object.imagen_modelo[dw_datos.getrow()]
	imagen_coleccion = dw_datos.object.imagen_coleccion[dw_datos.getrow()]
	
	if not isnull(imagen_modelo) and imagen_modelo <> "" and dw_imagenes_modelo.rowcount() > 0  then
		imagenes_marcadas = imagen_modelo
		Do while imagenes_marcadas <> ""
			posicion_separador = pos(imagenes_marcadas, ",")
			imagen_modelo = trim(mid(imagenes_marcadas, 1, posicion_separador - 1))
			imagenes_marcadas = mid(imagenes_marcadas, posicion_separador + 1)
			
			fila_marcada = dw_imagenes_modelo.Find("codigo = '"+imagen_modelo+"'", 1, dw_imagenes_modelo.rowcount())
			dw_imagenes_modelo.object.marcado[fila_marcada] = 1
		Loop
	end if
	if not isnull(imagen_coleccion) or imagen_coleccion = "" and dw_imagenes_coleccion.rowcount() > 0 then
		imagenes_marcadas = imagen_coleccion
		Do while imagenes_marcadas <> ""
			posicion_separador = pos(imagenes_marcadas, ",")
			imagen_coleccion = trim(mid(imagenes_marcadas, 1, posicion_separador - 1))
			imagenes_marcadas = mid(imagenes_marcadas, posicion_separador + 1)
			
			fila_marcada = dw_imagenes_coleccion.Find("codigo = '"+imagen_coleccion+"'", 1, dw_imagenes_coleccion.rowcount())
			dw_imagenes_coleccion.object.marcado[fila_marcada] = 1
		Loop
	end if
	
	
	
end if


/*
//ANTIGUO

if not isnull(codigo_coleccion) and codigo_coleccion <> "" and not isnull(modelo) and modelo <> "" then
	dw_historico.retrieve(codigo_empresa, codigo_coleccion)
	
	imagen_modelo = dw_datos.object.imagen_modelo[dw_datos.getrow()]
	imagen_coleccion = dw_datos.object.imagen_coleccion[dw_datos.getrow()]
	if isnull(imagen_modelo) or imagen_modelo = "" then
		imagen_modelo = "0"
	end if
	if isnull(imagen_coleccion) or imagen_coleccion = "" then
		imagen_coleccion = "0"
	end if
	
//	
//	if cbx_expo.checked <> true then
//		dw_imagen_mini.Object.datawindow.picture.File = ''		
//		ftc_imagen_fondo_datawindow (dw_imagen_mini, '5', codigo_coleccion, modelo, "")
//		dw_imagen_mini.visible = true
//		dw_imagen.visible = false
//	else
//		dw_imagen.Object.datawindow.picture.File = ''		
//		ftc_imagen_fondo_datawindow (dw_imagen, '2', codigo_coleccion, modelo, "")
//		dw_imagen.visible = true
//		dw_imagen_mini.visible = false
//	end if
//	
	
	dw_datos.object.imagen_modelo[dw_datos.getrow()] = ftc_galeria_datawindow(dw_imagen_mini, '5', codigo_coleccion, modelo, "", Long(imagen_modelo), true, expo)
	dw_datos.object.imagen_coleccion[dw_datos.getrow()] = ftc_galeria_datawindow(dw_imagen_col, '5', codigo_coleccion, "", "", Long(imagen_coleccion), true, expo)
	if cbx_expo.checked <> true then
		//dw_imagen_mini.visible = true
		dw_imagen.visible = false
	else
		ftc_galeria_datawindow(dw_imagen, '2', codigo_coleccion, modelo, "", Long(dw_datos.object.imagen_modelo[dw_datos.getrow()]), true, expo)
		//dw_imagen_mini.visible = false
	end if
	
	numero_imagenes = 0
	if expo then
		SELECT COUNT(*) INTO :numero_imagenes FROM modelo_archivo_expo WHERE empresa = :codigo_empresa AND coleccion = :codigo_coleccion AND modelo = :modelo and activo = 1;
	else
		SELECT COUNT(*) INTO :numero_imagenes FROM modelo_archivo_expo WHERE empresa = :codigo_empresa AND coleccion = :codigo_coleccion AND modelo = :modelo;
	end if
	if numero_imagenes > 1 then
		pb_subir_modelo.visible = true
		pb_bajar_modelo.visible = true
	else
		pb_subir_modelo.visible = false
		pb_bajar_modelo.visible = false
	end if
	numero_imagenes = 0
	if expo then
		SELECT COUNT(*) INTO :numero_imagenes FROM coleccion_archivo WHERE empresa = :codigo_empresa AND coleccion = :codigo_coleccion and activo = 1;
	else
		SELECT COUNT(*) INTO :numero_imagenes FROM coleccion_archivo WHERE empresa = :codigo_empresa AND coleccion = :codigo_coleccion;
	end if
	if numero_imagenes > 1 then
		pb_subir_coleccion.visible = true
		pb_bajar_coleccion.visible = true
	else
		pb_subir_coleccion.visible = false
		pb_bajar_coleccion.visible = false
	end if
end if
*/
end event

event dw_datos::doubleclicked;call super::doubleclicked;Long id_ventana
str_parametros lstr_param 

if row > 0 then	
	
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(row,"modelo_modelo")
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_consulta_disenyo"
	lstr_param.resultado = ''
//	id_ventana = f_menu_ventana_esta_abierta("wtc_trabajos_disenyo_nuevo")
//	if id_ventana <> -1 then
//		if MessageBox("Aviso","Ya tiene abierta una ventana de modelos de diseño, ¿Desea cerrarla para ver el modelo seleccionado?",Question!,YesNo!,2) = 1 then
//			close(wtc_trabajos_disenyo_nuevo)
//			OpenWithParm(wtc_trabajos_disenyo_nuevo, lstr_param)
//		else
//			ventanas_activas[id_ventana].ventana.bringtotop = true
//		end if
//	else
//		OpenWithParm(wtc_trabajos_disenyo_nuevo,lstr_param)
//	end if
	
	window lw_ventana 

	OpenWithParm(lw_ventana, lstr_param , "wtc_trabajos_disenyo_nuevo")	
	
end if
end event

event dw_datos::clicked;call super::clicked;if dwo.name = "descoleccionsol_fecha_coleccion_t" then
	dw_datos.setsort("descoleccionsol_fecha_coleccion DESC, integer(descoleccionsol_codigo) DESC, integer(modelo_modelo) DESC")
	dw_datos.sort()
	dw_datos2.setsort("descoleccionsol_fecha_coleccion DESC, integer(descoleccionsol_codigo) DESC, integer(modelo_modelo) DESC")
	dw_datos2.sort()
end if



end event

event dw_datos::itemchanged;call super::itemchanged;if row > 0 then
	if dwo.name = "seleccionado" then
		dw_datos2.object.seleccionado[row] = Long(data)
	end if
end if

end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_disenyo
integer x = 5385
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_disenyo
integer width = 2789
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_disenyo
integer x = 5029
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_disenyo
integer x = 1298
integer y = 232
integer width = 1673
integer height = 360
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_disenyo
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_disenyo
integer x = 1312
integer width = 1317
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_disenyo
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_disenyo
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_disenyo
integer x = 1307
integer width = 462
integer height = 252
long textcolor = 24076881
end type

type dw_historico from u_dw within wtc_consulta_disenyo
integer x = 32
integer y = 2752
integer width = 2537
integer height = 528
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_historicomodelo2"
boolean vscrollbar = true
end type

type dw_imagen from u_dw_imagen within wtc_consulta_disenyo
boolean visible = false
integer x = 750
integer y = 588
integer width = 4800
integer height = 2164
integer taborder = 90
end type

type dw_imagen_marco from datawindow within wtc_consulta_disenyo
boolean visible = false
integer x = 727
integer y = 508
integer width = 4818
integer height = 2236
integer taborder = 90
string title = "none"
string dataobject = "dw_aux_imagen"
boolean border = false
boolean livescroll = true
end type

type pb_email from picturebutton within wtc_consulta_disenyo
integer x = 4759
integer y = 120
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\mail.png"
alignment htextalign = left!
string powertiptext = "Adjuntar imágenes seleccionadas a correo electrónico"
end type

event clicked;Long i, seleccionados, posicion_separador
String codigo_coleccion, modelo, imagen_modelo, imagen_coleccion, ruta, ruta_adjuntos = "", imagenes_marcadas_modelo, imagenes_marcadas_coleccion

seleccionados = 0
For i = 1 To dw_datos.rowcount() 
	if dw_datos.object.seleccionado[i] = 1 then
		codigo_coleccion = dw_datos.object.descoleccionsol_codigo[i]
		modelo = dw_datos.object.modelo_modelo[i]
		imagenes_marcadas_modelo = dw_datos.object.imagen_modelo[i]
		
		//Modelo
		Do while imagenes_marcadas_modelo <> ""
			posicion_separador = pos(imagenes_marcadas_modelo, ",")
			imagen_modelo = trim(mid(imagenes_marcadas_modelo, 1, posicion_separador - 1))
			imagenes_marcadas_modelo = mid(imagenes_marcadas_modelo, posicion_separador + 1)
		
			if not isnull(codigo_coleccion) and codigo_coleccion <> "" and not isnull(modelo) and modelo <> "" then
				//ruta = f_reemplazar(ftc_imagen_ruta('3', codigo_coleccion, modelo, ""),"\","/")
				ruta = f_reemplazar(ftc_imagen_ruta_codigo('3', codigo_coleccion, modelo, "", imagen_modelo),"\","/")
				if not isnull(ruta) and ruta <> "" then
					seleccionados ++
					ruta = "file:///" + ruta 
					ruta_adjuntos = ruta_adjuntos + ruta + ","
				end if
			end if
		Loop
		
		//Coleccion
		if cbx_ambientes.checked = true then
			imagenes_marcadas_coleccion = dw_datos.object.imagen_coleccion[i]
			
			Do while imagenes_marcadas_coleccion <> ""
				posicion_separador = pos(imagenes_marcadas_coleccion, ",")
				imagen_coleccion = trim(mid(imagenes_marcadas_coleccion, 1, posicion_separador - 1))
				imagenes_marcadas_coleccion = mid(imagenes_marcadas_coleccion, posicion_separador + 1)
				
				ruta = f_reemplazar(ftc_imagen_ruta_codigo('3', codigo_coleccion, "", "", imagen_coleccion),"\","/")
				if not isnull(ruta) and ruta <> "" then
					if pos(ruta, ruta_adjuntos) = 0 then
						seleccionados ++
						ruta = "file:///" + ruta 
						ruta_adjuntos = ruta_adjuntos + ruta + ","
					end if
				end if
			Loop
		end if
	end if
Next

if seleccionados > 0 then
	if ruta_adjuntos <> "" then
		ruta_adjuntos = mid(ruta_adjuntos, 1, len(ruta_adjuntos)-1)
		ftc_enviar_correo(ruta_adjuntos)
	end if
else
	MessageBox("Error", "Debe marcar las imágenes que desea enviar por correo")
end if
end event

type pb_descarga from picturebutton within wtc_consulta_disenyo
integer x = 4608
integer y = 120
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Download_24x24.png"
alignment htextalign = left!
string powertiptext = "Descargar Alta Resolución"
end type

event clicked;Long i, res, sel, seleccionados, posicion_separador
String codigo_coleccion, modelo, imagen_modelo, imagen_coleccion, ruta, ruta_por_defecto, ruta_destino, pathname, filename, extension, tipo, imagenes_marcadas, imagenes_marcadas_coleccion
String botones[2]
str_ventana_alerta parametros
ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)

//ruta_por_defecto = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
//res = GetFileSaveName ("Indique una carpeta de descarga", pathname, filename, "jpg", "Imagenes jpg,*.jpg", ruta_por_defecto, 2)
ruta_destino = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
res = GetFolder("Indique una carpeta de descarga", ruta_destino )
if res <> 1 then
	MessageBox("Error", "No ha sido posible guardar en la ruta indicada.")
	return
end if

parametros.titulo = "Formato de la Imagen"
parametros.subtitulo = "Indique el Formato"
parametros.mensaje = "Seleccione el formato de la imagen a descargar."
parametros.tipo = 3
botones[1] = "Miniatura"
botones[2] = "Alta resolución"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
sel = Int(Message.DoubleParm)
if sel = 1 then
	tipo = '5'
elseif sel = 2 then
	tipo = '3'
else
	return
end if

//ruta_destino = f_reemplazar(pathname,filename,"")
ruta_destino = ruta_destino + "\modelos_" + String(today(),"ddmmyy") + "_" + String(Now(),"hhmmss") + "\"
if not fileexists(ruta_destino) then
	CreateDirectory(ruta_destino)
end if

seleccionados = 0
barra.position = 0
barra.Maxposition = dw_datos.rowcount() 
For i = 1 To dw_datos.rowcount() 
	if dw_datos.object.seleccionado[i] = 1 then
		codigo_coleccion = dw_datos.object.descoleccionsol_codigo[i]
		modelo = dw_datos.object.modelo_modelo[i]
		imagenes_marcadas = dw_datos.object.imagen_modelo[i]
		
		//Imagenes Modelo
		Do while imagenes_marcadas <> "" and not isnull(codigo_coleccion) and codigo_coleccion <> "" and not isnull(modelo) and modelo <> ""
			posicion_separador = pos(imagenes_marcadas, ",")
			imagen_modelo = trim(mid(imagenes_marcadas, 1, posicion_separador - 1))
			imagenes_marcadas = mid(imagenes_marcadas, posicion_separador + 1)
			
			ruta = f_reemplazar(ftc_imagen_ruta_codigo(tipo, codigo_coleccion, modelo, "", imagen_modelo),"\","/")
			extension = mid(ruta,pos(ruta,"."))
			if not isnull(ruta) and ruta <> "" then		
				seleccionados ++
				//res = FileCopy(ruta, ruta_destino + modelo + extension, true)
				res = FileCopy(ruta, ruta_destino + ftc_imagen_ruta_nombre(tipo, codigo_coleccion, modelo, "", imagen_modelo), true)
				
				if res = -1 then
					MessageBox("Error", "Error de lectura de la imagen del modelo "+modelo+".")
				elseif res = -2 then
					MessageBox("Error", "Error de escritura de la imagen del modelo "+modelo+".")
				end if	
			end if
		Loop
		
		//Imagenes Coleccion
		if cbx_ambientes.checked = true then
			imagenes_marcadas_coleccion = dw_datos.object.imagen_coleccion[i]
			Do while imagenes_marcadas_coleccion <> ""
				posicion_separador = pos(imagenes_marcadas_coleccion, ",")
				imagen_coleccion = trim(mid(imagenes_marcadas_coleccion, 1, posicion_separador - 1))
				imagenes_marcadas_coleccion = mid(imagenes_marcadas_coleccion, posicion_separador + 1)
				
				ruta = f_reemplazar(ftc_imagen_ruta_codigo('3', codigo_coleccion, "", "", imagen_coleccion),"\","/")
				extension = mid(ruta,pos(ruta,"."))
				if not isnull(ruta) and ruta <> "" then
					if not fileexists(ruta_destino + codigo_coleccion + extension) then
						seleccionados ++
						//res = FileCopy(ruta, ruta_destino + codigo_coleccion + extension, true)
						res = FileCopy(ruta, ruta_destino + ftc_imagen_ruta_nombre('3', codigo_coleccion, "", "", imagen_coleccion), true)
						if res = -1 then
							MessageBox("Error", "Error de lectura de la imagen de la coleccion "+codigo_coleccion+".")
						elseif res = -2 then
							MessageBox("Error", "Error de escritura de la imagen de la coleccion "+codigo_coleccion+".")
						end if
					end if
				end if
			Loop	
		end if
		
	end if
	barra.position = i
Next

if seleccionados > 0 then
	run("explorer "+ruta_destino) //Muestra la carpeta
else
	RemoveDirectory(ruta_destino)
	MessageBox("Error", "Debe marcar las imágenes que desea descargar")
end if

end event

type cbx_ambientes from checkbox within wtc_consulta_disenyo
integer x = 3191
integer y = 140
integer width = 869
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Descargar / Enviar Ambientes"
boolean checked = true
end type

type cb_1 from commandbutton within wtc_consulta_disenyo
integer x = 4242
integer y = 2660
integer width = 453
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcar Todos"
end type

event clicked;Long i, j
String codigos, expo

dw_datos.accepttext()
barra.position = 0
barra.Maxposition = dw_datos.rowcount() 
For i = 1 To dw_datos.rowcount()
	dw_datos.object.seleccionado[i] = 1
	dw_datos.setrow(i)
	
	codigos = ""
	For j = 1 to dw_imagenes_coleccion.rowcount()
		codigos = codigos + dw_imagenes_coleccion.object.codigo[j] + ","
		
//		if i = dw_datos.rowcount() then
//			dw_imagenes_coleccion.object.marcado[j] = 1
//		end if
		dw_imagenes_coleccion.object.marcado[j] = 1
	Next
	dw_datos.object.imagen_coleccion[i] = codigos
	
	codigos = ""
	For j = 1 to dw_imagenes_modelo.rowcount()
		codigos = codigos + dw_imagenes_modelo.object.codigo[j] + ","
		
//		if i = dw_datos.rowcount() then
//			dw_imagenes_modelo.object.marcado[j] = 1
//		end if
		dw_imagenes_modelo.object.marcado[j] = 1
	Next
	dw_datos.object.imagen_modelo[i] = codigos
		
	barra.position = I
Next
end event

type cb_2 from commandbutton within wtc_consulta_disenyo
integer x = 4690
integer y = 2660
integer width = 517
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Desmarcar Todos"
end type

event clicked;Long i
For i = 1 To dw_datos.rowcount()
	dw_datos.object.seleccionado[i] = 0
	dw_datos.object.imagen_coleccion[i] = ""
	dw_datos.object.imagen_modelo[i] = ""
Next
end event

type barra from hprogressbar within wtc_consulta_disenyo
integer x = 3191
integer y = 20
integer width = 1792
integer height = 68
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 1
end type

type dw_datos2 from datawindow within wtc_consulta_disenyo
boolean visible = false
integer x = 4846
integer y = 688
integer width = 686
integer height = 400
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_consulta_disenyo_impresion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_imagenes_modelo from datawindow within wtc_consulta_disenyo
integer x = 4306
integer y = 2824
integer width = 978
integer height = 376
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_galeria_modelo"
boolean vscrollbar = true
boolean border = false
end type

event itemchanged;//Guardamos elementos marcados en el datawindow principal
String marcados = ""
Long i, numero_marcados = 0
Int marcado

For i = 1 To this.rowcount()
	marcado = this.object.marcado[i]
	if row = i then
		if marcado = 1 then
			marcado = 0
		else
			marcado = 1
		end if
	end if
	if  marcado = 1 then
		marcados = marcados + this.object.codigo[i] + ","
		numero_marcados ++
	end if	
Next

//if numero_marcados > 0 then
//	marcados = mid( marcados,1, len(marcados) - 1)
//end if

dw_datos.object.imagen_modelo[dw_datos.getrow()] = marcados
dw_datos.object.seleccionado[dw_datos.getrow()] = 1 
end event

event doubleclicked;//Mostramos imagen en grande
String tamanyo, ruta_archivos_exposicion, ruta, fichero

if row > 0 then
	SELECT tamanyo INTO :tamanyo FROM archivo_resolucion WHERE codigo = '2';
	ruta_archivos_exposicion = this.object.empresas_ruta_archivos_exposicion[row]
	ruta = this.object.modelo_archivo_expo_ruta[row]
	fichero = this.object.modelo_archivo_expo_fichero[row]
	
	dw_imagen.Object.datawindow.picture.File =  ruta_archivos_exposicion + ruta + tamanyo + "\" + fichero
	dw_imagen.visible = true
	cb_cerrar_expo.visible = true
end if

end event

type dw_imagenes_coleccion from datawindow within wtc_consulta_disenyo
integer x = 2903
integer y = 2824
integer width = 978
integer height = 376
integer taborder = 80
string title = "none"
string dataobject = "dwtc_aux_galeria_coleccion"
boolean vscrollbar = true
boolean border = false
end type

event itemchanged;//Guardamos elementos marcados en el datawindow principal
String marcados = ""
Long i, numero_marcados = 0
Int marcado

For i = 1 To this.rowcount()
	marcado = this.object.marcado[i]
	if row = i then
		if marcado = 1 then
			marcado = 0
		else
			marcado = 1
		end if
	end if
	if  marcado = 1 then
		marcados = marcados + this.object.codigo[i] + ","
		numero_marcados ++
	end if	
Next

//if numero_marcados > 0 then
//	marcados = mid( marcados,1, len(marcados) - 1)
//end if

dw_datos.object.imagen_coleccion[dw_datos.getrow()] = marcados
dw_datos.object.seleccionado[dw_datos.getrow()] = 1 
end event

event doubleclicked;//Mostramos imagen en grande
String tamanyo, ruta_archivos_exposicion, ruta, fichero

if row > 0 then
	SELECT tamanyo INTO :tamanyo FROM archivo_resolucion WHERE codigo = '2';
	ruta_archivos_exposicion = this.object.empresas_ruta_archivos_exposicion[row]
	ruta = this.object.coleccion_archivo_ruta[row]
	fichero = this.object.coleccion_archivo_fichero[row]
	
	dw_imagen.Object.datawindow.picture.File =  ruta_archivos_exposicion + ruta + tamanyo + "\" + fichero
	dw_imagen.visible = true
	cb_cerrar_expo.visible = true
end if

end event

type cb_cerrar_expo from commandbutton within wtc_consulta_disenyo
boolean visible = false
integer x = 4869
integer y = 328
integer width = 425
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar Imagen"
end type

event clicked;dw_imagen.visible = false
this.visible = false
end event

type pb_ocultar from picturebutton within wtc_consulta_disenyo
boolean visible = false
integer x = 2985
integer y = 128
integer width = 114
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Delete_24x24.png"
alignment htextalign = left!
end type

event clicked;em_fecha1.visible = false
sle_valor1.visible = false
dw_filtro.visible = false
pb_buscar.visible = false
sle_texto.visible = false
lb_lista.visible = false

sle_texto.text = ''

sle_valor1.text = ''
ddlb_campo.selectitem(0) 
ddlb_operador.selectitem(0) 
dw_filtro.reset()
pb_ocultar.visible = false
end event

