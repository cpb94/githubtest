$PBExportHeader$rf_entradas_produccion_original.srw
forward
global type rf_entradas_produccion_original from window
end type
type pb_4 from picturebutton within rf_entradas_produccion_original
end type
type pb_3 from picturebutton within rf_entradas_produccion_original
end type
type pb_2 from picturebutton within rf_entradas_produccion_original
end type
type pb_1 from picturebutton within rf_entradas_produccion_original
end type
type pb_menos_pallet from picturebutton within rf_entradas_produccion_original
end type
type pb_mas_pallet from picturebutton within rf_entradas_produccion_original
end type
type em_piezas from editmask within rf_entradas_produccion_original
end type
type em_cajas from editmask within rf_entradas_produccion_original
end type
type em_pallets from editmask within rf_entradas_produccion_original
end type
type st_1 from statictext within rf_entradas_produccion_original
end type
type st_pallets from statictext within rf_entradas_produccion_original
end type
type pb_aceptar from picturebutton within rf_entradas_produccion_original
end type
type uo_lectura_pallet from u_sle_codbar_original within rf_entradas_produccion_original
end type
type uo_lectura_caja from u_sle_codbar_original within rf_entradas_produccion_original
end type
type st_cajas from statictext within rf_entradas_produccion_original
end type
type gb_1 from groupbox within rf_entradas_produccion_original
end type
type pb_cancelar from picturebutton within rf_entradas_produccion_original
end type
end forward

global type rf_entradas_produccion_original from window
integer width = 4718
integer height = 2504
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
pb_menos_pallet pb_menos_pallet
pb_mas_pallet pb_mas_pallet
em_piezas em_piezas
em_cajas em_cajas
em_pallets em_pallets
st_1 st_1
st_pallets st_pallets
pb_aceptar pb_aceptar
uo_lectura_pallet uo_lectura_pallet
uo_lectura_caja uo_lectura_caja
st_cajas st_cajas
gb_1 gb_1
pb_cancelar pb_cancelar
end type
global rf_entradas_produccion_original rf_entradas_produccion_original

type variables
string is_tipo_movimiento = '1'
string is_almacen = '7'
string is_zona = 'A'
int    ii_fila = 1
int    ii_altura = 1
end variables

on rf_entradas_produccion_original.create
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.pb_menos_pallet=create pb_menos_pallet
this.pb_mas_pallet=create pb_mas_pallet
this.em_piezas=create em_piezas
this.em_cajas=create em_cajas
this.em_pallets=create em_pallets
this.st_1=create st_1
this.st_pallets=create st_pallets
this.pb_aceptar=create pb_aceptar
this.uo_lectura_pallet=create uo_lectura_pallet
this.uo_lectura_caja=create uo_lectura_caja
this.st_cajas=create st_cajas
this.gb_1=create gb_1
this.pb_cancelar=create pb_cancelar
this.Control[]={this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1,&
this.pb_menos_pallet,&
this.pb_mas_pallet,&
this.em_piezas,&
this.em_cajas,&
this.em_pallets,&
this.st_1,&
this.st_pallets,&
this.pb_aceptar,&
this.uo_lectura_pallet,&
this.uo_lectura_caja,&
this.st_cajas,&
this.gb_1,&
this.pb_cancelar}
end on

on rf_entradas_produccion_original.destroy
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.pb_menos_pallet)
destroy(this.pb_mas_pallet)
destroy(this.em_piezas)
destroy(this.em_cajas)
destroy(this.em_pallets)
destroy(this.st_1)
destroy(this.st_pallets)
destroy(this.pb_aceptar)
destroy(this.uo_lectura_pallet)
destroy(this.uo_lectura_caja)
destroy(this.st_cajas)
destroy(this.gb_1)
destroy(this.pb_cancelar)
end on

type pb_4 from picturebutton within rf_entradas_produccion_original
integer x = 4352
integer y = 1548
integer width = 165
integer height = 144
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

type pb_3 from picturebutton within rf_entradas_produccion_original
integer x = 4187
integer y = 1548
integer width = 165
integer height = 144
integer taborder = 60
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

type pb_2 from picturebutton within rf_entradas_produccion_original
integer x = 4352
integer y = 1404
integer width = 165
integer height = 144
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

type pb_1 from picturebutton within rf_entradas_produccion_original
integer x = 4187
integer y = 1404
integer width = 165
integer height = 144
integer taborder = 50
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

type pb_menos_pallet from picturebutton within rf_entradas_produccion_original
integer x = 4352
integer y = 1260
integer width = 165
integer height = 144
integer taborder = 50
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

type pb_mas_pallet from picturebutton within rf_entradas_produccion_original
integer x = 4187
integer y = 1260
integer width = 165
integer height = 144
integer taborder = 40
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

