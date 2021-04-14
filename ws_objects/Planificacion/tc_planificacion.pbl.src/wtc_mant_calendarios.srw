$PBExportHeader$wtc_mant_calendarios.srw
forward
global type wtc_mant_calendarios from wt_ventana_padre
end type
type dw_almanaque from u_dw within wtc_mant_calendarios
end type
end forward

global type wtc_mant_calendarios from wt_ventana_padre
integer width = 2757
integer height = 1812
string title = "Mantenimiento de Calendarios"
dw_almanaque dw_almanaque
end type
global wtc_mant_calendarios wtc_mant_calendarios

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();string campo, motivo
boolean falta_Campo
Int resultado

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "calendario"
param_colisiones.campo = "codigo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = true

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

dw_1.SetTransObject(trans_ts)	

if dw_1.rowcount() > 0 then
	dw_1.object.empresa[dw_1.getrow()] = codigo_empresa		
	if String(dw_1.object.#1[dw_1.getrow()]) = '' or isnull (dw_1.object.#1[dw_1.getrow()]) then
		padre_codigo = String(f_colisiones ( trans_ts, param_colisiones))
		if isnull(padre_codigo) OR padre_codigo = '0'  then
			messagebox("ERROR", "No se puede asignar un código.")
			rtn = -1
			ROLLBACK USING trans_ts;
			dw_1.SetTransObject(SQLCA)	
		else
			rtn = 1
			dw_1.object.#1[dw_1.getrow()] = String(Long(padre_codigo) )
		end if
	end if
end if
//dw_1.accepttext()
if rtn = 1 then 
	rtn = dw_1.Update()
end if

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

on wtc_mant_calendarios.create
int iCurrent
call super::create
this.dw_almanaque=create dw_almanaque
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_almanaque
end on

on wtc_mant_calendarios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_almanaque)
end on

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_calendarios
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_calendarios
integer x = 2213
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_calendarios
integer width = 2688
integer height = 288
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_calendario"
boolean border = false
end type

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_calendarios
integer x = 2258
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_calendarios
integer x = 2569
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_calendarios
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_calendarios
integer width = 2149
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_calendarios
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_calendarios
integer x = 2414
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_calendarios
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT calendario.codigo, calendario.codigo, calendario.descripcion "+&
											" FROM calendario "+&
											" WHERE calendario.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, calendario.codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
	
	case "descripcion"
		padre_busqueda.consulta =  " SELECT calendario.codigo, calendario.descripcion "+&
											" FROM calendario "+&
											" WHERE calendario.empresa = '"+codigo_empresa+"'  "+&
											" ORDER BY calendario.descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"			
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT calendario.codigo, calendario.codigo, calendario.descripcion "+&
											" FROM calendario "+&
											" WHERE calendario.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, calendario.codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
end choose


call super :: clicked

dw_almanaque.SetTransObject(SQLCA)
dw_almanaque.retrieve(codigo_empresa, '21', 7, 2012)
end event

type dw_almanaque from u_dw within wtc_mant_calendarios
integer x = 27
integer y = 664
integer width = 2679
integer height = 956
integer taborder = 70
string dataobject = "dwtc_almanaque"
end type

