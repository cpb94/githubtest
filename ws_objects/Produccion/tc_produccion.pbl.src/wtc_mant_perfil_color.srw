$PBExportHeader$wtc_mant_perfil_color.srw
forward
global type wtc_mant_perfil_color from wt_ventana_padre
end type
type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_perfil_color
end type
type pb_anyade_trabajo from picturebutton within wtc_mant_perfil_color
end type
end forward

global type wtc_mant_perfil_color from wt_ventana_padre
integer width = 2944
integer height = 1468
string title = "Mantenimiento de Perfiles de Color"
dw_con_piezas_coleccion dw_con_piezas_coleccion
pb_anyade_trabajo pb_anyade_trabajo
end type
global wtc_mant_perfil_color wtc_mant_perfil_color

forward prototypes
public function integer f_guardar ()
public function integer f_borrar ()
end prototypes

public function integer f_guardar ();//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "perfil_color"
param_colisiones.campo = "codigo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = false

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_1 

dw_1.accepttext()
falta_campo = false
if dw_1.rowcount() > 0 then
	if IsNull(dw_1.object.descripcion[dw_1.getrow()]) or Trim(String(dw_1.object.descripcion[dw_1.getrow()])) = "" then
		  campo = "descripcion"
		  motivo = "Campo Obligatorio: Descripcion. "
		  falta_campo = True
	elseif IsNull(dw_1.object.esmalte[dw_1.getrow()]) or Trim(String(dw_1.object.esmalte[dw_1.getrow()])) = "" then
		  campo = "esmalte"
		  motivo = "Campo Obligatorio: Esmalte. "
		  falta_campo = True
	elseif IsNull(dw_1.object.pasta[dw_1.getrow()]) or Trim(String(dw_1.object.pasta[dw_1.getrow()])) = "" then
		  campo = "pasta"
		  motivo = "Campo Obligatorio: Pasta. "
		  falta_campo = TruE
	elseif IsNull(dw_1.object.fecha[dw_1.getrow()]) or Trim(String(dw_1.object.fecha[dw_1.getrow()])) = "" then
		  campo = "fecha"
		  motivo = "Campo Obligatorio: Fecha. "
		  falta_campo = True
	elseif IsNull(dw_1.object.perfil_color_resolucion[dw_1.getrow()]) or Trim(String(dw_1.object.perfil_color_resolucion[dw_1.getrow()])) = "" then
		  campo = "perfil_color_resolucion"
		  motivo = "Campo Obligatorio: Resolución. "
		  falta_campo = True
	end if
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

rtn = super::f_guardar()

IF rtn = 1 THEN
	COMMIT USING trans_ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_ts;
END IF

estado = 1 // Modo edición
dw_1.settransobject (SQLCA)

return rtn
end function

public function integer f_borrar ();Long usado

rtn = 1 //Todo ok

	
padre_codigo = dw_1.object.#1[dw_1.GetRow()]


SELECT isnull(COUNT(*), 0) INTO :usado FROM prodlineas_perfil_color WHERE empresa = :codigo_empresa AND perfil_color = :padre_codigo USING trans_Ts;

if usado > 0 then
	MessageBox("Atención","Existen máquinas de producción que utilizan este perfil. Elimine el perfil de las máquinas primero.")
	rtn = -1
end if
	

if rtn = 1 then
	rtn =  super::f_borrar()	
else
	MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
	ROLLBACK USING trans_Ts;

	dw_1.object.#1[1] = padre_codigo
	pb_cancelar.triggerevent(Clicked!)

end if
	
return rtn
end function

on wtc_mant_perfil_color.create
int iCurrent
call super::create
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.pb_anyade_trabajo=create pb_anyade_trabajo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_piezas_coleccion
this.Control[iCurrent+2]=this.pb_anyade_trabajo
end on

on wtc_mant_perfil_color.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_con_piezas_coleccion)
destroy(this.pb_anyade_trabajo)
end on

event activate;call super::activate;wtc_mant_perfil_color = ventanas_activas[id_ventana_activa].ventana
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_perfil_color
boolean visible = false
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_perfil_color
integer x = 2386
integer y = 4
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_perfil_color
integer y = 276
integer width = 2866
integer height = 976
string dataobject = "dwtc_perfil_color"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "base"
		SELECT descripcion 
		INTO :resultado 
		FROM articulos
		WHERE empresa = :codigo_empresa
		and codigo = :data and uso = '1';

		if SQLCA.sqlcode <> 100 then
			this.object.articulos_base_descripcion[Row] 	= resultado
		else
			dwo.Primary[row] = ''
			this.object.articulos_base_descripcion[Row] 	= ''
			return 2			
		end if
		
	CASE "esmalte"
		SELECT descripcion_laboratorio 
		INTO :resultado
		FROM prodformula
		WHERE empresa = :codigo_empresa
		and formula = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.prodformula_esmalte_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.prodformula_esmalte_descripcion[Row] 		= ''
			return 2			
		end if
		
	CASE "interfaz"
		SELECT descripcion_laboratorio 
		INTO :resultado
		FROM prodformula
		WHERE empresa = :codigo_empresa
		and formula = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.prodformula_interfaz_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.prodformula_interfaz_descripcion[Row] 		= ''
			return 2			
		end if
		
	CASE "perfil_color_nuevo_perfil"
		SELECT descripcion 
		INTO :resultado 
		FROM perfil_color
		WHERE empresa = :codigo_empresa
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.perfil_color_descripcion[Row] 	= resultado
		else
			dwo.Primary[row] = ''
			this.object.perfil_color_descripcion[Row] 	= ''
			return 2			
		end if
