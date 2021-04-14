$PBExportHeader$wi_mant_anyade_paking_masivo.srw
forward
global type wi_mant_anyade_paking_masivo from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_mant_anyade_paking_masivo
end type
type pb_imprimir from upb_imprimir within wi_mant_anyade_paking_masivo
end type
type uo_manejo from u_manejo_datawindow within wi_mant_anyade_paking_masivo
end type
type uo_formato from u_em_campo_2 within wi_mant_anyade_paking_masivo
end type
type gb_1 from groupbox within wi_mant_anyade_paking_masivo
end type
type xx from groupbox within wi_mant_anyade_paking_masivo
end type
type gb_3 from groupbox within wi_mant_anyade_paking_masivo
end type
type gb_2 from groupbox within wi_mant_anyade_paking_masivo
end type
type cb_1 from u_boton within wi_mant_anyade_paking_masivo
end type
type uo_tipopallet from u_em_campo_2 within wi_mant_anyade_paking_masivo
end type
type st_1 from statictext within wi_mant_anyade_paking_masivo
end type
type st_4 from statictext within wi_mant_anyade_paking_masivo
end type
type p_1 from picture within wi_mant_anyade_paking_masivo
end type
type em_piezas_caja from u_em_campo within wi_mant_anyade_paking_masivo
end type
type dw_1 from datawindow within wi_mant_anyade_paking_masivo
end type
type uo_caja from u_em_campo_2 within wi_mant_anyade_paking_masivo
end type
type st_5 from statictext within wi_mant_anyade_paking_masivo
end type
type em_metros_caja from u_em_campo within wi_mant_anyade_paking_masivo
end type
type st_6 from statictext within wi_mant_anyade_paking_masivo
end type
type st_8 from statictext within wi_mant_anyade_paking_masivo
end type
type em_metrosl_caja from u_em_campo within wi_mant_anyade_paking_masivo
end type
type st_9 from statictext within wi_mant_anyade_paking_masivo
end type
type em_peso_caja from u_em_campo within wi_mant_anyade_paking_masivo
end type
type gb_4 from groupbox within wi_mant_anyade_paking_masivo
end type
type em_cajas_pallet from u_em_campo within wi_mant_anyade_paking_masivo
end type
type em_planos_pallet from u_em_campo within wi_mant_anyade_paking_masivo
end type
type em_alturas_pallet from u_em_campo within wi_mant_anyade_paking_masivo
end type
type st_10 from statictext within wi_mant_anyade_paking_masivo
end type
type st_11 from statictext within wi_mant_anyade_paking_masivo
end type
type st_12 from statictext within wi_mant_anyade_paking_masivo
end type
type uo_tipopallet_marca from u_em_campo_2 within wi_mant_anyade_paking_masivo
end type
type uo_caja_marca from u_em_campo_2 within wi_mant_anyade_paking_masivo
end type
type gb_6 from groupbox within wi_mant_anyade_paking_masivo
end type
type st_13 from statictext within wi_mant_anyade_paking_masivo
end type
type st_14 from statictext within wi_mant_anyade_paking_masivo
end type
type rb_coinciden from radiobutton within wi_mant_anyade_paking_masivo
end type
type rb_no_coinciden from radiobutton within wi_mant_anyade_paking_masivo
end type
type cb_2 from u_boton within wi_mant_anyade_paking_masivo
end type
type cb_3 from u_boton within wi_mant_anyade_paking_masivo
end type
type gb_5 from groupbox within wi_mant_anyade_paking_masivo
end type
type uo_cliente from u_em_campo_2 within wi_mant_anyade_paking_masivo
end type
end forward

