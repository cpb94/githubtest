$PBExportHeader$rf_devolucion_desde_produccion.srw
forward
global type rf_devolucion_desde_produccion from window
end type
type uo_lectura_destino from u_sle_codbar within rf_devolucion_desde_produccion
end type
type st_pallets from statictext within rf_devolucion_desde_produccion
end type
type st_cajas from statictext within rf_devolucion_desde_produccion
end type
type st_piezas from statictext within rf_devolucion_desde_produccion
end type
type em_pallets from editmask within rf_devolucion_desde_produccion
end type
type em_cajas from editmask within rf_devolucion_desde_produccion
end type
type em_piezas from editmask within rf_devolucion_desde_produccion
end type
type pb_mas_pallet from picturebutton within rf_devolucion_desde_produccion
end type
type pb_mas_cajas from picturebutton within rf_devolucion_desde_produccion
end type
type pb_mas_piezas from picturebutton within rf_devolucion_desde_produccion
end type
type pb_menos_pallet from picturebutton within rf_devolucion_desde_produccion
end type
type pb_menos_cajas from picturebutton within rf_devolucion_desde_produccion
end type
type pb_menos_piezas from picturebutton within rf_devolucion_desde_produccion
end type
type pb_atras from picturebutton within rf_devolucion_desde_produccion
end type
type st_paso3 from statictext within rf_devolucion_desde_produccion
end type
type st_paso1 from statictext within rf_devolucion_desde_produccion
end type
type pb_1 from picturebutton within rf_devolucion_desde_produccion
end type
type pb_aceptar from picturebutton within rf_devolucion_desde_produccion
end type
type uo_lectura_origen from u_sle_codbar within rf_devolucion_desde_produccion
end type
type st_paso2 from statictext within rf_devolucion_desde_produccion
end type
end forward

global type rf_devolucion_desde_produccion from window
integer width = 4718
integer height = 2904
boolean titlebar = true
string title = "Devolución desde Producción"
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
uo_lectura_destino uo_lectura_destino
st_pallets st_pallets
st_cajas st_cajas
st_piezas st_piezas
em_pallets em_pallets
em_cajas em_cajas
em_piezas em_piezas
pb_mas_pallet pb_mas_pallet
pb_mas_cajas pb_mas_cajas
pb_mas_piezas pb_mas_piezas
pb_menos_pallet pb_menos_pallet
pb_menos_cajas pb_menos_cajas
pb_menos_piezas pb_menos_piezas
pb_atras pb_atras
st_paso3 st_paso3
st_paso1 st_paso1
pb_1 pb_1
pb_aceptar pb_aceptar
uo_lectura_origen uo_lectura_origen
st_paso2 st_paso2
end type
global rf_devolucion_desde_produccion rf_devolucion_desde_produccion

type variables
string is_tipo_movimiento_consumo = '209' //SALIDA A PRODUCCION
string is_tipo_movimiento_salida  = '102' //TRASPASO ALMACEN (S)
string is_tipo_movimiento_entrada = '103' //TRASPASO ALMACEN (E)
long   il_color_fondo_activo,il_color_fondo_inactivo
int    ii_paso_actual = 1
string is_almacen_produccion,is_zona_produccion
int    ii_fila_produccion,ii_altura_produccion
end variables

