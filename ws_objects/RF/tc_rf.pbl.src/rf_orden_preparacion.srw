$PBExportHeader$rf_orden_preparacion.srw
forward
global type rf_orden_preparacion from window
end type
type pb_salir from picturebutton within rf_orden_preparacion
end type
type tab_1 from tab within rf_orden_preparacion
end type
type tp_seleccion_orden from userobject within tab_1
end type
type pb_bajar from picturebutton within tp_seleccion_orden
end type
type pb_subir from picturebutton within tp_seleccion_orden
end type
type pb_1 from picturebutton within tp_seleccion_orden
end type
type dw_seleccion_orden from u_datawindow within tp_seleccion_orden
end type
type r_barra from rectangle within tp_seleccion_orden
end type
type r_indicador from rectangle within tp_seleccion_orden
end type
type tp_seleccion_orden from userobject within tab_1
pb_bajar pb_bajar
pb_subir pb_subir
pb_1 pb_1
dw_seleccion_orden dw_seleccion_orden
r_barra r_barra
r_indicador r_indicador
end type
type tp_preparacion_bulto from userobject within tab_1
end type
type p_ubicar_tras_preparar from picture within tp_preparacion_bulto
end type
type st_preparar_y_ubicar from statictext within tp_preparacion_bulto
end type
type st_preparar from statictext within tp_preparacion_bulto
end type
type em_piezas from editmask within tp_preparacion_bulto
end type
type em_cajas from editmask within tp_preparacion_bulto
end type
type em_pallets from editmask within tp_preparacion_bulto
end type
type st_piezas from statictext within tp_preparacion_bulto
end type
type st_cajas from statictext within tp_preparacion_bulto
end type
type st_pallets from statictext within tp_preparacion_bulto
end type
type p_bajar2 from picturebutton within tp_preparacion_bulto
end type
type p_subir2 from picturebutton within tp_preparacion_bulto
end type
type st_paso3 from statictext within tp_preparacion_bulto
end type
type dw_lineas_picos_orden from u_datawindow within tp_preparacion_bulto
end type
type pb_aceptar from picturebutton within tp_preparacion_bulto
end type
type pb_atras from picturebutton within tp_preparacion_bulto
end type
type uo_lectura_destino from u_sle_codbar within tp_preparacion_bulto
end type
type uo_lectura_origen from u_sle_codbar within tp_preparacion_bulto
end type
type st_paso2 from statictext within tp_preparacion_bulto
end type
type st_paso1 from statictext within tp_preparacion_bulto
end type
type r_barra2 from rectangle within tp_preparacion_bulto
end type
type r_indicador2 from rectangle within tp_preparacion_bulto
end type
type tp_preparacion_bulto from userobject within tab_1
p_ubicar_tras_preparar p_ubicar_tras_preparar
st_preparar_y_ubicar st_preparar_y_ubicar
st_preparar st_preparar
em_piezas em_piezas
em_cajas em_cajas
em_pallets em_pallets
st_piezas st_piezas
st_cajas st_cajas
st_pallets st_pallets
p_bajar2 p_bajar2
p_subir2 p_subir2
st_paso3 st_paso3
dw_lineas_picos_orden dw_lineas_picos_orden
pb_aceptar pb_aceptar
pb_atras pb_atras
uo_lectura_destino uo_lectura_destino
uo_lectura_origen uo_lectura_origen
st_paso2 st_paso2
st_paso1 st_paso1
r_barra2 r_barra2
r_indicador2 r_indicador2
end type
type tp_mover_pallets from userobject within tab_1
end type
type tp_mover_pallets from userobject within tab_1
end type
type tab_1 from tab within rf_orden_preparacion
tp_seleccion_orden tp_seleccion_orden
tp_preparacion_bulto tp_preparacion_bulto
tp_mover_pallets tp_mover_pallets
end type
end forward

global type rf_orden_preparacion from window
integer width = 4718
integer height = 2904
boolean titlebar = true
string title = "Traspaso de linea entre bultos"
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_salir pb_salir
tab_1 tab_1
end type
global rf_orden_preparacion rf_orden_preparacion

type variables
string is_tipo_movimiento_salida = '204'
string is_tipo_movimiento_entrada = '205'
long   il_color_fondo_activo,il_color_fondo_inactivo
int    ii_paso_actual = 1
long   il_orden_carga_preparo,il_orden_preparacion_preparo
boolean ib_ubicar_tras_preparar = false
string is_almacen_maquina = '11',is_zona_maquina = 'A'
int    ii_fila_maquina = 1,ii_altura_maquina = 1
end variables

on rf_orden_preparacion.create
this.pb_salir=create pb_salir
this.tab_1=create tab_1
this.Control[]={this.pb_salir,&
this.tab_1}
end on

on rf_orden_preparacion.destroy
destroy(this.pb_salir)
destroy(this.tab_1)
end on

event open;il_color_fondo_activo   = tab_1.tp_preparacion_bulto.st_paso1.backcolor
il_color_fondo_inactivo = tab_1.tp_preparacion_bulto.st_paso2.backcolor