END CHOOSE
end event

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "base"
			busqueda.titulo_ventana = "Búsqueda de Bases"
			busqueda.consulta =  "SELECT articulos.codigo, articulos.descripcion, formatos.abreviado, genter.razon "+&
							"FROM articulos "+&
							"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
							"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
							"WHERE articulos.empresa = '"+codigo_empresa+"' AND articulos.uso = '1' AND "+&
							"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
							"ORDER BY articulos.descripcion"
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Formato"
			busqueda.titulos[4] = "Cliente"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.base[dw_1.GetRow()] 	= resultado.valores[1]		// Devuelve el valor que encuentra ...
				dw_1.object.articulos_base_descripcion[dw_1.GetRow()] 	= resultado.valores[2]	
			end if
		CASE "esmalte"
			busqueda.titulo_ventana = "Búsqueda de Formulas para Esmalte"
			busqueda.consulta =  "SELECT prodformula.formula, prodformula.descripcion_laboratorio, prodformula.descripcion_produccion "+&
												"FROM prodformula "+&
												"WHERE prodformula.empresa = '"+codigo_empresa+"'"+&
												"ORDER BY prodformula.descripcion_laboratorio ASC"
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Desc. Laboratorio"
			busqueda.titulos[3] = "Desc. Producción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.esmalte[dw_1.GetRow()] 									= resultado.valores[1]		// Devuelve el valor que encuentra ...
				dw_1.object.prodformula_esmalte_descripcion[dw_1.GetRow()] 	= resultado.valores[2]	
			end if	
		CASE "interfaz"
			busqueda.titulo_ventana = "Búsqueda de Formulas para Esmalte"
			busqueda.consulta =  "SELECT prodformula.formula, prodformula.descripcion_laboratorio, prodformula.descripcion_produccion "+&
												"FROM prodformula "+&
												"WHERE prodformula.empresa = '"+codigo_empresa+"'"+&
												"ORDER BY prodformula.descripcion_laboratorio ASC"
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Desc. Laboratorio"
			busqueda.titulos[3] = "Desc. Producción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.interfaz[dw_1.GetRow()] 									= resultado.valores[1]		// Devuelve el valor que encuentra ...
				dw_1.object.prodformula_interfaz_descripcion[dw_1.GetRow()] 	= resultado.valores[2]	
			end if	
		CASE "perfil_color_nuevo_perfil"
			busqueda.titulo_ventana = "Búsqueda de Perfiles de color"
			busqueda.consulta =  "SELECT codigo, descripcion "+&
												"FROM perfil_color "+&
												"WHERE empresa = '"+codigo_empresa+"' AND codigo <> '"+f_codigo_principal()+"'"+&
												"ORDER BY descripcion ASC"
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.perfil_color_nuevo_perfil[dw_1.GetRow()] 	= resultado.valores[1]		// Devuelve el valor que encuentra ...
				dw_1.object.perfil_color_descripcion[dw_1.GetRow()] 	= resultado.valores[2]	
			end if
	END CHOOSE
end if	
	

end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_perfil_color
integer x = 2432
integer y = 120
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_perfil_color
integer x = 2743
integer y = 120
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_perfil_color
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_perfil_color
integer width = 2176
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_perfil_color
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
end if
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_perfil_color
integer x = 2587
integer y = 120
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_perfil_color
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT perfil_color.codigo, perfil_color.codigo, perfil_color.descripcion "+&	
									" FROM perfil_color "+&
									" WHERE perfil_color.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, perfil_color.codigo) asc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	

	case "descripcion"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT perfil_color.codigo, perfil_color.descripcion "+&	
									" FROM perfil_color "+&
									" WHERE perfil_color.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY perfil_color.descripcion asc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"		
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT perfil_color.codigo, perfil_color.codigo, perfil_color.descripcion "+&	
									" FROM perfil_color "+&
									" WHERE perfil_color.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, perfil_color.codigo) asc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"		
end choose


call super :: clicked


end event

type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_perfil_color
integer x = 4293
integer y = 2360
integer width = 1280
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

type pb_anyade_trabajo from picturebutton within wtc_mant_perfil_color
integer x = 5189
integer y = 2208
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
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;//long fila_actual, nuevaprueba, indice, maximo_valor_dw
//string modelo_actual
//
//nuevaprueba = 0
//modelo_actual =  padre_codigo
//
//select max(trabajo)
//into :nuevaprueba
//from destrabajo2
//where empresa = :codigo_empresa
//and modelo = :modelo_actual;
//
//maximo_valor_dw = long(dwtc_mant_trabajos_disenyo.Describe("Evaluate('Max(destrabajo2_trabajo)', 0)"))
//
//if isnull(nuevaprueba) then nuevaprueba = 0
//if isnull(maximo_valor_dw) then maximo_valor_dw = 0
//
//if nuevaprueba > maximo_valor_dw then
//	nuevaprueba ++
//else
//	nuevaprueba = maximo_valor_dw +1
//end if
//
//fila_actual = dwtc_mant_trabajos_disenyo.InsertRow(0)
//
//dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
//
//dwtc_mant_trabajos_disenyo.scrolltorow(fila_actual)
//dwtc_mant_trabajos_disenyo.SetColumn(3)
//dwtc_mant_trabajos_disenyo.Setfocus()
//dwtc_mant_trabajos_disenyo.object.destrabajo2_empresa[fila_actual] = codigo_empresa
////	dwtc_mant_trabajos_disenyo.object.destrabajo2_modelo[fila_actual] = modelo_actual
//dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
//dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[fila_actual] = 'N'
//dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_solicitud[fila_actual] = datetime(today())
//dwtc_mant_trabajos_disenyo.object.destrabajo2_laboratorio[fila_actual] = 'N'
//dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid[fila_actual] = 'N'
//dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis[fila_actual] = ''
//
end event

