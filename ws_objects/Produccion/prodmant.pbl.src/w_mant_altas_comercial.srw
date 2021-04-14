$PBExportHeader$w_mant_altas_comercial.srw
forward
global type w_mant_altas_comercial from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_altas_comercial
end type
type pb_1 from upb_imprimir within w_mant_altas_comercial
end type
type dw_listado from datawindow within w_mant_altas_comercial
end type
type st_50 from statictext within w_mant_altas_comercial
end type
type dw_escandallo from u_datawindow within w_mant_altas_comercial
end type
type dw_caja_articulo from u_datawindow within w_mant_altas_comercial
end type
type dw_paletizado from u_datawindow within w_mant_altas_comercial
end type
type dw_calidad_altas from u_datawindow within w_mant_altas_comercial
end type
type cb_duplicar from commandbutton within w_mant_altas_comercial
end type
type pb_desbloquear from picturebutton within w_mant_altas_comercial
end type
type dw_observacion_version from u_datawindow within w_mant_altas_comercial
end type
type dw_imagenes_modelo from datawindow within w_mant_altas_comercial
end type
type dw_imagen from u_dw_imagen within w_mant_altas_comercial
end type
type dw_codestadistico from u_datawindow within w_mant_altas_comercial
end type
end forward

global type w_mant_altas_comercial from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 4256
integer height = 3680
pb_calculadora pb_calculadora
pb_1 pb_1
dw_listado dw_listado
st_50 st_50
dw_escandallo dw_escandallo
dw_caja_articulo dw_caja_articulo
dw_paletizado dw_paletizado
dw_calidad_altas dw_calidad_altas
cb_duplicar cb_duplicar
pb_desbloquear pb_desbloquear
dw_observacion_version dw_observacion_version
dw_imagenes_modelo dw_imagenes_modelo
dw_imagen dw_imagen
dw_codestadistico dw_codestadistico
end type
global w_mant_altas_comercial w_mant_altas_comercial

type variables

end variables

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
cb_duplicar.enabled = true
end event

event open;call super::open;integer permiso

permiso = f_permiso_usuario( string(this.classname()), nombre_usuario)

choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Altas de Artículos"

This.title = istr_parametros.s_titulo_ventana

dw_escandallo.SetTransObject(SQLCA)
dw_codestadistico.SetTransObject(SQLCA)
dw_caja_articulo.SetTransObject(SQLCA)
dw_paletizado.SetTransObject(SQLCA)
dw_observacion_version.SetTransObject(SQLCA)
dw_calidad_altas.SetTransObject(SQLCA)


// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		dw_escandallo.Retrieve(codigo_empresa,sle_valor.Text, '1')
		dw_codestadistico.Retrieve(codigo_empresa,sle_valor.Text)
		dw_paletizado.Retrieve(codigo_empresa,sle_valor.Text)
		dw_observacion_version.Retrieve(codigo_empresa,sle_valor.Text, '1')
		dw_calidad_altas.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

	
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
cb_duplicar.enabled = false



end event

event ue_inserta_fila;call super::ue_inserta_fila;long fila

dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"activo",'S')
//dw_1.setitem(dw_1.getrow(),"unidad",'0')
//dw_1.setitem(dw_1.getrow(),"familia",'1')
dw_1.setitem(dw_1.getrow(),"fecha_alta", datetime ( date(string ( today(), 'dd-mm-yyyy' ) ) ) )
dw_1.setitem(dw_1.getrow(),"articulos_bloqueado",'S')


dw_1.setitem(dw_1.getrow(),"sector",'S')
dw_1.setitem(dw_1.getrow(),"usuario",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"tono",'N')
dw_1.setitem(dw_1.getrow(),"calibre",'N')
dw_1.setitem(dw_1.getrow(),"articulos_control_Stock",'S')

fila = dw_codestadistico.insertrow(0)
dw_codestadistico.ScrollToRow(fila)
dw_codestadistico.setitem(fila, "empresa", codigo_empresa)
dw_codestadistico.setitem(fila, "codigo", sle_valor.text)

fila = dw_caja_articulo.insertrow(0)
dw_caja_articulo.setitem(fila, "almartcajas_empresa", codigo_empresa)
dw_caja_articulo.setitem(fila, "almartcajas_articulo", sle_valor.text)
dw_caja_articulo.setitem(fila, "almartcajas_pordefecto", 'S')

fila = dw_paletizado.insertrow(0)
dw_paletizado.setitem(fila, "palarticulo_empresa", codigo_empresa)
dw_paletizado.setitem(fila, "palarticulo_articulo", sle_valor.text)
dw_paletizado.setitem(fila, "palarticulo_pordefecto", 'S')

fila = dw_observacion_version.insertrow(0)
dw_observacion_version.setitem(fila, "empresa", codigo_empresa)
dw_observacion_version.setitem(fila, "articulo", sle_valor.text)
dw_observacion_version.setitem(fila, "version", '1')
dw_observacion_version.setitem(fila, "tipo_version", 'P')
dw_observacion_version.setitem(fila, "descripcion", 'ÚNICA')

fila = dw_calidad_altas.insertrow(0)
dw_calidad_altas.setitem(fila, "empresa", codigo_empresa)
dw_calidad_altas.setitem(fila, "articulo", sle_valor.text)
dw_calidad_altas.setitem(fila, "calidad", '1')
dw_calidad_altas.setitem(dw_1.getrow(),"fecha_alta", datetime ( date(string ( today(), 'dd-mm-yyyy' ) ) ) )


end event

event ue_recuperar;
// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "articulos"

///////////////////////////////////////////////////////
// 	CONTROL STOCK, PEDIDO Y PLANIFICADO
///////////////////////////////////////////////////////

boolean hay_pedido, hay_stock, hay_planificado
int total
string texto, modelo, articulo, coleccion, imagen_origen



total = 0
if sle_valor.text <> '' and not isnull (sle_valor.text) then
	hay_pedido = false
	hay_stock = false
	hay_planificado = false
	texto = ""
	
	total = 0
	select count(*)
	into :total
	from venliped
	where empresa = :codigo_empresa
	and articulo = :sle_valor.text;
	
	if total > 0 then	
		hay_pedido = true
		texto = "Hay Pedido. "
	end if
	
	total = 0
	select SUM(cantidade - cantidads)
	into :total
	from almacenmovimientos
	where empresa = :codigo_empresa
	and articulo = :sle_valor.text
	group by articulo;
	
	if total > 0 then	
		hay_stock = true
		texto = texto + "Hay stock. "
	end if
	
	total = 0
	select count(*)
	into :total
	from planificacion
	where empresa = :codigo_empresa
	and cod_articulo = :sle_valor.text;
	
	if total > 0 then	
		hay_planificado = true
		texto = texto + "Hay Planificado. "
	end if
	
	if texto <> '' then
		messagebox("Aviso", nombre_usuario+": "+texto)
	end if 
end if

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
	
	
dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_escandallo.Retrieve(codigo_empresa,sle_valor.Text, '1')
dw_codestadistico.Retrieve(codigo_empresa,sle_valor.Text)
dw_caja_articulo.Retrieve(codigo_empresa,sle_valor.Text)
dw_paletizado.Retrieve(codigo_empresa,sle_valor.Text)
dw_observacion_version.Retrieve(codigo_empresa,sle_valor.Text, '1')
dw_calidad_altas.Retrieve(codigo_empresa,sle_valor.Text)

if dw_1.rowcount() > 0 then
	//descripcion coleccion
	modelo = dw_1.object.referencia_laboratorio[1]
	if not isnull(modelo) and modelo <> "" then
//		SELECT coleccion INTO :coleccion FROM modelo WHERE empresa = :codigo_empresa AND modelo = :modelo;
//		dw_descripcion_coleccion.Retrieve(codigo_empresa, coleccion)
	else
		modelo = dw_1.object.articulos_modelo_origen[1]
