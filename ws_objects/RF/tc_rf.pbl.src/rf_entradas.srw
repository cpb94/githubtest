$PBExportHeader$rf_entradas.srw
forward
global type rf_entradas from window
end type
type p_ayuda_ventana from picture within rf_entradas
end type
type pb_1 from picturebutton within rf_entradas
end type
type pb_atras from picturebutton within rf_entradas
end type
type st_paso1 from statictext within rf_entradas
end type
type st_paso2 from statictext within rf_entradas
end type
type pb_aceptar from picturebutton within rf_entradas
end type
type pb_menos_piezas from picturebutton within rf_entradas
end type
type pb_menos_cajas from picturebutton within rf_entradas
end type
type pb_menos_pallet from picturebutton within rf_entradas
end type
type pb_mas_piezas from picturebutton within rf_entradas
end type
type pb_mas_cajas from picturebutton within rf_entradas
end type
type pb_mas_pallet from picturebutton within rf_entradas
end type
type em_piezas from editmask within rf_entradas
end type
type em_cajas from editmask within rf_entradas
end type
type em_pallets from editmask within rf_entradas
end type
type st_piezas from statictext within rf_entradas
end type
type st_cajas from statictext within rf_entradas
end type
type st_pallets from statictext within rf_entradas
end type
type st_paso3 from statictext within rf_entradas
end type
type uo_lectura_pallet from u_sle_codbar within rf_entradas
end type
type uo_lectura_caja from u_sle_codbar within rf_entradas
end type
end forward

global type rf_entradas from window
integer width = 4718
integer height = 2904
boolean titlebar = true
string title = "MONTAR BULTO PRODUCCIÓN"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
p_ayuda_ventana p_ayuda_ventana
pb_1 pb_1
pb_atras pb_atras
st_paso1 st_paso1
st_paso2 st_paso2
pb_aceptar pb_aceptar
pb_menos_piezas pb_menos_piezas
pb_menos_cajas pb_menos_cajas
pb_menos_pallet pb_menos_pallet
pb_mas_piezas pb_mas_piezas
pb_mas_cajas pb_mas_cajas
pb_mas_pallet pb_mas_pallet
em_piezas em_piezas
em_cajas em_cajas
em_pallets em_pallets
st_piezas st_piezas
st_cajas st_cajas
st_pallets st_pallets
st_paso3 st_paso3
uo_lectura_pallet uo_lectura_pallet
uo_lectura_caja uo_lectura_caja
end type
global rf_entradas rf_entradas

type variables
string is_tipo_movimiento = '1'
string is_almacen = '8'
string is_zona = 'A'
int    ii_fila = 1
int    ii_altura = 1
long   il_color_fondo_activo,il_color_fondo_inactivo
int    ii_paso_actual = 1
str_parametros istr_parametros
str_rf_parametros_ventanas istr_rf_parametros_ventanas
end variables

forward prototypes
public function boolean f_salida_cajas (str_movimiento_almacen arg_str_movimiento_almacen)
end prototypes

public function boolean f_salida_cajas (str_movimiento_almacen arg_str_movimiento_almacen);boolean lb_rtn = true
string ls_caja_ventas,ls_articulo
long   ll_cajas_entrada

str_movimiento_almacen lstr_movimiento_almacen

ls_caja_ventas = arg_str_movimiento_almacen.caja
ls_articulo    = f_codigo_ventas_caja( codigo_empresa, ls_caja_ventas )

if trim(ls_articulo) <> "" then
	lstr_movimiento_almacen.empresa            = codigo_empresa
	lstr_movimiento_almacen.articulo           = ls_articulo
	lstr_movimiento_almacen.calidad            = "0"
	lstr_movimiento_almacen.tono               = ""
	lstr_movimiento_almacen.calibre            = 0
	lstr_movimiento_almacen.tipo_pallet        = "2"
	lstr_movimiento_almacen.caja               = "0"
	lstr_movimiento_almacen.cantidad           = dec(em_cajas.text) * -1
	lstr_movimiento_almacen.orden_carga_anyo   = 0
	lstr_movimiento_almacen.orden_carga_codigo = ""
	lstr_movimiento_almacen.orden_carga_linea  = 0
	lstr_movimiento_almacen.tipo_movimiento    = "999"
	lstr_movimiento_almacen.observaciones      = ""
	lstr_movimiento_almacen.almacen            = "7"
	lstr_movimiento_almacen.zona               = "A"
	lstr_movimiento_almacen.fila               = 1
	lstr_movimiento_almacen.altura             = 1
	lstr_movimiento_almacen.tercero            = ""
	lstr_movimiento_almacen.documento          = ""
	lstr_movimiento_almacen.fecha              = arg_str_movimiento_almacen.fecha
	lstr_movimiento_almacen.id_ubicacion       = 0
	lstr_movimiento_almacen.id_alm_bultos		 = 1//0 Siempre sacaremos el stock del bulto 1
	
	if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
		lb_rtn = false
	end if