tab_1.tp_seleccion_orden.dw_seleccion_orden.settransobject(sqlca)
tab_1.tp_seleccion_orden.dw_seleccion_orden.retrieve(codigo_empresa,0)

tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.settransobject(sqlca)

tab_1.tp_preparacion_bulto.uo_lectura_origen.SetFocus()
tab_1.tp_preparacion_bulto.uo_lectura_origen.event getfocus()
end event

type pb_salir from picturebutton within rf_orden_preparacion
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

type tab_1 from tab within rf_orden_preparacion
event create ( )
event destroy ( )
integer width = 4681
integer height = 2796
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tp_seleccion_orden tp_seleccion_orden
tp_preparacion_bulto tp_preparacion_bulto
tp_mover_pallets tp_mover_pallets
end type

on tab_1.create
this.tp_seleccion_orden=create tp_seleccion_orden
this.tp_preparacion_bulto=create tp_preparacion_bulto
this.tp_mover_pallets=create tp_mover_pallets
this.Control[]={this.tp_seleccion_orden,&
this.tp_preparacion_bulto,&
this.tp_mover_pallets}
end on

on tab_1.destroy
destroy(this.tp_seleccion_orden)
destroy(this.tp_preparacion_bulto)
destroy(this.tp_mover_pallets)
end on

event selectionchanged;choose case newindex
	case 2
		tab_1.tp_preparacion_bulto.uo_lectura_origen.SetFocus()
		tab_1.tp_preparacion_bulto.uo_lectura_origen.event getfocus()					
	case 3
		
end choose
end event

type tp_seleccion_orden from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4645
integer height = 2668
long backcolor = 67108864
string text = "Selección Orden"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_bajar pb_bajar
pb_subir pb_subir
pb_1 pb_1
dw_seleccion_orden dw_seleccion_orden
r_barra r_barra
r_indicador r_indicador
end type

on tp_seleccion_orden.create
this.pb_bajar=create pb_bajar
this.pb_subir=create pb_subir
this.pb_1=create pb_1
this.dw_seleccion_orden=create dw_seleccion_orden
this.r_barra=create r_barra
this.r_indicador=create r_indicador
this.Control[]={this.pb_bajar,&
this.pb_subir,&
this.pb_1,&
this.dw_seleccion_orden,&
this.r_barra,&
this.r_indicador}
end on

on tp_seleccion_orden.destroy
destroy(this.pb_bajar)
destroy(this.pb_subir)
destroy(this.pb_1)
destroy(this.dw_seleccion_orden)
destroy(this.r_barra)
destroy(this.r_indicador)
end on

type pb_bajar from picturebutton within tp_seleccion_orden
integer x = 3392
integer y = 2240
integer width = 439
integer height = 368
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\down.bmp"
alignment htextalign = left!
end type

event clicked;if tab_1.tp_seleccion_orden.dw_seleccion_orden.getrow() < tab_1.tp_seleccion_orden.dw_seleccion_orden.rowcount() then
	tab_1.tp_seleccion_orden.dw_seleccion_orden.setrow(tab_1.tp_seleccion_orden.dw_seleccion_orden.getrow() +1)
else
	tab_1.tp_seleccion_orden.dw_seleccion_orden.setrow(1)
end if


end event

type pb_subir from picturebutton within tp_seleccion_orden
integer x = 3392
integer width = 439
integer height = 368
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\up.bmp"
alignment htextalign = left!
end type

event clicked;if tab_1.tp_seleccion_orden.dw_seleccion_orden.getrow() > 1 then
	tab_1.tp_seleccion_orden.dw_seleccion_orden.setrow(tab_1.tp_seleccion_orden.dw_seleccion_orden.getrow() -1)
else
	tab_1.tp_seleccion_orden.dw_seleccion_orden.setrow(tab_1.tp_seleccion_orden.dw_seleccion_orden.rowcount())
end if
end event

type pb_1 from picturebutton within tp_seleccion_orden
integer x = 3840
integer y = 1908
integer width = 800
integer height = 700
integer taborder = 80
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

event clicked;if dw_seleccion_orden.getrow() > 0 then
	if tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.retrieve(codigo_empresa,tab_1.tp_seleccion_orden.dw_seleccion_orden.object.alm_orden_preparacion_id[dw_seleccion_orden.getrow()]) > 0 then
		il_orden_carga_preparo       = tab_1.tp_seleccion_orden.dw_seleccion_orden.object.alm_orden_carga_id[dw_seleccion_orden.getrow()]
		il_orden_preparacion_preparo = tab_1.tp_seleccion_orden.dw_seleccion_orden.object.alm_orden_preparacion_id[dw_seleccion_orden.getrow()]
		tab_1.SelectTab(2)
	else
		messagebox("Error","Ha marcado una orden de preparación sin lineas")
		il_orden_carga_preparo       = 0
		il_orden_preparacion_preparo = 0	
	end if
else	
	messagebox("Error","No ha marcado ninguna orden de preparación")
	il_orden_carga_preparo       = 0
	il_orden_preparacion_preparo = 0		
end if
end event

