$PBExportHeader$wtc_mant_coleccion_archivo_bd.srw
forward
global type wtc_mant_coleccion_archivo_bd from wt_ventana_padre_grid
end type
type p_imagen from picture within wtc_mant_coleccion_archivo_bd
end type
type pb_descargar_archivo from picturebutton within wtc_mant_coleccion_archivo_bd
end type
end forward

global type wtc_mant_coleccion_archivo_bd from wt_ventana_padre_grid
integer width = 4640
integer height = 2976
string title = "Mantenimiento de Archivos de la Colección (Ambientes)"
p_imagen p_imagen
pb_descargar_archivo pb_descargar_archivo
end type
global wtc_mant_coleccion_archivo_bd wtc_mant_coleccion_archivo_bd

on wtc_mant_coleccion_archivo_bd.create
int iCurrent
call super::create
this.p_imagen=create p_imagen
this.pb_descargar_archivo=create pb_descargar_archivo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_imagen
this.Control[iCurrent+2]=this.pb_descargar_archivo
end on

on wtc_mant_coleccion_archivo_bd.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_imagen)
destroy(this.pb_descargar_archivo)
end on

event open;call super::open;

dw_1.title = 'Colección ' + padre_codigo
end event

event closequery;//No hace falta porque contiene blobs y se guarda siempre que se realiza una acción


end event

type st_codigo from wt_ventana_padre_grid`st_codigo within wtc_mant_coleccion_archivo_bd
boolean visible = false
integer x = 27
integer y = 160
alignment alignment = left!
end type

type pb_duplicar1 from wt_ventana_padre_grid`pb_duplicar1 within wtc_mant_coleccion_archivo_bd
boolean visible = false
integer x = 361
integer y = 976
end type

type pb_borrar1 from wt_ventana_padre_grid`pb_borrar1 within wtc_mant_coleccion_archivo_bd
integer x = 183
integer y = 2656
end type

event pb_borrar1::clicked;long fila
boolean error_borrando
long fila_actual
str_ventana_alerta parametros


parametros.titulo = "Atención Borrado de Archivo de la Colección"
parametros.subtitulo = "Borrar ARCHIVO"
parametros.mensaje = "¿Desea borrar el Archivo?"
parametros.tipo = 1
//parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar = Int(Message.DoubleParm)

rtn = 0
if borrar = 1 then
	error_borrando = false
	fila_actual = dw_1.getrow()
	if fila_actual > 0 then
		if dw_1.DeleteRow(fila_actual) <> 1 then
			error_borrando = True
		else
			error_borrando = False
		end if
	end if
	
	if error_borrando then
		MessageBox("Error","No ha sido posible borrar el registro")
	
	else
		fila = dw_1.getrow()
		
		if fila > 0 then
			if fila = dw_1.rowcount() then
				dw_1.setrow(dw_1.rowcount())
			else
				dw_1.setrow(fila)
			end if	
		end if
		
		dw_1.event rowfocuschanged(dw_1.getrow())
		
	end if
end if


end event

type pb_anyadir1 from wt_ventana_padre_grid`pb_anyadir1 within wtc_mant_coleccion_archivo_bd
integer x = 32
integer y = 2656
integer weight = 700
end type

event pb_anyadir1::clicked;call super::clicked;string codigo_archivo
long fila
string pathname
string filename[]
blob imagen
int fh
transaction tr

//Tamaño archivo 
Long tamanyo_archivo = 10000000

fila = dw_1.insertrow(0)
dw_1.setrow(fila)

dw_1.object.empresa[fila] = codigo_empresa
dw_1.object.coleccion[fila] = padre_codigo
dw_1.object.guardado[fila] = 0

codigo_archivo = dw_1.Describe("Evaluate('max(integer(codigo))', 0)")

if codigo_archivo = '0' or isnull(codigo_archivo) or codigo_archivo = '' then
	codigo_archivo = '1'
else
	codigo_archivo = string(long(codigo_archivo) + 1)
end if

dw_1.object.codigo[fila] = codigo_Archivo


pb_grabar.EVENT clicked()


rtn = 1

GetFileOpenName ( "Añandir Archivo a Colección", pathname, filename, "jpg")

if FileLength(pathname) > tamanyo_archivo then
	MessageBox("Error","El tamaño de archivo excede el límite ("+String(tamanyo_archivo/1000000)+" MB).")
	return
end if

fh = FileOpen(pathname, StreamMode!)

IF fh <> -1 THEN
	
	//tamanyo_archivo
	
	param_transaccion.motor = 1
	ftc_crear_transaccion (tr, param_transaccion)
	connect using tr;


	
	FileReadEX(fh, imagen)        
	FileClose(fh)        
	
	UPDATEBLOB coleccion_Archivo
	SET imagen = :imagen        
	WHERE empresa = :codigo_empresa       
	and coleccion = :padre_codigo
	and codigo = :codigo_Archivo;
	connect USING tr ;
	
	IF SQLCA.SQLCode = -1 THEN         
		MessageBox("SQL error", SQLCA.SQLErrText)
		rtn = -1
	END IF
	
	if rtn <> -1 then
		update coleccion_archivo
		SET guardado = 1
		WHERE empresa = :codigo_empresa       
		and coleccion = :padre_codigo
		and codigo = :codigo_Archivo;
		connect USING tr ;
		
		IF SQLCA.SQLCode = -1 THEN         
			MessageBox("SQL error", SQLCA.SQLErrText)
			rtn = -1
		END IF
	end if
	
	IF rtn = 1 THEN
		COMMIT USING tr;
		dw_1.object.guardado [dw_1.getrow()] = 1
		dw_1.event rowfocuschanged(dw_1.getrow())
	ELSE
		ROLLBACK USING tr;
		messagebox("Error", "Error al guardar.", StopSign!)
	END IF
	
	DISCONNECT USING tr;
	destroy tr;
	
