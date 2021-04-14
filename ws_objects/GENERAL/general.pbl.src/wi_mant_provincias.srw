$PBExportHeader$wi_mant_provincias.srw
forward
global type wi_mant_provincias from wt_ventana_padre_2cp
end type
end forward

global type wi_mant_provincias from wt_ventana_padre_2cp
integer height = 1032
string title = "Mantenimiento de Provincias"
end type
global wi_mant_provincias wi_mant_provincias

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = '' //No está vinculado a la empresa
param_colisiones.tabla = "provincias"
param_colisiones.campo = "provincia"
param_colisiones.filtro = "provincias.pais = '"+dw_1.object.pais[dw_1.getrow()]+"'"
param_colisiones.buscar_huecos = true

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_1 

dw_1.accepttext()
falta_campo = false
if dw_1.rowcount() > 0 then
	
	if IsNull(dw_1.object.pais[dw_1.getrow()]) or Trim(String(dw_1.object.pais[dw_1.getrow()])) = "" then
		  campo = "pais"
		  motivo = "Campo Obligatorio: Pais. "
		  falta_campo = True
	elseif IsNull(dw_1.object.nombre[dw_1.getrow()]) or Trim(String(dw_1.object.nombre[dw_1.getrow()])) = "" then
		  campo = "nombre"
		  motivo = "Campo Obligatorio: Nombre. "
		  falta_campo = True
	end if
	
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

//PADRE
rtn = super::f_guardar()

IF rtn = 1 THEN
	COMMIT USING trans_ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_ts;
END IF
dw_1.SetTransObject(SQLCA)	


estado = 1 // Modo edición

return rtn
end function

on wi_mant_provincias.create
call super::create
end on

on wi_mant_provincias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;/*
String codigo, coleccion_antigua
Long esta_abierta, fila
if not isnull(ventana_invoca) and ventana_invoca <> "" then
	esta_abierta = f_menu_ventana_esta_abierta(ventana_invoca)
	if esta_abierta <> -1 then
		CHOOSE CASE ventana_invoca
			CASE "wtc_trabajos_disenyo_nuevo"
			//Devuelvo valores
			codigo = dw_1.object.#1[dw_1.getrow()]
			if not isnull(codigo) and codigo <> "" then
				fila = wtc_trabajos_disenyo_nuevo.dw_1.getrow()
				coleccion_antigua = wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion[fila]
				if not isnull(coleccion_antigua) and coleccion_antigua <> "" and coleccion_antigua <> codigo then
					if MessageBox("Atención","¿Desea reemplazar la colección "+coleccion_antigua+" por la colección "+codigo+" en el modelo?", Question!, YesNo!,2) = 1 then
						wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion[fila] = codigo
						wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(fila, wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion, codigo)
					end if
				else
					wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion[wtc_trabajos_disenyo_nuevo.dw_1.getrow()] = codigo
					wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(wtc_trabajos_disenyo_nuevo.dw_1.Getrow(), wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion, codigo)
				end if
			end if
		END CHOOSE
	end if
end if
*/
end event

type pb_imprimir from wt_ventana_padre_2cp`pb_imprimir within wi_mant_provincias
end type

type p_logo from wt_ventana_padre_2cp`p_logo within wi_mant_provincias
end type

type dw_1 from wt_ventana_padre_2cp`dw_1 within wi_mant_provincias
integer height = 556
string dataobject = "dw_provincias2"
end type

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name

	CASE "pais"
		SELECT paises.nombre
		INTO :resultado  
		FROM paises 
		WHERE pais = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.paises_nombre[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.paises_nombre[Row] 		= ''
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
		CASE "pais"
			busqueda.titulo_ventana = "Búsqueda de Cliente"
			busqueda.consulta  = " SELECT pais, nombre "+&
										" FROM paises ORDER BY nombre"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "País "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.pais[dw_1.GetRow()] 			 = resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.paises_nombre[dw_1.GetRow()] 	 = resultado.valores[2]			// Devuelve el valor que encuentra ...
			end if		
	END CHOOSE
end if
end event

type pb_borrar from wt_ventana_padre_2cp`pb_borrar within wi_mant_provincias
end type

type pb_salir from wt_ventana_padre_2cp`pb_salir within wi_mant_provincias
end type

type pb_grabar from wt_ventana_padre_2cp`pb_grabar within wi_mant_provincias
end type

type st_titulo from wt_ventana_padre_2cp`st_titulo within wi_mant_provincias
end type

type pb_nuevo from wt_ventana_padre_2cp`pb_nuevo within wi_mant_provincias
end type

type pb_cancelar from wt_ventana_padre_2cp`pb_cancelar within wi_mant_provincias
end type

type pb_buscar from wt_ventana_padre_2cp`pb_buscar within wi_mant_provincias
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = true
padre_busqueda.consulta =  "   SELECT provincias.pais, paises.nombre, provincias.provincia, provincias.nombre "+& 
									" 	 FROM provincias INNER JOIN paises ON provincias.pais = paises.pais  "+&
									"   ORDER BY provincias.pais ASC, provincias.nombre ASC "
padre_busqueda.titulos[1] = "Código País"
padre_busqueda.titulos[2] = "País"	
padre_busqueda.titulos[3] = "Código Provincia"	
padre_busqueda.titulos[4] = "Provincia"

call super :: clicked
end event

