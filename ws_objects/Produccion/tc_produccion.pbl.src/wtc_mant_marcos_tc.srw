$PBExportHeader$wtc_mant_marcos_tc.srw
forward
global type wtc_mant_marcos_tc from wt_ventana_padre
end type
type dw_3 from datawindow within wtc_mant_marcos_tc
end type
type pb_añadir from picturebutton within wtc_mant_marcos_tc
end type
type pb_eliminar from picturebutton within wtc_mant_marcos_tc
end type
type dw_2 from datawindow within wtc_mant_marcos_tc
end type
end forward

global type wtc_mant_marcos_tc from wt_ventana_padre
integer width = 2674
integer height = 2504
string title = "Mantenimiento de Marcos"
dw_3 dw_3
pb_añadir pb_añadir
pb_eliminar pb_eliminar
dw_2 dw_2
end type
global wtc_mant_marcos_tc wtc_mant_marcos_tc

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

on wtc_mant_marcos_tc.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.pb_añadir=create pb_añadir
this.pb_eliminar=create pb_eliminar
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.pb_añadir
this.Control[iCurrent+3]=this.pb_eliminar
this.Control[iCurrent+4]=this.dw_2
end on

on wtc_mant_marcos_tc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.pb_añadir)
destroy(this.pb_eliminar)
destroy(this.dw_2)
end on

event open;call super::open;dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)

end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_marcos_tc
integer x = 594
integer y = 136
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_marcos_tc
integer x = 2030
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_marcos_tc
integer x = 128
integer y = 288
integer width = 2418
integer height = 400
integer taborder = 10
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

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_marcos_tc
integer x = 2080
integer y = 132
end type

event pb_borrar::clicked;rtn = 1 //Todo ok
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
	dw_3.SetTransObject (SQLCA)
	
	//padre_codigo = dw_1.object.#1[dw_1.GetRow()]
	
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
	
	//dw3
	contador = dw_3.RowCount()
	for i = 1 to contador
		if rtn  <> -1 then
			rtn = dw_3.deleterow(1)
		end if
	next
	
	if rtn = 1 then
		rtn = dw_3.update()
	end if
	if rtn = 1 then
		COMMIT USING sqlca;
	else
		ROLLBACK USING sqlca;
	END IF
	
	return rtn
	pb_nuevo.TriggerEvent(Clicked!)
	
	/*
	IF contador >= 1 THEN
		codigo_marco = dw_2.object.codigo_marco[dw_2.GetRow()];
		
		DELETE FROM prodmarcos_pastas
		WHERE codigo_marco = :codigo_marco USING sqlca;
		
		if sqlca.sqlcode <> 0 THEN
			MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
			ROLLBACK USING sqlca;
		else
			COMMIT USING sqlca;
		END IF
	ELSE
	END IF
		
	contador = dw_3.RowCount()
	IF contador >= 1 THEN
		DELETE FROM prodmarcos_calibres
		WHERE codigo_marco = :codigo_marco USING sqlca;
		
		if sqlca.sqlcode <> 0 THEN
			MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
			ROLLBACK USING sqlca;
		else
			COMMIT USING sqlca;
		END IF
	ELSE
	END IF
	*/
	
END IF
//call super :: clicked
end event

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_marcos_tc
integer x = 2400
integer y = 132
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_marcos_tc
integer x = 439
integer y = 136
end type

event pb_grabar::clicked;call super::clicked;string empresa, codigo_marco, descripcion
int n, newrow2
long total2;


dw_2.accepttext()
dw_3.accepttext()

codigo_marco = dw_1.Object.codigo[dw_1.getrow()];

for n = 1 TO dw_3.rowCount()
		dw_3.Object.prodmarcos_calibres_empresa[n] = codigo_empresa
		dw_3.Object.prodmarcos_calibres_codigo_marco[n] = codigo_marco
NEXT

rtn = dw_2.Update()

IF rtn = 1 THEN
	COMMIT USING sqlca;