//		if not isnull(modelo) and modelo <> "" then
//			SELECT coleccion INTO :coleccion FROM modelo WHERE empresa = :codigo_empresa AND modelo = :modelo;
//			dw_descripcion_coleccion.Retrieve(codigo_empresa, coleccion)
//		end if
	end if
	//imagen
	articulo = String(sle_valor.text)
	if not isnull(articulo) and articulo <> "" then
		ftc_imagen_articulo("3", articulo, dw_imagen)
	end if
end if
CALL Super::ue_recuperar
end event

on w_mant_altas_comercial.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.st_50=create st_50
this.dw_escandallo=create dw_escandallo
this.dw_caja_articulo=create dw_caja_articulo
this.dw_paletizado=create dw_paletizado
this.dw_calidad_altas=create dw_calidad_altas
this.cb_duplicar=create cb_duplicar
this.pb_desbloquear=create pb_desbloquear
this.dw_observacion_version=create dw_observacion_version
this.dw_imagenes_modelo=create dw_imagenes_modelo
this.dw_imagen=create dw_imagen
this.dw_codestadistico=create dw_codestadistico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.st_50
this.Control[iCurrent+5]=this.dw_escandallo
this.Control[iCurrent+6]=this.dw_caja_articulo
this.Control[iCurrent+7]=this.dw_paletizado
this.Control[iCurrent+8]=this.dw_calidad_altas
this.Control[iCurrent+9]=this.cb_duplicar
this.Control[iCurrent+10]=this.pb_desbloquear
this.Control[iCurrent+11]=this.dw_observacion_version
this.Control[iCurrent+12]=this.dw_imagenes_modelo
this.Control[iCurrent+13]=this.dw_imagen
this.Control[iCurrent+14]=this.dw_codestadistico
end on

on w_mant_altas_comercial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.st_50)
destroy(this.dw_escandallo)
destroy(this.dw_caja_articulo)
destroy(this.dw_paletizado)
destroy(this.dw_calidad_altas)
destroy(this.cb_duplicar)
destroy(this.pb_desbloquear)
destroy(this.dw_observacion_version)
destroy(this.dw_imagenes_modelo)
destroy(this.dw_imagen)
destroy(this.dw_codestadistico)
end on

event closequery;call super::closequery;string v_tabla, v_empresa_mas_tabla
v_tabla = "articulos"

v_empresa_mas_tabla = codigo_empresa+"-"+v_tabla

delete from uti_bloqueo
where usuario = :nombre_usuario
and tabla = :v_empresa_mas_tabla
and titulo = :v_tabla;

if sqlca.sqlcode = -1 then 
	rollback using SQLCA;
	messagebox("Error","Error borrando los bloqueos del usuario actual",StopSign!)
else
	commit using SQLCA;
end if

end event

event close;call super::close;delete from uti_colisiones
where empresa = :codigo_empresa 
and tabla = "articulos"
and usuario = :nombre_usuario 
using sqlca;

if sqlca.sqlcode = -1 then
	rollback using sqlca;
	messagebox("Error", "Error borrando colisiones")
else 
	commit using sqlca;
end if

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_altas_comercial
integer x = 18
integer y = 280
integer width = 2491
integer height = 2100
integer taborder = 30
string dataobject = "dw_mant_altas_comercial"
boolean border = true
end type

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "articulos_marcas_codigo"
	bus_titulo     = "AYUDA SELECCION DE MARCAS"
	bus_datawindow = "dw_ayuda_marcas"
	bus_filtro     = "familias_codigo = '"+this.object.articulos_familia[row]+"'" 
CASE "articulos_submarcas_codigo"
	bus_titulo     = "AYUDA SELECCION DE SUBMARCAS"
	bus_datawindow = "dw_ayuda_submarcas"
	bus_filtro     = "familias_codigo = '"+this.object.articulos_familia[row]+"' and marcas_codigo = '"+this.object.articulos_marcas_codigo[row]+"'" 
CASE "formato"
	bus_titulo     = "AYUDA SELECCION DE FORMATOS"
	bus_datawindow = "dw_ayuda_formatos"
	bus_filtro     = ""
CASE "articulos_unidad"
	valor_empresa = FALSE
	bus_titulo     = "AYUDA SELECCION DE UNIDAD"
	bus_datawindow = "dw_ayuda_unidades"
	bus_filtro     = ""
CASE "articulos_costilla"
	bus_titulo     = "AYUDA SELECCION DE COSTILLA"
	bus_datawindow = "dw_ayuda_costilla"
	bus_filtro     = ""
CASE "uso"
	bus_titulo     = "VENTANA SELECCION DE USOS"
	bus_datawindow = "dw_ayuda_almusos"
	bus_filtro     = "" 		
CASE "cliente"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 	
CASE "articulos_cliente_marca"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 	
CASE "articulos_codigo_compras"
	bus_titulo     = "AYUDA SELECCION DE ARTÍCULOS DE COMPRAS"
	bus_datawindow = "dw_ayuda_venmprima"
	bus_filtro     = "" 
CASE "articulos_partidaest"
	bus_titulo     = "AYUDA SELECCION DE PARTIDAS ESTADISTICAS"
	bus_datawindow = "dw_ayuda_venpartidas"
	bus_filtro     = "" 
CASE "articulos_familia"
	bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
	bus_datawindow = "dw_ayuda_familias"
	bus_filtro     = "" 
CASE "articulos_subfamilia"
	bus_titulo     = "VENTANA SELECCION DE SUBFAMILIAS "
	bus_datawindow = "dw_ayuda_subfamilias"
	bus_filtro     = "" 
CASE "articulos_colecciones_ccc"
	bus_titulo     = "VENTANA SELECCION DE COLECCIONES "
	bus_datawindow = "dw_ayuda_colecciones_ccc"
	bus_filtro     = "" 
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::key;String coleccion, modelo
valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "articulos_marcas_codigo"
	bus_titulo     = "AYUDA SELECCION DE MARCAS"
	bus_datawindow = "dw_ayuda_marcas"
	bus_filtro     = "familias_codigo = '"+this.object.articulos_familia[this.getrow()]+"'" 
CASE "articulos_submarcas_codigo"
	bus_titulo     = "AYUDA SELECCION DE SUBMARCAS"
	bus_datawindow = "dw_ayuda_submarcas"
	bus_filtro     = "familias_codigo = '"+this.object.articulos_familia[this.getrow()]+"' and marcas_codigo = '"+this.object.articulos_marcas_codigo[this.getrow()]+"'" 
CASE "formato"
	bus_titulo     = "AYUDA SELECCION DE FORMATOS"
	bus_datawindow = "dw_ayuda_formatos"
	bus_filtro     = ""
CASE "articulos_unidad"
	valor_empresa = FALSE
	bus_titulo     = "AYUDA SELECCION DE UNIDAD"
	bus_datawindow = "dw_ayuda_unidades"
	bus_filtro     = ""
CASE "articulos_costilla"
	bus_titulo     = "AYUDA SELECCION DE COSTILLA"
	bus_datawindow = "dw_ayuda_costilla"
	bus_filtro     = ""
CASE "uso"
	bus_titulo     = "VENTANA SELECCION DE USOS"
	bus_datawindow = "dw_ayuda_almusos"
	bus_filtro     = "" 		
CASE "cliente"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 	
CASE "articulos_cliente_marca"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 	
CASE "articulos_codigo_compras"
	bus_titulo     = "AYUDA SELECCION DE ARTÍCULOS DE COMPRAS"
	bus_datawindow = "dw_ayuda_venmprima"
	bus_filtro     = "" 
CASE "articulos_partidaest"
	bus_titulo     = "AYUDA SELECCION DE PARTIDAS ESTADISTICAS"
	bus_datawindow = "dw_ayuda_venpartidas"
	bus_filtro     = "" 
CASE "articulos_familia"
	bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
	bus_datawindow = "dw_ayuda_familias"
	bus_filtro     = "" 
CASE "articulos_subfamilia"
	bus_titulo     = "VENTANA SELECCION DE SUBFAMILIAS "
	bus_datawindow = "dw_ayuda_subfamilias"
	bus_filtro     = "" 
CASE "articulos_colecciones_ccc"
	bus_titulo     = "VENTANA SELECCION DE COLECCIONES "
	bus_datawindow = "dw_ayuda_colecciones_ccc"
	bus_filtro     = "" 	
	
