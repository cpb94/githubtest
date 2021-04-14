$PBExportHeader$wtc_mant_operaciones.srw
forward
global type wtc_mant_operaciones from wt_ventana_padre
end type
type dw_2 from datawindow within wtc_mant_operaciones
end type
type pb_2 from picturebutton within wtc_mant_operaciones
end type
type pb_1 from picturebutton within wtc_mant_operaciones
end type
end forward

global type wtc_mant_operaciones from wt_ventana_padre
integer width = 2085
integer height = 1772
string title = "Mantenimiento de Aplicaciones"
dw_2 dw_2
pb_2 pb_2
pb_1 pb_1
end type
global wtc_mant_operaciones wtc_mant_operaciones

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

on wtc_mant_operaciones.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.pb_2=create pb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.pb_1
end on

on wtc_mant_operaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event open;call super::open;dw_2.SetTransObject(SQLCA)


end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_operaciones
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_operaciones
integer x = 1504
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_operaciones
integer width = 1998
integer height = 316
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_operaciones"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;/*string resultado

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
*/
end event

event dw_1::usr_keydown;call super::usr_keydown;/*
string campo
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

*/
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_operaciones
integer x = 1559
end type

event pb_borrar::clicked;call super::clicked;rtn = 1 //Todo ok
int i
long contador
string codigo_marco,  botones[2]
str_ventana_alerta parametros

parametros.titulo = "Atención"
parametros.subtitulo = "Borrar registro"
parametros.mensaje = "¿Desea borrar el registro?"
parametros.tipo = 1
botones[1] = "Sí"
botones[2] = "No"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar = Int(Message.DoubleParm)

IF borrar = 1 THEN
	//dw1
	dw_1.SetTransObject (SQLCA)
	dw_2.SetTransObject (SQLCA)
	
	/*
	contador = dw_1.RowCount()
	for i = 1 to contador
		if rtn  <> -1 then
			rtn = dw_1.deleterow(1)
		end if
	next
	
	if rtn = 1 then
		rtn = dw_1.update()
	end if
	if rtn = 1 then
		COMMIT USING trans_ts;	
	else
		MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
		ROLLBACK USING trans_ts;
		//dw_1.object.#1[1] = padre_codigo
		pb_cancelar.triggerevent(Clicked!)
	end if
	*/
	
	//dw2
	contador = dw_2.RowCount()
	for i = 1 to contador
		if rtn  <> -1 then
			rtn = dw_2.deleterow(1)
		end if
	next
	
	if rtn = 1 then
		rtn = dw_2.update()
	end if
	
	if rtn = 1 then
		COMMIT USING sqlca;
	else
		ROLLBACK USING sqlca;
	END IF
		
	return rtn
	pb_nuevo.TriggerEvent(Clicked!)	
END IF
end event

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_operaciones
integer x = 1874
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_operaciones
end type

event pb_grabar::clicked;call super::clicked;string marco;
int n;

dw_2.accepttext();

rtn = 1

rtn = dw_2.Update()

IF rtn = 1 THEN
	COMMIT USING sqlca;
ELSE
	ROLLBACK USING sqlca;
END IF

dw_2.settransobject(sqlca)


end event

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_operaciones
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_operaciones
end type

event pb_nuevo::clicked;call super::clicked;int newrow2

dw_2.reset()

end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_operaciones
integer x = 1719
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_operaciones
integer width = 137
end type

event pb_buscar::clicked;string campo, empresa, codigo_aplicacion
long total
int newrow2, contador

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT codigo, descripcion, resumido "+&
											" FROM prodaplicaciones "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripcion"
		padre_busqueda.titulos[3] = "Resumido"	
call super :: clicked

empresa = dw_1.Object.empresa[dw_1.getrow()];
codigo_aplicacion = dw_1.Object.codigo[dw_1.getrow()];

total = dw_2.retrieve(empresa, codigo_aplicacion)

contador = dw_2.RowCount()