END IF




end event

type pb_imprimir from wt_ventana_padre_grid`pb_imprimir within wtc_mant_coleccion_archivo_bd
boolean visible = false
end type

type p_logo from wt_ventana_padre_grid`p_logo within wtc_mant_coleccion_archivo_bd
integer x = 4064
integer y = 4
end type

type dw_1 from wt_ventana_padre_grid`dw_1 within wtc_mant_coleccion_archivo_bd
integer y = 300
integer width = 553
integer height = 2500
boolean titlebar = true
string title = "Ambientes"
string dataobject = "dwtc_coleccion_archivo"
boolean vscrollbar = true
end type

event dw_1::clicked;call super::clicked;/*
string pathname
string filename[]
string codigo_archivo
blob imagen
int fh
transaction tr
rtn = 1

if dwo.name = 'p_anyadir_archivo' then
	GetFileOpenName ( "Añandir Archivo a Colección", pathname, filename, "jpg")
	
	fh = FileOpen(pathname, StreamMode!)
	
	IF fh <> -1 THEN
		param_transaccion.motor = 1
		ftc_crear_transaccion (tr, param_transaccion)
		connect using tr;

		codigo_archivo = this.object.codigo[row]
		
		FileReadEX(fh, imagen)        
		FileClose(fh)        
		
		UPDATEBLOB coleccion_Archivo
		SET imagen = :imagen        
		WHERE empresa = :codigo_empresa       
		and coleccion = :padre_codigo
		and codigo = :codigo_Archivo;
		connect USING tr ;
		
		IF SQLCA.SQLCode = -1 THEN         
			MessageBox("SQL error", SQLCA.SQLErrText)
			rtn = -1
		END IF
		
		if rtn <> -1 then
			update coleccion_archivo
			SET guardado = 1
			WHERE empresa = :codigo_empresa       
			and coleccion = :padre_codigo
			and codigo = :codigo_Archivo;
			connect USING tr ;
			
			IF SQLCA.SQLCode = -1 THEN         
				MessageBox("SQL error", SQLCA.SQLErrText)
				rtn = -1
			END IF
		end if
		
		IF rtn = 1 THEN
			COMMIT USING tr;
			this.object.guardado [row] = 1
			this.event rowfocuschanged(row)
		ELSE
			ROLLBACK USING tr;
			messagebox("Error", "Error al guardar.", StopSign!)
		END IF
		
		DISCONNECT USING tr;
		destroy tr;
		
	END IF

end if


*/
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;string codigo_archivo
Blob imagen
boolean centrar_imagen = true
long ancho_std = 4000
long alto_std = 2500
long pos_x = 600
long pos_y = 300


p_imagen.visible = false // para evitar efectos raros en pantalla.

if currentrow <= 0 then
	return
end if


if dw_1.object.guardado[currentrow] = 1 then

	codigo_archivo = dw_1.object.codigo[currentrow]
	
	SELECTBLOB imagen
	INTO :imagen        
	FROM coleccion_archivo        
	WHERE empresa = :codigo_empresa
	and coleccion = :padre_codigo
	and codigo = :codigo_archivo
	USING SQLCA ;
	
	p_imagen.x = pos_x
	p_imagen.y = pos_y
	
	p_imagen.SetPicture(imagen)
	ftc_modifica_tamanyo_imagen ( ancho_std, alto_std, p_imagen, centrar_imagen)

end if
dw_1.selectrow(0, false)
dw_1.selectrow(currentrow, true)
dw_1.scrolltorow(dw_1.getrow())
end event

type pb_salir from wt_ventana_padre_grid`pb_salir within wtc_mant_coleccion_archivo_bd
integer x = 4434
integer y = 120
end type

type pb_grabar from wt_ventana_padre_grid`pb_grabar within wtc_mant_coleccion_archivo_bd
boolean visible = false
end type

type st_titulo from wt_ventana_padre_grid`st_titulo within wtc_mant_coleccion_archivo_bd
end type

type pb_cancelar from wt_ventana_padre_grid`pb_cancelar within wtc_mant_coleccion_archivo_bd
boolean visible = false
end type

type p_imagen from picture within wtc_mant_coleccion_archivo_bd
integer x = 599
integer y = 300
integer width = 4000
integer height = 2500
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type pb_descargar_archivo from picturebutton within wtc_mant_coleccion_archivo_bd
integer x = 411
integer y = 2660
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
string picturename = "C:\Tencer_PB12\import1.png"
alignment htextalign = left!
string powertiptext = "Descargar Archivo"
end type

event clicked;string pathname
string filename[]
string codigo_archivo
blob imagen
int fh
transaction tr


ftc_crear_transaccion (tr, param_transaccion)
connect using tr;

codigo_archivo = dw_1.object.codigo[dw_1.getrow()]
 
SELECTBLOB imagen 
INTO  :imagen  
FROM coleccion_archivo
WHERE empresa = :codigo_empresa
and coleccion = :padre_codigo
and codigo = :codigo_archivo
USING tr;

GetFileSaveName  ( "Descargar Archivo", pathname, filename, "jpg", "Archivos jpg (*.jpg),*.jpg")

fh = FileOpen(pathname, StreamMode!, Write!, Shared!, Replace!)

IF fh <> -1 THEN
	FileWriteEx(fh, imagen)
	FileClose(fh)        
end if

DISCONNECT USING tr;
destroy tr;







	

end event