end if

return lb_rtn



end function

on rf_entradas.create
this.p_ayuda_ventana=create p_ayuda_ventana
this.pb_1=create pb_1
this.pb_atras=create pb_atras
this.st_paso1=create st_paso1
this.st_paso2=create st_paso2
this.pb_aceptar=create pb_aceptar
this.pb_menos_piezas=create pb_menos_piezas
this.pb_menos_cajas=create pb_menos_cajas
this.pb_menos_pallet=create pb_menos_pallet
this.pb_mas_piezas=create pb_mas_piezas
this.pb_mas_cajas=create pb_mas_cajas
this.pb_mas_pallet=create pb_mas_pallet
this.em_piezas=create em_piezas
this.em_cajas=create em_cajas
this.em_pallets=create em_pallets
this.st_piezas=create st_piezas
this.st_cajas=create st_cajas
this.st_pallets=create st_pallets
this.st_paso3=create st_paso3
this.uo_lectura_pallet=create uo_lectura_pallet
this.uo_lectura_caja=create uo_lectura_caja
this.Control[]={this.p_ayuda_ventana,&
this.pb_1,&
this.pb_atras,&
this.st_paso1,&
this.st_paso2,&
this.pb_aceptar,&
this.pb_menos_piezas,&
this.pb_menos_cajas,&
this.pb_menos_pallet,&
this.pb_mas_piezas,&
this.pb_mas_cajas,&
this.pb_mas_pallet,&
this.em_piezas,&
this.em_cajas,&
this.em_pallets,&
this.st_piezas,&
this.st_cajas,&
this.st_pallets,&
this.st_paso3,&
this.uo_lectura_pallet,&
this.uo_lectura_caja}
end on

on rf_entradas.destroy
destroy(this.p_ayuda_ventana)
destroy(this.pb_1)
destroy(this.pb_atras)
destroy(this.st_paso1)
destroy(this.st_paso2)
destroy(this.pb_aceptar)
destroy(this.pb_menos_piezas)
destroy(this.pb_menos_cajas)
destroy(this.pb_menos_pallet)
destroy(this.pb_mas_piezas)
destroy(this.pb_mas_cajas)
destroy(this.pb_mas_pallet)
destroy(this.em_piezas)
destroy(this.em_cajas)
destroy(this.em_pallets)
destroy(this.st_piezas)
destroy(this.st_cajas)
destroy(this.st_pallets)
destroy(this.st_paso3)
destroy(this.uo_lectura_pallet)
destroy(this.uo_lectura_caja)
end on

event open;istr_parametros = Message.PowerObjectParm

IF istr_parametros.i_nargumentos = 2 THEN

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
		
		is_tipo_movimiento = istr_rf_parametros_ventanas.tipo_movimiento_entrada
	
		if istr_rf_parametros_ventanas.entrada_ubicacion_fija = 'S' then
			is_almacen = istr_rf_parametros_ventanas.almacen_entrada
			is_zona    = istr_rf_parametros_ventanas.zona_entrada
			ii_fila    = istr_rf_parametros_ventanas.fila_entrada
			ii_altura  = istr_rf_parametros_ventanas.altura_entrada
		else
			is_almacen = ""
			is_zona    = ""
			ii_fila    = 0
			ii_altura  = 0
		end if
	
		il_color_fondo_activo   = st_paso1.backcolor
		il_color_fondo_inactivo = st_paso2.backcolor
		
		uo_lectura_caja.SetFocus()
		uo_lectura_caja.event getfocus()	
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

type p_ayuda_ventana from picture within rf_entradas
integer x = 18
integer y = 4
integer width = 146
integer height = 144
string picturename = "C:\Fuentes_tencer_PB12\Information_16x16.png"
boolean border = true
boolean focusrectangle = false
end type

type pb_1 from picturebutton within rf_entradas
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

type pb_atras from picturebutton within rf_entradas
integer x = 41
integer y = 2040
integer width = 800
integer height = 700
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
		uo_lectura_caja.SetFocus()
		uo_lectura_caja.event getfocus()
	case 3
		uo_lectura_pallet.SetFocus()
		uo_lectura_pallet.event getfocus()	
	case else
		uo_lectura_caja.SetFocus()
		uo_lectura_caja.event getfocus()		
end choose
end event

