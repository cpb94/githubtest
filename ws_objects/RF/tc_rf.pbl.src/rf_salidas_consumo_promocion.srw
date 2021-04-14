$PBExportHeader$rf_salidas_consumo_promocion.srw
forward
global type rf_salidas_consumo_promocion from window
end type
type st_piezas_disponibles from statictext within rf_salidas_consumo_promocion
end type
type em_piezas_disponibles from editmask within rf_salidas_consumo_promocion
end type
type st_piezas_reservadas from statictext within rf_salidas_consumo_promocion
end type
type em_piezas_reservadas from editmask within rf_salidas_consumo_promocion
end type
type st_piezas_disponibles_totales from statictext within rf_salidas_consumo_promocion
end type
type em_piezas_disponibles_totales from editmask within rf_salidas_consumo_promocion
end type
type st_pallets from statictext within rf_salidas_consumo_promocion
end type
type st_cajas from statictext within rf_salidas_consumo_promocion
end type
type st_piezas from statictext within rf_salidas_consumo_promocion
end type
type em_pallets from editmask within rf_salidas_consumo_promocion
end type
type em_cajas from editmask within rf_salidas_consumo_promocion
end type
type em_piezas from editmask within rf_salidas_consumo_promocion
end type
type pb_mas_pallet from picturebutton within rf_salidas_consumo_promocion
end type
type pb_mas_cajas from picturebutton within rf_salidas_consumo_promocion
end type
type pb_mas_piezas from picturebutton within rf_salidas_consumo_promocion
end type
type pb_menos_pallet from picturebutton within rf_salidas_consumo_promocion
end type
type pb_menos_cajas from picturebutton within rf_salidas_consumo_promocion
end type
type pb_menos_piezas from picturebutton within rf_salidas_consumo_promocion
end type
type pb_atras from picturebutton within rf_salidas_consumo_promocion
end type
type st_paso3 from statictext within rf_salidas_consumo_promocion
end type
type st_paso1 from statictext within rf_salidas_consumo_promocion
end type
type pb_1 from picturebutton within rf_salidas_consumo_promocion
end type
type pb_aceptar from picturebutton within rf_salidas_consumo_promocion
end type
type uo_lectura_origen from u_sle_codbar within rf_salidas_consumo_promocion
end type
type st_paso2 from statictext within rf_salidas_consumo_promocion
end type
end forward

global type rf_salidas_consumo_promocion from window
integer width = 4718
integer height = 2904
boolean titlebar = true
string title = "Salidas Consumo Promoción"
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_piezas_disponibles st_piezas_disponibles
em_piezas_disponibles em_piezas_disponibles
st_piezas_reservadas st_piezas_reservadas
em_piezas_reservadas em_piezas_reservadas
st_piezas_disponibles_totales st_piezas_disponibles_totales
em_piezas_disponibles_totales em_piezas_disponibles_totales
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
global rf_salidas_consumo_promocion rf_salidas_consumo_promocion

type variables
string is_tipo_movimiento_salida  = '100'
string is_tipo_movimiento_entrada = ''
long   il_color_fondo_activo,il_color_fondo_inactivo
int    ii_paso_actual = 1
end variables