type dw_seleccion_orden from u_datawindow within tp_seleccion_orden
integer width = 3383
integer height = 2608
integer taborder = 11
string dataobject = "dw_rf_orden_preparacion_1"
end type

event retrieveend;call super::retrieveend;//r_barra.y = r_indicador.y

this.setrow(1)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_alto_total,ll_nueva_posicion

this.selectrow(0,false)

if currentrow > 0 then
	if currentrow = 1 then
		r_indicador.y = r_barra.y
	else
		ll_alto_total =  r_barra.height - r_indicador.height
	
		ll_nueva_posicion = (ll_alto_total / this.rowcount()) * currentrow
		
		r_indicador.y = r_barra.y + ll_nueva_posicion
	end if
	
	this.selectrow(currentrow,true)
	this.scrolltorow(currentrow)
else
	r_barra.y = r_indicador.y	
end if
end event

type r_barra from rectangle within tp_seleccion_orden
integer linethickness = 4
long fillcolor = 12632256
integer x = 3397
integer y = 372
integer width = 430
integer height = 1864
end type

type r_indicador from rectangle within tp_seleccion_orden
integer linethickness = 4
long fillcolor = 8421504
integer x = 3397
integer y = 372
integer width = 430
integer height = 168
end type

type tp_preparacion_bulto from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4645
integer height = 2668
long backcolor = 67108864
string text = "Preparación Bulto"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
p_ubicar_tras_preparar p_ubicar_tras_preparar
st_preparar_y_ubicar st_preparar_y_ubicar
st_preparar st_preparar
em_piezas em_piezas
em_cajas em_cajas
em_pallets em_pallets
st_piezas st_piezas
st_cajas st_cajas
st_pallets st_pallets
p_bajar2 p_bajar2
p_subir2 p_subir2
st_paso3 st_paso3
dw_lineas_picos_orden dw_lineas_picos_orden
pb_aceptar pb_aceptar
pb_atras pb_atras
uo_lectura_destino uo_lectura_destino
uo_lectura_origen uo_lectura_origen
st_paso2 st_paso2
st_paso1 st_paso1
r_barra2 r_barra2
r_indicador2 r_indicador2
end type

on tp_preparacion_bulto.create
this.p_ubicar_tras_preparar=create p_ubicar_tras_preparar
this.st_preparar_y_ubicar=create st_preparar_y_ubicar
this.st_preparar=create st_preparar
this.em_piezas=create em_piezas
this.em_cajas=create em_cajas
this.em_pallets=create em_pallets
this.st_piezas=create st_piezas
this.st_cajas=create st_cajas
this.st_pallets=create st_pallets
this.p_bajar2=create p_bajar2
this.p_subir2=create p_subir2
this.st_paso3=create st_paso3
this.dw_lineas_picos_orden=create dw_lineas_picos_orden
this.pb_aceptar=create pb_aceptar
this.pb_atras=create pb_atras
this.uo_lectura_destino=create uo_lectura_destino
this.uo_lectura_origen=create uo_lectura_origen
this.st_paso2=create st_paso2
this.st_paso1=create st_paso1
this.r_barra2=create r_barra2
this.r_indicador2=create r_indicador2
this.Control[]={this.p_ubicar_tras_preparar,&
this.st_preparar_y_ubicar,&
this.st_preparar,&
this.em_piezas,&
this.em_cajas,&
this.em_pallets,&
this.st_piezas,&
this.st_cajas,&
this.st_pallets,&
this.p_bajar2,&
this.p_subir2,&
this.st_paso3,&
this.dw_lineas_picos_orden,&
this.pb_aceptar,&
this.pb_atras,&
this.uo_lectura_destino,&
this.uo_lectura_origen,&
this.st_paso2,&
this.st_paso1,&
this.r_barra2,&
this.r_indicador2}
end on

on tp_preparacion_bulto.destroy
destroy(this.p_ubicar_tras_preparar)
destroy(this.st_preparar_y_ubicar)
destroy(this.st_preparar)
destroy(this.em_piezas)
destroy(this.em_cajas)
destroy(this.em_pallets)
destroy(this.st_piezas)
destroy(this.st_cajas)
destroy(this.st_pallets)
destroy(this.p_bajar2)
destroy(this.p_subir2)
destroy(this.st_paso3)
destroy(this.dw_lineas_picos_orden)
destroy(this.pb_aceptar)
destroy(this.pb_atras)
destroy(this.uo_lectura_destino)
destroy(this.uo_lectura_origen)
destroy(this.st_paso2)
destroy(this.st_paso1)
destroy(this.r_barra2)
destroy(this.r_indicador2)
end on

type p_ubicar_tras_preparar from picture within tp_preparacion_bulto
integer x = 983
integer y = 2472
integer width = 224
integer height = 196
string picturename = "C:\bmp\RF\db-Post_dis.png"
boolean border = true
boolean focusrectangle = false
end type

event clicked;if ib_ubicar_tras_preparar then
	this.picturename = 'C:\bmp\RF\db-Post_dis.png'
else
	this.picturename = 'C:\bmp\RF\db-Post.png'
end if

ib_ubicar_tras_preparar = not(ib_ubicar_tras_preparar)
end event