CASE "articulos_imagen_origen"	
		if key =  keyEnter! then
			modelo = this.object.articulos_modelo_origen[this.getrow()]
			if isnull(modelo) or modelo = "" then
				MessageBox("Atención", "Debe indicar previamente el código del modelo.")
				return
			end if
			SELECT coleccion INTO :coleccion FROM modelo WHERE empresa = :codigo_empresa AND modelo = :modelo;
			dw_imagenes_modelo.settransobject(SQLCA)
			dw_imagenes_modelo.retrieve(codigo_empresa, coleccion, modelo)
			dw_imagenes_modelo.visible = true
			return
		end if	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key
end event

event dw_1::itemchanged;call super::itemchanged;
string v_juegopantallas, v_factormp, operacion
string modelo, prueba, coleccion, descripcion, formato_etiqueta
Int decimales
dec {2} ancho_std, largo_std
string ls_objeto
str_parametros lstr_param

IF dwo.Name = "formato" THEN
	dw_1.object.formatos_abreviado[row] = f_nombre_formato_Abr(codigo_empresa, data)

	select abreviado, ancho, largo
	into  :formato_etiqueta, :ancho_std, :largo_std
	from formatos 
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_1.object.articulos_formato_etiqueta[row] = formato_etiqueta
	dw_1.object.articulos_ancho_std[row] = ancho_std
	dw_1.object.articulos_largo_std[row] = largo_std
END IF

//IF (dwo.Name = "articulos_ancho_std" or dwo.Name = "articulos_largo_std") and dw_caja_articulo.rowcount() > 0  THEN
//	if  dw_caja_articulo.object.almartcajas_piezascaja [1] <> 0 and dw_caja_articulo.object.almartcajas_caja [1] <> '' then
//		cb_insertar.TriggerEvent (clicked!)
//		lstr_param.s_titulo_ventana = "Mantenimiento de Cajas por Artículo"
//		lstr_param.s_argumentos[2]  = sle_valor.text
//		lstr_param.i_nargumentos    = 2
//		OpenWithParm(wi_mant_articulocaja,lstr_param)
//		dw_caja_articulo.Retrieve(codigo_empresa,sle_valor.text)
//	end if
//END IF


IF dwo.Name = "uso" THEN
	dw_1.object.almusos_descripcion[row] = f_nombre_almusos(codigo_empresa, data)
END IF
IF dwo.Name = "cliente" THEN
	dw_1.object.genter_razon[row] = f_nombre_cliente(codigo_empresa, 'C',data)
END IF
IF dwo.Name = "articulos_cliente_marca" THEN
	dw_1.object.genter_razon_1[row] = f_nombre_cliente(codigo_empresa, 'C',data)
END IF
IF dwo.Name = "articulos_unidad" THEN
	SELECT decimales INTO :decimales
	FROM unidades 
	WHERE codigo = :data;
	if isnull(decimales) then decimales = 0
	dw_1.object.articulos_decimales_unidad[row] = decimales
END IF
IF dwo.Name = "articulos_codigo_compras" THEN
	dw_1.object.venmprima_descripcion[row] = f_nombre_mprima(codigo_empresa,data)
END IF
IF dwo.Name = "articulos_partidaest" THEN
	dw_1.object.venpartidas_valor1[row] = f_valor1_venpartidas(codigo_empresa,data)
	dw_1.object.venpartidas_descripcion[row] = f_nombre_venpartidas(codigo_empresa,data)
END IF
if dwo.Name =  "articulos_imagen_origen" then
	/*
	if data <> "" then
		modelo = this.object.articulos_modelo_origen[dw_1.getrow()]
		if isnull(modelo) or modelo = "" then
			MessageBox("Atención", "Debe indicar previamente el código del modelo.")
			dwo.Primary[row] = ''
			return 2
		end if
		SELECT coleccion INTO :coleccion FROM modelo WHERE empresa = :codigo_empresa AND modelo = :modelo;
		dw_imagenes_modelo.settransobject(SQLCA)
		dw_imagenes_modelo.retrieve(codigo_empresa, coleccion, modelo)
		dw_imagenes_modelo.visible = true
		
		dwo.Primary[row] = ''
		return 2
	end if
	*/
end if

IF dwo.Name = "referencia_laboratorio" THEN
	if not isnull(data) then
//		SELECT coleccion INTO :coleccion FROM modelo WHERE empresa = :codigo_empresa AND modelo = :data;
//		dw_descripcion_coleccion.Retrieve(codigo_empresa, coleccion)
	end if
end if
IF dwo.Name = "articulos_familia" THEN
	dw_1.object.familias_descripcion[row] = f_nombre_familia(codigo_empresa, data)
end if

IF dwo.Name = "articulos_subfamilia" THEN
	dw_1.object.subfamilias_descripcion[row] = f_nombre_subfamilia( codigo_empresa,data)
END IF

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;String texto

if row <> 0 then
	if not isnull(dw_1.object.descripcion[row]) then
		texto = trim(String(dw_1.object.descripcion[row]))
		dw_1.accepttext()
		dw_1.object.descripcion[row] = texto
	END IF
end if
end event

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_articulos_marcas_codigo'
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"articulos_marcas_codigo")
	OpenWithParm(wi_mant_marcas,lstr_param)  
CASE 'pb_articulos_submarcas_codigo'
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"articulos_submarcas_codigo")
	OpenWithParm(wi_mant_submarcas,lstr_param)  
 CASE 'p_marca'
   lstr_param.i_nargumentos    = 1
   lstr_param.s_argumentos[1]=GetItemString(This.GetRow(),"articulos_cliente_marca")
  OpenWithParm(wtc_mant_clientes,lstr_param)  
  CASE 'p_costilla'
   lstr_param.i_nargumentos    = 1
   lstr_param.s_argumentos[1]=GetItemString(This.GetRow(),"articulos_costilla")
  OpenWithParm(wtc_mant_costilla,lstr_param)  
CASE 'p_familia'
	lstr_param.i_nargumentos    = 2
	 lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"articulos_familia")
  OpenWithParm(wi_mant_familias,lstr_param)  
CASE 'p_subfamilia'
	lstr_param.i_nargumentos    = 1
	lstr_param.s_argumentos[1]=GetItemString(This.GetRow(),"articulos_subfamilia")
	OpenWithParm(wi_mant_subfamilias,lstr_param) 
CASE 'p_colecciones_ccc'
	lstr_param.i_nargumentos    = 1
	lstr_param.s_argumentos[1]=GetItemString(This.GetRow(),"articulos_colecciones_ccc")
	OpenWithParm(wtc_mant_colecciones_ccc,lstr_param)  	
  
END CHOOSE
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_altas_comercial
integer x = 59
integer y = 176
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_altas_comercial
integer x = 2747
integer y = 148
integer height = 100
end type

event cb_insertar::clicked;int total
integer li_rc, valor
string motivo, controles, campo, texto
long numero, i, j, k, l, m, fila_actual
datawindow dato
boolean falta_campo, exito
String referencia_lab, modelo_origen, articulo, ruta, fichero, modelo_imagen_antiguo
Datetime fecha_modificacion
string texto_error
string bloqueo_packing

exito = true

SELECT bloqueo_packing
INTO  :bloqueo_packing
FROM articulos 
WHERE empresa = :codigo_empresa 
	AND codigo = :sle_valor.text
USING SQLCA;
	
if  bloqueo_packing = 'S' then
	 MessageBox("¡Atención!", "NO se puede modificar el packing. El Artículo tiene el packing confirmado. Avisar a Departamento de Hornos. ",StopSign!,OK!)
	return
end if


IF dw_1.rowcount() > 0 THEN
	if dw_codestadistico.object.art_codestadistico_g2[1] = 'N' and dw_1.object.uso[1] <> '1' then
		if cb_insertar.enabled  then