global type wi_mant_anyade_paking_masivo from w_int_con_empresa
integer width = 3671
integer height = 2060
pb_1 pb_1
pb_imprimir pb_imprimir
uo_manejo uo_manejo
uo_formato uo_formato
gb_1 gb_1
xx xx
gb_3 gb_3
gb_2 gb_2
cb_1 cb_1
uo_tipopallet uo_tipopallet
st_1 st_1
st_4 st_4
p_1 p_1
em_piezas_caja em_piezas_caja
dw_1 dw_1
uo_caja uo_caja
st_5 st_5
em_metros_caja em_metros_caja
st_6 st_6
st_8 st_8
em_metrosl_caja em_metrosl_caja
st_9 st_9
em_peso_caja em_peso_caja
gb_4 gb_4
em_cajas_pallet em_cajas_pallet
em_planos_pallet em_planos_pallet
em_alturas_pallet em_alturas_pallet
st_10 st_10
st_11 st_11
st_12 st_12
uo_tipopallet_marca uo_tipopallet_marca
uo_caja_marca uo_caja_marca
gb_6 gb_6
st_13 st_13
st_14 st_14
rb_coinciden rb_coinciden
rb_no_coinciden rb_no_coinciden
cb_2 cb_2
cb_3 cb_3
gb_5 gb_5
uo_cliente uo_cliente
end type
global wi_mant_anyade_paking_masivo wi_mant_anyade_paking_masivo

type variables
boolean marca = false
end variables

forward prototypes
public function boolean f_stock_articulo_caja_pallet (string articulo, string caja, string pallet)
end prototypes

public function boolean f_stock_articulo_caja_pallet (string articulo, string caja, string pallet);dec stock
//Quitamos la empresa del select para comprobar en las dos empresas

select sum(existencias)
into   :stock
from   almlinubica
where  articulo    = :articulo
and    caja        = :caja
and    tipo_pallet = :pallet;

if isnull(stock) then stock = 0

if stock <> 0 then
	return true
else
	return false
end if
end function

on wi_mant_anyade_paking_masivo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.uo_manejo=create uo_manejo
this.uo_formato=create uo_formato
this.gb_1=create gb_1
this.xx=create xx
this.gb_3=create gb_3
this.gb_2=create gb_2
this.cb_1=create cb_1
this.uo_tipopallet=create uo_tipopallet
this.st_1=create st_1
this.st_4=create st_4
this.p_1=create p_1
this.em_piezas_caja=create em_piezas_caja
this.dw_1=create dw_1
this.uo_caja=create uo_caja
this.st_5=create st_5
this.em_metros_caja=create em_metros_caja
this.st_6=create st_6
this.st_8=create st_8
this.em_metrosl_caja=create em_metrosl_caja
this.st_9=create st_9
this.em_peso_caja=create em_peso_caja
this.gb_4=create gb_4
this.em_cajas_pallet=create em_cajas_pallet
this.em_planos_pallet=create em_planos_pallet
this.em_alturas_pallet=create em_alturas_pallet
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.uo_tipopallet_marca=create uo_tipopallet_marca
this.uo_caja_marca=create uo_caja_marca
this.gb_6=create gb_6
this.st_13=create st_13
this.st_14=create st_14
this.rb_coinciden=create rb_coinciden
this.rb_no_coinciden=create rb_no_coinciden
this.cb_2=create cb_2
this.cb_3=create cb_3
this.gb_5=create gb_5
this.uo_cliente=create uo_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.uo_formato
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.xx
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.uo_tipopallet
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.p_1
this.Control[iCurrent+14]=this.em_piezas_caja
this.Control[iCurrent+15]=this.dw_1
this.Control[iCurrent+16]=this.uo_caja
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.em_metros_caja
this.Control[iCurrent+19]=this.st_6
this.Control[iCurrent+20]=this.st_8
this.Control[iCurrent+21]=this.em_metrosl_caja
this.Control[iCurrent+22]=this.st_9
this.Control[iCurrent+23]=this.em_peso_caja
this.Control[iCurrent+24]=this.gb_4
this.Control[iCurrent+25]=this.em_cajas_pallet
this.Control[iCurrent+26]=this.em_planos_pallet
this.Control[iCurrent+27]=this.em_alturas_pallet
this.Control[iCurrent+28]=this.st_10
this.Control[iCurrent+29]=this.st_11
this.Control[iCurrent+30]=this.st_12
this.Control[iCurrent+31]=this.uo_tipopallet_marca
this.Control[iCurrent+32]=this.uo_caja_marca
this.Control[iCurrent+33]=this.gb_6
this.Control[iCurrent+34]=this.st_13
this.Control[iCurrent+35]=this.st_14
this.Control[iCurrent+36]=this.rb_coinciden
this.Control[iCurrent+37]=this.rb_no_coinciden
this.Control[iCurrent+38]=this.cb_2
this.Control[iCurrent+39]=this.cb_3
this.Control[iCurrent+40]=this.gb_5
this.Control[iCurrent+41]=this.uo_cliente
end on