type st_preparar_y_ubicar from statictext within tp_preparacion_bulto
integer x = 1211
integer y = 2472
integer width = 2062
integer height = 196
integer textsize = -36
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ubicar Tras Preparar"
boolean focusrectangle = false
end type

event clicked;if ib_ubicar_tras_preparar then
	tab_1.tp_preparacion_bulto.p_ubicar_tras_preparar.picturename = 'C:\bmp\RF\db-Post_dis.png'
else
	tab_1.tp_preparacion_bulto.p_ubicar_tras_preparar.picturename = 'C:\bmp\RF\db-Post.png'
end if

ib_ubicar_tras_preparar = not(ib_ubicar_tras_preparar)
end event

type st_preparar from statictext within tp_preparacion_bulto
integer x = 978
integer y = 1972
integer width = 2702
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
string text = "Preparar"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type em_piezas from editmask within tp_preparacion_bulto
event clicked pbm_bnclicked
integer x = 2871
integer y = 2300
integer width = 805
integer height = 168
integer taborder = 140
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
boolean displayonly = true
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

type em_cajas from editmask within tp_preparacion_bulto
event clicked pbm_bnclicked
integer x = 1938
integer y = 2300
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
boolean displayonly = true
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

type em_pallets from editmask within tp_preparacion_bulto
event clicked pbm_bnclicked
integer x = 978
integer y = 2300
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
boolean displayonly = true
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

type st_piezas from statictext within tp_preparacion_bulto
integer x = 2871
integer y = 2136
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

type st_cajas from statictext within tp_preparacion_bulto
integer x = 1938
integer y = 2136
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

type st_pallets from statictext within tp_preparacion_bulto
integer x = 978
integer y = 2132
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

type p_bajar2 from picturebutton within tp_preparacion_bulto
integer x = 4352
integer y = 1740
integer width = 274
integer height = 224
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\down.bmp"
string disabledname = "C:\bmp\down.bmp"
alignment htextalign = left!
end type

event clicked;if tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow() < tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.rowcount() then
	tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.setrow(tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow() +1)
else
	tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.setrow(1)
end if

end event

type p_subir2 from picturebutton within tp_preparacion_bulto
integer x = 4352
integer y = 1252
integer width = 274
integer height = 224
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\up.bmp"
string disabledname = "C:\bmp\up.bmp"
alignment htextalign = left!
end type

event clicked;if tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow() > 1 then
	tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.setrow(tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow() -1)
else
	tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.setrow(tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.rowcount())
end if
end event

type st_paso3 from statictext within tp_preparacion_bulto
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

type dw_lineas_picos_orden from u_datawindow within tp_preparacion_bulto
integer y = 1252
integer width = 4347
integer height = 712
integer taborder = 11
boolean enabled = false
string dataobject = "dw_rf_orden_preparacion_2"
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_alto_total,ll_nueva_posicion

this.selectrow(0,false)

if currentrow > 0 then
	if currentrow = 1 then
		r_indicador2.y = r_barra2.y
	else
		ll_alto_total =  r_barra2.height - r_indicador2.height
	
		ll_nueva_posicion = (ll_alto_total / this.rowcount()) * currentrow
		
		r_indicador2.y = r_barra2.y + ll_nueva_posicion
	end if
	
	tab_1.tp_preparacion_bulto.em_pallets.text = "0"
	tab_1.tp_preparacion_bulto.em_cajas.text   = string(this.object.cajas[currentrow],tab_1.tp_preparacion_bulto.em_cajas.mask)
	tab_1.tp_preparacion_bulto.em_piezas.text  = string(this.object.venliped_reservas_cantidad[currentrow],tab_1.tp_preparacion_bulto.em_piezas.mask)
	
	this.selectrow(currentrow,true)
	this.scrolltorow(currentrow)
else
	r_barra2.y = r_indicador2.y	
end if
end event

type pb_aceptar from picturebutton within tp_preparacion_bulto
integer x = 3831
integer y = 1968
integer width = 800
integer height = 700
integer taborder = 70
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
str_venliped_reservas lstr_venliped_reservas
str_venliped_reservas_ubi_orig lstr_venliped_reservas_ubi_orig

integer li_pallets_reflejados_en_pedido
long    ll_indice,ll_total,ll_piezas_traspaso
boolean lb_correcto = true,lb_cerrar = false

ll_total  = tab_1.tp_preparacion_bulto.uo_lectura_origen.ii_lineas_bulto