//			if dw_descripcion_coleccion.rowcount() < 1 then
//				messagebox("Aviso", "Hay algún problema con la referencia de laboraratorio o con la colección. ")
//				return
//			end if
		end if		
	end if
	
	falta_campo = false
	
	dw_1.accepttext()
	i = dw_1.getrow()
	
	if not isnull(dw_1.object.descripcion[i]) then
		texto = trim(String(dw_1.object.descripcion[i]))
		dw_1.object.descripcion[i] = texto
	END IF
	
	dw_codestadistico.accepttext()
	j = dw_codestadistico.getrow()
	dw_caja_articulo.accepttext()
	m = dw_caja_articulo.getrow()
	dw_paletizado.accepttext()
	k = dw_paletizado.getrow()
//	dw_descripcion_coleccion.accepttext()
	
	if k = 0 or m = 0 or j = 0 then 
		MessageBox("Error","Es obligatorio introducir información sobre el paletizado, caja y código estadístico.")
		return 1
	end if
	
	IF IsNull(dw_1.object.descripcion[i]) or Trim(String(dw_1.object.descripcion[i]))="" THEN
		  campo="descripcion"
		  motivo  = "(Campo Obligatorio) Introduzca la descripción."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.articulos_familia[i]) or Trim(String(dw_1.object.articulos_familia[i]))="" THEN
		  campo="articulos_familia"
		  motivo  = "(Campo Obligatorio) Introduzca la familia."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.articulos_unidad[i]) or Trim(String(dw_1.object.articulos_unidad[i]))="" THEN
		  campo="articulos_unidad"
		  motivo  = "(Campo Obligatorio) Introduzca la Unidad."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.articulos_decimales_unidad[i]) or Trim(String(dw_1.object.articulos_decimales_unidad[i]))="" THEN
		  campo="articulos_decimales_unidad"
		  motivo  = "(Campo Obligatorio) Introduzca los decimales de la Unidad para este artículo."
		  dato = dw_1
		  numero = 1
		  falta_campo = True		  
	ELSEIF IsNull(dw_1.object.articulos_costilla[i]) or Trim(String(dw_1.object.articulos_costilla[i]))="" THEN
		  campo="articulos_costilla"
		  motivo  = "(Campo Obligatorio) Introduzca la Costilla (Sin costilla especial SIN PLACA)."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.formato[i]) or Trim(String(dw_1.object.formato[i]))="" THEN
		  campo="formato"
		  motivo  = "(Campo Obligatorio) Introduzca el formato."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.articulos_partidaest[i]) or Trim(String(dw_1.object.articulos_partidaest[i]))="" THEN
		  campo="articulos_partidaest"
		  motivo  = "(Campo Obligatorio) Introduzca la partida estadística."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
		  
	ELSEIF IsNull(dw_1.object.uso[i]) or Trim(String(dw_1.object.uso[i]))="" THEN
		  campo="uso"
		  motivo  = "(Campo Obligatorio) Introduzca el uso."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.tono[i]) or Trim(String(dw_1.object.tono[i]))="" THEN
		  campo="destrabajo_contratipo"
		  motivo  = "(Campo Obligatorio) Introduzca el tono."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.calibre[i]) or Trim(String(dw_1.object.calibre[i]))="" THEN
		  campo="calibre"
		  motivo  = "(Campo Obligatorio) Introduzca calibre."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.articulos_venta_conjuntos[i]) or Trim(String(dw_1.object.articulos_venta_conjuntos[i]))="" THEN
		  campo="articulos_venta_conjuntos"
		  motivo  = "(Campo Obligatorio) ¿Se vende por conjuntos?."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_codestadistico.object.art_codestadistico_g1[j]) or Trim(String(dw_codestadistico.object.art_codestadistico_g1[j]))="" THEN
		  campo="art_codestadistico_g1"
		  motivo  = "(Campo Obligatorio) Introduzca G1."
		  dato = dw_codestadistico
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_codestadistico.object.art_codestadistico_g2[j]) or Trim(String(dw_codestadistico.object.art_codestadistico_g2[j]))="" THEN
		  campo="art_codestadistico_g2"
		  motivo  = "(Campo Obligatorio) Introduzca G2."
		  dato = dw_codestadistico
		  numero = 1
		  falta_campo = True
/* Descomentar cuando pongamos el control de compras.
	ELSEIF Trim(String(dw_codestadistico.object.art_codestadistico_g2[j]))="N" and ( dw_1.object.articulos_codigo_compras[j] = '' &
																												or isnull (dw_1.object.articulos_codigo_compras[j])) THEN
		  campo="articulos_codigo_compras"
		  motivo  = "(Campo Obligatorio) Introduzca Cód. Compras."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
*/

	ELSEIF IsNull(dw_codestadistico.object.art_codestadistico_g3[j]) or Trim(String(dw_codestadistico.object.art_codestadistico_g3[j]))="" THEN
		  campo="art_codestadistico_g3"
		  motivo  = "(Campo Obligatorio) Introduzca G3."
		  dato = dw_codestadistico
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_codestadistico.object.art_codestadistico_en[j]) or Trim(String(dw_codestadistico.object.art_codestadistico_en[j]))="" THEN
		  campo="art_codestadistico_en"
		  motivo  = "(Campo Obligatorio) Introduzca EN."
		  dato = dw_codestadistico
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_codestadistico.object.art_codestadistico_pt[j]) or Trim(String(dw_codestadistico.object.art_codestadistico_pt[j]))="" THEN
		  campo="art_codestadistico_pt"
		  motivo  = "(Campo Obligatorio) Introduzca PT."
		  dato = dw_codestadistico
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_caja_articulo.object.almartcajas_caja[m]) or Trim(String(dw_caja_articulo.object.almartcajas_caja[m]))='' THEN
		  campo="almartcajas_caja"
		  motivo  = "(Campo Obligatorio) Introduzca Caja."
		  dato = dw_caja_articulo
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_caja_articulo.object.almartcajas_piezascaja[m]) or dw_caja_articulo.object.almartcajas_piezascaja[m]=0 THEN
		  campo="almartcajas_piezascaja"
		  motivo  = "(Campo Obligatorio) Introduzca Piezas / caja."
		  dato = dw_caja_articulo
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_paletizado.object.palarticulo_codigo[k]) or Trim(String(dw_paletizado.object.palarticulo_codigo[k]))="" THEN
		  campo="palarticulo_codigo"
		  motivo  = "(Campo Obligatorio) Introduzca pallet."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_paletizado.object.palarticulo_caja[k]) or Trim(String(dw_paletizado.object.palarticulo_caja[k]))="" THEN
		  campo="palarticulo_caja"
		  motivo  = "(Campo Obligatorio) Introduzca Caja."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_paletizado.object.palarticulo_cajaspallet[k]) or dw_paletizado.object.palarticulo_cajaspallet[k]=0 THEN
		  campo="palarticulo_cajaspallet"
		  motivo  = "(Campo Obligatorio) Introduzca Cajas / Pallet."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_paletizado.object.palarticulo_planospallet[k]) or dw_paletizado.object.palarticulo_planospallet[k]=0 THEN
		  campo="palarticulo_planospallet"
		  motivo  = "(Campo Obligatorio) Introduzca Planos / Pallet."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_paletizado.object.palarticulo_alturas[k]) or dw_paletizado.object.palarticulo_alturas[k]= 0 THEN
		  campo="palarticulo_alturas"
		  motivo  = "(Campo Obligatorio) Introduzca Alturas / Pallet."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	ELSEIF dw_paletizado.object.palarticulo_caja[k] <> dw_caja_articulo.object.almartcajas_caja[m] THEN
		  campo="palarticulo_caja"
		  motivo  = "NO puede ser distinta la caja del pallet a la CAJA indicada."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True

	ELSEIF IsNull(dw_1.object.articulos_contra_Stock[i]) or Trim(String(dw_1.object.articulos_contra_Stock[i]))="" THEN
		  campo="articulos_contra_Stock"
		  motivo  = "(Campo Obligatorio) Introduzca si el artículo se fabrica contra stock."
		  dato = dw_1
		  numero = 1
		  falta_campo = True		  
		  