on rf_salidas_consumo_promocion.create
this.st_piezas_disponibles=create st_piezas_disponibles
this.em_piezas_disponibles=create em_piezas_disponibles
this.st_piezas_reservadas=create st_piezas_reservadas
this.em_piezas_reservadas=create em_piezas_reservadas
this.st_piezas_disponibles_totales=create st_piezas_disponibles_totales
this.em_piezas_disponibles_totales=create em_piezas_disponibles_totales
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
this.Control[]={this.st_piezas_disponibles,&
this.em_piezas_disponibles,&
this.st_piezas_reservadas,&
this.em_piezas_reservadas,&
this.st_piezas_disponibles_totales,&
this.em_piezas_disponibles_totales,&
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

on rf_salidas_consumo_promocion.destroy
destroy(this.st_piezas_disponibles)
destroy(this.em_piezas_disponibles)
destroy(this.st_piezas_reservadas)
destroy(this.em_piezas_reservadas)
destroy(this.st_piezas_disponibles_totales)
destroy(this.em_piezas_disponibles_totales)
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

st_paso2.text = f_nombre_almtipomov(codigo_empresa,is_tipo_movimiento_salida)

uo_lectura_origen.SetFocus()
uo_lectura_origen.event getfocus()
end event

type st_piezas_disponibles from statictext within rf_salidas_consumo_promocion
integer x = 274
integer y = 1408
integer width = 2944
integer height = 236
integer textsize = -36
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 21642288
long backcolor = 16777215
boolean enabled = false
string text = "Piezas Disponibles Bulto:"
boolean focusrectangle = false
end type

type em_piezas_disponibles from editmask within rf_salidas_consumo_promocion
integer x = 3232
integer y = 1404
integer width = 997
integer height = 240
integer taborder = 60
integer textsize = -36
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 21642288
long backcolor = 16777215
string text = "0"
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean autoskip = true
double increment = 1
string minmax = "0~~9999"
end type

type st_piezas_reservadas from statictext within rf_salidas_consumo_promocion
boolean visible = false
integer x = 274
integer y = 1664
integer width = 2944
integer height = 236
integer textsize = -36
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Piezas Reservadas Bulto:"
boolean focusrectangle = false
end type

type em_piezas_reservadas from editmask within rf_salidas_consumo_promocion
boolean visible = false
integer x = 3232
integer y = 1664
integer width = 997
integer height = 240
integer taborder = 60
integer textsize = -36
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
string text = "0"
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean autoskip = true
double increment = 1
string minmax = "0~~9999"
end type

type st_piezas_disponibles_totales from statictext within rf_salidas_consumo_promocion
integer x = 274
integer y = 1144
integer width = 2944
integer height = 236
integer textsize = -36
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 21642288
long backcolor = 16777215
boolean enabled = false
string text = "Piezas Disponibles Totales:"
boolean focusrectangle = false
end type

type em_piezas_disponibles_totales from editmask within rf_salidas_consumo_promocion
integer x = 3232
integer y = 1144
integer width = 997
integer height = 240
integer taborder = 50
integer textsize = -36
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 21642288
long backcolor = 16777215
string text = "0"
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean autoskip = true
double increment = 1
string minmax = "0~~9999"
end type

type st_pallets from statictext within rf_salidas_consumo_promocion
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

type st_cajas from statictext within rf_salidas_consumo_promocion
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

type st_piezas from statictext within rf_salidas_consumo_promocion
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

type em_pallets from editmask within rf_salidas_consumo_promocion
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

type em_cajas from editmask within rf_salidas_consumo_promocion
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
	messagebox("Error de datos","No se puede realizar un movimiento de cantidad superior a "+string(ll_max)+" Cajas")
else
	if ll_valor < ll_min then
		this.text = string(0,this.mask)		
		messagebox("Error de datos","No se puede realizar un movimiento de cantidad inferior a "+string(ll_min)+" Cajas")
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
end event

type em_piezas from editmask within rf_salidas_consumo_promocion
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
	messagebox("Error de datos","No se puede realizar un movimiento de cantidad superior a "+string(ll_max)+" Pzs")
else
	if ll_valor < ll_min then
		this.text = string(0,this.mask)		
		messagebox("Error de datos","No se puede realizar un movimiento de cantidad inferior a "+string(ll_min)+" Pzs")
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
		if uo_lectura_origen.ib_ubicacion_gestionada_en_piezas then
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

type pb_mas_pallet from picturebutton within rf_salidas_consumo_promocion
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

type pb_mas_cajas from picturebutton within rf_salidas_consumo_promocion
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

type pb_mas_piezas from picturebutton within rf_salidas_consumo_promocion
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

type pb_menos_pallet from picturebutton within rf_salidas_consumo_promocion
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

type pb_menos_cajas from picturebutton within rf_salidas_consumo_promocion
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

type pb_menos_piezas from picturebutton within rf_salidas_consumo_promocion
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

type pb_atras from picturebutton within rf_salidas_consumo_promocion
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

type st_paso3 from statictext within rf_salidas_consumo_promocion
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

type st_paso1 from statictext within rf_salidas_consumo_promocion
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

type pb_1 from picturebutton within rf_salidas_consumo_promocion
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
		uo_lectura_origen.SetFocus()
		uo_lectura_origen.event getfocus()		
	case 3

	case else
		uo_lectura_origen.SetFocus()
		uo_lectura_origen.event getfocus()		
end choose
end event

type pb_aceptar from picturebutton within rf_salidas_consumo_promocion
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

long ll_indice,ll_total
boolean lb_correcto = true

ll_total  = uo_lectura_origen.ii_lineas_bulto

if uo_lectura_origen.ii_bultos = 1 and uo_lectura_origen.ii_indice_lineas_bulto > 0 then
	if uo_lectura_origen.ii_anyo_orden_carga = 0 and uo_lectura_origen.is_orden_carga = "" then
		lstr_movimiento_almacen.empresa            = codigo_empresa
		lstr_movimiento_almacen.articulo           = uo_lectura_origen.is_codigo_articulo
		lstr_movimiento_almacen.calidad            = uo_lectura_origen.is_codigo_calidad
		lstr_movimiento_almacen.tono               = uo_lectura_origen.is_lote
		lstr_movimiento_almacen.calibre            = uo_lectura_origen.ii_calibre
		lstr_movimiento_almacen.tipo_pallet        = uo_lectura_origen.is_codigo_pallet
		lstr_movimiento_almacen.caja               = uo_lectura_origen.is_codigo_caja
		lstr_movimiento_almacen.cantidad           = -1 * ( long(em_piezas.text) )
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

		else
			lb_correcto = false
		end if	
	
		if lb_correcto then
			commit;
			uo_lectura_origen.event ue_refrescar()
		else
			rollback;
			Messagebox("Error","No se ha generado el movimiento")
		end if			
	else
		//Error por no seleccionar la misma orden de carga
		Messagebox("Error","No se puede hacer una salida de un bulto con O.C.")
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

type uo_lectura_origen from u_sle_codbar within rf_salidas_consumo_promocion
integer y = 168
integer taborder = 10
boolean ib_mostrar_desplegado = true
boolean ib_permitir_desplegar = false
boolean ib_obligatorio_marcar_una_linea = true
string is_descripcion = "LECTURA ORIGEN"
end type

on uo_lectura_origen.destroy
call u_sle_codbar::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;ii_paso_actual = 2
em_pallets.setfocus()

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

st_piezas_disponibles.visible = true
em_piezas_disponibles.visible = true

long ll_piezas_bulto

ll_piezas_bulto = uo_lectura_origen.il_piezas - uo_lectura_origen.il_piezas_reservadas_bulto
																	  																	  
if ll_piezas_bulto > uo_lectura_origen.il_piezas_disponibles_totales then
	ll_piezas_bulto = uo_lectura_origen.il_piezas_disponibles_totales
end if

if ll_piezas_bulto > 0 then
	pb_aceptar.enabled = true
else
	pb_aceptar.enabled = false
end if
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

st_piezas_disponibles_totales.visible = false
em_piezas_disponibles_totales.visible = false
st_piezas_disponibles.visible         = false
em_piezas_disponibles.visible         = false
st_piezas_reservadas.visible          = false
em_piezas_reservadas.visible          = false
end event

event modified;call super::modified;string ls_articulo,ls_pallet,ls_caja
int    li_piezas_caja,li_cajas_maximas
long   ll_piezas_pallet,ll_piezas_bulto,ll_disponible, li_cajas_pallet

em_pallets.text = "0"
em_cajas.text   = "0"
em_piezas.text  = "0"

ls_articulo     = uo_lectura_origen.is_codigo_articulo
ls_pallet       = uo_lectura_origen.is_codigo_pallet
ls_caja         = uo_lectura_origen.is_codigo_caja
ll_piezas_bulto = uo_lectura_origen.il_piezas_disponibles_bulto //uo_lectura_origen.il_piezas - uo_lectura_origen.il_piezas_reservadas_bulto
	
//if uo_lectura_origen.ib_ubicacion_permite_reservas then	
//	if ll_piezas_bulto > uo_lectura_origen.il_piezas_disponibles_totales then
//		ll_piezas_bulto = uo_lectura_origen.il_piezas_disponibles_totales
//	end if
//end if

ll_piezas_bulto = uo_lectura_origen.il_piezas_disponibles_bulto

em_piezas_disponibles_totales.text = string(uo_lectura_origen.il_piezas_disponibles_totales,em_piezas_disponibles_totales.mask)
em_piezas_disponibles.text = string(uo_lectura_origen.il_piezas_disponibles_bulto,em_piezas_disponibles.mask)

st_piezas_disponibles_totales.visible = true
em_piezas_disponibles_totales.visible = true
st_piezas_disponibles.visible         = true
em_piezas_disponibles.visible         = true

//Mostramos las piezas reservadas del bulto seleccionado
em_piezas_reservadas.text  = string(uo_lectura_origen.il_piezas_reservadas_bulto,em_piezas_reservadas.mask)

if uo_lectura_origen.il_piezas_reservadas_bulto <> 0 then	
	st_piezas_reservadas.visible = true
	em_piezas_reservadas.visible = true
else
	st_piezas_reservadas.visible = false
	em_piezas_reservadas.visible = false
end if

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
em_cajas.text    = string(0,em_cajas.mask)
em_piezas.text   = string(0,em_piezas.mask)
//editmask
end event

event ue_pre_siguiente_objeto;call super::ue_pre_siguiente_objeto;pb_atras.visible           = true
end event

type st_paso2 from statictext within rf_salidas_consumo_promocion
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