type st_paso1 from statictext within rf_entradas
integer x = 169
integer y = 4
integer width = 1381
integer height = 144
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388736
string text = "Caja"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_paso2 from statictext within rf_entradas
integer x = 1554
integer y = 4
integer width = 1381
integer height = 144
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
boolean enabled = false
string text = "Bulto"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_aceptar from picturebutton within rf_entradas
integer x = 3831
integer y = 2040
integer width = 800
integer height = 700
integer taborder = 60
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

/*
//Vamos a comprobar si añadimos cantidad a un pallet
if uo_lectura_pallet.ii_lineas_bulto > 0 then
	if uo_lectura_caja.is_codigo_articulo = uo_lectura_pallet.is_codigo_articulo and &
		uo_lectura_caja.is_codigo_calidad  = uo_lectura_pallet.is_codigo_calidad and &
		uo_lectura_caja.is_lote            = uo_lectura_pallet.is_lote and &
		uo_lectura_caja.ii_calibre         = uo_lectura_pallet.ii_calibre and &
		uo_lectura_caja.is_codigo_caja     = uo_lectura_pallet.is_codigo_caja then
		
		if dec(em_pallets.text) = 1 then
			messagebox("¡Atención!","No se puede añadir un pallet entero a un bulto existente.")
			return 0
		end if
	else
		messagebox("¡Atención!","Deben coincidor las caracteristicas del lote para poder añadir a un bulto existente.")
		return 0
	end if
end if
*/

if dec(em_piezas.text) > 0 then
//	if f_compras_articulo(codigo_empresa,uo_lectura_caja.is_codigo_articulo) = 'S' then
//		is_tipo_movimiento = '3'
//	else
//		is_tipo_movimiento = '1'
//	end if
	
	lstr_movimiento_almacen.empresa            = codigo_empresa
	lstr_movimiento_almacen.articulo           = uo_lectura_caja.is_codigo_articulo
	lstr_movimiento_almacen.calidad            = uo_lectura_caja.is_codigo_calidad
	lstr_movimiento_almacen.tono               = uo_lectura_caja.is_lote
	lstr_movimiento_almacen.calibre            = uo_lectura_caja.ii_calibre
	lstr_movimiento_almacen.tipo_pallet        = uo_lectura_caja.is_codigo_pallet
	lstr_movimiento_almacen.caja               = uo_lectura_caja.is_codigo_caja
	lstr_movimiento_almacen.cantidad           = dec(em_piezas.text)
	lstr_movimiento_almacen.orden_carga_anyo   = 0
	lstr_movimiento_almacen.orden_carga_codigo = ""
	lstr_movimiento_almacen.orden_carga_linea  = 0
	lstr_movimiento_almacen.tipo_movimiento    = is_tipo_movimiento
	lstr_movimiento_almacen.observaciones      = ""
	if uo_lectura_pallet.ii_lineas_bulto > 0 then
		lstr_movimiento_almacen.almacen            = uo_lectura_pallet.is_almacen
		lstr_movimiento_almacen.zona               = uo_lectura_pallet.is_zona
		lstr_movimiento_almacen.fila               = uo_lectura_pallet.ii_fila
		lstr_movimiento_almacen.altura             = uo_lectura_pallet.ii_altura		
	else
		lstr_movimiento_almacen.almacen            = is_almacen
		lstr_movimiento_almacen.zona               = is_zona
		lstr_movimiento_almacen.fila               = ii_fila
		lstr_movimiento_almacen.altura             = ii_altura
	end if
	lstr_movimiento_almacen.tercero            = ""
	lstr_movimiento_almacen.documento          = ""
	lstr_movimiento_almacen.fecha              = datetime(today())
	lstr_movimiento_almacen.id_ubicacion       = 0
	lstr_movimiento_almacen.id_alm_bultos		 = uo_lectura_pallet.il_id_bulto
	
	//Introduce pallet a pallet
	if f_movimiento_almacen(lstr_movimiento_almacen) then
		if f_promocion_articulo(lstr_movimiento_almacen.empresa,lstr_movimiento_almacen.articulo) = "S" then
			commit;
			uo_lectura_pallet.f_reset()			
		else
			if f_salida_cajas(lstr_movimiento_almacen) then
				commit;
				uo_lectura_pallet.f_reset()
			else
				rollback;
				Messagebox("Error","No se ha generado el movimiento")			
			end if
		end if
	else
		rollback;
		Messagebox("Error","No se ha generado el movimiento")
	end if
	
	uo_lectura_caja.SetFocus()
	uo_lectura_caja.event getfocus()
else
	Messagebox("Error","No se ha indicado el numero de piezas")
