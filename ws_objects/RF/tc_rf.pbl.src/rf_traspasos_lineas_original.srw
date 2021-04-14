$PBExportHeader$rf_traspasos_lineas_original.srw
forward
global type rf_traspasos_lineas_original from window
end type
type cb_1 from commandbutton within rf_traspasos_lineas_original
end type
type pb_aceptar from picturebutton within rf_traspasos_lineas_original
end type
type uo_lectura_destino from u_sle_codbar_original within rf_traspasos_lineas_original
end type
type uo_lectura_origen from u_sle_codbar_original within rf_traspasos_lineas_original
end type
end forward

global type rf_traspasos_lineas_original from window
integer width = 4718
integer height = 2504
boolean titlebar = true
string title = "Traspaso de linea entre bultos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
pb_aceptar pb_aceptar
uo_lectura_destino uo_lectura_destino
uo_lectura_origen uo_lectura_origen
end type
global rf_traspasos_lineas_original rf_traspasos_lineas_original

type variables
string is_tipo_movimiento_salida = '102'
string is_tipo_movimiento_entrada = '103'
end variables

on rf_traspasos_lineas_original.create
this.cb_1=create cb_1
this.pb_aceptar=create pb_aceptar
this.uo_lectura_destino=create uo_lectura_destino
this.uo_lectura_origen=create uo_lectura_origen
this.Control[]={this.cb_1,&
this.pb_aceptar,&
this.uo_lectura_destino,&
this.uo_lectura_origen}
end on

on rf_traspasos_lineas_original.destroy
destroy(this.cb_1)
destroy(this.pb_aceptar)
destroy(this.uo_lectura_destino)
destroy(this.uo_lectura_origen)
end on

type cb_1 from commandbutton within rf_traspasos_lineas_original
integer x = 4270
integer y = 4
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Etiquetas"
end type

event clicked;str_parametros lstr_param
OpenWithParm(rf_impresion_etiquetas_bultos, lstr_param)

end event

type pb_aceptar from picturebutton within rf_traspasos_lineas_original
integer x = 4018
integer y = 1820
integer width = 654
integer height = 572
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\db-Post.png"
string disabledname = "C:\bmp\RF\db-Post_dis.png"
alignment htextalign = left!
end type

event clicked;str_movimiento_almacen lstr_movimiento_almacen

long ll_indice,ll_total
boolean lb_correcto = true

ll_total  = uo_lectura_origen.ii_lineas_bulto