on wi_mant_anyade_paking_masivo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.uo_manejo)
destroy(this.uo_formato)
destroy(this.gb_1)
destroy(this.xx)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.cb_1)
destroy(this.uo_tipopallet)
destroy(this.st_1)
destroy(this.st_4)
destroy(this.p_1)
destroy(this.em_piezas_caja)
destroy(this.dw_1)
destroy(this.uo_caja)
destroy(this.st_5)
destroy(this.em_metros_caja)
destroy(this.st_6)
destroy(this.st_8)
destroy(this.em_metrosl_caja)
destroy(this.st_9)
destroy(this.em_peso_caja)
destroy(this.gb_4)
destroy(this.em_cajas_pallet)
destroy(this.em_planos_pallet)
destroy(this.em_alturas_pallet)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.uo_tipopallet_marca)
destroy(this.uo_caja_marca)
destroy(this.gb_6)
destroy(this.st_13)
destroy(this.st_14)
destroy(this.rb_coinciden)
destroy(this.rb_no_coinciden)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.gb_5)
destroy(this.uo_cliente)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Añadir Paking Masivamente"
istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)

f_activar_campo(uo_formato.em_campo)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_anyade_paking_masivo
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_anyade_paking_masivo
end type

event sle_opcion_orden::getfocus;f_activar_campo(uo_formato.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_anyade_paking_masivo
end type

type pb_1 from upb_salir within wi_mant_anyade_paking_masivo
integer x = 3465
integer width = 123
integer height = 112
integer taborder = 0
end type

type pb_imprimir from upb_imprimir within wi_mant_anyade_paking_masivo
event clicked pbm_bnclicked
integer x = 3474
integer y = 136
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_1)
end event

type uo_manejo from u_manejo_datawindow within wi_mant_anyade_paking_masivo
event valores pbm_custom01
integer x = 2994
integer y = 88
integer width = 635
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_formato.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type uo_formato from u_em_campo_2 within wi_mant_anyade_paking_masivo
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 27
integer y = 144
integer width = 818
integer height = 72
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;this.em_campo.text=f_nombre_formato(codigo_empresa,this.em_codigo.text)
If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formatos"
ue_datawindow ="dw_ayuda_formatos"
ue_filtro = ""
end event

on uo_formato.destroy
call u_em_campo_2::destroy
end on

type gb_1 from groupbox within wi_mant_anyade_paking_masivo
integer x = 873
integer y = 96
integer width = 1225
integer height = 140
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Cliente"
end type

type xx from groupbox within wi_mant_anyade_paking_masivo
integer x = 2551
integer y = 92
integer width = 370
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
end type

type gb_3 from groupbox within wi_mant_anyade_paking_masivo
integer x = 2171
integer y = 92
integer width = 375
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
end type

type gb_2 from groupbox within wi_mant_anyade_paking_masivo
integer x = 5
integer y = 96
integer width = 869
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Formato"
end type

type cb_1 from u_boton within wi_mant_anyade_paking_masivo
integer x = 2185
integer y = 132
integer width = 347
integer height = 88
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;String formato,cliente


