$PBExportHeader$wtc_mant_serie.srw
forward
global type wtc_mant_serie from wt_ventana_padre
end type
end forward

global type wtc_mant_serie from wt_ventana_padre
integer height = 1496
string title = "Mantenimiento de Series"
end type
global wtc_mant_serie wtc_mant_serie

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "desserie"
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
	elseif IsNull(dw_1.object.cliente[dw_1.getrow()]) or Trim(String(dw_1.object.cliente[dw_1.getrow()])) = "" then
		  campo = "cliente"
		  motivo = "Campo Obligatorio: Cliente. "
		  falta_campo = True
	elseif IsNull(dw_1.object.ancho[dw_1.getrow()]) or Trim(String(dw_1.object.ancho[dw_1.getrow()])) = "" then
		  campo = "ancho"
		  motivo = "Campo Obligatorio: Ancho. "
		  falta_campo = True
	elseif IsNull(dw_1.object.largo[dw_1.getrow()]) or Trim(String(dw_1.object.largo[dw_1.getrow()])) = "" then
		  campo = "largo"
		  motivo = "Campo Obligatorio: Largo. "
		  falta_campo = True
	elseif IsNull(dw_1.object.tipo[dw_1.getrow()]) or Trim(String(dw_1.object.tipo[dw_1.getrow()])) = "" then
		  campo = "tipo"
		  motivo = "Campo Obligatorio: Tipo. "
		  falta_campo = True
	elseif IsNull(dw_1.object.aspecto[dw_1.getrow()]) or Trim(String(dw_1.object.aspecto[dw_1.getrow()])) = "" then
		  campo = "aspecto"
		  motivo = "Campo Obligatorio: Aspecto. "
		  falta_campo = True
	elseif IsNull(dw_1.object.desserie_rectificada[dw_1.getrow()]) or Trim(String(dw_1.object.desserie_rectificada[dw_1.getrow()])) = "" then
		  campo = "desserie_rectificada"
		  motivo = "Campo Obligatorio: Introduzca si la serie es rectificada o no. "
		  falta_campo = True
	elseif IsNull(dw_1.object.desserie_hay_base[dw_1.getrow()]) or Trim(String(dw_1.object.desserie_hay_base[dw_1.getrow()])) = "" then
		  campo = "desserie_hay_base"
		  motivo = "Campo Obligatorio: Introduzca si hay base o no. "
		  falta_campo = True
	elseif IsNull(dw_1.object.desserie_hay_cliches[dw_1.getrow()]) or Trim(String(dw_1.object.desserie_hay_cliches[dw_1.getrow()])) = "" then
		  campo = "desserie_hay_cliches"
		  motivo = "Campo Obligatorio: Introduzca si hay clichés o no. "
		  falta_campo = True
	end if
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if


/*****************************************************************************/
//PADRE 

rtn = super::f_guardar()

/*********************************************/

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

on wtc_mant_serie.create
call super::create
end on

on wtc_mant_serie.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Long esta_abierta, fila
String cliente

if not isnull(ventana_invoca) and ventana_invoca <> "" and not isnull(padre_codigo) and padre_codigo <> "" and dw_1.rowcount() > 0 then
	esta_abierta = f_menu_ventana_esta_abierta(ventana_invoca)
	if esta_abierta <> -1 then
		CHOOSE CASE ventana_invoca
			CASE "wtc_trabajos_disenyo_nuevo"
				fila = wtc_trabajos_disenyo_nuevo.dw_clientes.getrow()
				cliente =  wtc_trabajos_disenyo_nuevo.dw_clientes.object.cliente[fila]
				if cliente = dw_1.object.cliente[dw_1.getrow()] then
					fila = wtc_trabajos_disenyo_nuevo.dw_trabajos.getrow()
					wtc_trabajos_disenyo_nuevo.dw_trabajos.object.modelo_trabajo_serie[fila] = padre_codigo
					wtc_trabajos_disenyo_nuevo.dw_trabajos.EVENT itemchanged(fila, wtc_trabajos_disenyo_nuevo.dw_trabajos.object.modelo_trabajo_serie, padre_codigo)
				end if
		END CHOOSE
	end if
end if
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_serie
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_serie
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_serie
integer height = 1040
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_desserie"
boolean border = false
end type

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "cliente"
			busqueda.titulo_ventana = "Búsqueda de Cliente"
			busqueda.consulta  = " SELECT CODIGO, RAZON "+&
										" FROM genter "+&
										" WHERE empresa = '"+codigo_empresa+"' and tipoter = 'C' ORDER BY RAZON"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Razón "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.cliente[dw_1.GetRow()] 			 = resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.genter_razon[dw_1.GetRow()] 	 = resultado.valores[2]			// Devuelve el valor que encuentra ...
			end if		
	END CHOOSE
end if
end event

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name

	CASE "cliente"
		SELECT genter.razon
		INTO :resultado  
		FROM genter  
		WHERE ( genter.empresa = :codigo_empresa ) AND  
				( genter.tipoter = 'C' ) AND
				( genter.codigo  = :data );

		if SQLCA.sqlcode <> 100 then
			this.object.genter_razon[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.genter_razon[Row] 		= ''
			return 2
		end if

END CHOOSE


this.Accepttext()
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_serie
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_serie
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_serie
boolean originalsize = true
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_serie
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_serie
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_serie
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_serie
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  "   SELECT desserie.codigo, desserie.codigo, desserie.descripcion, CONVERT(Char,desserie.ancho), CONVERT(Char,desserie.largo), genter.razon "+& 
         								" 	 FROM desserie LEFT OUTER JOIN genter ON desserie.empresa = genter.empresa AND desserie.cliente = genter.codigo "+&
         								" 	 WHERE ( desserie.empresa = '"+codigo_empresa+"' ) AND "+&
         								" 	 ( genter.tipoter = 'C' ) "+&
											"   ORDER BY CONVERT(INTEGER, desserie.codigo) desc "
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
		padre_busqueda.titulos[4] = "Ancho"	
		padre_busqueda.titulos[5] = "Largo"
		padre_busqueda.titulos[6] = "Cliente"	
	
	case "descripcion"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  "   SELECT desserie.codigo, desserie.descripcion, CONVERT(Char,desserie.ancho), CONVERT(Char,desserie.largo), genter.razon "+& 
         								" 	 FROM desserie LEFT OUTER JOIN genter ON desserie.empresa = genter.empresa AND desserie.cliente = genter.codigo "+&
         								" 	 WHERE (desserie.empresa = '"+codigo_empresa+"' ) AND "+&
         								" 	 ( genter.tipoter = 'C' ) "+&
											"   ORDER BY desserie.descripcion desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"	
		padre_busqueda.titulos[3] = "Ancho"	
		padre_busqueda.titulos[4] = "Largo"
		padre_busqueda.titulos[5] = "Cliente"		
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  "   SELECT desserie.codigo, desserie.codigo, desserie.descripcion, CONVERT(Char,desserie.ancho), CONVERT(Char,desserie.largo), genter.razon "+& 
         								" 	 FROM desserie LEFT OUTER JOIN genter ON desserie.empresa = genter.empresa AND desserie.cliente = genter.codigo "+&
         								" 	 WHERE ( desserie.empresa = '"+codigo_empresa+"' ) AND "+&
         								" 	 ( genter.tipoter = 'C' ) "+&
											"   ORDER BY CONVERT(INTEGER, desserie.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
		padre_busqueda.titulos[4] = "Ancho"	
		padre_busqueda.titulos[5] = "Largo"
		padre_busqueda.titulos[6] = "Cliente"	
end choose


call super :: clicked
end event