type em_piezas from editmask within rf_entradas_produccion_original
event clicked pbm_bnclicked
integer x = 3822
integer y = 1568
integer width = 357
integer height = 108
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "0~~9999"
end type

event modified;string cadena,ls_articulos_unidad,ls_codigo_articulo,ls_codigo_caja,ls_m2 
dec    ld_metroscaja,ld_m2
int    posi_aux,posi,li_piezas,li_piezascaja

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
		em_piezas.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
else
	em_pallets.text     = "0"
	em_cajas.text       = "0"
end if
end event

event losefocus;this.event modified()
end event

type em_cajas from editmask within rf_entradas_produccion_original
event clicked pbm_bnclicked
integer x = 3822
integer y = 1424
integer width = 357
integer height = 108
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "0~~9999"
end type

event modified;string cadena 
int    posi_aux,posi

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

event losefocus;this.event modified()
end event

type em_pallets from editmask within rf_entradas_produccion_original
event clicked pbm_bnclicked
integer x = 3822
integer y = 1280
integer width = 357
integer height = 108
integer taborder = 40
integer textsize = -12
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
boolean spin = true
double increment = 1
string minmax = "0~~1"
end type

event clicked;this.event modified()
end event

event modified;string cadena
int    posi_aux,posi

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

event losefocus;this.event modified()
end event

type st_1 from statictext within rf_entradas_produccion_original
integer x = 3525
integer y = 1568
integer width = 283
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Piezas"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_pallets from statictext within rf_entradas_produccion_original
integer x = 3525
integer y = 1280
integer width = 283
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pallets"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_aceptar from picturebutton within rf_entradas_produccion_original
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

if dec(em_piezas.text) > 0 then
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
	lstr_movimiento_almacen.almacen            = is_almacen
	lstr_movimiento_almacen.zona               = is_zona
	lstr_movimiento_almacen.fila               = ii_fila
	lstr_movimiento_almacen.altura             = ii_altura
	lstr_movimiento_almacen.tercero            = ""
	lstr_movimiento_almacen.documento          = ""
	lstr_movimiento_almacen.fecha              = datetime(today())
	lstr_movimiento_almacen.id_ubicacion       = 0
	lstr_movimiento_almacen.id_alm_bultos		 = uo_lectura_pallet.il_id_bulto
	
	//Introduce pallet a pallet
	if f_movimiento_almacen(lstr_movimiento_almacen) then
		commit;
		uo_lectura_pallet.event ue_refrescar()
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

type uo_lectura_pallet from u_sle_codbar_original within rf_entradas_produccion_original
integer x = 5
integer y = 1200
integer taborder = 20
string is_descripcion = "LECTURA BULTO"
end type

on uo_lectura_pallet.destroy
call u_sle_codbar_original::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;em_pallets.setfocus()
end event

type uo_lectura_caja from u_sle_codbar_original within rf_entradas_produccion_original
integer x = 5
integer y = 4
integer taborder = 10
string is_tipo_codigo = "EAN128"
string is_descripcion = "LECTURA CAJA"
end type

on uo_lectura_caja.destroy
call u_sle_codbar_original::destroy
end on

event modified;call super::modified;string ls_articulo,ls_pallet,ls_caja
int li_piezas_caja,li_piezas_pallet
long li_cajas_pallet

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
		 :li_piezas_pallet 
from   almartcajas,palarticulo
where  almartcajas.empresa  = palarticulo.empresa 
and    almartcajas.articulo = palarticulo.articulo 
and    almartcajas.caja     = palarticulo.caja 
and    almartcajas.empresa  = :codigo_empresa 
and    almartcajas.articulo = :ls_articulo 
and    almartcajas.caja     = :ls_caja 
and    palarticulo.codigo   = :ls_pallet;

em_cajas.minmax = "0~~"+string(li_cajas_pallet,"##0")
em_piezas.minmax = "0~~"+string(li_piezas_pallet,"####0")
//editmask
end event

event ue_siguiente_objeto;call super::ue_siguiente_objeto;uo_lectura_pallet.SetFocus()
uo_lectura_pallet.event getfocus()
end event

type st_cajas from statictext within rf_entradas_produccion_original
integer x = 3525
integer y = 1424
integer width = 283
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cajas"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_1 from groupbox within rf_entradas_produccion_original
integer x = 3433
integer y = 1196
integer width = 1161
integer height = 524
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unidades"
end type

type pb_cancelar from picturebutton within rf_entradas_produccion_original
integer x = 3365
integer y = 1820
integer width = 654
integer height = 572
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\Cross.png"
string disabledname = "C:\bmp\RF\Cross_dis.png"
alignment htextalign = left!
end type

event clicked;uo_lectura_caja.f_reset()
uo_lectura_pallet.f_reset()

uo_lectura_caja.SetFocus()
uo_lectura_caja.event getfocus()
end event