if IsNull(uo_formato.em_codigo.text) or Trim(uo_formato.em_codigo.text) = "" then
	f_mensaje("Consulta de Artículos","Introduzca el formato")
	f_activar_campo(uo_formato.em_campo)
	return
end if

formato = uo_formato.em_codigo.text

if uo_cliente.em_codigo.text = '' then
	cliente = "%"
else
	cliente = uo_cliente.em_codigo.text
end if

dw_1.Retrieve(codigo_empresa,formato,cliente)
end event

type uo_tipopallet from u_em_campo_2 within wi_mant_anyade_paking_masivo
event destroy ( )
integer x = 1527
integer y = 280
integer width = 265
integer height = 72
integer taborder = 100
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tipopallet.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_tipopallet.em_campo.text = f_nombre_pallet_abr(codigo_empresa,uo_tipopallet.em_codigo.text)
IF Trim(uo_tipopallet.em_campo.text) = "" THEN 
	IF Trim(uo_tipopallet.em_codigo.text) <> "" Then uo_tipopallet.em_campo.SetFocus()
	uo_tipopallet.em_campo.text  = ""
	uo_tipopallet.em_codigo.text = ""
END IF

f_activar_campo(uo_tipopallet.em_campo)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_pallets"
ue_filtro     = ""

end event

type st_1 from statictext within wi_mant_anyade_paking_masivo
integer x = 18
integer y = 288
integer width = 251
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Tipo Caja:"
boolean focusrectangle = false
end type

type st_4 from statictext within wi_mant_anyade_paking_masivo
integer x = 1243
integer y = 288
integer width = 270
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Tipo Pallet"
boolean focusrectangle = false
end type

type p_1 from picture within wi_mant_anyade_paking_masivo
integer x = 1088
integer y = 276
integer width = 110
integer height = 92
boolean bringtotop = true
string picturename = "c:\bmp\calcula.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Dec{3} peso_caja,peso_envase,peso_piezas,metros_caja,metrosl_caja,var_piezas,var_peso_pieza,var_largo,var_ancho
String cod_formato
if uo_formato.em_codigo.text <> "" and dec(em_piezas_caja.text) > 0 then
	var_piezas     = dec(em_piezas_caja.text)
	var_peso_pieza = f_peso_formato(codigo_empresa,uo_formato.em_codigo.text)
	peso_piezas    = var_peso_pieza  * var_piezas
	peso_envase    = f_peso_envase(codigo_empresa,uo_caja.em_codigo.text)
	
	peso_caja      = peso_envase + peso_piezas
	
	var_largo      = f_largo_formato(codigo_empresa,uo_formato.em_codigo.text)
	var_ancho      = f_ancho_formato(codigo_empresa,uo_formato.em_codigo.text)
	
	metros_caja  = (var_piezas * var_largo*var_ancho)/10000
	metrosl_caja = (var_piezas * var_largo)/100
	
	em_peso_caja.text    = string(peso_caja)
	em_metros_caja.text  = string(metros_caja)
	em_metrosl_caja.text = string(metrosl_caja)
	
end if
end event

type em_piezas_caja from u_em_campo within wi_mant_anyade_paking_masivo
integer x = 256
integer y = 360
integer width = 247
integer height = 72
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

type dw_1 from datawindow within wi_mant_anyade_paking_masivo
integer y = 532
integer width = 3593
integer height = 1296
string dataobject = "dw_mant_cambio_paking_masivo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param 
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[1]="wi_con_formatos_articulos"
lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
OpenWithParm(wi_mant_articulos,lstr_param)

end event

event clicked;long    indice,total
boolean coincide_pallet,coincide_caja