if uo_lectura_origen.ii_bultos = 1 and uo_lectura_origen.ii_indice_lineas_bulto > 0 and uo_lectura_destino.ii_bultos = 1 then
	if uo_lectura_origen.il_id_bulto <> uo_lectura_destino.il_id_bulto then
		if uo_lectura_origen.ii_anyo_orden_carga = uo_lectura_destino.ii_anyo_orden_carga and uo_lectura_origen.is_orden_carga = uo_lectura_destino.is_orden_carga then
			lstr_movimiento_almacen.empresa            = codigo_empresa
			lstr_movimiento_almacen.articulo           = uo_lectura_origen.is_codigo_articulo
			lstr_movimiento_almacen.calidad            = uo_lectura_origen.is_codigo_calidad
			lstr_movimiento_almacen.tono               = uo_lectura_origen.is_lote
			lstr_movimiento_almacen.calibre            = uo_lectura_origen.ii_calibre
			lstr_movimiento_almacen.tipo_pallet        = uo_lectura_origen.is_codigo_pallet
			lstr_movimiento_almacen.caja               = uo_lectura_origen.is_codigo_caja
			lstr_movimiento_almacen.cantidad           = -1 * ( uo_lectura_origen.il_piezas )
			lstr_movimiento_almacen.orden_carga_anyo   = uo_lectura_origen.ii_anyo_orden_carga
			lstr_movimiento_almacen.orden_carga_codigo = uo_lectura_origen.is_orden_carga
			lstr_movimiento_almacen.orden_carga_linea  = uo_lectura_origen.il_linea_orden_carga
			lstr_movimiento_almacen.tipo_movimiento    = is_tipo_movimiento_salida
			lstr_movimiento_almacen.observaciones      = ""
			lstr_movimiento_almacen.almacen            = uo_lectura_origen.is_almacen
			lstr_movimiento_almacen.zona               = uo_lectura_origen.is_zona
			lstr_movimiento_almacen.fila               = uo_lectura_origen.ii_fila
			lstr_movimiento_almacen.altura             = uo_lectura_origen.ii_altura
			lstr_movimiento_almacen.tercero            = ""
			lstr_movimiento_almacen.documento          = ""
			lstr_movimiento_almacen.fecha              = datetime(today())
			lstr_movimiento_almacen.id_ubicacion       = uo_lectura_origen.il_id_ubicacion
			lstr_movimiento_almacen.id_alm_bultos		 = uo_lectura_origen.il_id_bulto
			
			if f_movimiento_almacen(lstr_movimiento_almacen) then
				lstr_movimiento_almacen.empresa            = codigo_empresa
				lstr_movimiento_almacen.articulo           = uo_lectura_origen.is_codigo_articulo
				lstr_movimiento_almacen.calidad            = uo_lectura_origen.is_codigo_calidad
				lstr_movimiento_almacen.tono               = uo_lectura_origen.is_lote
				lstr_movimiento_almacen.calibre            = uo_lectura_origen.ii_calibre
				lstr_movimiento_almacen.tipo_pallet        = uo_lectura_origen.is_codigo_pallet
				lstr_movimiento_almacen.caja               = uo_lectura_origen.is_codigo_caja
				lstr_movimiento_almacen.cantidad           = uo_lectura_origen.il_piezas
				lstr_movimiento_almacen.orden_carga_anyo   = uo_lectura_origen.ii_anyo_orden_carga
				lstr_movimiento_almacen.orden_carga_codigo = uo_lectura_origen.is_orden_carga
				lstr_movimiento_almacen.orden_carga_linea  = uo_lectura_origen.il_linea_orden_carga
				lstr_movimiento_almacen.tipo_movimiento    = is_tipo_movimiento_entrada
				lstr_movimiento_almacen.observaciones      = ""
				lstr_movimiento_almacen.almacen            = uo_lectura_destino.is_almacen
				lstr_movimiento_almacen.zona               = uo_lectura_destino.is_zona
				lstr_movimiento_almacen.fila               = uo_lectura_destino.ii_fila
				lstr_movimiento_almacen.altura             = uo_lectura_destino.ii_altura
				lstr_movimiento_almacen.tercero            = ""
				lstr_movimiento_almacen.documento          = ""
				lstr_movimiento_almacen.fecha              = datetime(today())
				lstr_movimiento_almacen.id_ubicacion       = uo_lectura_destino.il_id_ubicacion
				lstr_movimiento_almacen.id_alm_bultos		 = uo_lectura_destino.il_id_bulto
				
				if f_movimiento_almacen(lstr_movimiento_almacen) then
		
				else
					lb_correcto = false					
				end if
			else
				lb_correcto = false
			end if	
		
			if lb_correcto then
				commit;
				uo_lectura_origen.event ue_refrescar()
				uo_lectura_destino.event ue_refrescar()
			else
				rollback;
				Messagebox("Error","No se ha generado el movimiento")
			end if			
		else
			//Error por no seleccionar la misma orden de carga
			Messagebox("Error","No se han seleccionado bultos de la misma O.C.")
		end if
	else
		//Error al no seleccionar distintos bultos
		Messagebox("Error","No se han seleccionado distintos bultos")
	end if
else
	if uo_lectura_origen.ii_bultos > 1 then
		Messagebox("Error","Ha seleccionado un origen con mas de un bulto")
	else
		Messagebox("Error","No se ha seleccionado el origen del traspaso")
	end if
end if

uo_lectura_origen.SetFocus()
uo_lectura_origen.event getfocus()
end event

type uo_lectura_destino from u_sle_codbar_original within rf_traspasos_lineas_original
integer x = 5
integer y = 1200
integer taborder = 20
string is_descripcion = "LECTURA DESTINO"
end type

on uo_lectura_destino.destroy
call u_sle_codbar_original::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;pb_aceptar.SetFocus()
end event

type uo_lectura_origen from u_sle_codbar_original within rf_traspasos_lineas_original
integer x = 5
integer y = 4
integer taborder = 10
string is_descripcion = "LECTURA ORIGEN"
end type

on uo_lectura_origen.destroy
call u_sle_codbar_original::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;uo_lectura_destino.SetFocus()
uo_lectura_destino.event getfocus()
end event

