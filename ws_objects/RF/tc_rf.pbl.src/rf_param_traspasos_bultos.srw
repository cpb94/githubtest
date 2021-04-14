$PBExportHeader$rf_param_traspasos_bultos.srw
forward
global type rf_param_traspasos_bultos from window
end type
type p_ayuda_ventana from picture within rf_param_traspasos_bultos
end type
type pb_salir from picturebutton within rf_param_traspasos_bultos
end type
type st_paso3 from statictext within rf_param_traspasos_bultos
end type
type pb_atras from picturebutton within rf_param_traspasos_bultos
end type
type st_paso2 from statictext within rf_param_traspasos_bultos
end type
type st_paso1 from statictext within rf_param_traspasos_bultos
end type
type pb_aceptar from picturebutton within rf_param_traspasos_bultos
end type
type uo_lectura_destino from u_sle_codbar within rf_param_traspasos_bultos
end type
type uo_lectura_origen from u_sle_codbar within rf_param_traspasos_bultos
end type
end forward

global type rf_param_traspasos_bultos from window
integer width = 4718
integer height = 2904
boolean titlebar = true
string title = "Traspasos de Ubicación"
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
p_ayuda_ventana p_ayuda_ventana
pb_salir pb_salir
st_paso3 st_paso3
pb_atras pb_atras
st_paso2 st_paso2
st_paso1 st_paso1
pb_aceptar pb_aceptar
uo_lectura_destino uo_lectura_destino
uo_lectura_origen uo_lectura_origen
end type
global rf_param_traspasos_bultos rf_param_traspasos_bultos

type variables
string is_tipo_movimiento_salida = '102'
string is_tipo_movimiento_entrada = '103'
long   il_color_fondo_activo,il_color_fondo_inactivo
int    ii_paso_actual = 1

str_parametros  istr_parametros
str_rf_parametros_ventanas istr_rf_parametros_ventanas
boolean ib_ubicacion_origen_fija = false
boolean ib_ubicacion_destino_fija = false
end variables

on rf_param_traspasos_bultos.create
this.p_ayuda_ventana=create p_ayuda_ventana
this.pb_salir=create pb_salir
this.st_paso3=create st_paso3
this.pb_atras=create pb_atras
this.st_paso2=create st_paso2
this.st_paso1=create st_paso1
this.pb_aceptar=create pb_aceptar
this.uo_lectura_destino=create uo_lectura_destino
this.uo_lectura_origen=create uo_lectura_origen
this.Control[]={this.p_ayuda_ventana,&
this.pb_salir,&
this.st_paso3,&
this.pb_atras,&
this.st_paso2,&
this.st_paso1,&
this.pb_aceptar,&
this.uo_lectura_destino,&
this.uo_lectura_origen}
end on

on rf_param_traspasos_bultos.destroy
destroy(this.p_ayuda_ventana)
destroy(this.pb_salir)
destroy(this.st_paso3)
destroy(this.pb_atras)
destroy(this.st_paso2)
destroy(this.st_paso1)
destroy(this.pb_aceptar)
destroy(this.uo_lectura_destino)
destroy(this.uo_lectura_origen)
end on

event open;istr_parametros = Message.PowerObjectParm