if dwo.name = "marca" then
	total = this.rowcount()
	if total > 0 then
		for indice = 1 to total
			if not(marca) then
				if uo_tipopallet_marca.em_codigo.text <> "" or uo_caja_marca.em_codigo.text <> "" then
					if uo_tipopallet_marca.em_codigo.text <> "" then
						if this.object.palarticulo_codigo[indice] = uo_tipopallet_marca.em_codigo.text then
							coincide_pallet = true
						else
							coincide_pallet = false
						end if
					else
						coincide_pallet = true
					end if
					if uo_caja_marca.em_codigo.text <> "" then
						if this.object.almartcajas_caja[indice] = uo_caja_marca.em_codigo.text then
							coincide_caja = true
						else
							coincide_caja = false
						end if
					else
						coincide_caja = true
					end if
					if coincide_pallet and coincide_caja then
						if rb_coinciden.checked then
							this.object.articulos_marca[indice] = "S"
						else
							this.object.articulos_marca[indice] = "N"
						end if
					else
						if rb_coinciden.checked then
							this.object.articulos_marca[indice] = "N"
						else
							this.object.articulos_marca[indice] = "S"
						end if
					end if
				else
					this.object.articulos_marca[indice] = "S"
				end if
			else
				this.object.articulos_marca[indice] = "N"
			end if
		next
		marca = not(marca)
	end if
end if
end event

event retrieveend;long   indice,total,donde
string sel,articulo,filtro_cliente
datastore articulos 

marca = false

if uo_cliente.em_codigo.text = "" then
	filtro_cliente = ""
else
	filtro_cliente = " and cliente = '"+uo_cliente.em_codigo.text+"' "
end if

sel = "SELECT codigo,descripcion,familia,pesopieza "+&
      "FROM articulos "+&   
      "WHERE empresa = '"+codigo_empresa+"' "+&
		"AND   formato = '"+uo_formato.em_codigo.text+"' "+&
		filtro_cliente

articulos = f_cargar_cursor(sel)

total = articulos.rowcount()

if total > 0 then
	dw_1.setredraw(false)
	for indice = 1 to total
		articulo = articulos.object.codigo[indice]
		if dw_1.find("codigo = '"+articulo+"'",1,dw_1.rowcount()) < 1 then
			donde = dw_1.insertrow(0)
			dw_1.object.codigo[donde]               = articulo
			dw_1.object.descripcion[donde]          = articulos.object.descripcion[indice]
			dw_1.object.familia[donde]              = articulos.object.familia[indice]
			dw_1.object.familias_descripcion[donde] = f_nombre_familia(codigo_empresa,articulos.object.familia[indice])
			dw_1.object.articulos_pesopieza[donde]  = articulos.object.pesopieza[indice]
		end if
	next	
	dw_1.sort()
	dw_1.groupcalc()
	dw_1.setredraw(true)
end if

destroy articulos
end event

type uo_caja from u_em_campo_2 within wi_mant_anyade_paking_masivo
event destroy ( )
integer x = 256
integer y = 280
integer width = 247
integer height = 72
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text = f_nombre_caja_abr(codigo_empresa,uo_caja.em_codigo.text)

IF Trim(uo_caja.em_campo.text) = ""  or IsNull(uo_caja.em_campo.text)THEN 
	IF Trim(uo_caja.em_codigo.text) <> "" Then 
		uo_caja.em_campo.SetFocus()
	END IF
	uo_caja.em_campo.text  = ""
	uo_caja.em_codigo.text = ""
END IF

f_activar_campo(uo_caja.em_campo)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_cajas"
ue_filtro     = ""


end event

type st_5 from statictext within wi_mant_anyade_paking_masivo
integer x = 18
integer y = 368
integer width = 229
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Piezas :"
boolean focusrectangle = false
end type

type em_metros_caja from u_em_campo within wi_mant_anyade_paking_masivo
integer x = 256
integer y = 444
integer width = 247
integer height = 72
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type st_6 from statictext within wi_mant_anyade_paking_masivo
integer x = 18
integer y = 452
integer width = 229
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Metros:"
boolean focusrectangle = false
end type