on rf_devolucion_desde_produccion.create
this.uo_lectura_destino=create uo_lectura_destino
this.st_pallets=create st_pallets
this.st_cajas=create st_cajas
this.st_piezas=create st_piezas
this.em_pallets=create em_pallets
this.em_cajas=create em_cajas
this.em_piezas=create em_piezas
this.pb_mas_pallet=create pb_mas_pallet
this.pb_mas_cajas=create pb_mas_cajas
this.pb_mas_piezas=create pb_mas_piezas
this.pb_menos_pallet=create pb_menos_pallet
this.pb_menos_cajas=create pb_menos_cajas
this.pb_menos_piezas=create pb_menos_piezas
this.pb_atras=create pb_atras
this.st_paso3=create st_paso3
this.st_paso1=create st_paso1
this.pb_1=create pb_1
this.pb_aceptar=create pb_aceptar
this.uo_lectura_origen=create uo_lectura_origen
this.st_paso2=create st_paso2
this.Control[]={this.uo_lectura_destino,&
this.st_pallets,&
this.st_cajas,&
this.st_piezas,&
this.em_pallets,&
this.em_cajas,&
this.em_piezas,&
this.pb_mas_pallet,&
this.pb_mas_cajas,&
this.pb_mas_piezas,&
this.pb_menos_pallet,&
this.pb_menos_cajas,&
this.pb_menos_piezas,&
this.pb_atras,&
this.st_paso3,&
this.st_paso1,&
this.pb_1,&
this.pb_aceptar,&
this.uo_lectura_origen,&
this.st_paso2}
end on

on rf_devolucion_desde_produccion.destroy
destroy(this.uo_lectura_destino)
destroy(this.st_pallets)
destroy(this.st_cajas)
destroy(this.st_piezas)
destroy(this.em_pallets)
destroy(this.em_cajas)
destroy(this.em_piezas)
destroy(this.pb_mas_pallet)
destroy(this.pb_mas_cajas)
destroy(this.pb_mas_piezas)
destroy(this.pb_menos_pallet)
destroy(this.pb_menos_cajas)
destroy(this.pb_menos_piezas)
destroy(this.pb_atras)
destroy(this.st_paso3)
destroy(this.st_paso1)
destroy(this.pb_1)
destroy(this.pb_aceptar)
destroy(this.uo_lectura_origen)
destroy(this.st_paso2)
end on

event open;il_color_fondo_activo   = st_paso1.backcolor
il_color_fondo_inactivo = st_paso2.backcolor

st_paso2.text = "Reubicar y hacer salida del resto"//f_nombre_almtipomov(codigo_empresa,is_tipo_movimiento_salida)

is_almacen_produccion = "7"
is_zona_produccion    = "A"
ii_fila_produccion    = 1
ii_altura_produccion  = 1


uo_lectura_origen.SetFocus()
uo_lectura_origen.event getfocus()
end event

type uo_lectura_destino from u_sle_codbar within rf_devolucion_desde_produccion
event destroy ( )
integer y = 1096
integer taborder = 30
boolean ib_mostrar_desplegado = true
boolean ib_permitir_desplegar = false
string is_descripcion = "LECTURA DESTINO"
end type

on uo_lectura_destino.destroy
call u_sle_codbar::destroy
end on

event getfocus;call super::getfocus;ii_paso_actual = 2

st_paso1.backcolor         = il_color_fondo_inactivo
st_paso2.backcolor         = il_color_fondo_activo

pb_atras.visible           = true

end event

event modified;call super::modified;if il_id_ubicacion = 0 then
	f_reset()
	messagebox("¡Atención!","Debe seleccionar una ubicación de destino.",StopSign!)
	this.SetFocus()
	this.event getfocus()	
end if
end event

event ue_siguiente_objeto;call super::ue_siguiente_objeto;pb_aceptar.visible         = true
em_pallets.setfocus()
end event

type st_pallets from statictext within rf_devolucion_desde_produccion
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
boolean enabled = false
string text = "Pallets"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_cajas from statictext within rf_devolucion_desde_produccion
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

type st_piezas from statictext within rf_devolucion_desde_produccion
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

type em_pallets from editmask within rf_devolucion_desde_produccion
event clicked pbm_bnclicked
integer x = 978
integer y = 2572
integer width = 805
integer height = 168
integer taborder = 110
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
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

