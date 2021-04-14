$PBExportHeader$wtc_mant_coleccion.srw
forward
global type wtc_mant_coleccion from wt_ventana_padre
end type
end forward

global type wtc_mant_coleccion from wt_ventana_padre
integer height = 1580
string title = "Mantenimiento de colecciones"
end type
global wtc_mant_coleccion wtc_mant_coleccion

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
param_colisiones.tabla = "descoleccionsol"
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
	if IsNull(dw_1.object.disenyador[dw_1.getrow()]) or Trim(String(dw_1.object.disenyador[dw_1.getrow()])) = "" then
		  campo = "disenyador"
		  motivo = "Campo Obligatorio: Disenyador. "
		  falta_campo = True
	elseif IsNull(dw_1.object.descoleccionsol_comercial[dw_1.getrow()]) or Trim(String(dw_1.object.descoleccionsol_comercial[dw_1.getrow()])) = "" then
		  campo = "descoleccionsol_comercial"
		  motivo = "Campo Obligatorio: Comercial. "
		  falta_campo = True
	elseif IsNull(dw_1.object.descoleccionsol_grafica[dw_1.getrow()]) or Trim(String(dw_1.object.descoleccionsol_grafica[dw_1.getrow()])) = "" then
		  campo = "descoleccionsol_grafica"
		  motivo = "Campo Obligatorio: Gráfica. "
		  falta_campo = True
	elseif IsNull(dw_1.object.ambiente[dw_1.getrow()]) or Trim(String(dw_1.object.ambiente[dw_1.getrow()])) = "" then
		  campo = "ambiente"
		  motivo = "Campo Obligatorio: Ambiente. "
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

public function integer f_borrar ();Long total

//Comprobaciones previas

padre_codigo = dw_1.object.#1[dw_1.GetRow()]
	
select isnull(count(*) , 0 )
into :total
from desmodelo
where empresa = :codigo_empresa
and coleccion = :padre_codigo;

if total > 0 then
	messagebox("Aviso", "No se puede borrar la coleccion porque tiene piezas asociadas")
	return -1
end if

rtn = 1 //Todo ok

delete from deshistorico 
where empresa = :codigo_empresa 
and coleccion = :padre_codigo 
using trans_ts;

IF trans_ts.SQLCode <> 0 THEN         
	MessageBox("SQL error", trans_ts.SQLErrText)
	rtn = -1
	ROLLBACK USING trans_ts;
	dw_1.object.#1[1] = padre_codigo
	pb_cancelar.triggerevent(Clicked!)
else
	rtn = super::f_borrar()
END IF


return rtn
end function

on wtc_mant_coleccion.create
call super::create
end on

on wtc_mant_coleccion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_coleccion
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_coleccion
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_coleccion
integer height = 1128
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_descoleccion"
boolean border = false
end type

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "descoleccionsol_tecnico_lab"
			busqueda.titulo_ventana = "Búsqueda de Técnico"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM TECNICO_LAB WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Técnico"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.descoleccionsol_tecnico_lab[dw_1.GetRow()] = resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.tecnico_lab_descripcion[dw_1.GetRow()] 	 = resultado.valores[2]			// Devuelve el valor que encuentra ...
				dw_1.Modify("tecnico_lab_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
			end if		
			
		CASE "disenyador"
			busqueda.titulo_ventana = "Búsqueda de Diseñador"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM TECNICO_DIS WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Diseñador"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.disenyador[dw_1.GetRow()] 						= resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.tecnico_dis_descripcion[dw_1.GetRow()] 	= resultado.valores[2]			// Devuelve el valor que encuentra ...
				dw_1.Modify("tecnico_dis_descripcion.Background.Color = "+ftc_control_color_descripcion(0))			
			end if		
			
		CASE "descoleccionsol_comercial"
			busqueda.titulo_ventana = "Búsqueda de Comercial"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM comercial WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Comercial"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.descoleccionsol_comercial[dw_1.GetRow()] 					= resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.comercial_descripcion[dw_1.GetRow()] 	= resultado.valores[2]			// Devuelve el valor que encuentra ...
				dw_1.Modify("comercial_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
			end if		
			
	END CHOOSE
end if
end event

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name

	CASE "descoleccionsol_tecnico_lab"
		SELECT tecnico_lab.descripcion 
		INTO :resultado
		FROM tecnico_lab
		WHERE empresa = :codigo_empresa
		and tecnico_lab.codigo = :data
		ORDER BY tecnico_lab.descripcion ;

		if SQLCA.sqlcode <> 100 then
			this.object.tecnico_lab_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tecnico_lab_descripcion[Row] 		= ''
			return 2
		end if

	CASE "disenyador"
		SELECT tecnico_dis.descripcion 
		INTO :resultado
		FROM tecnico_dis
		WHERE empresa = :codigo_empresa
		and tecnico_dis.codigo = :data
		ORDER BY tecnico_dis.descripcion ;

		if SQLCA.sqlcode <> 100 then
			this.object.tecnico_dis_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tecnico_dis_descripcion[Row] 		= ''
			return 2
		end if
		
	CASE "descoleccionsol_comercial"
		SELECT comercial.descripcion 
		INTO :resultado
		FROM comercial
		WHERE empresa = :codigo_empresa
		and comercial.codigo = :data
		ORDER BY comercial.descripcion ;

		if SQLCA.sqlcode <> 100 then
			this.object.comercial_descripcion[Row] 		= resultado		
		else
			dwo.Primary[row] = ''
			this.object.comercial_descripcion[Row] 		= ''
			return 2
		end if
END CHOOSE


this.Accepttext()
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_coleccion
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_coleccion
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_coleccion
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_coleccion
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_coleccion
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_coleccion
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_coleccion
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT descoleccionsol.codigo, descoleccionsol.codigo, descoleccionsol.ambiente, descoleccionsol.descripcion "+&
											" FROM descoleccionsol "+&
											" WHERE descoleccionsol.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, descoleccionsol.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Ambiente"	
		padre_busqueda.titulos[4] = "Descripción"	
	
	case "descripcion"
		padre_busqueda.consulta =  " SELECT descoleccionsol.codigo, descoleccionsol.codigo, descoleccionsol.ambiente, descoleccionsol.descripcion "+&
											" FROM descoleccionsol "+&
											" WHERE descoleccionsol.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY descoleccionsol.descripcion desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Ambiente"	
		padre_busqueda.titulos[3] = "Descripción"		
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT descoleccionsol.codigo, descoleccionsol.codigo, descoleccionsol.ambiente, descoleccionsol.descripcion "+&
											" FROM descoleccionsol "+&
											" WHERE descoleccionsol.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, descoleccionsol.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Ambiente"	
		padre_busqueda.titulos[4] = "Descripción"	
end choose


call super :: clicked
end event

