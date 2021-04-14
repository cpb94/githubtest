$PBExportHeader$rf_entradas_produccion_tab.srw
forward
global type rf_entradas_produccion_tab from window
end type
type tab_1 from tab within rf_entradas_produccion_tab
end type
type tabpage_1 from userobject within tab_1
end type
type uo_lectura_caja from u_sle_codbar within tabpage_1
end type
type tabpage_1 from userobject within tab_1
uo_lectura_caja uo_lectura_caja
end type
type tabpage_2 from userobject within tab_1
end type
type uo_lectura_pallet from u_sle_codbar within tabpage_2
end type
type tabpage_2 from userobject within tab_1
uo_lectura_pallet uo_lectura_pallet
end type
type tabpage_3 from userobject within tab_1
end type
type pb_cancelar from picturebutton within tabpage_3
end type
type st_cajas from statictext within tabpage_3
end type
type pb_aceptar from picturebutton within tabpage_3
end type
type st_pallets from statictext within tabpage_3
end type
type st_1 from statictext within tabpage_3
end type
type em_pallets from editmask within tabpage_3
end type
type em_cajas from editmask within tabpage_3
end type
type em_piezas from editmask within tabpage_3
end type
type pb_mas_pallet from picturebutton within tabpage_3
end type
type pb_menos_pallet from picturebutton within tabpage_3
end type
type pb_1 from picturebutton within tabpage_3
end type
type pb_2 from picturebutton within tabpage_3
end type
type pb_3 from picturebutton within tabpage_3
end type
type pb_4 from picturebutton within tabpage_3
end type
type gb_1 from groupbox within tabpage_3
end type
type st_pagina3 from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
pb_cancelar pb_cancelar
st_cajas st_cajas
pb_aceptar pb_aceptar
st_pallets st_pallets
st_1 st_1
em_pallets em_pallets
em_cajas em_cajas
em_piezas em_piezas
pb_mas_pallet pb_mas_pallet
pb_menos_pallet pb_menos_pallet
pb_1 pb_1
pb_2 pb_2
pb_3 pb_3
pb_4 pb_4
gb_1 gb_1
st_pagina3 st_pagina3
end type
type tab_1 from tab within rf_entradas_produccion_tab
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type rf_entradas_produccion_tab from window
integer width = 4718
integer height = 2504
boolean titlebar = true
string title = "Entradas Producción"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
tab_1 tab_1
end type
global rf_entradas_produccion_tab rf_entradas_produccion_tab

type variables
string is_tipo_movimiento = '1'
string is_almacen = '7'
string is_zona = 'A'
int    ii_fila = 1
int    ii_altura = 1
end variables

on rf_entradas_produccion_tab.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on rf_entradas_produccion_tab.destroy
destroy(this.tab_1)
end on

event open;tab_1.SelectTab(1)
tab_1.tabpage_1.uo_lectura_caja.SetFocus()
tab_1.tabpage_1.uo_lectura_caja.event getfocus()
end event

type tab_1 from tab within rf_entradas_produccion_tab
event create ( )
event destroy ( )
integer width = 4681
integer height = 2396
integer taborder = 40
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;choose case newindex
	case 1
		tab_1.tabpage_1.uo_lectura_caja.SetFocus()
		tab_1.tabpage_1.uo_lectura_caja.event getfocus()		
	case 2
		tab_1.tabpage_2.uo_lectura_pallet.SetFocus()
		tab_1.tabpage_2.uo_lectura_pallet.event getfocus()		
	case 3
		tab_1.tabpage_3.em_pallets.setfocus()
end choose
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 176
integer width = 4645
integer height = 2204
long backcolor = 67108864
string text = "1º"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uo_lectura_caja uo_lectura_caja
end type

on tabpage_1.create
this.uo_lectura_caja=create uo_lectura_caja
this.Control[]={this.uo_lectura_caja}
end on

on tabpage_1.destroy
destroy(this.uo_lectura_caja)
end on

type uo_lectura_caja from u_sle_codbar within tabpage_1
event destroy ( )
integer taborder = 20
string is_tipo_codigo = "EAN128"
boolean ib_permitir_ir_atras = false
string is_descripcion = "LECTURA CAJA"
end type

on uo_lectura_caja.destroy
call u_sle_codbar::destroy
end on

event modified;call super::modified;string ls_articulo,ls_pallet,ls_caja
int li_piezas_caja,li_piezas_pallet
long li_cajas_pallet

tab_1.tabpage_3.em_pallets.text = "0"
tab_1.tabpage_3.em_cajas.text   = "0"
tab_1.tabpage_3.em_piezas.text  = "0"

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

tab_1.tabpage_3.em_cajas.minmax = "0~~"+string(li_cajas_pallet,"##0")
tab_1.tabpage_3.em_piezas.minmax = "0~~"+string(li_piezas_pallet,"####0")
//editmask
end event