event getfocus;this.SelectText(1,len(this.text))
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
	
	cadena = f_calculo_unidades_piezas(codigo_empresa,uo_lectura_origen.is_codigo_articulo,&
									  uo_lectura_origen.is_codigo_pallet,&
									  uo_lectura_origen.is_codigo_caja,&
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

type em_cajas from editmask within rf_devolucion_desde_produccion
event clicked pbm_bnclicked
integer x = 1938
integer y = 2572
integer width = 805
integer height = 168
integer taborder = 120
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

event getfocus;this.SelectText(1,len(this.text))
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
	cadena = f_calculo_unidades_piezas(codigo_empresa,uo_lectura_origen.is_codigo_articulo,&
									  uo_lectura_origen.is_codigo_pallet,&
									  uo_lectura_origen.is_codigo_caja,&
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

if uo_lectura_destino.il_id_ubicacion = 0 then
	uo_lectura_destino.setfocus()
	uo_lectura_destino.event getfocus()		
end if
end event

type em_piezas from editmask within rf_devolucion_desde_produccion
event clicked pbm_bnclicked
integer x = 2871
integer y = 2572
integer width = 805
integer height = 168
integer taborder = 130
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

event getfocus;this.SelectText(1,len(this.text))
end event

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
	
	ls_codigo_articulo = uo_lectura_origen.is_codigo_articulo
	ls_codigo_caja     = uo_lectura_origen.is_codigo_caja
	
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
		
		cadena = f_calculo_unidades_piezas(codigo_empresa,uo_lectura_origen.is_codigo_articulo,&
										  uo_lectura_origen.is_codigo_pallet,&
										  uo_lectura_origen.is_codigo_caja,&
										  0,&
										  0,ld_m2, "")
	else
		cadena = f_calculo_unidades_piezas(codigo_empresa,uo_lectura_origen.is_codigo_articulo,&
										  uo_lectura_origen.is_codigo_pallet,&
										  uo_lectura_origen.is_codigo_caja,&
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
		em_piezas.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
else
	em_pallets.text     = "0"
	em_cajas.text       = "0"
end if

if uo_lectura_destino.il_id_ubicacion = 0 then
	uo_lectura_destino.setfocus()
	uo_lectura_destino.event getfocus()		
end if
end event

type pb_mas_pallet from picturebutton within rf_devolucion_desde_produccion
integer x = 1390
integer y = 2040
integer width = 398
integer height = 328
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
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

type pb_mas_cajas from picturebutton within rf_devolucion_desde_produccion
integer x = 2350
integer y = 2040
integer width = 398
integer height = 328
integer taborder = 90
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

type pb_mas_piezas from picturebutton within rf_devolucion_desde_produccion
integer x = 3282
integer y = 2040
integer width = 398
integer height = 328
integer taborder = 100
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

type pb_menos_pallet from picturebutton within rf_devolucion_desde_produccion
integer x = 978
integer y = 2040
integer width = 398
integer height = 328
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
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

type pb_menos_cajas from picturebutton within rf_devolucion_desde_produccion
integer x = 1938
integer y = 2040
integer width = 398
integer height = 328
integer taborder = 60
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

type pb_menos_piezas from picturebutton within rf_devolucion_desde_produccion
integer x = 2871
integer y = 2040
integer width = 398
integer height = 328
integer taborder = 70
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

type pb_atras from picturebutton within rf_devolucion_desde_produccion
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

type st_paso3 from statictext within rf_devolucion_desde_produccion
boolean visible = false
integer x = 2917
integer y = 4
integer width = 1403
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

type st_paso1 from statictext within rf_devolucion_desde_produccion
integer x = 18
integer y = 4
integer width = 1403
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

type pb_1 from picturebutton within rf_devolucion_desde_produccion
integer x = 41
integer y = 2040
integer width = 800
integer height = 700
integer taborder = 40
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

	case else
		uo_lectura_origen.SetFocus()
		uo_lectura_origen.event getfocus()		
end choose
end event

type pb_aceptar from picturebutton within rf_devolucion_desde_produccion
integer x = 3831
integer y = 2040
integer width = 800
integer height = 700
integer taborder = 140
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

long ll_indice,ll_total,ll_piezas_consumo,ll_piezas_traspaso
boolean lb_correcto = true

ll_total  = uo_lectura_origen.ii_lineas_bulto

if uo_lectura_origen.ii_bultos = 1 and uo_lectura_origen.ii_indice_lineas_bulto > 0 then
	if uo_lectura_origen.ii_anyo_orden_carga = 0 and uo_lectura_origen.is_orden_carga = "" then		
		ll_piezas_consumo  = uo_lectura_origen.il_piezas - long(em_piezas.text)
		ll_piezas_traspaso = long(em_piezas.text)
		
		if ll_piezas_traspaso > 0 and uo_lectura_destino.il_id_ubicacion > 0 or ll_piezas_traspaso = 0 then
			if ll_piezas_consumo > 0 then
				lstr_movimiento_almacen.empresa            = codigo_empresa
				lstr_movimiento_almacen.articulo           = uo_lectura_origen.is_codigo_articulo
				lstr_movimiento_almacen.calidad            = uo_lectura_origen.is_codigo_calidad
				lstr_movimiento_almacen.tono               = uo_lectura_origen.is_lote
				lstr_movimiento_almacen.calibre            = uo_lectura_origen.ii_calibre
				lstr_movimiento_almacen.tipo_pallet        = uo_lectura_origen.is_codigo_pallet
				lstr_movimiento_almacen.caja               = uo_lectura_origen.is_codigo_caja
				lstr_movimiento_almacen.cantidad           = -1 * ll_piezas_consumo
				lstr_movimiento_almacen.orden_carga_anyo   = uo_lectura_origen.ii_anyo_orden_carga
				lstr_movimiento_almacen.orden_carga_codigo = uo_lectura_origen.is_orden_carga
				lstr_movimiento_almacen.orden_carga_linea  = uo_lectura_origen.il_linea_orden_carga
				lstr_movimiento_almacen.tipo_movimiento    = is_tipo_movimiento_consumo
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
	
				if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
					lb_correcto = false
					ll_piezas_traspaso = 0
				end if
			end if
			
			if ll_piezas_traspaso > 0 then
				lstr_movimiento_almacen.empresa            = codigo_empresa
				lstr_movimiento_almacen.articulo           = uo_lectura_origen.is_codigo_articulo
				lstr_movimiento_almacen.calidad            = uo_lectura_origen.is_codigo_calidad
				lstr_movimiento_almacen.tono               = uo_lectura_origen.is_lote
				lstr_movimiento_almacen.calibre            = uo_lectura_origen.ii_calibre
				lstr_movimiento_almacen.tipo_pallet        = uo_lectura_origen.is_codigo_pallet
				lstr_movimiento_almacen.caja               = uo_lectura_origen.is_codigo_caja
				lstr_movimiento_almacen.cantidad           = -1 * ll_piezas_traspaso
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
					lstr_movimiento_almacen.cantidad           = ll_piezas_traspaso
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
	
					if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
						lb_correcto = false
					end if	
				else
					lb_correcto = false
				end if	
			end if
			
			if lb_correcto then
				commit;				
			else
				rollback;
				Messagebox("Error","No se ha generado el traspaso")
			end if			
			uo_lectura_origen.SetFocus()
			uo_lectura_origen.event getfocus()			
		else
			Messagebox("Error","No se ha seleccionado el destino del traspaso")
			uo_lectura_destino.SetFocus()
			uo_lectura_destino.event getfocus()			
		end if
	else
		//Error por no seleccionar la misma orden de carga
		Messagebox("Error","No se puede hacer un traspaso a producción de un bulto con O.C.")
	end if
else
	if uo_lectura_origen.ii_bultos > 1 then
		Messagebox("Error","Ha seleccionado un origen con mas de un bulto")
	else
		Messagebox("Error","No se ha seleccionado el origen del traspaso")
	end if
	uo_lectura_origen.SetFocus()
	uo_lectura_origen.event getfocus()	
end if
end event

type uo_lectura_origen from u_sle_codbar within rf_devolucion_desde_produccion
integer y = 168
integer taborder = 10
boolean ib_mostrar_desplegado = true
boolean ib_permitir_desplegar = false
string is_descripcion = "LECTURA ORIGEN"
end type

on uo_lectura_origen.destroy
call u_sle_codbar::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;ii_paso_actual = 2
//em_pallets.setfocus()

st_paso1.backcolor        = il_color_fondo_inactivo
st_paso2.backcolor        = il_color_fondo_activo
st_paso3.backcolor        = il_color_fondo_inactivo

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

if this.is_almacen = '7' and this.is_zona = 'A' and this.ii_fila = 1 and this.ii_altura = 1 then
	uo_lectura_destino.f_sugerir_ubicacion_destino(this)
end if

uo_lectura_destino.visible = true

uo_lectura_destino.SetFocus()
uo_lectura_destino.event getfocus()
end event

event getfocus;call super::getfocus;ii_paso_actual = 1

em_pallets.text = "0"
em_cajas.text   = "0"
em_piezas.text  = "0"

st_paso1.backcolor        = il_color_fondo_activo
st_paso2.backcolor        = il_color_fondo_inactivo
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
uo_lectura_destino.visible = false
end event

event modified;call super::modified;if il_id_bulto = 0 then
	f_reset()
	messagebox("¡Atención!","Debe seleccionar un bulto.",StopSign!)
	this.SetFocus()
	this.event getfocus()	
else
	if ii_bultos > 1 then
		Messagebox("Error","Ha seleccionado un origen con mas de un bulto~nDebe hacer la lectura de la etiqueta del bulto.")
		this.SetFocus()
		this.event getfocus()			
	else
		if this.is_almacen <> is_almacen_produccion or this.is_zona <> is_zona_produccion or this.ii_fila <> ii_fila_produccion or this.ii_altura <> ii_altura_produccion then
			Messagebox("Error","Debe seleccionar un bulto ubicado en la zona de producción")
			this.SetFocus()
			this.event getfocus()					
		else
			string ls_articulo,ls_pallet,ls_caja
			int    li_piezas_caja,li_cajas_maximas
			long   ll_piezas_pallet,ll_piezas_bulto, li_cajas_pallet
			
			em_pallets.text = "0"
			em_cajas.text   = "0"
			em_piezas.text  = "0"
			
			ls_articulo     = uo_lectura_origen.is_codigo_articulo
			ls_pallet       = uo_lectura_origen.is_codigo_pallet
			ls_caja         = uo_lectura_origen.is_codigo_caja
			ll_piezas_bulto = uo_lectura_origen.il_piezas
			
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
			
			if li_piezas_caja = 0 then
				select isnull(almartcajas.piezascaja,0),
						 0,
						 0 
				into   :li_piezas_caja,
						 :li_cajas_pallet,
						 :ll_piezas_pallet 
				from   almartcajas
				where  almartcajas.empresa  = :codigo_empresa 
				and    almartcajas.articulo = :ls_articulo 
				and    almartcajas.caja     = :ls_caja;			
				
			end if
			
			if li_piezas_caja <> 0 then
				li_cajas_maximas = truncate(ll_piezas_bulto / li_piezas_caja,0)
			else
				li_cajas_maximas = 0
			end if
			
			em_cajas.minmax  = "0~~"+string(li_cajas_maximas,"##0")
			em_piezas.minmax = "0~~"+string(ll_piezas_bulto,"####0")
			em_cajas.text    = string(li_cajas_maximas,em_cajas.mask)
			em_piezas.text   = string(ll_piezas_bulto,em_piezas.mask)
			//editmask			
		end if
	end if	
end if



end event

type st_paso2 from statictext within rf_devolucion_desde_produccion
integer x = 1463
integer y = 4
integer width = 2857
integer height = 144
boolean bringtotop = true
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
boolean enabled = false
string text = "2"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

