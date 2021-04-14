$PBExportHeader$wtc_mant_trabajo_archivo.srw
forward
global type wtc_mant_trabajo_archivo from wt_ventana_padre
end type
end forward

global type wtc_mant_trabajo_archivo from wt_ventana_padre
integer width = 2830
integer height = 1280
string title = "Mantenimiento de Trabajos para Archivo"
end type
global wtc_mant_trabajo_archivo wtc_mant_trabajo_archivo

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "trabajo_archivo"
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
	if IsNull(dw_1.object.tecnico_dis[dw_1.getrow()]) or Trim(String(dw_1.object.tecnico_dis[dw_1.getrow()])) = "" then
		  campo = "tecnico_dis"
		  motivo = "Campo Obligatorio: Diseñador. "
		  falta_campo = True
	elseif IsNull(dw_1.object.numero_modelos[dw_1.getrow()]) or dw_1.object.numero_modelos[dw_1.getrow()] < 0 THEN
		  campo="numero_modelos"
		  motivo  = "Campo Obligatorio: Número de Modeios"
		  falta_campo = True
	elseif IsNull(dw_1.object.fecha_necesidad[dw_1.getrow()]) or Trim(String(dw_1.object.fecha_necesidad[dw_1.getrow()]))="" THEN
		  campo="fecha_necesidad"
		  motivo  = "Campo Obligatorio: Fecha Necesidad"
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
estado = 1 // Modo edición
dw_1.settransobject(sqlca)
return rtn
end function

on wtc_mant_trabajo_archivo.create
call super::create
end on

on wtc_mant_trabajo_archivo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_trabajo_archivo
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_trabajo_archivo
integer x = 2267
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_trabajo_archivo
integer width = 2757
integer height = 812
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_mant_trabajo_archivo"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "tecnico_dis"
		SELECT tecnico_dis.descripcion 
		INTO :resultado
		FROM tecnico_dis
		WHERE empresa = :codigo_empresa 
		and activo = 'S' 
		and tecnico_dis.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tecnico_dis_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tecnico_dis_descripcion[Row] 		= ''
			return 2
		end if
END CHOOSE


this.Accepttext()
end event

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

//if key = KeyF8! then
	//dw_1.EVENT usr_keydown(key, keyflags)
//end if

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "tecnico_dis"
			busqueda.titulo_ventana = "Búsqueda de Diseñador"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM TECNICO_DIS WHERE EMPRESA = '"+codigo_empresa+"' and activo = 'S' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Diseñador"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.tecnico_dis[this.GetRow()] 					= resultado.valores[1]			
				this.object.tecnico_dis_descripcion[this.GetRow()] 	= resultado.valores[2]			
			end if		
	END CHOOSE
end if	
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_trabajo_archivo
integer x = 2313
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_trabajo_archivo
integer x = 2624
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_trabajo_archivo
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_trabajo_archivo
integer width = 2217
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_trabajo_archivo
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_trabajo_archivo
integer x = 2469
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_trabajo_archivo
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"	
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT trabajo_archivo.codigo, trabajo_archivo.codigo, tecnico_dis.descripcion, trabajo_archivo.fecha_necesidad, trabajo_archivo.numero_modelos "+&
											" FROM trabajo_archivo, tecnico_dis "+&
											" WHERE trabajo_archivo.empresa = '"+codigo_empresa+"' "+&
											" and trabajo_archivo.empresa = tecnico_dis.empresa "+&
											" and trabajo_archivo.tecnico_dis = tecnico_dis.codigo "+&
											" ORDER BY CONVERT(INTEGER, trabajo_archivo.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Diseñador"	
		padre_busqueda.titulos[4] = "F. Necesidad"	
		padre_busqueda.titulos[5] = "Nº Modelos"	
		
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT trabajo_archivo.codigo, trabajo_archivo.codigo, tecnico_dis.descripcion, trabajo_archivo.fecha_necesidad, trabajo_archivo.numero_modelos "+&
											" FROM trabajo_archivo, tecnico_dis "+&
											" WHERE trabajo_archivo.empresa = '"+codigo_empresa+"' "+&
											" and trabajo_archivo.empresa = tecnico_dis.empresa "+&
											" and trabajo_archivo.tecnico_dis = tecnico_dis.codigo "+&
											" ORDER BY CONVERT(INTEGER, trabajo_archivo.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Diseñador"	
		padre_busqueda.titulos[4] = "F. Necesidad"	
		padre_busqueda.titulos[5] = "Nº Modelos"	
end choose


call super :: clicked
end event