event ue_siguiente_objeto;call super::ue_siguiente_objeto;tab_1.SelectTab(2)
tab_1.tabpage_2.uo_lectura_pallet.SetFocus()
tab_1.tabpage_2.uo_lectura_pallet.event getfocus()
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 176
integer width = 4645
integer height = 2204
long backcolor = 67108864
string text = "2º"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uo_lectura_pallet uo_lectura_pallet
end type

on tabpage_2.create
this.uo_lectura_pallet=create uo_lectura_pallet
this.Control[]={this.uo_lectura_pallet}
end on

on tabpage_2.destroy
destroy(this.uo_lectura_pallet)
end on

type uo_lectura_pallet from u_sle_codbar within tabpage_2
event destroy ( )
integer taborder = 30
string is_descripcion = "LECTURA BULTO"
end type

on uo_lectura_pallet.destroy
call u_sle_codbar::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;tab_1.SelectTab(3)
tab_1.tabpage_3.em_pallets.setfocus()
end event

event ue_anterior_objeto;call super::ue_anterior_objeto;tab_1.SelectTab(1)
tab_1.tabpage_1.uo_lectura_caja.SetFocus()
tab_1.tabpage_1.uo_lectura_caja.event getfocus()
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 176
integer width = 4645
integer height = 2204
long backcolor = 67108864
string text = "3º"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_cancelar pb_cancelar
st_cajas st_cajas
pb_aceptar pb_aceptar
st_pallets st_pallets
st_1 st_1
em_pallets em_pallets
em_cajas em_cajas
em_piezas em_piezas
pb_mas_pallet pb_mas_pallet
pb_menos_pallet pb_menos_pallet
pb_1 pb_1
pb_2 pb_2
pb_3 pb_3
pb_4 pb_4
gb_1 gb_1
st_pagina3 st_pagina3
end type

on tabpage_3.create
this.pb_cancelar=create pb_cancelar
this.st_cajas=create st_cajas
this.pb_aceptar=create pb_aceptar
this.st_pallets=create st_pallets
this.st_1=create st_1
this.em_pallets=create em_pallets
this.em_cajas=create em_cajas
this.em_piezas=create em_piezas
this.pb_mas_pallet=create pb_mas_pallet
this.pb_menos_pallet=create pb_menos_pallet
this.pb_1=create pb_1
this.pb_2=create pb_2
this.pb_3=create pb_3
this.pb_4=create pb_4
this.gb_1=create gb_1
this.st_pagina3=create st_pagina3
this.Control[]={this.pb_cancelar,&
this.st_cajas,&
this.pb_aceptar,&
this.st_pallets,&
this.st_1,&
this.em_pallets,&
this.em_cajas,&
this.em_piezas,&
this.pb_mas_pallet,&
this.pb_menos_pallet,&
this.pb_1,&
this.pb_2,&
this.pb_3,&
this.pb_4,&
this.gb_1,&
this.st_pagina3}
end on

on tabpage_3.destroy
destroy(this.pb_cancelar)
destroy(this.st_cajas)
destroy(this.pb_aceptar)
destroy(this.st_pallets)
destroy(this.st_1)
destroy(this.em_pallets)
destroy(this.em_cajas)
destroy(this.em_piezas)
destroy(this.pb_mas_pallet)
destroy(this.pb_menos_pallet)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.pb_4)
destroy(this.gb_1)
destroy(this.st_pagina3)
end on

type pb_cancelar from picturebutton within tabpage_3
integer x = 4485
integer y = 8
integer width = 146
integer height = 128
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\Back.png"
string disabledname = "C:\bmp\RF\Back_dis.gif"
alignment htextalign = left!
end type

event clicked;//tab_1.tabpage_1.uo_lectura_caja.f_reset()
//tab_1.tabpage_2.uo_lectura_pallet.f_reset()
//
//tab_1.tabpage_1.uo_lectura_caja.SetFocus()
//tab_1.tabpage_1.uo_lectura_caja.event getfocus()

tab_1.SelectTab(2)
tab_1.tabpage_2.uo_lectura_pallet.SetFocus()
tab_1.tabpage_2.uo_lectura_pallet.event getfocus()
end event

type st_cajas from statictext within tabpage_3
integer x = 873
integer y = 884
integer width = 443
integer height = 156
integer textsize = -20
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

type pb_aceptar from picturebutton within tabpage_3
integer x = 2121
integer y = 644
integer width = 709
integer height = 620
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

if dec(em_piezas.text) > 0 then
	lstr_movimiento_almacen.empresa            = codigo_empresa
	lstr_movimiento_almacen.articulo           = tab_1.tabpage_1.uo_lectura_caja.is_codigo_articulo
	lstr_movimiento_almacen.calidad            = tab_1.tabpage_1.uo_lectura_caja.is_codigo_calidad
	lstr_movimiento_almacen.tono               = tab_1.tabpage_1.uo_lectura_caja.is_lote
	lstr_movimiento_almacen.calibre            = tab_1.tabpage_1.uo_lectura_caja.ii_calibre
	lstr_movimiento_almacen.tipo_pallet        = tab_1.tabpage_1.uo_lectura_caja.is_codigo_pallet
	lstr_movimiento_almacen.caja               = tab_1.tabpage_1.uo_lectura_caja.is_codigo_caja
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
	lstr_movimiento_almacen.id_alm_bultos		 = tab_1.tabpage_2.uo_lectura_pallet.il_id_bulto
	
	//Introduce pallet a pallet
	if f_movimiento_almacen(lstr_movimiento_almacen) then
		commit;
		tab_1.tabpage_2.uo_lectura_pallet.event ue_refrescar()
	else
		rollback;
		Messagebox("Error","No se ha generado el movimiento")
	end if
	
	tab_1.tabpage_1.uo_lectura_caja.SetFocus()
	tab_1.tabpage_1.uo_lectura_caja.event getfocus()
