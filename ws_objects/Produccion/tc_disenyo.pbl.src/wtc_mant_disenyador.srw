$PBExportHeader$wtc_mant_disenyador.srw
forward
global type wtc_mant_disenyador from wt_ventana_padre
end type
end forward

global type wtc_mant_disenyador from wt_ventana_padre
integer height = 880
string title = "Mantenimiento de Diseñadores"
end type
global wtc_mant_disenyador wtc_mant_disenyador

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "tecnico_dis"
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
	if IsNull(dw_1.object.tecnico_dis_descripcion[dw_1.getrow()]) or Trim(String(dw_1.object.tecnico_dis_descripcion[dw_1.getrow()])) = "" then
		  campo = "tecnico_dis_descripcion"
		  motivo = "Campo Obligatorio: Nombre. "
		  falta_campo = True
	elseif IsNull(dw_1.object.activo[dw_1.getrow()]) or Trim(String(dw_1.object.activo[dw_1.getrow()])) = "" then
		  campo = "activo"
		  motivo = "Campo Obligatorio: Activo. "
		  falta_campo = True
	elseif IsNull(dw_1.object.tecnico_dis_zona[dw_1.getrow()]) or Trim(String(dw_1.object.tecnico_dis_zona[dw_1.getrow()])) = "" then
		  campo = "tecnico_dis_zona"
		  motivo = "Campo Obligatorio: Zona. "
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
			   FIN COMPROBAR LOS CAMPOS OBLIGATORIOS.
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
dw_1.settransobject(sqlca)

return rtn
end function

on wtc_mant_disenyador.create
call super::create
end on

on wtc_mant_disenyador.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_disenyador
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_disenyador
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_disenyador
integer height = 412
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_disenyador"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "tecnico_dis_zona"
		SELECT descripcion 
		INTO :resultado
		FROM tecnico_dis_zonas
		WHERE empresa = :codigo_empresa 
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tecnico_dis_zonas_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tecnico_dis_zonas_descripcion[Row] 		= ''
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
		CASE "tecnico_dis_zona"
			busqueda.titulo_ventana = "Búsqueda de Zonas"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION "+&
										" FROM tecnico_dis_zonas "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Zonas "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.tecnico_dis_zona[this.GetRow()] 					= resultado.valores[1]		
				this.object.tecnico_dis_zonas_descripcion[this.GetRow()] = resultado.valores[2]		
			end if	
	END CHOOSE
end if	
	

end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_disenyador
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_disenyador
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_disenyador
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_disenyador
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_disenyador
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_disenyador
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_disenyador
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT tecnico_dis.codigo, tecnico_dis.codigo, tecnico_dis.descripcion "+&
											" FROM tecnico_dis "+&
											" WHERE tecnico_dis.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, tecnico_dis.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
	
	case "descripcion"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT tecnico_dis.codigo, tecnico_dis.descripcion "+&
											" FROM tecnico_dis "+&
											" WHERE tecnico_dis.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY tecnico_dis.descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"			
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT tecnico_dis.codigo, tecnico_dis.codigo, tecnico_dis.descripcion "+&
											" FROM tecnico_dis "+&
											" WHERE tecnico_dis.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, tecnico_dis.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"		
end choose


call super :: clicked
end event