if tab_1.tp_preparacion_bulto.uo_lectura_origen.ii_bultos = 1 and tab_1.tp_preparacion_bulto.uo_lectura_origen.ii_indice_lineas_bulto > 0 and tab_1.tp_preparacion_bulto.uo_lectura_destino.ii_bultos = 1 then
	if tab_1.tp_preparacion_bulto.uo_lectura_origen.il_id_bulto <> tab_1.tp_preparacion_bulto.uo_lectura_destino.il_id_bulto then
		if long(em_piezas.text) > 0 then
			
			lstr_venliped_reservas.anyo                 = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venped_anyo[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]
			lstr_venliped_reservas.pedido               = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venped_pedido[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]
			lstr_venliped_reservas.linea                = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venliped_linea[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]
			lstr_venliped_reservas.alm_bultos_lineas_id = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venliped_reservas_alm_bultos_lineas_id[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]
			
			if f_cargar_str_venliped_reservas(codigo_empresa,lstr_venliped_reservas.anyo,lstr_venliped_reservas.pedido,lstr_venliped_reservas.linea,lstr_venliped_reservas.alm_bultos_lineas_id,lstr_venliped_reservas) then
				lstr_venliped_reservas_ubi_orig.empresa               = lstr_venliped_reservas.empresa
				lstr_venliped_reservas_ubi_orig.anyo                  = lstr_venliped_reservas.anyo
				lstr_venliped_reservas_ubi_orig.pedido                = lstr_venliped_reservas.pedido
				lstr_venliped_reservas_ubi_orig.linea                 = lstr_venliped_reservas.linea
				lstr_venliped_reservas_ubi_orig.alm_bultos_lineas_id  = lstr_venliped_reservas.alm_bultos_lineas_id
				lstr_venliped_reservas_ubi_orig.cantidad              = lstr_venliped_reservas.cantidad
				lstr_venliped_reservas_ubi_orig.id_ubicacion_original = lstr_venliped_reservas.id_ubicacion_original
				lstr_venliped_reservas_ubi_orig.alm_bultos_id         = tab_1.tp_preparacion_bulto.uo_lectura_origen.il_id_bulto
				lstr_venliped_reservas_ubi_orig.id_ubicacion_destino  = lstr_venliped_reservas.id_ubicacion_destino 
				
				if not(f_insert_str_venliped_reservas_ubi_orig(lstr_venliped_reservas_ubi_orig)) then
					messagebox("¡Error!","Se ha producido un error al guardar las ubicaciones originales de la O.C.")
					lb_correcto = false							
				end if
			else
				messagebox("¡Error!","Se ha producido un error al guardar las ubicaciones originales de la O.C.")
				lb_correcto = false
			end if			
			
			ll_piezas_traspaso = long(tab_1.tp_preparacion_bulto.em_piezas.text)
			
			if tab_1.tp_preparacion_bulto.uo_lectura_origen.ii_anyo_orden_carga = tab_1.tp_preparacion_bulto.uo_lectura_destino.ii_anyo_orden_carga and tab_1.tp_preparacion_bulto.uo_lectura_origen.is_orden_carga = tab_1.tp_preparacion_bulto.uo_lectura_destino.is_orden_carga then
				lstr_movimiento_almacen.empresa            = codigo_empresa
				lstr_movimiento_almacen.articulo           = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_codigo_articulo
				lstr_movimiento_almacen.calidad            = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_codigo_calidad
				lstr_movimiento_almacen.tono               = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_lote
				lstr_movimiento_almacen.calibre            = tab_1.tp_preparacion_bulto.uo_lectura_origen.ii_calibre
				lstr_movimiento_almacen.tipo_pallet        = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_codigo_pallet
				lstr_movimiento_almacen.caja               = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_codigo_caja
				lstr_movimiento_almacen.cantidad           = -1 * ll_piezas_traspaso //( uo_lectura_origen.il_piezas )
				lstr_movimiento_almacen.orden_carga_anyo   = 0
				lstr_movimiento_almacen.orden_carga_codigo = ""
				lstr_movimiento_almacen.orden_carga_linea  = 0
				lstr_movimiento_almacen.tipo_movimiento    = is_tipo_movimiento_salida
				lstr_movimiento_almacen.observaciones      = ""
				lstr_movimiento_almacen.almacen            = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_almacen
				lstr_movimiento_almacen.zona               = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_zona
				lstr_movimiento_almacen.fila               = tab_1.tp_preparacion_bulto.uo_lectura_origen.ii_fila
				lstr_movimiento_almacen.altura             = tab_1.tp_preparacion_bulto.uo_lectura_origen.ii_altura
				lstr_movimiento_almacen.tercero            = ""
				lstr_movimiento_almacen.documento          = ""
				lstr_movimiento_almacen.fecha              = datetime(today())
				lstr_movimiento_almacen.id_ubicacion       = tab_1.tp_preparacion_bulto.uo_lectura_origen.il_id_ubicacion
				lstr_movimiento_almacen.id_alm_bultos		 = tab_1.tp_preparacion_bulto.uo_lectura_origen.il_id_bulto
				lstr_movimiento_almacen.venliped_anyo      = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venped_anyo[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]
				lstr_movimiento_almacen.venliped_pedido    = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venped_pedido[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]
				lstr_movimiento_almacen.venliped_linea     = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venliped_linea[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]
							
				if f_movimiento_almacen(lstr_movimiento_almacen) then
					//Si el bulto de destino no tiene una ubicacion definida(Es un bulto nuevo)
					//Le asignamos la ubicacion del bulto de origen
					
					lstr_movimiento_almacen.empresa            = codigo_empresa
					lstr_movimiento_almacen.articulo           = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_codigo_articulo
					lstr_movimiento_almacen.calidad            = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_codigo_calidad
					lstr_movimiento_almacen.tono               = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_lote
					lstr_movimiento_almacen.calibre            = tab_1.tp_preparacion_bulto.uo_lectura_origen.ii_calibre
					if tab_1.tp_preparacion_bulto.uo_lectura_destino.ib_ubicacion_con_bulto_asociado then
						//Si el destino tiene bulto asociado le asociamos al movimiento de entrada el tipo de pallet de este
						lstr_movimiento_almacen.tipo_pallet = tab_1.tp_preparacion_bulto.uo_lectura_destino.is_codigo_pallet
					else
						lstr_movimiento_almacen.tipo_pallet = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_codigo_pallet
					end if
					lstr_movimiento_almacen.caja               = tab_1.tp_preparacion_bulto.uo_lectura_origen.is_codigo_caja
					lstr_movimiento_almacen.cantidad           = ll_piezas_traspaso
					lstr_movimiento_almacen.orden_carga_anyo   = 0
					lstr_movimiento_almacen.orden_carga_codigo = ""
					lstr_movimiento_almacen.orden_carga_linea  = 0
					lstr_movimiento_almacen.tipo_movimiento    = is_tipo_movimiento_entrada
					lstr_movimiento_almacen.observaciones      = ""
					if tab_1.tp_preparacion_bulto.uo_lectura_destino.il_id_ubicacion > 0 then
						lstr_movimiento_almacen.almacen         = tab_1.tp_preparacion_bulto.uo_lectura_destino.is_almacen
						lstr_movimiento_almacen.zona            = tab_1.tp_preparacion_bulto.uo_lectura_destino.is_zona
						lstr_movimiento_almacen.fila            = tab_1.tp_preparacion_bulto.uo_lectura_destino.ii_fila
						lstr_movimiento_almacen.altura          = tab_1.tp_preparacion_bulto.uo_lectura_destino.ii_altura
					else
						//Por defecto la ubicacion asignada a la carretilla
						lstr_movimiento_almacen.almacen         = is_almacen_maquina
						lstr_movimiento_almacen.zona            = is_zona_maquina
						lstr_movimiento_almacen.fila            = ii_fila_maquina
						lstr_movimiento_almacen.altura          = ii_altura_maquina						
					end if
					lstr_movimiento_almacen.tercero            = ""
					lstr_movimiento_almacen.documento          = ""
					lstr_movimiento_almacen.fecha              = datetime(today())
					if tab_1.tp_preparacion_bulto.uo_lectura_destino.il_id_ubicacion > 0 then
						lstr_movimiento_almacen.id_ubicacion    = tab_1.tp_preparacion_bulto.uo_lectura_destino.il_id_ubicacion
					else
						lstr_movimiento_almacen.id_ubicacion    = tab_1.tp_preparacion_bulto.uo_lectura_origen.il_id_ubicacion
					end if
					lstr_movimiento_almacen.id_alm_bultos		 = tab_1.tp_preparacion_bulto.uo_lectura_destino.il_id_bulto
					lstr_movimiento_almacen.venliped_anyo      = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venped_anyo[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]
					lstr_movimiento_almacen.venliped_pedido    = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venped_pedido[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]
					lstr_movimiento_almacen.venliped_linea     = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.object.venliped_linea[tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.getrow()]					
					
					if f_movimiento_almacen(lstr_movimiento_almacen) then
			
					else
						lb_correcto = false					
					end if
				else
					lb_correcto = false
				end if	
			
				if lb_correcto then
					commit;
					
					//Vamos a chequear si ya hay pallet en las lineas del bulto
					SELECT sum(isnull(venliped.pallets,0))
					INTO   :li_pallets_reflejados_en_pedido
					FROM   venliped,   
							 venliped_reservas,   
							 alm_bultos,   
							 alm_bultos_lineas  
					WHERE ( venliped.empresa = venliped_reservas.empresa ) 
					and   ( venliped.anyo = venliped_reservas.anyo ) 
					and   ( venliped.pedido = venliped_reservas.pedido ) 
					and   ( venliped.linea = venliped_reservas.linea ) 
					and   ( alm_bultos_lineas.id_alm_bultos = alm_bultos.id ) 
					and   ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) 
					and ( ( alm_bultos.id = :tab_1.tp_preparacion_bulto.uo_lectura_destino.il_id_bulto ) );		
					
					if li_pallets_reflejados_en_pedido = 0 then
						
					end if
					//
					
					tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.retrieve(codigo_empresa,il_orden_preparacion_preparo)
					
					tab_1.tp_preparacion_bulto.uo_lectura_origen.f_reset() //event ue_refrescar()
					tab_1.tp_preparacion_bulto.uo_lectura_destino.event ue_refrescar()
					
					if tab_1.tp_preparacion_bulto.uo_lectura_destino.il_id_bulto <> 0 then		
						if ib_ubicar_tras_preparar then		
							
							window lw_ventana 
							str_parametros lstr_param 
							
							string ls_tipo_ventana
							long   ll_rf_parametros_ventanas_id = 11
							
							ls_tipo_ventana = f_rf_parametros_ventanas_tipo_ventana(ll_rf_parametros_ventanas_id)
							
							lstr_param.i_nargumentos   = 3
							lstr_param.s_argumentos[2] = string(ll_rf_parametros_ventanas_id)
							lstr_param.s_argumentos[3] = tab_1.tp_preparacion_bulto.uo_lectura_destino.sle_codbar.text
							
							OpenWithParm(lw_ventana, lstr_param , ls_tipo_ventana)	
							lw_ventana.Show( )
																					
							ib_ubicar_tras_preparar = false
							
						end if
					end if
					//
				else
					rollback;
					Messagebox("Error","No se ha generado el movimiento")
				end if			
			else
				//Error por no seleccionar la misma orden de carga
				Messagebox("Error","No se han seleccionado bultos de la misma O.C.")
			end if			
		else
			Messagebox("Error","Debe indicar la cantidad a traspasar")
		end if
			
	else
		//Error al no seleccionar distintos bultos
		Messagebox("Error","No se han seleccionado distintos bultos")
	end if
