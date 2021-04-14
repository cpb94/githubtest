$PBExportHeader$wtc_mant_marcos.srw
forward
global type wtc_mant_marcos from wt_ventana_padre
end type
end forward

global type wtc_mant_marcos from wt_ventana_padre
integer height = 856
string title = "Mantenimiento de Marcos"
end type
global wtc_mant_marcos wtc_mant_marcos

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();string campo, motivo
boolean falta_Campo
Int resultado

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "prodmarcos"
param_colisiones.campo = "codigo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = false

rtn = 1

resultado = 1 //Todo ok si devolvemos 1

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

super::f_guardar()

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

on wtc_mant_marcos.create
call super::create
end on

on wtc_mant_marcos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_marcos
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_marcos
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_marcos
integer height = 396
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_marco"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name

	CASE "molde"
		SELECT prodmoldes.descripcion
		INTO :resultado  
		FROM prodmoldes  
		WHERE ( prodmoldes.empresa = :codigo_empresa ) AND  
					( prodmoldes.codigo  = :data );

		if SQLCA.sqlcode <> 100 then
			this.object.prodmoldes_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.prodmoldes_descripcion[Row] 		= ''
			return 2
		end if

END CHOOSE


this.Accepttext()
end event

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "molde"
			busqueda.titulo_ventana = "Búsqueda de Moldes"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION"+&
										" FROM prodmoldes "+&
										" WHERE empresa = '"+codigo_empresa+"'"+&
										" AND activo = 'S'"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.molde[dw_1.GetRow()] 			 					= resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.prodmoldes_descripcIon[dw_1.GetRow()] 	= resultado.valores[2]			// Devuelve el valor que encuentra ...
			end if		
	END CHOOSE
end if
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_marcos
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_marcos
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_marcos
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_marcos
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_marcos
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_marcos
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_marcos
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT codigo, descripcion "+&
											" FROM prodmarcos "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
	
	case "descripcion"
		padre_busqueda.consulta =  " SELECT codigo, descripcion "+&
											" FROM prodmarcos "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"			
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT codigo, codigo, descripcion "+&
											" FROM prodmarcos "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"
end choose


call super :: clicked
end event