end if
end event

type pb_menos_piezas from picturebutton within rf_entradas
integer x = 2871
integer y = 2040
integer width = 398
integer height = 328
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\db-Delete.png"
string disabledname = "C:\bmp\RF\db-Delete_dis.png"
alignment htextalign = left!
end type

event clicked;string ls_minmax,ls_min,ls_max
long   ll_min,ll_max,ll_pos,ll_valor,ll_nuevo_valor

ls_minmax = em_piezas.minmax

ll_pos = pos(ls_minmax,"~~")
if ll_pos > 0 then
	ls_min = mid(ls_minmax,1,ll_pos -1)
	ls_max = mid(ls_minmax,ll_pos +1,len(ls_minmax)- ll_pos)
	
	ll_min = long(ls_min)
	ll_max = long(ls_max)
else
	ll_min = 0
	ll_max = 0
end if

ll_valor = long(em_piezas.text)

if (ll_valor - 1) >= ll_min then
	em_piezas.text = string((ll_valor - 1),em_piezas.mask)
	em_piezas.event modified()
end if
end event

type pb_menos_cajas from picturebutton within rf_entradas
integer x = 1938
integer y = 2040
integer width = 398
integer height = 328
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\db-Delete.png"
string disabledname = "C:\bmp\RF\db-Delete_dis.png"
alignment htextalign = left!
end type

event clicked;string ls_minmax,ls_min,ls_max
long   ll_min,ll_max,ll_pos,ll_valor,ll_nuevo_valor

ls_minmax = em_cajas.minmax

ll_pos = pos(ls_minmax,"~~")
if ll_pos > 0 then
	ls_min = mid(ls_minmax,1,ll_pos -1)
	ls_max = mid(ls_minmax,ll_pos +1,len(ls_minmax)- ll_pos)
	
	ll_min = long(ls_min)
	ll_max = long(ls_max)
else
	ll_min = 0
	ll_max = 0
end if

ll_valor = long(em_cajas.text)

if (ll_valor - 1) >= ll_min then
	em_cajas.text = string((ll_valor - 1),em_cajas.mask)
	em_cajas.event modified()
end if
end event

type pb_menos_pallet from picturebutton within rf_entradas
integer x = 978
integer y = 2040
integer width = 398
integer height = 328
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\db-Delete.png"
string disabledname = "C:\bmp\RF\db-Delete_dis.png"
alignment htextalign = left!
end type

event clicked;string ls_minmax,ls_min,ls_max
long   ll_min,ll_max,ll_pos,ll_valor,ll_nuevo_valor

ls_minmax = em_pallets.minmax

ll_pos = pos(ls_minmax,"~~")
if ll_pos > 0 then
	ls_min = mid(ls_minmax,1,ll_pos -1)
	ls_max = mid(ls_minmax,ll_pos +1,len(ls_minmax)- ll_pos)
	
	ll_min = long(ls_min)
	ll_max = long(ls_max)
else
	ll_min = 0
	ll_max = 0
end if

ll_valor = long(em_pallets.text)

if (ll_valor - 1) >= ll_min then
	em_pallets.text = string((ll_valor - 1),em_pallets.mask)
	em_pallets.event modified()
end if
end event

type pb_mas_piezas from picturebutton within rf_entradas
integer x = 3282
integer y = 2040
integer width = 398
integer height = 328
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = " "
string picturename = "C:\bmp\RF\db-Add.png"
string disabledname = "C:\bmp\RF\db-Add_dis.png"
alignment htextalign = left!
end type

event clicked;string ls_minmax,ls_min,ls_max
long   ll_min,ll_max,ll_pos,ll_valor,ll_nuevo_valor

ls_minmax = em_piezas.minmax

ll_pos = pos(ls_minmax,"~~")
if ll_pos > 0 then
	ls_min = mid(ls_minmax,1,ll_pos -1)
	ls_max = mid(ls_minmax,ll_pos +1,len(ls_minmax)- ll_pos)
	
	ll_min = long(ls_min)
	ll_max = long(ls_max)
else
	ll_min = 0
	ll_max = 0
end if

ll_valor = long(em_piezas.text)

if (ll_valor + 1) <= ll_max then
	em_piezas.text = string((ll_valor + 1),em_piezas.mask)
	em_piezas.event modified()
end if
end event

type pb_mas_cajas from picturebutton within rf_entradas
integer x = 2350
integer y = 2040
integer width = 398
integer height = 328
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = " "
string picturename = "C:\bmp\RF\db-Add.png"
string disabledname = "C:\bmp\RF\db-Add_dis.png"
alignment htextalign = left!
end type