type st_8 from statictext within wi_mant_anyade_paking_masivo
integer x = 521
integer y = 288
integer width = 151
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "ML:"
boolean focusrectangle = false
end type

type em_metrosl_caja from u_em_campo within wi_mant_anyade_paking_masivo
integer x = 686
integer y = 280
integer width = 247
integer height = 72
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type st_9 from statictext within wi_mant_anyade_paking_masivo
integer x = 521
integer y = 368
integer width = 151
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Peso:"
boolean focusrectangle = false
end type

type em_peso_caja from u_em_campo within wi_mant_anyade_paking_masivo
integer x = 686
integer y = 360
integer width = 247
integer height = 72
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type gb_4 from groupbox within wi_mant_anyade_paking_masivo
integer x = 5
integer y = 232
integer width = 1211
integer height = 304
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Datos Caja"
end type

type em_cajas_pallet from u_em_campo within wi_mant_anyade_paking_masivo
integer x = 1527
integer y = 360
integer width = 187
integer height = 72
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

type em_planos_pallet from u_em_campo within wi_mant_anyade_paking_masivo
integer x = 1527
integer y = 444
integer width = 187
integer height = 72
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

type em_alturas_pallet from u_em_campo within wi_mant_anyade_paking_masivo
integer x = 1934
integer y = 444
integer width = 187
integer height = 72
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

type st_10 from statictext within wi_mant_anyade_paking_masivo
integer x = 1243
integer y = 368
integer width = 261
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Cajas:"
boolean focusrectangle = false
end type

type st_11 from statictext within wi_mant_anyade_paking_masivo
integer x = 1243
integer y = 452
integer width = 261
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Planos:"
boolean focusrectangle = false
end type

type st_12 from statictext within wi_mant_anyade_paking_masivo
integer x = 1728
integer y = 452
integer width = 197
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Alturas:"
boolean focusrectangle = false
end type

type uo_tipopallet_marca from u_em_campo_2 within wi_mant_anyade_paking_masivo
event destroy ( )
integer x = 2455
integer y = 360
integer width = 247
integer height = 72
integer taborder = 150
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tipopallet_marca.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_nombre_pallet_abr(codigo_empresa,this.em_codigo.text)
IF Trim(this.em_campo.text) = "" THEN 
	IF Trim(this.em_codigo.text) <> "" Then this.em_campo.SetFocus()
	this.em_campo.text  = ""
	this.em_codigo.text = ""
END IF

f_activar_campo(this.em_campo)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_pallets"
ue_filtro     = ""

end event

type uo_caja_marca from u_em_campo_2 within wi_mant_anyade_paking_masivo
event destroy ( )
integer x = 2455
integer y = 280
integer width = 247
integer height = 72
integer taborder = 140
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja_marca.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_nombre_caja_abr(codigo_empresa,this.em_codigo.text)

IF Trim(this.em_campo.text) = ""  or IsNull(this.em_campo.text)THEN 
	IF Trim(this.em_codigo.text) <> "" Then 
		this.em_campo.SetFocus()
	END IF
	this.em_campo.text  = ""
	this.em_codigo.text = ""
END IF

f_activar_campo(this.em_campo)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_cajas"
ue_filtro     = ""


end event

type gb_6 from groupbox within wi_mant_anyade_paking_masivo
integer x = 2149
integer y = 232
integer width = 699
integer height = 304
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Opciones de Marcado"
end type

type st_13 from statictext within wi_mant_anyade_paking_masivo
integer x = 2167
integer y = 368
integer width = 283
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Tipo Pallet:"
boolean focusrectangle = false
end type

type st_14 from statictext within wi_mant_anyade_paking_masivo
integer x = 2167
integer y = 288
integer width = 251
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Tipo Caja:"
boolean focusrectangle = false
end type

type rb_coinciden from radiobutton within wi_mant_anyade_paking_masivo
integer x = 2162
integer y = 432
integer width = 677
integer height = 48
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Marcar coincidencias"
boolean checked = true
boolean lefttext = true
end type

