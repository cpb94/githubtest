﻿$PBExportHeader$wtc_mant_etiquetas.srw
forward
global type wtc_mant_etiquetas from wt_ventana_padre
end type
type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_etiquetas
end type
type pb_anyade_trabajo from picturebutton within wtc_mant_etiquetas
end type
end forward

global type wtc_mant_etiquetas from wt_ventana_padre
integer width = 4507
integer height = 1504
string title = "Mantenimiento de Etiquetas"
dw_con_piezas_coleccion dw_con_piezas_coleccion
pb_anyade_trabajo pb_anyade_trabajo
end type
global wtc_mant_etiquetas wtc_mant_etiquetas

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo, ruta_mostrada
boolean falta_Campo
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "almetiquetas"
param_colisiones.campo = "codigo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = true

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
	end if
	if IsNull(dw_1.object.ruta[dw_1.getrow()]) or Trim(String(dw_1.object.ruta[dw_1.getrow()])) = "" then
		  campo = "ruta"
		  motivo = "Campo Obligatorio: Ruta. "
		  falta_campo = True
	end if
	SELECT ruta_etiquetas INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa;
	if not fileexists(ruta_mostrada + String(dw_1.object.ruta[dw_1.getrow()])) then
		  campo = "ruta"
		  motivo = "La ruta no coincide con ninguna etiqueta. "
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
dw_1.settransobject(sqlca)

return rtn
end function

on wtc_mant_etiquetas.create
int iCurrent
call super::create
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.pb_anyade_trabajo=create pb_anyade_trabajo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_piezas_coleccion
this.Control[iCurrent+2]=this.pb_anyade_trabajo
end on

on wtc_mant_etiquetas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_con_piezas_coleccion)
destroy(this.pb_anyade_trabajo)
end on

event activate;call super::activate;wtc_mant_etiquetas = ventanas_activas[id_ventana_activa].ventana
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_etiquetas
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_etiquetas
integer x = 3950
integer y = 40
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_etiquetas
integer y = 304
integer width = 4443
integer height = 1004
string dataobject = "dwtc_mant_etiquetas"
boolean border = false
end type

event dw_1::clicked;call super::clicked;String ruta_mostrada
String ruta_seleccionada, fichero
Long resultado

SELECT ruta_etiquetas INTO :ruta_mostrada FROM empresas WHERE empresa = :codigo_empresa;

if row > 0 then
	if dwo.name = "b_examinar" then
		if GetFileOpenName ("Ruta de la etiqueta ", ruta_seleccionada, fichero, "lpa", "Fichero de etiqueta, *.lpa", ruta_mostrada, 2) = 1 then
			if pos(upper(ruta_seleccionada), upper(ruta_mostrada)) > 0 then
				this.object.ruta[this.getrow()] = f_reemplazar(upper(ruta_seleccionada), upper(ruta_mostrada), '')
			else
				MessageBox("Error", "Las etiquetas deben estar en "+ruta_mostrada)
			end if
		end if
	end if	
end if
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_etiquetas
integer x = 3995
integer y = 156
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_etiquetas
integer x = 4306
integer y = 156
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_etiquetas
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_etiquetas
integer width = 3090
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_etiquetas
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
end if
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_etiquetas
integer x = 4151
integer y = 156
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_etiquetas
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT almetiquetas.codigo, almetiquetas.codigo, almetiquetas.descripcion "+&	
									" FROM almetiquetas "+&
									" WHERE almetiquetas.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, almetiquetas.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	

	case "descripcion"
		padre_busqueda.consulta =  " SELECT almetiquetas.codigo, almetiquetas.descripcion "+&	
									" FROM almetiquetas "+&
									" WHERE almetiquetas.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY almetiquetas.descripcion desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"		
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT almetiquetas.codigo, almetiquetas.codigo, almetiquetas.descripcion "+&	
									" FROM almetiquetas "+&
									" WHERE almetiquetas.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, almetiquetas.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
end choose


call super :: clicked


end event

type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_etiquetas
integer x = 4293
integer y = 2360
integer width = 1280
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

type pb_anyade_trabajo from picturebutton within wtc_mant_etiquetas
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

