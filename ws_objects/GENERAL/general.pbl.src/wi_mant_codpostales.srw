$PBExportHeader$wi_mant_codpostales.srw
$PBExportComments$Mantenimiento de codigos postales ( clave alfa_numerica).
forward
global type wi_mant_codpostales from wt_ventana_padre_2cp
end type
end forward

global type wi_mant_codpostales from wt_ventana_padre_2cp
integer height = 940
string title = "Mantenimiento de Códigos Postales"
end type
global wi_mant_codpostales wi_mant_codpostales

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado

rtn = 1
resultado = 1 //Todo ok si devolvemos 1

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
	elseif IsNull(dw_1.object.codpostal[dw_1.getrow()]) or Trim(String(dw_1.object.codpostal[dw_1.getrow()])) = "" then
		  campo = "codpostal"
		  motivo = "Campo Obligatorio: Código Postal. "
		  falta_campo = True
	elseif IsNull(dw_1.object.ciudad[dw_1.getrow()]) or Trim(String(dw_1.object.ciudad[dw_1.getrow()])) = "" then
		  campo = "ciudad"
		  motivo = "Campo Obligatorio: Ciudad. "
		  falta_campo = True
	end if
	
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

//PADRE MODIFICADO

dw_1.accepttext()

//Codigo por si se desea mostrar aviso antes de guardar (Por defecto NO, si no utilizar Message.DoubleParm = 10001)


dw_1.SetTransObject(trans_ts)	