event clicked;string ls_minmax,ls_min,ls_max
long   ll_min,ll_max,ll_pos,ll_valor,ll_nuevo_valor

ls_minmax = em_cajas.minmax

ll_pos = pos(ls_minmax,"~~")
if ll_pos > 0 then
	ls_min = mid(ls_minmax,1,ll_pos -1)
	ls_max = mid(ls_minmax,ll_pos +1,len(ls_minmax)- ll_pos)
	
	ll_min = long(ls_min)
	ll_max = long(ls_max)
else
	ll_min = 0
	ll_max = 0
end if

ll_valor = long(em_cajas.text)

if (ll_valor + 1) <= ll_max then
	em_cajas.text = string((ll_valor + 1),em_cajas.mask)
	em_cajas.event modified()
end if
end event

type pb_mas_pallet from picturebutton within rf_entradas
integer x = 1390
integer y = 2040
integer width = 398
integer height = 328
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = " "
string picturename = "C:\bmp\RF\db-Add.png"
string disabledname = "C:\bmp\RF\db-Add_dis.png"
alignment htextalign = left!
end type

event clicked;string ls_minmax,ls_min,ls_max
long   ll_min,ll_max,ll_pos,ll_valor,ll_nuevo_valor

ls_minmax = em_pallets.minmax

ll_pos = pos(ls_minmax,"~~")
if ll_pos > 0 then
	ls_min = mid(ls_minmax,1,ll_pos -1)
	ls_max = mid(ls_minmax,ll_pos +1,len(ls_minmax)- ll_pos)
	
	ll_min = long(ls_min)
	ll_max = long(ls_max)
else
	ll_min = 0
	ll_max = 0
end if

ll_valor = long(em_pallets.text)

if (ll_valor + 1) <= ll_max then
	em_pallets.text = string((ll_valor + 1),em_pallets.mask)
	em_pallets.event modified()
end if
end event

type em_piezas from editmask within rf_entradas
event clicked pbm_bnclicked
integer x = 2871
integer y = 2572
integer width = 805
integer height = 168
integer taborder = 50
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "######0"
boolean autoskip = true
double increment = 1
string minmax = "0~~9999"
end type

event losefocus;this.event modified()
end event

event modified;string cadena,ls_articulos_unidad,ls_codigo_articulo,ls_codigo_caja,ls_m2 
dec    ld_metroscaja,ld_m2
int    posi_aux,posi,li_piezas,li_piezascaja

//Control de rango
string ls_minmax,ls_min,ls_max
long   ll_min,ll_max,ll_pos,ll_valor,ll_nuevo_valor

ls_minmax = this.minmax

ll_pos = pos(ls_minmax,"~~")
if ll_pos > 0 then
	ls_min = mid(ls_minmax,1,ll_pos -1)
	ls_max = mid(ls_minmax,ll_pos +1,len(ls_minmax)- ll_pos)
	
	ll_min = long(ls_min)
	ll_max = long(ls_max)
else
	ll_min = 0
	ll_max = 0
end if

ll_valor = long(this.text)

if ll_valor > ll_max then
	this.text = string(0,this.mask)
else
	if ll_valor < ll_min then
		this.text = string(0,this.mask)		
	end if	
end if
//Fin de control de rango

if integer(this.text) > 0 then
	li_piezas = dec(this.text)
	
	ls_codigo_articulo = uo_lectura_caja.is_codigo_articulo
	ls_codigo_caja     = uo_lectura_caja.is_codigo_caja
	
	SELECT isnull(articulos.unidad,''),
			 isnull(almartcajas.metroscaja,0), 
			 isnull(almartcajas.piezascaja,0) 
	INTO   :ls_articulos_unidad,
			 :ld_metroscaja,
			 :li_piezascaja
	FROM   articulos,almartcajas 
	WHERE  almartcajas.empresa  = articulos.empresa 
	AND    almartcajas.articulo = articulos.codigo 
	AND    almartcajas.empresa  = :codigo_empresa 
	AND    almartcajas.articulo = :ls_codigo_articulo 
	AND    almartcajas.caja     = :ls_codigo_caja;
	
	if ls_articulos_unidad = '1' then
		ld_m2 = (li_piezas / li_piezascaja) * ld_metroscaja
		
		cadena = f_calculo_unidades_piezas(codigo_empresa,uo_lectura_caja.is_codigo_articulo,&
										  uo_lectura_caja.is_codigo_pallet,&
										  uo_lectura_caja.is_codigo_caja,&
										  0,&
										  0,ld_m2, "")
	else
		cadena = f_calculo_unidades_piezas(codigo_empresa,uo_lectura_caja.is_codigo_articulo,&
										  uo_lectura_caja.is_codigo_pallet,&
										  uo_lectura_caja.is_codigo_caja,&
										  0,&
										  0,li_piezas, "")
	end if
								 
	//Pallets
	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		em_pallets.text     = Mid(cadena,1,posi - 1)
		posi_aux = posi + 1
	end if
	//Cajas de pico
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
		//em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
	//Total cajas
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		em_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
	//Unidades
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		posi_aux = posi + 1
	end if
	//Metros Lineales
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		posi_aux = posi + 1
	end if
	//Unidades
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		if uo_lectura_pallet.ib_ubicacion_gestionada_en_piezas then
			em_piezas.text      = string(li_piezas)
		else
			em_piezas.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
			posi_aux = posi + 1
		end if		
	end if