//	ELSEIF dw_descripcion_coleccion.rowcount() > 0 then
//			if ( IsNull(dw_descripcion_coleccion.object.descoleccionsol_descripcion[1]) or dw_descripcion_coleccion.object.descoleccionsol_descripcion[1]= '') &
//			and dw_codestadistico.object.art_codestadistico_g2[1] <> 'N' THEN
//			  campo="descoleccionsol_descripcion"
//			  motivo  = "(Campo Obligatorio) Introduzca la descripción de la colección. "
//			  dato = dw_descripcion_coleccion
//			  numero = 1
//			  falta_campo = True
//			end if
	END IF
	
	IF dw_codestadistico.object.art_codestadistico_g2[1] <> 'N' THEN
		referencia_lab = Trim(String(dw_1.object.referencia_laboratorio[i]))
		modelo_origen = Trim(String(dw_1.object.articulos_modelo_origen[i]))
		if isnull(referencia_lab) or referencia_lab = "" then
			if isnull(modelo_origen) or modelo_origen = "" then
				//NO SE puede dejar en blanco todo
				campo="referencia_laboratorio"
				motivo  = "Cumplimente la referencia del modelo según el modelo sea nuevo o viejo"
				dato = dw_1
				numero = 1
				falta_campo = True
			else
				//Comprobamos la referencia nueva
				//Esta bien porque solo tienen que indicar el modelo y está indicado
			end if
		else
			if isnull(modelo_origen) or modelo_origen = "" then
				//Comprobamos la referencia antigua
				//No es obligatoria la prueba
				/*
				IF IsNull(dw_1.object.version_laboratorio[i]) or Trim(String(dw_1.object.version_laboratorio[i]))="" THEN
					  campo="version_laboratorio"
					  motivo  = "(Campo Obligatorio) Introduzca la Prueba de laboratorio de procedencia del articulo."
					  dato = dw_1
					  numero = 1
					  falta_campo = True
				END IF
				*/
				
//				if dw_1.rowcount() > 0 then
//					if dw_1.object.codigo_pantallas[1] = '' or isnull (dw_1.object.codigo_pantallas[1]) then
//						dw_1.setitem(dw_1.getrow(),"codigo_pantallas",dw_1.object.referencia_laboratorio[1])
//					else
//						messagebox("Aviso", "La imagen del artículo puede ser modificada. Avisa a Laboratorio")
//					end if
//				end if
				
				
			else
				//NO PUEDEN DARSE LAS DOS REFERENCIAS (Antigua y nueva a la vez)
				campo="referencia_laboratorio"
				motivo  = "No puede introducir dos referencias de modelo para un mismo artículo. Cumplimente la correcta según el modelo sea nuevo o viejo"
				dato = dw_1
				numero = 1
				falta_campo = True
			end if
		end if
	END IF
	string ls_familia,ls_marca,ls_submarca,ls_uso
	string ls_familia_descripcion,ls_marca_descripcion,ls_submarca_descripcion,ls_uso_descripcion
	
	ls_familia  = dw_1.object.articulos_familia[i]
	ls_familia_descripcion = f_nombre_familia(codigo_empresa,ls_familia)
	
	if trim(ls_familia) = "" or trim(ls_familia_descripcion) = "" then
		dato = dw_1
		campo="articulos_familia"
		motivo  = "(Campo Obligatorio) Debe introducir la Familia."
		falta_campo = True
	end if
	
	ls_marca    = dw_1.object.articulos_marcas_codigo[i]
	ls_marca_descripcion = f_marcas_descripcion(codigo_empresa,ls_familia,ls_marca) 
	
	if trim(ls_marca) = "" or trim(ls_marca_descripcion) = "" then
		dato = dw_1
		campo="articulos_marcas_codigo"
		motivo  = "(Campo Obligatorio) Debe introducir la Marca."
		falta_campo = True
	end if	
	
	ls_submarca = dw_1.object.articulos_submarcas_codigo[i]
	ls_submarca_descripcion = f_submarcas_descripcion(codigo_empresa,ls_familia,ls_marca,ls_submarca) 
	
	if trim(ls_submarca) = "" or trim(ls_submarca_descripcion) = "" then
		dato = dw_1
		campo="articulos_submarcas_codigo"
		motivo  = "(Campo Obligatorio) Debe introducir la SubMarca."
		falta_campo = True
	end if	
	
	ls_uso      = dw_1.object.uso[i]
	ls_uso_descripcion = f_nombre_almusos(codigo_empresa,ls_uso)
	
	if trim(ls_uso) = "" or trim(ls_uso_descripcion) = "" then
		dato = dw_1
		campo="uso"
		motivo  = "(Campo Obligatorio) Debe introducir el Uso"
		falta_campo = True
	end if	
	
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dato.setfocus()
	  dato.SetColumn(campo)
	  return 1
	END IF
	
	// Creamos la estructura de una base de cliente
	if dw_codestadistico.object.art_codestadistico_g2[j] = 'N' and dw_1.object.uso[i] = '1' then
		
		dw_observacion_version.object.descripcion[dw_observacion_version.getrow()] = 'ÚNICA'
		dw_observacion_version.object.tipo_version[dw_observacion_version.getrow()] = 'P'
		
		dw_codestadistico.object.art_codestadistico_g4[dw_codestadistico.getrow()] =  'SE'
		dw_codestadistico.object.art_codestadistico_ct[dw_codestadistico.getrow()] =  '00'
		dw_codestadistico.object.art_codestadistico_tm[dw_codestadistico.getrow()] =  '00'
		dw_codestadistico.object.art_codestadistico_nc[dw_codestadistico.getrow()] =  '1'
		dw_codestadistico.object.art_codestadistico_av[dw_codestadistico.getrow()] =  '0'
		dw_codestadistico.object.art_codestadistico_pl[dw_codestadistico.getrow()] =  'N'
		dw_codestadistico.object.art_codestadistico_n[dw_codestadistico.getrow()] =  'N'
		dw_codestadistico.object.art_codestadistico_rectificado[dw_codestadistico.getrow()] =  'N'
		dw_codestadistico.object.art_codestadistico_inkcid[dw_codestadistico.getrow()] =  'N'

		dw_1.object.articulos_molde [dw_1.getrow()] = '25'
		
	
		select count(*)
		into :valor
		from art_escandallo 
		where empresa = :codigo_empresa
		and articulo = :sle_valor.text
		and version = '1' 
		and articulo_ant = '0';
		
		if valor = 0 then
			insert into art_escandallo (empresa, articulo, version, articulo_ant )
			values (:codigo_empresa, :sle_valor.text, '1', '0');
			if SQLCA.SQLCode = -1 then
				exito = false
			end if
		end if
	end if
	
END IF

if cb_insertar.enabled then

	dw_1.accepttext()
	fila_actual = dw_1.GetRow()
	dw_1.object.ean13[fila_actual] = f_calcula_ean13(dw_1.object.ean13[fila_actual])
	

	Dec{4} peso_caja,peso_envase,peso_piezas,metros_caja, metros_caja_reales, metrosl_caja,var_piezas,var_peso_pieza,var_largo,var_ancho
	String cod_formato, caja_defecto, pallet_defecto
	
	pallet_defecto = dw_paletizado.object.palarticulo_codigo[k]
	dw_paletizado.object.palarticulo_pordefecto[k] = 'S'
	
	caja_defecto = dw_caja_articulo.object.almartcajas_caja[m]
	var_piezas     = dw_caja_articulo.object.almartcajas_piezascaja[m]
	cod_formato = dw_1.object.formato[1] 
	dw_caja_articulo.accepttext()
	dw_caja_articulo.object.almartcajas_pordefecto[m] = 'S'
	dw_caja_articulo.accepttext()
end if

dw_codestadistico.update()
if SQLCA.SQLCode = -1 then
	exito = false
	texto_error = SQLCA.SQLErrText
end if
dw_caja_articulo.update()
if SQLCA.SQLCode = -1 then
	exito = false
	texto_error = SQLCA.SQLErrText
end if
dw_paletizado.update()
if SQLCA.SQLCode = -1 then
	exito = false
	texto_error = SQLCA.SQLErrText
end if
dw_observacion_version.update()
if SQLCA.SQLCode = -1 then
	exito = false
	texto_error = SQLCA.SQLErrText