IF contador >= 1 THEN
	empresa = dw_2.Object.empresa[1];
	codigo_aplicacion = dw_2.Object.codigo_aplicacion[1];
END IF
	





end event

type dw_2 from datawindow within wtc_mant_operaciones
event usr_keydown ( keycode key,  unsignedlong keyflags )
integer x = 23
integer y = 624
integer width = 1998
integer height = 956
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_operaciones_aplicaciones"
boolean border = false
boolean livescroll = true
end type

event usr_keydown(keycode key, unsignedlong keyflags);string campo, empresa, codigo_aplicacion
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "campo"
			busqueda.titulo_ventana = "Búsqueda de Campos"
			busqueda.consulta  = " SELECT ORDINAL_POSITION, COLUMN_NAME"+&
										" FROM INFORMATION_SCHEMA.COLUMNS"+&
										" WHERE TABLE_SCHEMA = 'dbo'"+&
										" AND TABLE_NAME = 'art_ver_op_aplicaciones'"+&
										" ORDER BY ORDINAL_POSITION"
			busqueda.titulos[1] = "Índice"
			busqueda.titulos[2] = "Nombre columna"			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_2.object.aplicacion_campos_n_campo[dw_2.getRow()]   = integer(resultado.valores[1])		
				dw_2.object.campo[dw_2.getRow()]   	= resultado.valores[2]			// Devuelve el valor que encuentra ...
			end if
	END CHOOSE
END IF
end event

event doubleclicked; if dwo.name = this.object.#1.name then
	pb_buscar.triggerevent(clicked!)
else
	dw_2.EVENT usr_keydown(KeyEnter!, 0)
end if
end event

event clicked;IF dwo.name = "codigo_aplicacion" THEN
	This.SelectRow(0, false)
	This.SelectRow(row, true)
END IF
end event

type pb_2 from picturebutton within wtc_mant_operaciones
integer x = 210
integer y = 1428
integer width = 146
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer\Delete_24x24.png"
end type

event clicked;rtn = 1 //Todo ok
int i, row1
string codigo, botones[2], empresa, codigo_marco
str_ventana_alerta parametros

parametros.titulo = "Atención"
parametros.subtitulo = "Borrar registro"
parametros.mensaje = "¿Desea borrar el registro?"
parametros.tipo = 1
botones[1] = "Sí"
botones[2] = "No"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar = Int(Message.DoubleParm)

IF borrar = 1 THEN
	row1 = dw_2.GetSelectedRow(0)
	
	if row1 <> 0 then
		codigo = dw_2.Object.codigo_aplicacion[row1]
		rtn = dw_2.deleterow(row1)
		
		rtn = dw_2.Update()
	
		IF rtn = 1 THEN
			COMMIT USING sqlca;
		ELSE
			ROLLBACK USING sqlca;
		END IF
	ELSE
		messagebox("Aviso","Selecciona una fila a borrar")
	END IF
END IF
end event

type pb_1 from picturebutton within wtc_mant_operaciones
integer x = 50
integer y = 1428
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
boolean originalsize = true
string picturename = "C:\Tencer\Add_24x24.png"
end type

event clicked;long newrow, n, n1
string empresa, codigo_aplicacion, aplicacion, orden, descripcion, orden1


dw_2.accepttext();

n = dw_2.rowcount()
n1 = n+1
orden = string(n1)

empresa = dw_1.Object.empresa[dw_1.getrow()]
codigo_aplicacion = dw_1.Object.codigo[dw_1.getrow()]
descripcion = dw_1.Object.resumido[dw_1.getrow()]

IF isnull(codigo_aplicacion) OR codigo_aplicacion = "" THEN
	messagebox("Error: ", "No se encuentra el codigo")
ELSE
	newrow = dw_2.insertRow(0);
	dw_2.Object.empresa[newrow] = empresa
	dw_2.Object.codigo_aplicacion[newrow] = codigo_aplicacion
	dw_2.Object.descripcion[newrow] = descripcion
	dw_2.Object.campo[newrow]
	dw_2.Object.orden[newrow] = orden
END IF

end event