ELSE
	ROLLBACK USING sqlca;
END IF

rtn = dw_3.Update()

IF rtn = 1 THEN
	COMMIT USING sqlca;
ELSE
	ROLLBACK USING sqlca;
END IF

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)



end event

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_marcos_tc
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_marcos_tc
integer x = 128
integer y = 136
end type

event pb_nuevo::clicked;call super::clicked;//resetear valores a 0
dw_2.reset()
dw_3.reset()

end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_marcos_tc
integer x = 2240
integer y = 132
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_marcos_tc
integer x = 283
integer y = 136
integer width = 137
end type

event pb_buscar::clicked;string campo, empresa, codigo_marco, descripcion, pasta, empresa2, codigo_marco2, descripcion2, pasta2
long total2, total3
int newrow2, i, contador

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

empresa = dw_1.Object.empresa[dw_1.getrow()];
codigo_marco = dw_1.Object.codigo[dw_1.getrow()];

total2 = dw_2.retrieve(empresa, codigo_marco)

contador = dw_2.RowCount()

IF contador >= 1 THEN
	empresa = dw_2.Object.empresa[1];
	codigo_marco = dw_2.Object.codigo_marco[1];
	pasta = dw_2.Object.pasta[1]
	dw_3.reset()
	total3 = dw_3.retrieve(empresa, codigo_marco, pasta)
ELSE
	dw_3.reset()
END IF




end event

type dw_3 from datawindow within wtc_mant_marcos_tc
integer x = 128
integer y = 1588
integer width = 2418
integer height = 648
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_marco_calibre"
boolean border = false
boolean livescroll = true
end type

event itemchanged;decimal row1, datos, ancho_max, ancho_min, largo_max, largo_min, tolerancia_ancho, tolerancia_largo

IF dwo.name = "ancho_central" THEN
	datos = dec(data)
	
	row1 = dw_2.GetSelectedRow(0)
	
	tolerancia_ancho = dw_2.Object.tolerancia_ancho[row1]
	
	dw_3.Object.ancho_max[row] = datos + tolerancia_ancho
	dw_3.Object.ancho_min[row] = datos - tolerancia_ancho
ELSE
	datos = dec(data)
	
	row1 = dw_2.GetSelectedRow(0)
	
	tolerancia_largo = dw_2.Object.tolerancia_largo[row1]
	
	dw_3.Object.largo_max[row] = datos + tolerancia_largo
	dw_3.Object.largo_min[row] = datos - tolerancia_largo

END IF

end event

type pb_añadir from picturebutton within wtc_mant_marcos_tc
integer x = 169
integer y = 1380
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer\Add_24x24.png"
end type

event clicked;string empresa, codigo_marco, descripcion
int newrow2
long total2;

Boolean resultado
resultado = false

dw_2.accepttext();

rtn = 1

empresa = dw_1.Object.empresa[dw_1.getrow()];
codigo_marco = dw_1.Object.codigo[dw_1.getrow()];

IF isnull(codigo_marco) OR codigo_marco = "" THEN
	messagebox("Error: ", "No se encuentra el codigo")
ELSE
	descripcion = dw_1.Object.descripcion[dw_1.getrow()];
	
	newrow2 = dw_2.insertRow(0);
	dw_2.Object.codigo_marco[newrow2] = codigo_marco
	dw_2.Object.empresa[newrow2] = empresa
	dw_2.Object.descripcion[newrow2] = descripcion
	dw_2.Object.pasta[newrow2] 
	dw_2.Object.ancho[newrow2] = 00
	dw_2.Object.largo[newrow2] = 00
	dw_2.Object.area[newrow2] = 00
	dw_2.Object.tolerancia_ancho[newrow2] = 00
	dw_2.Object.tolerancia_largo[newrow2] = 00
END IF
end event

type pb_eliminar from picturebutton within wtc_mant_marcos_tc
integer x = 329
integer y = 1380
integer width = 146
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer\Delete_24x24.png"
string disabledname = "C:\Fuentes_tencer\Delete_24x24_D.png"
end type