end if
dw_calidad_altas.update()
if SQLCA.SQLCode = -1 then
	exito = false
	texto_error = SQLCA.SQLErrText
end if
//dw_descripcion_coleccion.update()
//if SQLCA.SQLCode = -1 then
//	exito = false
//end if
	
if exito then	
	Call super::clicked
	if reg_insertado = true and dw_1.getrow() > 0 then	
		//insertamos la imagen del modelo
		articulo = String(sle_valor.text)
		modelo_origen = Trim(String(dw_1.object.articulos_modelo_origen[dw_1.getrow()]))
		if not isnull(articulo) and articulo <> "" and not isnull(modelo_origen) and modelo_origen <> "" then
			SELECT modelo INTO :modelo_imagen_antiguo FROM articulos_imagen_encajado WHERE empresa = :codigo_empresa AND articulo = :articulo AND produccion = 1;
			if isnull(modelo_imagen_antiguo) or modelo_imagen_antiguo = "" or modelo_imagen_antiguo <> modelo_origen then 
				
				//Borramos la imagen que había como principal
				DELETE FROM articulos_imagen_encajado 
				WHERE empresa = :codigo_empresa 
					AND articulo = :articulo 
					AND produccion = 1 
				using sqlca;
				if sqlca.sqlcode = -1 then
					exito = false
					texto_error = SQLCA.SQLErrText
				end if
			
				//Modelo origen de la imagen
				SELECT ruta, fichero INTO :ruta, :fichero FROM modelo_archivo_expo WHERE empresa = :codigo_empresa AND modelo = :modelo_origen AND produccion = 1;
				
				//Inserción imagen
				if fichero <> "" then
					fecha_modificacion = datetime(today(), now())
					INSERT INTO articulos_imagen_encajado (empresa, articulo, codigo, modelo, pieza, ruta, fichero, produccion, fecha_modificacion) 
					VALUES (:codigo_empresa, :articulo, '1', :modelo_origen, NULL, :ruta, :fichero, 1, :fecha_modificacion)
					using sqlca;
					if sqlca.sqlcode = -1 then
						exito = false
						texto_error = SQLCA.SQLErrText
					end if
					
				end if
			end if
		end if
		
		if not isnull(articulo) and articulo <> "" then
			ftc_imagen_articulo("3", articulo, dw_imagen)
		end if
		
		//Actualizamos la caja por defecto
		UPDATE almartcajas SET pordefecto = 'N' 
		WHERE empresa = :codigo_empresa AND articulo = :articulo AND caja <> :caja_defecto 
		using sqlca;
		if sqlca.sqlcode = -1 then
			exito = false
			texto_error = SQLCA.SQLErrText
		end if
		
		
		//Actualizamos pallet por defecto
		//pallet_defecto
		UPDATE palarticulo SET pordefecto = 'N' 
		WHERE empresa = :codigo_empresa 
			AND articulo = :articulo 
			AND codigo <> :pallet_defecto 
			AND caja <> :caja_defecto
		using sqlca;
		if sqlca.sqlcode = -1 then
			exito = false
			texto_error = SQLCA.SQLErrText			
		end if

		
		delete from uti_colisiones
		where empresa = :codigo_empresa 
		and tabla = "articulos"
		and usuario = :nombre_usuario 
		using sqlca;
		if sqlca.sqlcode = -1 then
			exito = false
			texto_error = SQLCA.SQLErrText
		end if
		
	end if
end if 	

if exito then
	commit using SQLCA;
else
	rollback using SQLCA;
	messagebox ("Error", texto_error)
end if
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_altas_comercial
integer x = 3163
integer y = 148
integer height = 100
end type

event cb_borrar::clicked;string valor
boolean exito

valor = sle_valor.text
//if MessageBox("Aviso", "¿Se Borraran todas las Pantallas Asociadas?", Exclamation!, YesNo!, 2) = 1 then


exito = true

if cb_borrar.enabled then
	delete from art_codestadistico 
	where empresa = :codigo_empresa 
	and codigo = :valor;
	
	if SQLCA.SQLCode <> 0 then
		exito = false
	else
		delete from art_escandallo
		where empresa = :codigo_empresa 
		and articulo = :valor;
		if SQLCA.SQLCode <> 0 then
			exito = false
		else
			delete from almartcajas
			where empresa = :codigo_empresa 
			and articulo = :valor;
			if SQLCA.SQLCode <> 0 then
				exito = false
			else
				delete from palarticulo
				where empresa = :codigo_empresa 
				and articulo = :valor;
				if SQLCA.SQLCode <> 0 then
					exito = false
				else
					delete from art_versiones
					where empresa = :codigo_empresa 
					and articulo = :valor
					and version = '1';
					if SQLCA.SQLCode <> 0 then
						exito = false
					else
						delete from almartcal
						where empresa = :codigo_empresa 
						and articulo = :valor;
						if SQLCA.SQLCode <> 0 then
							exito = false
						else
							delete from art_escandallo
							where empresa = :codigo_empresa 
							and articulo = :valor
							and version = '1';
							if SQLCA.SQLCode <> 0 then
								exito = false
							else
								delete from articulos_imagen_encajado
								where empresa = :codigo_empresa 
								and articulo = :valor;
								if SQLCA.SQLCode <> 0 then
									exito = false
								end if
							end if
						end if
					end if
				end if
			end if
		end if
	end if
	
	if exito then
		CALL Super::clicked
//		commit;
	else
		rollback;
	end if
end if





end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_altas_comercial
integer x = 334
integer y = 172
integer width = 311
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_articulos"
ue_titulo      = "AYUDA SELECCION DE ARTÍCULOS"
ue_filtro      = ""
end event

event sle_valor::busqueda;String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

consulta_busqueda =  "SELECT articulos.codigo, articulos.descripcion, formatos.abreviado, almusos.descripcion, genter.razon "+&
							"FROM articulos "+&
							"INNER JOIN almusos ON articulos.uso = almusos.codigo and articulos.empresa = almusos.empresa "+&
							"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
							"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
							"WHERE articulos.empresa = '"+codigo_empresa+"' AND "+&
							"articulos.fecha_anulado IS NULL AND "+&
							"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
							"ORDER BY articulos.descripcion"


busqueda.consulta = consulta_busqueda
busqueda.titulos[1] = "Código"
busqueda.titulos[2] = "Descripción"
busqueda.titulos[3] = "Formato"
busqueda.titulos[4] = "Uso"
busqueda.titulos[5] = "Cliente"

IF not isnull(this.text) and this.text <> "" THEN
	//busqueda.filtro = this.text
	if Long(this.text) = 0 then
		//Es texto
		busqueda.filtro = this.text
		//busqueda.filtro_es_codigo = false
	else
		//Es código
		//busqueda.filtro_es_codigo = true
	end if
END IF

This.text = ue_valor
OpenWithParm(wt_busquedas, busqueda)
resultado = Message.PowerObjectParm
if resultado.resultado = -1 then
	MessageBox("Error en la creación de la búsqueda",resultado.error)
elseif resultado.resultado > 0 then
	this.text = resultado.valores[1]
	//sle_valor.Text = this.text
	This.TriggerEvent("modificado")
	ue_ante_valor = This.text
	This.SelectText(1,Len(This.Text))
end if

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_altas_comercial
integer x = 3584
integer y = 148
integer height = 100
end type

event cb_salir::clicked;if insercion = "S"  then
	parent.triggerevent(closequery!)
end if

CALL Super::clicked
end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_altas_comercial
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_altas_comercial
integer x = 1152
integer y = 104
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_altas_comercial
integer y = 16
integer width = 4137
end type

type pb_calculadora from u_calculadora within w_mant_altas_comercial
integer x = 658
integer y = 164
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
end type