else
	em_pallets.text     = "0"
	em_cajas.text       = "0"
end if
end event

event getfocus;this.SelectText(1,len(this.text))
end event

type em_cajas from editmask within rf_entradas
event clicked pbm_bnclicked
integer x = 1938
integer y = 2572
integer width = 805
integer height = 168
integer taborder = 40
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "######0"
boolean autoskip = true
double increment = 1
string minmax = "0~~9999"
end type

event losefocus;this.event modified()
end event

event modified;string cadena 
int    posi_aux,posi

//Control de rango
string ls_minmax,ls_min,ls_max
long   ll_min,ll_max,ll_pos,ll_valor,ll_nuevo_valor

ls_minmax = this.minmax

ll_pos = pos(ls_minmax,"~~")
if ll_pos > 0 then
	ls_min = mid(ls_minmax,1,ll_pos -1)
	ls_max = mid(ls_minmax,ll_pos +1,len(ls_minmax)- ll_pos)
	
	ll_min = long(ls_min)
	ll_max = long(ls_max)
else
	ll_min = 0
	ll_max = 0
end if

ll_valor = long(this.text)

if ll_valor > ll_max then
	this.text = string(0,this.mask)
else
	if ll_valor < ll_min then
		this.text = string(0,this.mask)		
	end if	
end if
//Fin de control de rango

if integer(this.text) > 0 then
	cadena = f_calculo_unidades_piezas(codigo_empresa,uo_lectura_caja.is_codigo_articulo,&
									  uo_lectura_caja.is_codigo_pallet,&
									  uo_lectura_caja.is_codigo_caja,&
									  0,&
									  integer(this.text),0, "")
								 
	//Pallets
	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		em_pallets.text     = Mid(cadena,1,posi - 1)
		posi_aux = posi + 1
	end if
	//Cajas de pico
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
		//em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
	//Total cajas
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		em_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
	//Unidades
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		posi_aux = posi + 1
	end if
	//Metros Lineales
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		posi_aux = posi + 1
	end if
	//Unidades
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		em_piezas.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
else
	em_pallets.text     = "0"
	em_piezas.text      = "0"
end if
end event

event getfocus;this.SelectText(1,len(this.text))
end event

type em_pallets from editmask within rf_entradas
event clicked pbm_bnclicked
integer x = 978
integer y = 2572
integer width = 805
integer height = 168
integer taborder = 30
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0"
boolean autoskip = true
double increment = 1
string minmax = "0~~1"
end type

event clicked;this.event modified()
end event

event losefocus;this.event modified()
end event

event modified;string cadena
int    posi_aux,posi

//Control de rango
string ls_minmax,ls_min,ls_max
long   ll_min,ll_max,ll_pos,ll_valor,ll_nuevo_valor

ls_minmax = this.minmax

ll_pos = pos(ls_minmax,"~~")
if ll_pos > 0 then
	ls_min = mid(ls_minmax,1,ll_pos -1)
	ls_max = mid(ls_minmax,ll_pos +1,len(ls_minmax)- ll_pos)
	
	ll_min = long(ls_min)
	ll_max = long(ls_max)
else
	ll_min = 0
	ll_max = 0
end if

ll_valor = long(this.text)

if ll_valor > ll_max then
	this.text = string(0,this.mask)
else
	if ll_valor < ll_min then
		this.text = string(0,this.mask)		
	end if	
end if
//Fin de control de rango

if integer(this.text) > 0 then
	
	cadena = f_calculo_unidades_piezas(codigo_empresa,uo_lectura_caja.is_codigo_articulo,&
									  uo_lectura_caja.is_codigo_pallet,&
									  uo_lectura_caja.is_codigo_caja,&
									  integer(this.text),&
									  0,0, "")
								 
	//Pallets
	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		em_pallets.text     = Mid(cadena,1,posi - 1)
		posi_aux = posi + 1
	end if
	//Cajas de pico
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
		//em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
	//Total cajas
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		em_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
	//Unidades
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		posi_aux = posi + 1
	end if
	//Metros Lineales
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		posi_aux = posi + 1
	end if
	//Unidades
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		em_piezas.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
else
	em_cajas.text       = "0"
	em_piezas.text      = "0"