else
	if tab_1.tp_preparacion_bulto.uo_lectura_origen.ii_bultos > 1 then
		Messagebox("Error","Ha seleccionado un origen con mas de un bulto")
	else
		Messagebox("Error","No se ha seleccionado el origen del traspaso")
	end if
end if

if lb_cerrar then
	//close(parent)
else
	tab_1.tp_preparacion_bulto.uo_lectura_origen.SetFocus()
	tab_1.tp_preparacion_bulto.uo_lectura_origen.event getfocus()
end if
end event

type pb_atras from picturebutton within tp_preparacion_bulto
integer y = 1968
integer width = 800
integer height = 700
integer taborder = 60
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

type uo_lectura_destino from u_sle_codbar within tp_preparacion_bulto
event destroy ( )
integer y = 1096
integer height = 152
integer taborder = 50
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
pb_aceptar.visible         = false
end event

event modified;call super::modified;long ll_donde

if il_id_bulto = 0 then
	f_reset()
	messagebox("¡Atención!","Debe seleccionar un bulto.",StopSign!)
	uo_lectura_destino.SetFocus()
	uo_lectura_destino.event getfocus()			
else
	if il_id_bulto = uo_lectura_origen.il_id_bulto then
		f_reset()
		messagebox("¡Atención!","Debe seleccionar un bulto distinto al origen.",StopSign!)
		uo_lectura_destino.SetFocus()
		uo_lectura_destino.event getfocus()				
	else
		//Comprobar si el bulto está vacio o las lineas que lo componen tienen material de la orden que estamos preparando
		
		long ll_lineas_reservadas_otra_orden,ll_lineas_reservadas_misma_orden
		
		SELECT isnull(count(venliped.id_alm_orden_carga),0)
		INTO   :ll_lineas_reservadas_otra_orden
		FROM alm_bultos,   
			  alm_bultos_lineas,   
			  venliped,   
			  venliped_reservas  
		WHERE ( alm_bultos.id               = alm_bultos_lineas.id_alm_bultos ) 
		and   ( alm_bultos_lineas.id        = venliped_reservas.alm_bultos_lineas_id ) 
		and   ( venliped_reservas.empresa   = venliped.empresa ) 
		and   ( venliped_reservas.anyo      = venliped.anyo ) 
		and   ( venliped_reservas.pedido    = venliped.pedido ) 
		and   ( venliped_reservas.linea     = venliped.linea ) 
		and ( ( alm_bultos.id               = :il_id_bulto ) 
		and   ( venliped.id_alm_orden_carga <> :il_orden_carga_preparo ) );
		
		SELECT isnull(count(venliped.id_alm_orden_carga),0)
		INTO   :ll_lineas_reservadas_misma_orden
		FROM alm_bultos,   
			  alm_bultos_lineas,   
			  venliped,   
			  venliped_reservas  
		WHERE ( alm_bultos.id               = alm_bultos_lineas.id_alm_bultos ) 
		and   ( alm_bultos_lineas.id        = venliped_reservas.alm_bultos_lineas_id ) 
		and   ( venliped_reservas.empresa   = venliped.empresa ) 
		and   ( venliped_reservas.anyo      = venliped.anyo ) 
		and   ( venliped_reservas.pedido    = venliped.pedido ) 
		and   ( venliped_reservas.linea     = venliped.linea ) 
		and ( ( alm_bultos.id               = :il_id_bulto ) 
		and   ( venliped.id_alm_orden_carga = :il_orden_carga_preparo ) );		
		
		if ll_lineas_reservadas_otra_orden > 0 then
			f_reset()
			messagebox("¡Atención!","Debe seleccionar un bulto no asociado a otra orden de carga.",StopSign!)
			uo_lectura_destino.SetFocus()
			uo_lectura_destino.event getfocus()						
		end if
	end if