event clicked;/*
long iteraciones, v_codigo
boolean exito
string v_tabla, v_titulo, v_empresa_mas_tabla
datetime v_fecha

v_tabla = "articulos"
v_titulo = v_tabla
v_fecha = datetime (today())

v_empresa_mas_tabla = codigo_empresa+"-"+v_tabla

connect using sqlca;

delete from uti_bloqueo
where usuario = :nombre_usuario
and tabla = :v_tabla
and titulo = "articulos";

if sqlca.sqlcode= 0 then 
	commit using SQLCA;
else
	rollback using SQLCA;
	messagebox("Error","Error borrando los bloqueos del usuario actual",StopSign!)
end if
// Fin de borrar bloqueos del usuario actual

select max (convert(integer, codigo))
into :v_codigo
from articulos 
where empresa = :codigo_empresa;

v_codigo ++


DO WHILE iteraciones < 10 and not exito
	INSERT INTO uti_bloqueo (tabla, codigo, titulo, fecha, usuario)
					VALUES (:v_empresa_mas_tabla, :v_codigo, :v_titulo, :v_fecha, :nombre_usuario);
	if sqlca.sqlcode= 0 then 
		commit;
		exito = true
	else
		rollback;
		iteraciones ++
		v_codigo ++
	end if
LOOP


if iteraciones >= 10 then
	messagebox("ERROR", "No se puede asignar un código.")
else
	sle_valor.text=string(v_codigo)
	dw_1.triggerEvent("clicked")
end if

*/

Long codigo
codigo = f_colisiones2(codigo_empresa, "articulos", "codigo", "",false)

if codigo = 0  then
	messagebox("ERROR", "No se puede asignar un código.")
else
	sle_valor.text=String(codigo)
	dw_1.triggerEvent("clicked")
end if

end event

type pb_1 from upb_imprimir within w_mant_altas_comercial
integer x = 4055
integer y = 152
integer taborder = 0
boolean bringtotop = true
end type

event clicked;long   indice,total,i
tipo_array val, ent

//openWithParm(w_pedir_version,ent)
//val =  message.powerObjectparm
//IF val.valor[1] = "RETURN" Then 
//	Return
//end if

dw_listado.SetTransObject(SQLCA)
//dw_listado.retrieve(codigo_empresa, val.valor[1],val.valor[2])
//dw_listado.retrieve(codigo_empresa, 1,1)


f_imprimir_ficha_tecnica_ot(dw_listado,sle_valor.text,'1','1', 0)
f_imprimir_datawindow(dw_listado)





end event

type dw_listado from datawindow within w_mant_altas_comercial
boolean visible = false
integer x = 2592
integer y = 1996
integer width = 581
integer height = 348
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_50 from statictext within w_mant_altas_comercial
integer x = 46
integer y = 2472
integer width = 1495
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217729
boolean enabled = false
string text = "Escandallo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_escandallo from u_datawindow within w_mant_altas_comercial
integer x = 46
integer y = 2560
integer width = 1495
integer height = 844
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_escandallo"
boolean vscrollbar = true
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_tipooperacion"
			lstr_param.s_argumentos[1]  = "w_mant_art_ver_tipooperacion"
			lstr_param.i_nargumentos    = 2
			OpenWithParm(w_mant_art_ver_tipooperacion, lstr_param)
	END CHOOSE
end if

If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF



end event

event itemchanged;string v_Articulo

IF dwo.Name = "art_escandallo_articulo_ant" THEN
	select descripcion
	into :v_Articulo
	from articulos
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_escandallo.object.articulos_descripcion[row] = v_articulo

END IF  
end event

event rbuttondown;
bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "art_escandallo_articulo_ant"
		bus_titulo     = "AYUDA SELECCION ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
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
	CASE "art_escandallo_articulo_ant"
		bus_titulo     = "AYUDA SELECCION ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type dw_caja_articulo from u_datawindow within w_mant_altas_comercial
integer x = 2578
integer y = 760
integer width = 1595
integer height = 180
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_caja_articulo"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if




end event

event itemchanged;
IF dwo.Name = "almartcajas_caja" THEN
	dw_caja_Articulo.object.almcajas_descripcion[row] = f_nombre_caja ( codigo_empresa, data)
END IF  
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "almartcajas_caja"
		bus_titulo     = "AYUDA SELECCION CAJAS"
		bus_datawindow = "dw_ayuda_cajas"
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
	CASE "almartcajas_caja"
		bus_titulo     = "AYUDA SELECCION CAJAS"
		bus_datawindow = "dw_ayuda_cajas"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_paletizado from u_datawindow within w_mant_altas_comercial
integer x = 2578
integer y = 968
integer width = 1595
integer height = 716
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_paletizado"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if

end event

event itemchanged;string v_Articulo

IF dwo.Name = "palarticulo_codigo" THEN
	dw_paletizado.object.pallets_descripcion[row] = f_nombre_pallet(codigo_empresa, data)

END IF  
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "palarticulo_codigo"
		bus_titulo     = "AYUDA SELECCION pallets"
		bus_datawindow = "dw_ayuda_pallets"
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
	CASE "palarticulo_codigo"
		bus_titulo     = "AYUDA SELECCION pallets"
		bus_datawindow = "dw_ayuda_pallets"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_calidad_altas from u_datawindow within w_mant_altas_comercial
boolean visible = false
integer x = 384
integer y = 1920
integer width = 1929
integer height = 396
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_calidad_altas"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if




end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type cb_duplicar from commandbutton within w_mant_altas_comercial
integer x = 1509
integer y = 156
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Duplicar"
end type

event clicked;string descripcion, formato, cliente, uso, referencia_laboratorio, tono, calibre, g1, g2, g3, en, pt
string caja, pallet
dec {6} piezascaja, cajaspallet, planospallet, alturas, version_laboratorio, articulos_ancho, articulos_largo, ancho_std, largo_std
long fila
string formato_etiqueta


descripcion = "NUEVO"
formato = dw_1.object.formato[dw_1.getrow()]
formato_etiqueta = dw_1.object.articulos_formato_etiqueta[dw_1.getrow()]
cliente = dw_1.object.cliente[dw_1.getrow()]
uso = dw_1.object.uso[dw_1.getrow()]
tono = dw_1.object.tono[dw_1.getrow()]
calibre = dw_1.object.calibre[dw_1.getrow()]
articulos_ancho = dw_1.object.articulos_ancho[dw_1.getrow()]
articulos_largo = dw_1.object.articulos_largo[dw_1.getrow()]

ancho_std = dw_1.object.articulos_ancho_std[dw_1.getrow()]
largo_std = dw_1.object.articulos_largo_std[dw_1.getrow()]

g1 = dw_codestadistico.object.art_codestadistico_g1[dw_codestadistico.getrow()]
g2 = dw_codestadistico.object.art_codestadistico_g2[dw_codestadistico.getrow()]
g3 = dw_codestadistico.object.art_codestadistico_g3[dw_codestadistico.getrow()]
en = dw_codestadistico.object.art_codestadistico_en[dw_codestadistico.getrow()]
pt = dw_codestadistico.object.art_codestadistico_pt[dw_codestadistico.getrow()]

caja = dw_caja_articulo.object.almartcajas_caja[dw_caja_articulo.getrow()]
piezascaja = dw_caja_articulo.object.almartcajas_piezascaja[dw_caja_articulo.getrow()]
dw_caja_Articulo.accepttext()
dw_caja_Articulo.object.almcajas_descripcion[dw_caja_articulo.getrow()] = f_nombre_caja ( codigo_empresa, caja)

pallet = dw_paletizado.object.palarticulo_codigo[dw_paletizado.getrow()]
cajaspallet = dw_paletizado.object.palarticulo_cajaspallet[dw_paletizado.getrow()]
planospallet = dw_paletizado.object.palarticulo_planospallet[dw_paletizado.getrow()]
alturas = dw_paletizado.object.palarticulo_alturas[dw_paletizado.getrow()]
dw_paletizado.accepttext()
dw_paletizado.object.pallets_descripcion[dw_paletizado.getrow()] = f_nombre_pallet(codigo_empresa, pallet)

pb_calculadora.TriggerEvent(clicked!)

dw_1.object.articulos_formato_etiqueta[dw_1.getrow()] = formato_etiqueta
dw_1.object.articulos_ancho_std[dw_1.getrow()] = ancho_std
dw_1.object.articulos_largo_std[dw_1.getrow()] = largo_std


