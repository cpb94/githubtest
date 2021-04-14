$PBExportHeader$wtc_mant_colecciones_ccc.srw
forward
global type wtc_mant_colecciones_ccc from wt_ventana_padre
end type
end forward

global type wtc_mant_colecciones_ccc from wt_ventana_padre
integer width = 2400
integer height = 880
string title = "Mantenimiento de Colecciones CCC"
end type
global wtc_mant_colecciones_ccc wtc_mant_colecciones_ccc

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//LLAMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado
string total_regs


rtn = 1
resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "colecciones_ccc"
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
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

rtn = super::f_guardar()

IF rtn = 1 THEN
	COMMIT USING trans_TS;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_TS;
	messagebox("Error", "Se ha Producido un errror grabando la coleccion_ccc.",StopSign!)
END IF
estado = 1 // Modo edición

dw_1.Settransobject(sqlca)

return rtn
end function

on wtc_mant_colecciones_ccc.create
call super::create
end on

on wtc_mant_colecciones_ccc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_colecciones_ccc
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_colecciones_ccc
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_colecciones_ccc
integer x = 18
integer y = 300
integer width = 2267
integer height = 288
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_colecciones_ccc"
boolean border = false
end type

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_colecciones_ccc
integer x = 1819
integer y = 144
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_colecciones_ccc
integer x = 2130
integer y = 144
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_colecciones_ccc
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_colecciones_ccc
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_colecciones_ccc
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_colecciones_ccc
integer x = 1975
integer y = 144
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_colecciones_ccc
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT colecciones_ccc.codigo, colecciones_ccc.codigo, colecciones_ccc.descripcion "+&
											" FROM colecciones_ccc "+&
											" WHERE colecciones.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, colecciones.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
	
	case "descripcion"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT colecciones_ccc.codigo, colecciones_ccc.descripcion "+&
											" FROM colecciones_ccc "+&
											" WHERE colecciones_ccc.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY colecciones_ccc.descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"			
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT colecciones_ccc.codigo, colecciones_ccc.codigo, colecciones_ccc.descripcion "+&
											" FROM colecciones_ccc "+&
											" WHERE colecciones_ccc.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, colecciones_ccc.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"		
end choose


call super :: clicked
end event