IF istr_parametros.i_nargumentos >= 2 THEN

	if f_cargar_str_rf_parametros_ventanas(long(istr_parametros.s_argumentos[2]),istr_rf_parametros_ventanas) then
		
		f_inicializar_str_rf_parametros_ventanas(istr_rf_parametros_ventanas)
		
		//istr_rf_parametros_ventanas.id
		//istr_rf_parametros_ventanas.empresa
		//istr_rf_parametros_ventanas.descripcion
		
		//Parametros generales
		//istr_rf_parametros_ventanas.texto_ventana
		//istr_rf_parametros_ventanas.tipo_ventana
		//istr_rf_parametros_ventanas.ayuda_ventana
		//istr_rf_parametros_ventanas.texto_paso1
		//istr_rf_parametros_ventanas.texto_paso2
		//istr_rf_parametros_ventanas.texto_paso3
		//istr_rf_parametros_ventanas.ayuda_paso1
		//istr_rf_parametros_ventanas.ayuda_paso2
		//istr_rf_parametros_ventanas.ayuda_paso3
		
		//Parametros Entrada
		//istr_rf_parametros_ventanas.tipo_movimiento_entrada
		//istr_rf_parametros_ventanas.sugerir_ubicacion_entrada
		//istr_rf_parametros_ventanas.entrada_ubicacion_fija
		//istr_rf_parametros_ventanas.almacen_entrada
		//istr_rf_parametros_ventanas.zona_entrada
		//istr_rf_parametros_ventanas.fila_entrada
		//istr_rf_parametros_ventanas.altura_entrada
		
		//Parametros Salida
		//istr_rf_parametros_ventanas.tipo_movimiento_salida
		//istr_rf_parametros_ventanas.salida_ubicacion_fija
		//istr_rf_parametros_ventanas.almacen_salida
		//istr_rf_parametros_ventanas.zona_salida
		//istr_rf_parametros_ventanas.fila_salida
		//istr_rf_parametros_ventanas.altura_salida
	
		this.title = upper(istr_rf_parametros_ventanas.texto_ventana)
		p_ayuda_ventana.powertiptext = istr_rf_parametros_ventanas.ayuda_ventana
		
		st_paso1.text = upper(istr_rf_parametros_ventanas.texto_paso1)
		st_paso1.tag  = istr_rf_parametros_ventanas.ayuda_paso1
		
		st_paso2.text = upper(istr_rf_parametros_ventanas.texto_paso2)
		st_paso2.tag  = istr_rf_parametros_ventanas.ayuda_paso2
		
		st_paso3.text = upper(istr_rf_parametros_ventanas.texto_paso3)
		st_paso3.tag  = istr_rf_parametros_ventanas.ayuda_paso3
		
		is_tipo_movimiento_entrada = istr_rf_parametros_ventanas.tipo_movimiento_entrada
		is_tipo_movimiento_salida  = istr_rf_parametros_ventanas.tipo_movimiento_salida
	
		if istr_rf_parametros_ventanas.entrada_ubicacion_fija = 'S' then
			ib_ubicacion_destino_fija = true
//			is_almacen = istr_rf_parametros_ventanas.almacen_entrada
//			is_zona    = istr_rf_parametros_ventanas.zona_entrada
//			ii_fila    = istr_rf_parametros_ventanas.fila_entrada
//			ii_altura  = istr_rf_parametros_ventanas.altura_entrada
		else
//			is_almacen = ""
//			is_zona    = ""
//			ii_fila    = 0
//			ii_altura  = 0
		end if
	
		if istr_rf_parametros_ventanas.salida_ubicacion_fija = 'S' then
			ib_ubicacion_origen_fija = true
		end if
	
		if istr_rf_parametros_ventanas.mostrar_contenido_bulto_entrada = 'S' then
			uo_lectura_destino.ib_mostrar_desplegado = true
		else	
			uo_lectura_destino.ib_mostrar_desplegado = false
		end if
		
		uo_lectura_destino.event constructor()	
	
		il_color_fondo_activo   = st_paso1.backcolor
		il_color_fondo_inactivo = st_paso2.backcolor
		
		uo_lectura_origen.SetFocus()
		uo_lectura_origen.event getfocus()
		
		if istr_parametros.i_nargumentos >= 3 then
			uo_lectura_origen.sle_codbar.text = istr_parametros.s_argumentos[3]
			uo_lectura_origen.sle_codbar.event modified()
		end if
	else
		//cerrar la ventana por falta de parametros
		close(this)
	end if
	istr_parametros.i_nargumentos = 0
ELSE
	//cerrar la ventana por falta de parametros
	close(this)
END IF
end event

type p_ayuda_ventana from picture within rf_param_traspasos_bultos
integer x = 18
integer y = 4
integer width = 146
integer height = 144
string picturename = "C:\Fuentes_tencer_PB12\Information_16x16.png"
boolean border = true
boolean focusrectangle = false
end type

type pb_salir from picturebutton within rf_param_traspasos_bultos
integer x = 4320
integer width = 357
integer height = 316
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\salir.png"
string disabledname = "C:\bmp\RF\salir_dis.tif"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type st_paso3 from statictext within rf_param_traspasos_bultos
boolean visible = false
integer x = 2939
integer y = 4
integer width = 1381
integer height = 144
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
string text = "3"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_atras from picturebutton within rf_param_traspasos_bultos
integer x = 41
integer y = 2040
integer width = 800
integer height = 700
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\Back.png"
string disabledname = "C:\bmp\RF\Back_dis.png"
alignment htextalign = left!
end type