else
	Messagebox("Error","No se ha indicado el numero de piezas")
end if
end event

type st_pallets from statictext within tabpage_3
integer x = 873
integer y = 700
integer width = 443
integer height = 156
integer textsize = -20
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

type st_1 from statictext within tabpage_3
integer x = 873
integer y = 1068
integer width = 443
integer height = 156
integer textsize = -20
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

type em_pallets from editmask within tabpage_3
event clicked pbm_bnclicked
integer x = 1330
integer y = 700
integer width = 357
integer height = 156
integer taborder = 40
integer textsize = -20
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

event losefocus;this.event modified()
end event

event modified;string cadena
int    posi_aux,posi

if integer(this.text) > 0 then
	
	cadena = f_calculo_unidades_piezas(codigo_empresa,tab_1.tabpage_1.uo_lectura_caja.is_codigo_articulo,&
									  tab_1.tabpage_1.uo_lectura_caja.is_codigo_pallet,&
									  tab_1.tabpage_1.uo_lectura_caja.is_codigo_caja,&
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

type em_cajas from editmask within tabpage_3
event clicked pbm_bnclicked
integer x = 1330
integer y = 884
integer width = 357
integer height = 156
integer taborder = 60
integer textsize = -20
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

event losefocus;this.event modified()
end event

event modified;string cadena 
int    posi_aux,posi

if integer(this.text) > 0 then
	cadena = f_calculo_unidades_piezas(codigo_empresa,tab_1.tabpage_1.uo_lectura_caja.is_codigo_articulo,&
									  tab_1.tabpage_1.uo_lectura_caja.is_codigo_pallet,&
									  tab_1.tabpage_1.uo_lectura_caja.is_codigo_caja,&
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

type em_piezas from editmask within tabpage_3
event clicked pbm_bnclicked
integer x = 1330
integer y = 1068
integer width = 357
integer height = 156
integer taborder = 60
integer textsize = -20
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

event losefocus;this.event modified()
end event

event modified;string cadena,ls_articulos_unidad,ls_codigo_articulo,ls_codigo_caja,ls_m2 
dec    ld_metroscaja,ld_m2
int    posi_aux,posi,li_piezas,li_piezascaja

if integer(this.text) > 0 then
	li_piezas = dec(this.text)
	
	ls_codigo_articulo = tab_1.tabpage_1.uo_lectura_caja.is_codigo_articulo
	ls_codigo_caja     = tab_1.tabpage_1.uo_lectura_caja.is_codigo_caja
	
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
		
		cadena = f_calculo_unidades_piezas(codigo_empresa,tab_1.tabpage_1.uo_lectura_caja.is_codigo_articulo,&
										  tab_1.tabpage_1.uo_lectura_caja.is_codigo_pallet,&
										  tab_1.tabpage_1.uo_lectura_caja.is_codigo_caja,&
										  0,&
										  0,ld_m2, "")
	else
		cadena = f_calculo_unidades_piezas(codigo_empresa,tab_1.tabpage_1.uo_lectura_caja.is_codigo_articulo,&
										  tab_1.tabpage_1.uo_lectura_caja.is_codigo_pallet,&
										  tab_1.tabpage_1.uo_lectura_caja.is_codigo_caja,&
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

type pb_mas_pallet from picturebutton within tabpage_3
integer x = 1696
integer y = 696
integer width = 187
integer height = 164
integer taborder = 30
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

type pb_menos_pallet from picturebutton within tabpage_3
integer x = 1883
integer y = 696
integer width = 187
integer height = 164
integer taborder = 30
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

type pb_1 from picturebutton within tabpage_3
integer x = 1696
integer y = 880
integer width = 187
integer height = 164
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

type pb_2 from picturebutton within tabpage_3
integer x = 1883
integer y = 880
integer width = 187
integer height = 164
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

type pb_3 from picturebutton within tabpage_3
integer x = 1696
integer y = 1064
integer width = 187
integer height = 164
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

type pb_4 from picturebutton within tabpage_3
integer x = 1883
integer y = 1064
integer width = 187
integer height = 164
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

type gb_1 from groupbox within tabpage_3
integer x = 823
integer y = 584
integer width = 1289
integer height = 676
integer taborder = 20
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unidades"
end type

type st_pagina3 from statictext within tabpage_3
integer x = 1504
integer width = 3131
integer height = 144
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cantidades y Validación"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

