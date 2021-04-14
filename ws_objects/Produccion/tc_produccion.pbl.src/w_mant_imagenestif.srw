$PBExportHeader$w_mant_imagenestif.srw
forward
global type w_mant_imagenestif from wt_ventana_padre
end type
type dw_con_piezas_coleccion from u_dw_padre within w_mant_imagenestif
end type
type pb_anyade_trabajo from picturebutton within w_mant_imagenestif
end type
end forward

global type w_mant_imagenestif from wt_ventana_padre
integer height = 1012
string title = "Mantenimiento de Imagenes INK"
dw_con_piezas_coleccion dw_con_piezas_coleccion
pb_anyade_trabajo pb_anyade_trabajo
end type
global w_mant_imagenestif w_mant_imagenestif

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//LLAMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "desimagenestif"
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
	if IsNull(dw_1.object.desimagenestif_tipomaquina_disenyo[dw_1.getrow()]) or Trim(String(dw_1.object.desimagenestif_tipomaquina_disenyo[dw_1.getrow()])) = "" then
		  campo = "desimagenestif_tipomaquina_disenyo"
		  motivo = "Campo Obligatorio: Tipo Máquina. "
		  falta_campo = True
	elseif IsNull(dw_1.object.modelo[dw_1.getrow()]) or Trim(String(dw_1.object.modelo[dw_1.getrow()])) = "" then
		  campo = "modelo"
		  motivo = "Campo Obligatorio: Modelo. "
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

dw_1.SetTransObject(SQLCA)
estado = 1 // Modo edición

return rtn
end function

on w_mant_imagenestif.create
int iCurrent
call super::create
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.pb_anyade_trabajo=create pb_anyade_trabajo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_piezas_coleccion
this.Control[iCurrent+2]=this.pb_anyade_trabajo
end on

on w_mant_imagenestif.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_con_piezas_coleccion)
destroy(this.pb_anyade_trabajo)
end on

event activate;call super::activate;w_mant_imagenestif = ventanas_activas[id_ventana_activa].ventana
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within w_mant_imagenestif
end type

type p_logo from wt_ventana_padre`p_logo within w_mant_imagenestif
end type

type dw_1 from wt_ventana_padre`dw_1 within w_mant_imagenestif
integer y = 304
integer height = 524
string dataobject = "dw_mant_desimagenestif2"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "desimagenestif_tipomaquina_disenyo"
		SELECT tipomaquina_disenyo.descripcion
		INTO :resultado
		FROM tipomaquina_disenyo
		WHERE empresa = :codigo_empresa
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tipomaquina_disenyo_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tipomaquina_disenyo_descripcion[Row] 		= ''
			return 2			
		end if
	CASE "perfil"	
		
		SELECT descripcion
		INTO :resultado
		FROM desperfil
		WHERE empresa = :codigo_empresa
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.desperfil_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.desperfil_descripcion[Row] 		= ''
			return 2			
		end if
END CHOOSE
end event

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

//control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "desimagenestif_tipomaquina_disenyo"
			
			busqueda.titulo_ventana = "Búsqueda de Tipo de Aplicación"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION "+&
										" FROM tipomaquina_disenyo "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.desimagenestif_tipomaquina_disenyo[this.GetRow()] 		= resultado.valores[1]		
				this.object.tipomaquina_disenyo_descripcion[this.GetRow()] 		= resultado.valores[2]		
			end if
		CASE "perfil"
			
			busqueda.titulo_ventana = "Búsqueda de Tipo de Aplicación"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION, FECHA "+&
										" FROM desperfil "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Fecha"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.perfil[this.GetRow()] 		= resultado.valores[1]		
				this.object.desperfil_descripcion[this.GetRow()] 		= resultado.valores[2]		
			end if
	END CHOOSE
end if
end event

type pb_borrar from wt_ventana_padre`pb_borrar within w_mant_imagenestif
end type

type pb_salir from wt_ventana_padre`pb_salir within w_mant_imagenestif
end type

type pb_grabar from wt_ventana_padre`pb_grabar within w_mant_imagenestif
end type

type st_titulo from wt_ventana_padre`st_titulo within w_mant_imagenestif
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within w_mant_imagenestif
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
end if
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within w_mant_imagenestif
end type

type pb_buscar from wt_ventana_padre`pb_buscar within w_mant_imagenestif
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT desimagenestif.codigo, desimagenestif.codigo, CONVERT(char(5),tipomaquina_disenyo.prefijo), desimagenestif.modelo, desimagenestif.descripcion "+&	
									" FROM desimagenestif "+&
									" LEFT OUTER JOIN tipomaquina_disenyo ON desimagenestif.empresa = tipomaquina_disenyo.empresa AND desimagenestif.tipomaquina_disenyo = tipomaquina_disenyo.codigo "+&
									" WHERE desimagenestif.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, desimagenestif.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Tipo"
		padre_busqueda.titulos[4] = "Modelo"
		padre_busqueda.titulos[5] = "Descripción"	
		
call super :: clicked


end event

type dw_con_piezas_coleccion from u_dw_padre within w_mant_imagenestif
integer x = 4293
integer y = 2360
integer width = 1280
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

type pb_anyade_trabajo from picturebutton within w_mant_imagenestif
integer x = 5189
integer y = 2208
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;//long fila_actual, nuevaprueba, indice, maximo_valor_dw
//string modelo_actual
//
//nuevaprueba = 0
//modelo_actual =  padre_codigo
//
//select max(trabajo)
//into :nuevaprueba
//from destrabajo2
//where empresa = :codigo_empresa
//and modelo = :modelo_actual;
//
//maximo_valor_dw = long(dwtc_mant_trabajos_disenyo.Describe("Evaluate('Max(destrabajo2_trabajo)', 0)"))
//
//if isnull(nuevaprueba) then nuevaprueba = 0
//if isnull(maximo_valor_dw) then maximo_valor_dw = 0
//
//if nuevaprueba > maximo_valor_dw then
//	nuevaprueba ++
//else
//	nuevaprueba = maximo_valor_dw +1
//end if
//
//fila_actual = dwtc_mant_trabajos_disenyo.InsertRow(0)
//
//dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
//
//dwtc_mant_trabajos_disenyo.scrolltorow(fila_actual)
//dwtc_mant_trabajos_disenyo.SetColumn(3)
//dwtc_mant_trabajos_disenyo.Setfocus()
//dwtc_mant_trabajos_disenyo.object.destrabajo2_empresa[fila_actual] = codigo_empresa
////	dwtc_mant_trabajos_disenyo.object.destrabajo2_modelo[fila_actual] = modelo_actual
//dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
//dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[fila_actual] = 'N'
//dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_solicitud[fila_actual] = datetime(today())
//dwtc_mant_trabajos_disenyo.object.destrabajo2_laboratorio[fila_actual] = 'N'
//dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid[fila_actual] = 'N'
//dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis[fila_actual] = ''
//
end event

