$PBExportHeader$wtc_mant_tipoaplicacion.srw
forward
global type wtc_mant_tipoaplicacion from wt_ventana_padre
end type
type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_tipoaplicacion
end type
type pb_anyade_trabajo from picturebutton within wtc_mant_tipoaplicacion
end type
end forward

global type wtc_mant_tipoaplicacion from wt_ventana_padre
integer height = 900
string title = "Mantenimiento de Tipos de Aplicaciones"
dw_con_piezas_coleccion dw_con_piezas_coleccion
pb_anyade_trabajo pb_anyade_trabajo
end type
global wtc_mant_tipoaplicacion wtc_mant_tipoaplicacion

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
param_colisiones.tabla = "tipoaplicacion"
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
	if IsNull(dw_1.object.abreviado[dw_1.getrow()]) or Trim(String(dw_1.object.abreviado[dw_1.getrow()])) = "" then
		  campo = "abreviado"
		  motivo = "Campo Obligatorio: Abreviado. "
		  falta_campo = True
	elseif IsNull(dw_1.object.descripcion[dw_1.getrow()]) or Trim(String(dw_1.object.descripcion[dw_1.getrow()])) = "" then
		  campo = "descripcion"
		  motivo = "Campo Obligatorio: Descripcion. "
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

dw_1.settransobject(sqlca)

estado = 1 // Modo edición

return rtn
end function

public function integer f_borrar ();str_ventana_alerta parametros
string botones[2]

rtn = 1 //Todo ok
	
DELETE FROM tipooperacion_tipoaplicacion WHERE tipoaplicacion = :padre_codigo USING trans_ts;

IF trans_ts.SQLCode <> 0 THEN         
	MessageBox("SQL error", trans_ts.SQLErrText)
	rtn = -1
END IF
	
if rtn = 1 then
	
	DELETE FROM maquina_tipoaplicacion WHERE tipoaplicacion = :padre_codigo USING trans_ts;
	
	IF trans_ts.SQLCode <> 0 THEN         
		MessageBox("SQL error", trans_ts.SQLErrText)
		rtn = -1
	END IF
	
end if

if rtn = 1 then
	super::f_borrar()	
else
	MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
	ROLLBACK USING trans_ts;

	dw_1.object.#1[1] = padre_codigo
	pb_cancelar.triggerevent(Clicked!)

end if

return rtn
end function

on wtc_mant_tipoaplicacion.create
int iCurrent
call super::create
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.pb_anyade_trabajo=create pb_anyade_trabajo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_piezas_coleccion
this.Control[iCurrent+2]=this.pb_anyade_trabajo
end on

on wtc_mant_tipoaplicacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_con_piezas_coleccion)
destroy(this.pb_anyade_trabajo)
end on

event activate;call super::activate;wtc_mant_tipoaplicacion = ventanas_activas[id_ventana_activa].ventana
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_tipoaplicacion
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_tipoaplicacion
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_tipoaplicacion
integer y = 304
integer height = 376
string dataobject = "dwtc_tipoaplicacion"
boolean border = false
end type

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_tipoaplicacion
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_tipoaplicacion
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_tipoaplicacion
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_tipoaplicacion
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_tipoaplicacion
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
end if
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_tipoaplicacion
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_tipoaplicacion
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT tipoaplicacion.codigo, tipoaplicacion.codigo, tipoaplicacion.abreviado, tipoaplicacion.descripcion "+&	
									" FROM tipoaplicacion "+&
									" WHERE tipoaplicacion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, tipoaplicacion.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Abreviado"	
		padre_busqueda.titulos[4] = "Descripción"	

	case "abreviado"
		padre_busqueda.consulta =  " SELECT tipoaplicacion.codigo, tipoaplicacion.abreviado, tipoaplicacion.descripcion "+&	
									" FROM tipoaplicacion "+&
									" WHERE tipoaplicacion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY tipoaplicacion.abreviado desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Abreviado"	
		padre_busqueda.titulos[3] = "Descripción"	
	case "descripcion"
		padre_busqueda.consulta =  " SELECT tipoaplicacion.codigo, tipoaplicacion.descripcion, tipoaplicacion.abreviado "+&	
									" FROM tipoaplicacion "+&
									" WHERE tipoaplicacion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY tipoaplicacion.descripcion desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Abreviado"	
		padre_busqueda.titulos[3] = "Descripción"		
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT tipoaplicacion.codigo, tipoaplicacion.codigo, tipoaplicacion.abreviado, tipoaplicacion.descripcion "+&	
									" FROM tipoaplicacion "+&
									" WHERE tipoaplicacion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, tipoaplicacion.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Abreviado"	
		padre_busqueda.titulos[4] = "Descripción"	
end choose


call super :: clicked


end event

type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_tipoaplicacion
integer x = 4293
integer y = 2360
integer width = 1280
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

type pb_anyade_trabajo from picturebutton within wtc_mant_tipoaplicacion
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