end if
end event

event getfocus;this.SelectText(1,len(this.text))
end event

type st_piezas from statictext within rf_entradas
integer x = 2871
integer y = 2388
integer width = 809
integer height = 168
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24011603
string text = "Piezas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_cajas from statictext within rf_entradas
integer x = 1938
integer y = 2388
integer width = 809
integer height = 168
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24011603
string text = "Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_pallets from statictext within rf_entradas
integer x = 978
integer y = 2384
integer width = 809
integer height = 168
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24011603
string text = "Pallets"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_paso3 from statictext within rf_entradas
integer x = 2939
integer y = 4
integer width = 1381
integer height = 144
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
string text = "Cantidad"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_lectura_pallet from u_sle_codbar within rf_entradas
event destroy ( )
integer y = 1096
boolean ib_permitir_desplegar = false
string is_descripcion = "LECTURA BULTO"
end type

on uo_lectura_pallet.destroy
call u_sle_codbar::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;ii_paso_actual = 3
em_pallets.setfocus()

st_paso1.backcolor        = il_color_fondo_inactivo
st_paso2.backcolor        = il_color_fondo_inactivo
st_paso3.backcolor        = il_color_fondo_activo

pb_atras.visible          = true
st_pallets.visible        = true
em_pallets.visible        = true
pb_mas_pallet.visible     = true
pb_menos_pallet.visible   = true
st_cajas.visible          = true
em_cajas.visible          = true
pb_mas_cajas.visible      = true
pb_menos_cajas.visible    = true
st_piezas.visible         = true
em_piezas.visible         = true
pb_mas_piezas.visible      = true
pb_menos_piezas.visible    = true
pb_aceptar.visible        = true
//pb_atras.enabled = true
end event

event ue_anterior_objeto;call super::ue_anterior_objeto;uo_lectura_caja.SetFocus()
uo_lectura_caja.event getfocus()
end event

event getfocus;call super::getfocus;ii_paso_actual = 2

st_paso1.backcolor        = il_color_fondo_inactivo
st_paso2.backcolor        = il_color_fondo_activo
st_paso3.backcolor        = il_color_fondo_inactivo

pb_atras.visible          = true
st_pallets.visible        = false
em_pallets.visible        = false
pb_mas_pallet.visible     = false
pb_menos_pallet.visible   = false
st_cajas.visible          = false
em_cajas.visible          = false
pb_mas_cajas.visible      = false
pb_menos_cajas.visible    = false
st_piezas.visible         = false
em_piezas.visible         = false
pb_mas_piezas.visible     = false
pb_menos_piezas.visible   = false
pb_aceptar.visible        = false

//pb_atras.enabled = true
end event

event modified;call super::modified;boolean lb_control_ubicacion_pasado = false
	
//Control de si he leido una ubicacion con bulto asociado

//if istr_rf_parametros_ventanas.entrada_ubicacion_fija = 'S' then
//	if istr_rf_parametros_ventanas.almacen_entrada        = is_almacen and &
//		istr_rf_parametros_ventanas.zona_entrada           = is_zona    and &
//		istr_rf_parametros_ventanas.fila_entrada           = ii_fila    and &
//		istr_rf_parametros_ventanas.altura_entrada         = ii_altura then
//		lb_control_ubicacion_pasado = true
//	else
//		lb_control_ubicacion_pasado = false
//	end if
//else
	lb_control_ubicacion_pasado = true
//end if

//istr_rf_parametros_ventanas.permitir_en_bulto_con_lineas
//istr_rf_parametros_ventanas.permitir_en_bulto_de_ubicacion

if lb_control_ubicacion_pasado then
	if ib_ubicacion_con_bulto_asociado and istr_rf_parametros_ventanas.permitir_en_bulto_de_ubicacion = 'N' then
		f_reset()
		messagebox("¡Atención!","Debe seleccionar un bulto.~nNo se puede seleccionar una ubicación.",StopSign!)	
		uo_lectura_pallet.SetFocus()
		uo_lectura_pallet.event getfocus()		
	else
		if ii_lineas_bulto > 0 and istr_rf_parametros_ventanas.permitir_en_bulto_con_lineas = 'N' then
			f_reset()
			messagebox("¡Atención!","Debe seleccionar un bulto sin contenido.",StopSign!)	
			uo_lectura_pallet.SetFocus()
			uo_lectura_pallet.event getfocus()	
		else
			if il_id_bulto = 0 then
				f_reset()
				messagebox("¡Atención!","Debe seleccionar un bulto.",StopSign!)
				uo_lectura_pallet.SetFocus()
				uo_lectura_pallet.event getfocus()			
			end if
		end if
	end if