end if
end event

event ue_siguiente_objeto;call super::ue_siguiente_objeto;ii_paso_actual = 3

pb_aceptar.visible         = true
pb_aceptar.SetFocus()
end event

type uo_lectura_origen from u_sle_codbar within tp_preparacion_bulto
event destroy ( )
integer y = 168
integer taborder = 20
boolean ib_mostrar_desplegado = true
boolean ib_obligatorio_marcar_una_linea = true
string is_descripcion = "LECTURA ORIGEN"
end type

on uo_lectura_origen.destroy
call u_sle_codbar::destroy
end on

event getfocus;call super::getfocus;ii_paso_actual = 1

tab_1.tp_preparacion_bulto.st_paso1.backcolor         = il_color_fondo_activo
tab_1.tp_preparacion_bulto.st_paso2.backcolor         = il_color_fondo_inactivo

tab_1.tp_preparacion_bulto.uo_lectura_destino.visible = false
tab_1.tp_preparacion_bulto.pb_atras.visible           = false
tab_1.tp_preparacion_bulto.pb_aceptar.visible         = false

tab_1.tp_preparacion_bulto.em_pallets.text = "0"
tab_1.tp_preparacion_bulto.em_cajas.text   = "0"
tab_1.tp_preparacion_bulto.em_piezas.text  = "0"

