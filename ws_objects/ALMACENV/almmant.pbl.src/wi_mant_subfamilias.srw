$PBExportHeader$wi_mant_subfamilias.srw
forward
global type wi_mant_subfamilias from wt_ventana_padre
end type
end forward

global type wi_mant_subfamilias from wt_ventana_padre
integer height = 744
string title = "Mantenimiento de Clientes"
end type
global wi_mant_subfamilias wi_mant_subfamilias

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();
string campo, motivo
boolean falta_Campo
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "subfamilias"
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
	end if
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

/*---------------------------------------------------------------------------------------------------------------------------------
			   FIN CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

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
dw_1.SetTransObject (SQLCA)

return rtn

end function

on wi_mant_subfamilias.create
call super::create
end on

on wi_mant_subfamilias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_imprimir from wt_ventana_padre`pb_imprimir within wi_mant_subfamilias
end type

type p_logo from wt_ventana_padre`p_logo within wi_mant_subfamilias
end type

type dw_1 from wt_ventana_padre`dw_1 within wi_mant_subfamilias
integer height = 288
string title = "Mantenimeinto de Colecciones"
string dataobject = "dw_subfamilias"
boolean border = false
end type

type pb_borrar from wt_ventana_padre`pb_borrar within wi_mant_subfamilias
end type

type pb_salir from wt_ventana_padre`pb_salir within wi_mant_subfamilias
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wi_mant_subfamilias
end type

type st_titulo from wt_ventana_padre`st_titulo within wi_mant_subfamilias
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wi_mant_subfamilias
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wi_mant_subfamilias
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wi_mant_subfamilias
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT subfamilias.codigo, subfamilias.codigo, subfamilias.descripcion "+&
											" FROM subfamilias "+&
											" WHERE subfamilias.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, subfamilias.codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
	
	case "descripcion"
		padre_busqueda.consulta =  " SELECT subfamilias.codigo, subfamilias.descripcion "+&
											" FROM subfamilias "+&
											" WHERE subfamilias.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY subfamilias.descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"			
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT subfamilias.codigo, subfamilias.codigo, subfamilias.descripcion "+&
											" FROM subfamilias "+&
											" WHERE subfamilias.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, subfamilias.codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"
end choose


call super :: clicked
end event