else
	messagebox("¡Atención!","Debe seleccionar un bulto en "+istr_rf_parametros_ventanas.almacen_entrada+"-"+istr_rf_parametros_ventanas.zona_entrada+"-"+string(istr_rf_parametros_ventanas.fila_entrada)+"-"+string(istr_rf_parametros_ventanas.altura_entrada),StopSign!)	
end if
end event

type uo_lectura_caja from u_sle_codbar within rf_entradas
event destroy ( )
integer y = 168
integer taborder = 10
string is_tipo_codigo = "EAN128"
boolean ib_permitir_ir_atras = false
boolean ib_mostrar_desplegado = true
boolean ib_permitir_desplegar = false
string is_descripcion = "LECTURA CAJA"
end type

on uo_lectura_caja.destroy
call u_sle_codbar::destroy
end on

event modified;call super::modified;string ls_articulo,ls_pallet,ls_caja
int   li_piezas_caja
long   ll_piezas_pallet, li_cajas_pallet

if this.is_codigo_articulo <> "" then
	em_pallets.text = "0"
	em_cajas.text   = "0"
	em_piezas.text  = "0"
	
	ls_articulo = uo_lectura_caja.is_codigo_articulo
	ls_pallet   = uo_lectura_caja.is_codigo_pallet
	ls_caja     = uo_lectura_caja.is_codigo_caja
	
	select isnull(almartcajas.piezascaja,0),
			 isnull(palarticulo.cajaspallet,0),
			 isnull(palarticulo.cajaspallet,0) * isnull(almartcajas.piezascaja,0) 
	into   :li_piezas_caja,
			 :li_cajas_pallet,
			 :ll_piezas_pallet 
	from   almartcajas,palarticulo
	where  almartcajas.empresa  = palarticulo.empresa 
	and    almartcajas.articulo = palarticulo.articulo 
	and    almartcajas.caja     = palarticulo.caja 
	and    almartcajas.empresa  = :codigo_empresa 
	and    almartcajas.articulo = :ls_articulo 
	and    almartcajas.caja     = :ls_caja 
	and    palarticulo.codigo   = :ls_pallet;
	
	em_cajas.minmax = "0~~"+string(li_cajas_pallet,"##0")
	em_piezas.minmax = "0~~"+string(ll_piezas_pallet,"####0")
	
	em_pallets.text  = string(1,em_pallets.mask)
	em_cajas.text    = string(li_cajas_pallet,em_cajas.mask)
	em_piezas.text   = string(ll_piezas_pallet,em_piezas.mask)

	if istr_rf_parametros_ventanas.tipologia_articulo <> "TODAS" then
		if istr_rf_parametros_ventanas.tipologia_articulo = "PROMOCION" and this.istr_articulos.promocion <> "S" then
			messagebox("¡Atención!","Proceso solo permitido para articulos de promoción")
			this.f_reset()
			this.event getfocus()
		else
			if istr_rf_parametros_ventanas.tipologia_articulo = "NO PROMOCION" and this.istr_articulos.promocion <> "N" then			
				messagebox("¡Atención!","Proceso solo permitido para articulos que no sean de promoción")
				this.f_reset()
				this.event getfocus()
			end if		
		end if
	end if
end if
end event

event ue_siguiente_objeto;call super::ue_siguiente_objeto;uo_lectura_pallet.visible = true

uo_lectura_pallet.SetFocus()
uo_lectura_pallet.event getfocus()
end event

event getfocus;call super::getfocus;ii_paso_actual = 1

st_paso1.backcolor        = il_color_fondo_activo
st_paso2.backcolor        = il_color_fondo_inactivo
st_paso3.backcolor        = il_color_fondo_inactivo

uo_lectura_pallet.visible = false
pb_atras.visible          = false
st_pallets.visible        = false
em_pallets.visible        = false
pb_mas_pallet.visible     = false
pb_menos_pallet.visible   = false
st_cajas.visible          = false
em_cajas.visible          = false
pb_mas_cajas.visible      = false
pb_menos_cajas.visible    = false
st_piezas.visible         = false
em_piezas.visible         = false
pb_mas_piezas.visible     = false
pb_menos_piezas.visible   = false
pb_aceptar.visible        = false

//pb_atras.enabled = false
end event