event clicked;rtn = 1 //Todo ok
int i, row1, contador, total2, total3, row
string codigob, pasta, botones[2], empresa, codigo_marco
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
	codigob = dw_2.Object.codigo_marco[row1]
	pasta = dw_2.Object.pasta[row1]
	
	/*
	delete from prodmarcos_calibres where
					codigo_marco = :codigob AND 
					pasta = :pasta USING sqlca;
	
	if sqlca.sqlcode <> 0 THEN
		MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
		ROLLBACK USING sqlca;
	else
		COMMIT USING sqlca;
	END IF
	
	delete from prodmarcos_pastas where
					codigo_marco = :codigob AND
					pasta = :pasta USING sqlca;
	
	if sqlca.sqlcode <> 0 THEN
		MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
		ROLLBACK USING sqlca;
	else
		COMMIT USING sqlca;
	END IF
	*/
	
	rtn = dw_2.deleterow(row1)
	
	rtn = dw_2.Update()

	IF rtn = 1 THEN
		COMMIT USING sqlca;
	ELSE
		ROLLBACK USING sqlca;
	END IF
	
	contador = dw_3.RowCount()
	for i = 1 to contador
		if rtn  <> -1 then
			rtn = dw_3.deleterow(1)
		end if
	next
	
	rtn = dw_3.Update()
	
	IF rtn = 1 THEN
		COMMIT USING sqlca;
	ELSE
		ROLLBACK USING sqlca;
	END IF
	
	//dw_3.reset()

END IF
 
end event

type dw_2 from datawindow within wtc_mant_marcos_tc
integer x = 128
integer y = 724
integer width = 2423
integer height = 820
integer taborder = 30
string title = "none"
string dataobject = "dwtc_marco_pastas"
boolean border = false
boolean livescroll = true
end type

event itemchanged;decimal datos, ancho, largo, row1

IF dwo.name = "ancho" THEN
	datos = dec(data)

	largo = dw_2.Object.largo[row]
	
	dw_2.Object.area[row] = datos * largo
ELSEIF dwo.name = "largo" THEN
	datos = dec(data)

	ancho = dw_2.Object.ancho[row]
	
	dw_2.Object.area[row] = ancho * datos
ELSE
END IF


end event

event clicked;string empresa, codigo_marco, pasta
int newrow3, contador
long total3;

dw_2.accepttext();
dw_3.accepttext();

IF dwo.name = "codigo_marco" THEN

	empresa = dw_2.Object.empresa[row];
	codigo_marco = dw_2.Object.codigo_marco[row];
	pasta = dw_2.Object.pasta[row];
	
	This.SelectRow(0, false)
	This.SelectRow(row, true)
	
	total3 = dw_3.retrieve(empresa, codigo_marco, pasta);
	contador = dw_3.RowCount();
	
	IF contador = 0 THEN
		newrow3 = dw_3.insertRow(0);
		dw_3.Object.prodmarcos_calibres_pasta[newrow3] = pasta
		dw_3.Object.calibre[newrow3] = "4"
		dw_3.Object.ancho_central[newrow3] = 00
		dw_3.Object.largo_central[newrow3] = 00
		
		newrow3 = dw_3.insertRow(0);
		dw_3.Object.prodmarcos_calibres_pasta[newrow3] = pasta
		dw_3.Object.calibre[newrow3] = "5"
		dw_3.Object.ancho_central[newrow3] = 00
		dw_3.Object.largo_central[newrow3] = 00
	
		newrow3 = dw_3.insertRow(0);
		dw_3.Object.prodmarcos_calibres_pasta[newrow3] = pasta
		dw_3.Object.calibre[newrow3] = "6"
		dw_3.Object.ancho_central[newrow3] = 00
		dw_3.Object.largo_central[newrow3] = 00
		
	END IF
END IF
end event