event clicked;choose case ii_paso_actual
	case 2
		uo_lectura_origen.SetFocus()
		uo_lectura_origen.event getfocus()		
	case 3
		uo_lectura_destino.SetFocus()
		uo_lectura_destino.event getfocus()			
	case else
		uo_lectura_origen.SetFocus()
		uo_lectura_origen.event getfocus()		
end choose
end event

type st_paso2 from statictext within rf_param_traspasos_bultos
integer x = 1554
integer y = 4
integer width = 1381
integer height = 144
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
boolean enabled = false
string text = "Destino"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_paso1 from statictext within rf_param_traspasos_bultos
integer x = 169
integer y = 4
integer width = 1381
integer height = 144
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388736
string text = "Bulto"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_aceptar from picturebutton within rf_param_traspasos_bultos
integer x = 3831
integer y = 2040
integer width = 800
integer height = 700
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

event clicked;//str_movimiento_almacen lstr_movimiento_almacen
str_movimiento_almacen_traspaso_bultos lstr_movimiento_almacen_traspaso_bultos

long ll_indice,ll_total
boolean lb_correcto = true

ll_total  = uo_lectura_origen.ii_lineas_bulto

if uo_lectura_origen.ii_bultos = 1 then
	for ll_indice = 1 to ll_total
		if uo_lectura_origen.f_setrow(ll_indice) > 0 then
			/* Traspaso linea a linea que cambia el id de las lineas
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
				lstr_movimiento_almacen.id_alm_bultos		 = uo_lectura_origen.il_id_bulto
				
				if f_movimiento_almacen(lstr_movimiento_almacen) then

				else
					lb_correcto = false					
				end if
			else
				lb_correcto = false
			end if	
			*/
			lstr_movimiento_almacen_traspaso_bultos.empresa                   = codigo_empresa
			lstr_movimiento_almacen_traspaso_bultos.articulo                  = uo_lectura_origen.is_codigo_articulo
			lstr_movimiento_almacen_traspaso_bultos.calidad                   = uo_lectura_origen.is_codigo_calidad
			lstr_movimiento_almacen_traspaso_bultos.tono                      = uo_lectura_origen.is_lote
			lstr_movimiento_almacen_traspaso_bultos.calibre                   = uo_lectura_origen.ii_calibre
			lstr_movimiento_almacen_traspaso_bultos.tipo_pallet               = uo_lectura_origen.is_codigo_pallet
			lstr_movimiento_almacen_traspaso_bultos.caja                      = uo_lectura_origen.is_codigo_caja
			lstr_movimiento_almacen_traspaso_bultos.cantidad                  = -1 * ( uo_lectura_origen.il_piezas )
			lstr_movimiento_almacen_traspaso_bultos.orden_carga_anyo          = uo_lectura_origen.ii_anyo_orden_carga
			lstr_movimiento_almacen_traspaso_bultos.orden_carga_codigo        = uo_lectura_origen.is_orden_carga
			lstr_movimiento_almacen_traspaso_bultos.orden_carga_linea         = uo_lectura_origen.il_linea_orden_carga
			lstr_movimiento_almacen_traspaso_bultos.tipo_movimiento_salida    = is_tipo_movimiento_salida
			lstr_movimiento_almacen_traspaso_bultos.observaciones             = ""
			lstr_movimiento_almacen_traspaso_bultos.almacen_salida            = uo_lectura_origen.is_almacen
			lstr_movimiento_almacen_traspaso_bultos.zona_salida               = uo_lectura_origen.is_zona
			lstr_movimiento_almacen_traspaso_bultos.fila_salida               = uo_lectura_origen.ii_fila
			lstr_movimiento_almacen_traspaso_bultos.altura_salida             = uo_lectura_origen.ii_altura
			lstr_movimiento_almacen_traspaso_bultos.tercero                   = ""
			lstr_movimiento_almacen_traspaso_bultos.documento                 = ""
			lstr_movimiento_almacen_traspaso_bultos.fecha                     = datetime(today())
			lstr_movimiento_almacen_traspaso_bultos.id_ubicacion_salida       = uo_lectura_origen.il_id_ubicacion
			lstr_movimiento_almacen_traspaso_bultos.id_alm_bultos		         = uo_lectura_origen.il_id_bulto		
			lstr_movimiento_almacen_traspaso_bultos.tipo_movimiento_entrada   = is_tipo_movimiento_entrada
			lstr_movimiento_almacen_traspaso_bultos.almacen_entrada           = uo_lectura_destino.is_almacen
			lstr_movimiento_almacen_traspaso_bultos.zona_entrada              = uo_lectura_destino.is_zona
			lstr_movimiento_almacen_traspaso_bultos.fila_entrada              = uo_lectura_destino.ii_fila
			lstr_movimiento_almacen_traspaso_bultos.altura_entrada            = uo_lectura_destino.ii_altura			
			lstr_movimiento_almacen_traspaso_bultos.id_ubicacion_entrada      = uo_lectura_destino.il_id_ubicacion
			
			if not(f_movimiento_almacen_traspaso_bultos(lstr_movimiento_almacen_traspaso_bultos)) then
				lb_correcto = false
			end if			
			
		else
			lb_correcto = false
		end if

	next

	if lb_correcto then
		commit;
		uo_lectura_origen.f_reset()
		uo_lectura_destino.f_reset()
	else
		rollback;
		Messagebox("Error","No se ha generado el movimiento")
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