type rb_no_coinciden from radiobutton within wi_mant_anyade_paking_masivo
integer x = 2162
integer y = 480
integer width = 677
integer height = 48
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Marcar no coincidencias"
boolean lefttext = true
end type

type cb_2 from u_boton within wi_mant_anyade_paking_masivo
integer x = 2565
integer y = 132
integer width = 343
integer height = 88
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;long    indice,total,pallets_con_esta_caja
string  articulo,caja,tipo_pallet
boolean stock
if MessageBox("Proceso de Borrado","Desea eliminar los paking seleccionados",Question!,YesNo!,2) = 1 then
	total = dw_1.rowcount()
	if total > 0 then
		for indice = 1 to total
			f_mensaje_proceso("Borrando",indice,total)
			if dw_1.object.articulos_marca[indice] = "S" then				
				articulo    = dw_1.object.codigo[indice]
				caja        = dw_1.object.almartcajas_caja[indice]
				tipo_pallet = dw_1.object.palarticulo_codigo[indice]
				stock       = f_stock_articulo_caja_pallet(articulo,caja,tipo_pallet)
				if not(stock) then
					//Borramos los datos del pallet
					delete palarticulo
					where  empresa  = :codigo_empresa
					and    articulo = :articulo
					and    codigo   = :tipo_pallet
					and    caja     = :caja;
					if sqlca.sqlcode = 0 then
						//Si este articulo no utiliza la caja con otro pallet 
						//Borramos los datos de la caja
						select count(*)
						into   :pallets_con_esta_caja
						from   palarticulo
						where  empresa  = :codigo_empresa
						and    articulo = :articulo
						and    caja     = :caja;
						
						if isnull(pallets_con_esta_caja) then pallets_con_esta_caja = 0
						if pallets_con_esta_caja = 0 then
							delete almartcajas
							where  empresa  = :codigo_empresa
							and    articulo = :articulo
							and    caja     = :caja;
							if sqlca.sqlcode = 0 then
								commit;
							else
								rollback;
							end if						
						else
							commit;
						end if
					else
						rollback;
					end if
				end if
			end if			
		next
	end if
	cb_1.triggerevent(clicked!)
end if	

end event

type cb_3 from u_boton within wi_mant_anyade_paking_masivo
integer x = 1819
integer y = 284
integer width = 306
integer height = 76
integer taborder = 180
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Añadir"
end type

event clicked;long    indice,total,existe
string  articulo,caja,tipo_pallet,articulo_ant
long    piezas_caja,cajas_pallet,planos_pallet,alturas_pallet
dec     metros_caja,metrosl_caja,peso_caja,var_peso_pieza,peso_piezas,peso_envase
boolean todo_correcto = false,bien

caja           = uo_caja.em_codigo.text
tipo_pallet    = uo_tipopallet.em_codigo.text
piezas_caja    = dec(em_piezas_caja.text)
metros_caja    = dec(em_metros_caja.text)
metrosl_caja   = dec(em_metrosl_caja.text)
cajas_pallet   = dec(em_cajas_pallet.text)
planos_pallet  = dec(em_planos_pallet.text)
alturas_pallet = dec(em_alturas_pallet.text)

if trim(caja) = "" then
	messagebox("Dato obligatorio","Introduzca el tipo de caja")
	uo_caja.em_campo.setfocus()