//El parámetro 1 es la CP fuerte y el parámetro 2 la CP dependiente de la 1
if dw_1.rowcount() > 0 then
	dw_1.object.empresa[dw_1.getrow()] = codigo_empresa		
	if String(dw_1.object.#2[dw_1.getrow()]) = '' or isnull (dw_1.object.#2[dw_1.getrow()]) then
		messagebox("ERROR", "Deber indicar el Código Postal.")
		rtn = -1
		ROLLBACK USING trans_ts;
	end if
end if

if rtn <> -1 then
	rtn = dw_1.Update()
end if

//fin padre 

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

on wi_mant_codpostales.create
call super::create
end on

on wi_mant_codpostales.destroy
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

type pb_imprimir from wt_ventana_padre_2cp`pb_imprimir within wi_mant_codpostales
end type

type p_logo from wt_ventana_padre_2cp`p_logo within wi_mant_codpostales
end type

type dw_1 from wt_ventana_padre_2cp`dw_1 within wi_mant_codpostales
integer height = 472
string dataobject = "dw_codpostales2"
end type

event dw_1::itemchanged;call super::itemchanged;string resultado, pais

this.Accepttext()

CHOOSE CASE dwo.name

	CASE "pais"
		SELECT paises.nombre
		INTO :resultado  
		FROM paises 
		WHERE pais = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.paises_nombre[Row] 		= resultado
			this.object.codpostal[Row] = ''
			this.object.provincia[Row] = ''
			this.object.provincias_nombre[Row] = ''
		else
			dwo.Primary[row] = ''
			this.object.paises_nombre[Row] 		= ''
			this.object.codpostal[Row] = ''
			this.object.provincia[Row] = ''
			this.object.provincias_nombre[Row] = ''
			return 2
		end if
		
	CASE "codpostal"
		pais = this.object.pais[Row]
		if isnull(pais) or pais = '' then
			MessageBox("Error", "Debe indicar el país antes de introducir el código postal")
			dwo.Primary[row] = ''
			return 2
		end if
		SELECT codpostales.ciudad
		INTO :resultado  
		FROM codpostales WHERE pais = :pais and codpostal = :data;

		if SQLCA.sqlcode <> 100 then
			MessageBox("Error", "Ya existe el código postal indicado para la localidad "+resultado)
			dwo.Primary[row] = ''
			return 2
		end if
	CASE "provincia"
		pais = this.object.pais[Row]
		if isnull(pais) or pais = '' then
			MessageBox("Error", "Debe indicar el país antes de introducir la provincia")
			dwo.Primary[row] = ''
			return 2
		end if
		SELECT provincias.nombre
		INTO :resultado  
		FROM provincias 
		WHERE pais = :pais AND provincia = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.provincias_nombre[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.provincias_nombre[Row] 		= ''
			return 2
		end if
		
END CHOOSE


this.Accepttext()
end event

event dw_1::usr_keydown;call super::usr_keydown;string campo, pais
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "pais"
			busqueda.titulo_ventana = "Búsqueda de País"
			busqueda.consulta  = " SELECT pais, nombre "+&
										" FROM paises ORDER BY nombre"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "País "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.pais[dw_1.GetRow()] 			 = resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.paises_nombre[dw_1.GetRow()] 	 = resultado.valores[2]			// Devuelve el valor que encuentra ...
				this.object.codpostal[dw_1.GetRow()] = ''
				this.object.provincia[dw_1.GetRow()] = ''
				this.object.provincias_nombre[dw_1.GetRow()] = ''
			end if
		CASE "provincia"
			pais = this.object.pais[dw_1.GetRow()]
			if isnull(pais) or pais = '' then
				MessageBox("Error", "Debe indicar el país antes de introducir la provincia")
				return 
			end if
			
			busqueda.titulo_ventana = "Búsqueda de Provincia"
			busqueda.consulta  = " SELECT provincia, nombre "+&
										" FROM provincias WHERE pais = '"+pais+"' ORDER BY nombre"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Provincia "
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.provincia[dw_1.GetRow()] 			 = resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.provincias_nombre[dw_1.GetRow()] 	 = resultado.valores[2]			// Devuelve el valor que encuentra ...
			end if
			
	END CHOOSE
end if
end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param
long esta_abierta
String pais

CHOOSE CASE dwo.name
	CASE "p_prov"
	pais = this.object.pais[Row]
	if isnull(pais) or pais = '' then
		return
	end if
	esta_abierta = f_menu_ventana_esta_abierta("wi_mant_provincias")
	//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
	if esta_abierta = -1 then
		lstr_param.s_argumentos[1] = pais
		lstr_param.s_argumentos[2] = this.object.provincia[row]
		lstr_param.i_nargumentos = 2
		lstr_param.nombre_ventana = "wi_mant_codpostales"
		lstr_param.resultado = ''
		Openwithparm(wi_mant_provincias, lstr_param)
	else
		ventanas_activas[esta_abierta].ventana.BringToTop = true
	end if
END CHOOSE

end event

type pb_borrar from wt_ventana_padre_2cp`pb_borrar within wi_mant_codpostales
end type

type pb_salir from wt_ventana_padre_2cp`pb_salir within wi_mant_codpostales
end type

type pb_grabar from wt_ventana_padre_2cp`pb_grabar within wi_mant_codpostales
end type

type st_titulo from wt_ventana_padre_2cp`st_titulo within wi_mant_codpostales
end type

type pb_nuevo from wt_ventana_padre_2cp`pb_nuevo within wi_mant_codpostales
end type

type pb_cancelar from wt_ventana_padre_2cp`pb_cancelar within wi_mant_codpostales
end type

type pb_buscar from wt_ventana_padre_2cp`pb_buscar within wi_mant_codpostales
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = true
padre_busqueda.consulta =  "   SELECT codpostales.pais, paises.nombre, codpostales.codpostal, codpostales.ciudad "+& 
									" 	 FROM codpostales INNER JOIN paises ON codpostales.pais = paises.pais  "+&
									"   ORDER BY codpostales.pais ASC, codpostales.codpostal ASC "
padre_busqueda.titulos[1] = "Código País"
padre_busqueda.titulos[2] = "País"	
padre_busqueda.titulos[3] = "Código Postal"	
padre_busqueda.titulos[4] = "Localidad"	

call super :: clicked
end event