type uo_lectura_destino from u_sle_codbar within rf_param_traspasos_bultos
integer y = 1096
integer taborder = 20
boolean ib_mostrar_desplegado = true
boolean ib_permitir_desplegar = false
string is_descripcion = "LECTURA DESTINO"
end type

on uo_lectura_destino.destroy
call u_sle_codbar::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;ii_paso_actual = 3

pb_aceptar.visible         = true
pb_aceptar.SetFocus()
end event

event getfocus;call super::getfocus;ii_paso_actual = 2

st_paso1.backcolor         = il_color_fondo_inactivo
st_paso2.backcolor         = il_color_fondo_activo

pb_atras.visible           = true
pb_aceptar.visible         = false
end event

event modified;call super::modified;boolean lb_control_ubicacion_pasado = false

if il_id_ubicacion = 0 then
	f_reset()
	messagebox("¡Atención!","Debe seleccionar una ubicación de destino.",StopSign!)
	this.SetFocus()
	this.event getfocus()	
else

	if istr_rf_parametros_ventanas.entrada_ubicacion_fija = 'S' then
		if istr_rf_parametros_ventanas.almacen_entrada        = is_almacen and &
			istr_rf_parametros_ventanas.zona_entrada           = is_zona    and &
			istr_rf_parametros_ventanas.fila_entrada           = ii_fila    and &
			istr_rf_parametros_ventanas.altura_entrada         = ii_altura then
			
			lb_control_ubicacion_pasado = true
		else
			lb_control_ubicacion_pasado = false
			messagebox("¡Atención!","Destino Fijo "+istr_rf_parametros_ventanas.almacen_entrada+"-"+istr_rf_parametros_ventanas.zona_entrada+"-"+string(istr_rf_parametros_ventanas.fila_entrada)+"-"+string(istr_rf_parametros_ventanas.altura_entrada),StopSign!)	
			this.f_reset()
			this.event getfocus()		
		end if
	else
		lb_control_ubicacion_pasado = true		
	end if

	if lb_control_ubicacion_pasado then
		if ib_ubicacion_con_bulto_asociado and istr_rf_parametros_ventanas.permitir_en_bulto_de_ubicacion = 'N' then
			f_reset()
			Messagebox("Error","Ha seleccionado un bulto de destino asociado a una ubicación.~nNo se permite hacer un traspaso de ubicación.")
			this.SetFocus()
			this.event getfocus()					
		end if
	end if
end if
end event

type uo_lectura_origen from u_sle_codbar within rf_param_traspasos_bultos
integer y = 168
integer taborder = 10
boolean ib_mostrar_desplegado = true
boolean ib_permitir_desplegar = false
string is_descripcion = "LECTURA ORIGEN"
end type