else
	if trim(tipo_pallet) = "" then
		messagebox("Dato obligatorio","Introduzca el tipo de pallet")
		uo_tipopallet.em_campo.setfocus()
	else
		if piezas_caja = 0 then
			messagebox("Dato obligatorio","Introduzca las piezas por caja")
			em_piezas_caja.setfocus()
		else
			if piezas_caja = 0 then
				messagebox("Dato obligatorio","Introduzca las piezas por caja")
				em_piezas_caja.setfocus()
			else
				if metros_caja = 0 then
					messagebox("Dato obligatorio","Introduzca los metros por caja")
					em_metros_caja.setfocus()
				else
					if metrosl_caja = 0 then
						messagebox("Dato obligatorio","Introduzca los metros lineales por caja")
						em_metrosl_caja.setfocus()
					else
						if cajas_pallet = 0 then
							messagebox("Dato obligatorio","Introduzca las cajas por pallet")
							em_cajas_pallet.setfocus()
						else
							if planos_pallet = 0 then
								messagebox("Dato obligatorio","Introduzca los planos por pallet")
								em_planos_pallet.setfocus()
							else
								if alturas_pallet = 0 then
									messagebox("Dato obligatorio","Introduzca las alturas por pallet")
									em_alturas_pallet.setfocus()
								else
									todo_correcto = true
								end if																																								
							end if																															
						end if																							
					end if										
				end if					
			end if																						
		end if			
	end if	
end if
if todo_correcto then
	articulo_ant = ""
	if MessageBox("Proceso de Inserción","Desea añadir el paking a los articulos seleccionados",Question!,YesNo!,2) = 1 then
		total = dw_1.rowcount()
		if total > 0 then
			for indice = 1 to total
				f_mensaje_proceso("Insertando",indice,total)
				if dw_1.object.articulos_marca[indice] = "S" then				
					articulo    = dw_1.object.codigo[indice]
					if articulo <> articulo_ant then
						var_peso_pieza = f_peso_articulo(codigo_empresa,articulo)
						peso_piezas    = var_peso_pieza  * piezas_caja
						peso_envase    = f_peso_envase(codigo_empresa,uo_caja.em_codigo.text)
						
						peso_caja      = peso_envase + peso_piezas						
																								
						bien = true
						articulo_ant = articulo
						//Insertamos la caja si no existe
						select count(*)
						into   :existe
						from   almartcajas
						where  empresa  = :codigo_empresa
						and    articulo = :articulo
						and    caja     = :caja;
						
						if isnull(existe) then existe = 0
						if existe = 0 then
							insert into almartcajas
								(empresa,
								 articulo,
								 caja,
								 piezascaja,
								 metroscaja,
								 metroslcaja,
								 pesocaja,
								 codigo_anterior,
								 destacar_en_consultas)
							values
								(:codigo_empresa,
								 :articulo,
								 :caja,

								 :piezas_caja,
								 :metros_caja,
								 :metrosl_caja,
								 :peso_caja,
								 '',
								 'N');
								 
							if sqlca.sqlcode <> 0 then
								bien = false
							end if
						end if
						//Insertamos el pallet si no existe
						select count(*)
						into   :existe
						from   palarticulo
						where  empresa  = :codigo_empresa
						and    articulo = :articulo
						and    codigo   = :tipo_pallet
						and    caja     = :caja;
						
						if isnull(existe) then existe = 0
						if existe = 0 then
							insert into palarticulo
								(empresa,
								 articulo,
								 codigo,
								 caja,
								 cajaspallet,
								 planospallet,
								 alturas)
							values
								(:codigo_empresa,
								 :articulo,
								 :tipo_pallet,
								 :caja,
								 :cajas_pallet,
								 :planos_pallet,
								 :alturas_pallet);
								 
							if sqlca.sqlcode <> 0 then
								bien = false
							end if
						end if
						
						if bien then
							commit;
						else
							rollback;
						end if
					end if
				end if			
			next
		end if
	end if	
	cb_1.triggerevent(clicked!)
end if

end event

type gb_5 from groupbox within wi_mant_anyade_paking_masivo
integer x = 1221
integer y = 232
integer width = 923
integer height = 304
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Datos Pallet"
end type

type uo_cliente from u_em_campo_2 within wi_mant_anyade_paking_masivo
event destroy ( )
integer x = 896
integer y = 144
integer width = 1179
integer height = 72
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