tab_1.tp_preparacion_bulto.p_subir2.enabled = true
tab_1.tp_preparacion_bulto.p_bajar2.enabled = true

ib_lanzar_modified = false
tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.selectrow(0,false)
ib_lanzar_modified = true
end event

event modified;call super::modified;long ll_donde

if il_id_bulto = 0 or ii_lineas_bulto = 0 then
	f_reset()
	messagebox("¡Atención!","Debe seleccionar un bulto con contenido.",StopSign!)
	this.SetFocus()
	this.event getfocus()	
else
	if ii_bultos > 1 then
		Messagebox("Error","Ha seleccionado un origen con mas de un bulto~nDebe hacer la lectura de la etiqueta del bulto.")
		this.SetFocus()
		this.event getfocus()			
	else	
		ll_donde = tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.find("alm_bultos_id = "+string(il_id_bulto),1,tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.rowcount())
		
		if ll_donde > 0 then
			tab_1.tp_preparacion_bulto.p_subir2.enabled = false
			tab_1.tp_preparacion_bulto.p_bajar2.enabled = false

			tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.selectrow(0,false)
			tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.selectrow(ll_donde,true)
			tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.setrow(ll_donde)
			tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.scrolltorow(ll_donde)
			
			tab_1.tp_preparacion_bulto.dw_lineas_picos_orden.event rowfocuschanged(ll_donde)
		else
			//f_reset()
			messagebox("¡Atención!","Debe seleccionar un bulto de la orden.",StopSign!)			
			this.SetFocus()
			this.event getfocus()							
		end if
	end if	
end if




/*
if il_id_bulto = 0 or ii_lineas_bulto = 0 then
	f_reset()
	messagebox("¡Atención!","Debe seleccionar un bulto con contenido.",StopSign!)
	this.SetFocus()
	this.event getfocus()	
else
	if ii_bultos > 1 then
		Messagebox("Error","Ha seleccionado un origen con mas de un bulto~nDebe hacer la lectura de la etiqueta del bulto.")
		this.SetFocus()
		this.event getfocus()			
	else
		string ls_articulo,ls_pallet,ls_caja
		int    li_piezas_caja,li_cajas_maximas
		long   ll_piezas_pallet,ll_piezas_bulto, li_cajas_pallet
				
		ls_articulo     = uo_lectura_origen.is_codigo_articulo
		ls_pallet       = uo_lectura_origen.is_codigo_pallet
		ls_caja         = uo_lectura_origen.is_codigo_caja
		ll_piezas_bulto = uo_lectura_origen.il_piezas - uo_lectura_origen.il_piezas_reservadas_bulto
	
//Solo controlamos la piezas reservadas de ese bulto	
//		if ll_piezas_bulto > uo_lectura_origen.il_piezas_disponibles_totales then
//			ll_piezas_bulto = uo_lectura_origen.il_piezas_disponibles_totales
//		end if
		
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
				
		if ll_piezas_bulto >= ll_piezas_pallet and ll_piezas_pallet > 0 then
		else
		end if
		//editmask			
	end if	
end if
*/
end event

event ue_siguiente_objeto;call super::ue_siguiente_objeto;uo_lectura_destino.visible = true

uo_lectura_destino.SetFocus()
uo_lectura_destino.event getfocus()
end event

event ue_pre_siguiente_objeto;call super::ue_pre_siguiente_objeto;pb_atras.visible           = true
end event

type st_paso2 from statictext within tp_preparacion_bulto
integer x = 1463
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
boolean enabled = false
string text = "Bulto Destino"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_paso1 from statictext within tp_preparacion_bulto
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
string text = "Bulto Origen"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type r_barra2 from rectangle within tp_preparacion_bulto
integer linethickness = 4
long fillcolor = 12632256
integer x = 4357
integer y = 1476
integer width = 265
integer height = 264
end type

type r_indicador2 from rectangle within tp_preparacion_bulto
integer linethickness = 4
long fillcolor = 8421504
integer x = 4357
integer y = 1476
integer width = 265
integer height = 44
end type

type tp_mover_pallets from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4645
integer height = 2668
long backcolor = 67108864
string text = "Mover Pallets Completos"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