on uo_lectura_origen.destroy
call u_sle_codbar::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;/*
this.il_id_ubicacion
this.is_almacen
this.is_zona
this.ii_fila
this.ii_altura
*/
//Ubicacion provisional de las entradas de produccion
//is_almacen = '7'
//is_zona = 'A'
//ii_fila = 1
//ii_altura = 1

if istr_rf_parametros_ventanas.sugerir_ubicacion_entrada = 'S' and not(istr_rf_parametros_ventanas.entrada_ubicacion_fija = 'S') then
	uo_lectura_destino.f_sugerir_ubicacion_destino(this)
end if
//if this.is_almacen = '8' and this.is_zona = 'A' and this.ii_fila = 1 and this.ii_altura = 1 then
//	uo_lectura_destino.f_sugerir_ubicacion_destino(this)
//end if

uo_lectura_destino.visible = true

uo_lectura_destino.SetFocus()
uo_lectura_destino.event getfocus()
end event

event getfocus;call super::getfocus;ii_paso_actual = 1

st_paso1.backcolor         = il_color_fondo_activo
st_paso2.backcolor         = il_color_fondo_inactivo

uo_lectura_destino.visible = false
pb_atras.visible           = false
pb_aceptar.visible         = false

if istr_rf_parametros_ventanas.salida_ubicacion_fija = 'S' then
	string ls_ean_13
	
	select isnull(almubimapa_codbar.ean13,'') 
	into   :ls_ean_13
	from   almubimapa_codbar 
	where  almubimapa_codbar.empresa = :codigo_empresa 
	and    almubimapa_codbar.almacen = :istr_rf_parametros_ventanas.almacen_salida
	and    almubimapa_codbar.zona    = :istr_rf_parametros_ventanas.zona_salida
	and    almubimapa_codbar.fila    = :istr_rf_parametros_ventanas.fila_salida
	and    almubimapa_codbar.altura  = :istr_rf_parametros_ventanas.altura_salida;
	
	if trim(ls_ean_13) <> "" and trim(ls_ean_13) <> this.sle_codbar.text then
		ib_ubicacion_origen_fija = false
		this.sle_codbar.text = ls_ean_13
		this.sle_codbar.event modified()
		ib_ubicacion_origen_fija = true
	end if
end if
end event

event modified;call super::modified;boolean lb_control_ubicacion_pasado = false

if il_id_bulto = 0 then
	f_reset()
	messagebox("¡Atención!","Debe seleccionar un bulto.",StopSign!)
	this.SetFocus()
	this.event getfocus()	
else

	if istr_rf_parametros_ventanas.salida_ubicacion_fija = 'S' then
		if istr_rf_parametros_ventanas.almacen_salida        = is_almacen and &
			istr_rf_parametros_ventanas.zona_salida           = is_zona    and &
			istr_rf_parametros_ventanas.fila_salida           = ii_fila    and &
			istr_rf_parametros_ventanas.altura_salida         = ii_altura then
			
			lb_control_ubicacion_pasado = true
		else
			lb_control_ubicacion_pasado = false
			messagebox("¡Atención!","Debe seleccionar un bulto en "+istr_rf_parametros_ventanas.almacen_salida+"-"+istr_rf_parametros_ventanas.zona_salida+"-"+string(istr_rf_parametros_ventanas.fila_salida)+"-"+string(istr_rf_parametros_ventanas.altura_salida),StopSign!)	
			this.f_reset()
			this.event getfocus()		
		end if
	else
		lb_control_ubicacion_pasado = true
	end if

	if lb_control_ubicacion_pasado then
		if ib_ubicacion_con_bulto_asociado and istr_rf_parametros_ventanas.permitir_en_bulto_de_ubicacion = 'N' then
			f_reset()
			Messagebox("Error","Ha seleccionado un bulto de origen asociado a una ubicación.~nNo se permite hacer un traspaso de ubicación.")
			this.SetFocus()
			this.event getfocus()					
		else
			if ii_bultos > 1 then
				Messagebox("Error","Ha seleccionado un origen con mas de un bulto~nDebe hacer la lectura de la etiqueta del bulto.")
				this.SetFocus()
				this.event getfocus()			
			end if	
		end if
	end if
end if
end event