dw_1.object.descripcion[dw_1.getrow()] = descripcion 
dw_1.object.formato[dw_1.getrow()] = formato
dw_1.object.cliente[dw_1.getrow()] = cliente
dw_1.object.uso[dw_1.getrow()] = uso
dw_1.object.tono[dw_1.getrow()] = tono
dw_1.object.calibre[dw_1.getrow()] = calibre
dw_1.accepttext()
dw_1.object.formatos_abreviado[dw_1.getrow()] = f_nombre_formato(codigo_empresa, formato)
dw_1.object.almusos_descripcion[dw_1.getrow()] = f_nombre_almusos(codigo_empresa, uso)
dw_1.object.genter_razon[dw_1.getrow()] = f_nombre_cliente(codigo_empresa, 'C',cliente)
dw_1.object.articulos_ancho[dw_1.getrow()] = articulos_ancho
dw_1.object.articulos_largo[dw_1.getrow()] = articulos_largo

dw_codestadistico.object.art_codestadistico_g1[dw_codestadistico.getrow()] = g1
dw_codestadistico.object.art_codestadistico_g2[dw_codestadistico.getrow()] = g2
dw_codestadistico.object.art_codestadistico_g3[dw_codestadistico.getrow()] = g3
dw_codestadistico.object.art_codestadistico_en[dw_codestadistico.getrow()] = en
dw_codestadistico.object.art_codestadistico_pt[dw_codestadistico.getrow()] = pt
dw_codestadistico.accepttext()
dw_codestadistico.object.art_grupo1_descripcion[dw_codestadistico.getrow()] = f_nombre_grupo1(codigo_empresa, g1)
dw_codestadistico.object.art_grupo2_descripcion[dw_codestadistico.getrow()] = f_nombre_grupo2(codigo_empresa, g2)
dw_codestadistico.object.art_grupo3_descripcion[dw_codestadistico.getrow()] = f_nombre_grupo3(codigo_empresa, g3)
dw_codestadistico.object.art_encajado_descripcion[dw_codestadistico.getrow()] = f_nombre_encajado(codigo_empresa, en)

dw_caja_articulo.object.almartcajas_caja[dw_caja_articulo.getrow()] = caja
dw_caja_articulo.object.almartcajas_piezascaja[dw_caja_articulo.getrow()] = piezascaja
dw_caja_Articulo.accepttext()
dw_caja_Articulo.object.almcajas_descripcion[dw_caja_articulo.getrow()] = f_nombre_caja ( codigo_empresa, caja)

dw_paletizado.object.palarticulo_codigo[dw_paletizado.getrow()] = pallet
dw_paletizado.object.palarticulo_caja[dw_paletizado.getrow()] = caja
dw_paletizado.object.palarticulo_cajaspallet[dw_paletizado.getrow()] = cajaspallet
dw_paletizado.object.palarticulo_planospallet[dw_paletizado.getrow()] = planospallet
dw_paletizado.object.palarticulo_alturas[dw_paletizado.getrow()] = alturas
dw_paletizado.accepttext()
dw_paletizado.object.pallets_descripcion[dw_paletizado.getrow()] = f_nombre_pallet(codigo_empresa, pallet)


end event

type pb_desbloquear from picturebutton within w_mant_altas_comercial
boolean visible = false
integer x = 2167
integer y = 156
integer width = 110
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Custom016!"
alignment htextalign = left!
end type

event clicked;//w_mant_altas_laboratorio 


if dw_1.object.articulos_bloqueado[dw_1.getrow()] = 'S' then
	dw_1.setitem(dw_1.getrow(),"articulos_bloqueado",'N')
	if sle_valor.text <> '' then
		update articulos
		set bloqueado = 'N'
		where empresa = :codigo_empresa
		and codigo = :sle_valor.text using sqlca;
		
		commit using SQLCA;
	end if
else
	dw_1.setitem(dw_1.getrow(),"articulos_bloqueado",'S')
	if sle_valor.text <> '' then
		update articulos
		set bloqueado = 'S'
		where empresa = :codigo_empresa
		and codigo = :sle_valor.text using sqlca;
		
		commit using SQLCA;
	end if

end if
	

//parent.triggerevent("ue_recuperar")
end event

type dw_observacion_version from u_datawindow within w_mant_altas_comercial
integer x = 2578
integer y = 1744
integer width = 1605
integer height = 572
integer taborder = 90
string dataobject = "dw_observacion_version"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if




end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_imagenes_modelo from datawindow within w_mant_altas_comercial
boolean visible = false
integer x = 2437
integer y = 1496
integer width = 1129
integer height = 1476
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_imagenes_modelos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;if dwo.name = "b_cerrar" then
	this.visible = false
end if
end event

event clicked;String codigo

if row > 0 then
	codigo = this.object.codigo[row]
	dw_1.object.articulos_imagen_origen[dw_1.getrow()] = codigo
	this.visible = false
end if
end event

type dw_imagen from u_dw_imagen within w_mant_altas_comercial
integer x = 1573
integer y = 2572
integer width = 2592
integer height = 804
integer taborder = 110
end type

type dw_codestadistico from u_datawindow within w_mant_altas_comercial
integer x = 2578
integer y = 280
integer width = 1595
integer height = 448
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_codestadistico_alta_comercial"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_tipooperacion"
			lstr_param.s_argumentos[1]  = "w_mant_art_ver_tipooperacion"
			lstr_param.i_nargumentos    = 2
			OpenWithParm(w_mant_art_ver_tipooperacion, lstr_param)
	END CHOOSE
end if

If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF



end event

event itemchanged;
IF dwo.Name = "art_codestadistico_g1" THEN
	dw_codestadistico.object.art_grupo1_descripcion[row] = f_nombre_grupo1(codigo_empresa, data)
END IF
IF dwo.Name = "art_codestadistico_g2" THEN
	dw_codestadistico.object.art_grupo2_descripcion[row] = f_nombre_grupo2(codigo_empresa, data)
END IF
IF dwo.Name = "art_codestadistico_g3" THEN
	dw_codestadistico.object.art_grupo3_descripcion[row] = f_nombre_grupo3(codigo_empresa, data)
END IF
IF dwo.Name = "art_codestadistico_en" THEN
	dw_codestadistico.object.art_encajado_descripcion[row] = f_nombre_encajado(codigo_empresa, data)
END IF

end event

event rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "art_codestadistico_g1"
	bus_titulo     = "AYUDA SELECCION DE G1"
	bus_datawindow = "dw_ayuda_art_grupo1_abr"
	bus_filtro     = ""
CASE "art_codestadistico_g2"
	bus_titulo     = "AYUDA SELECCION DE G2"
	bus_datawindow = "dw_ayuda_art_grupo2_abr"
	bus_filtro     = ""
CASE "art_codestadistico_g3"
	bus_titulo     = "AYUDA SELECCION DE G3"
	bus_datawindow = "dw_ayuda_art_grupo3_abr"
	bus_filtro     = ""
CASE "art_codestadistico_en"
	bus_titulo     = "AYUDA SELECCION DE G4"
	bus_datawindow = "dw_ayuda_art_encajado_abr"
	bus_filtro     = ""

CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "art_codestadistico_g1"
	bus_titulo     = "AYUDA SELECCION DE G1"
	bus_datawindow = "dw_ayuda_art_grupo1_abr"
	bus_filtro     = ""
CASE "art_codestadistico_g2"
	bus_titulo     = "AYUDA SELECCION DE G2"
	bus_datawindow = "dw_ayuda_art_grupo2_abr"
	bus_filtro     = ""
CASE "art_codestadistico_g3"
	bus_titulo     = "AYUDA SELECCION DE G3"
	bus_datawindow = "dw_ayuda_art_grupo3_abr"
	bus_filtro     = ""
CASE "art_codestadistico_en"
	bus_titulo     = "AYUDA SELECCION DE G4"
	bus_datawindow = "dw_ayuda_art_encajado_abr"
	bus_filtro     = ""

CASE ELSE
	SetNull(bus_campo)
END CHOOSE

CALL Super::Key
end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

