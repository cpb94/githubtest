$PBExportHeader$w_con_hoja_pallet.srw
$PBExportComments$Hojas de Pallet
forward
global type w_con_hoja_pallet from w_int_con_empresa
end type
type gb_4 from groupbox within w_con_hoja_pallet
end type
type gb_3 from groupbox within w_con_hoja_pallet
end type
type gb_9 from groupbox within w_con_hoja_pallet
end type
type gb_7 from groupbox within w_con_hoja_pallet
end type
type gb_6 from groupbox within w_con_hoja_pallet
end type
type cb_1 from u_boton within w_con_hoja_pallet
end type
type uo_articulo from u_em_campo_2 within w_con_hoja_pallet
end type
type gb_5 from groupbox within w_con_hoja_pallet
end type
type pb_2 from upb_imprimir within w_con_hoja_pallet
end type
type pb_1 from upb_salir within w_con_hoja_pallet
end type
type uo_caja from u_em_campo_2 within w_con_hoja_pallet
end type
type gb_1 from groupbox within w_con_hoja_pallet
end type
type uo_tipo_pallet from u_em_campo_2 within w_con_hoja_pallet
end type
type dw_1 from u_datawindow_consultas within w_con_hoja_pallet
end type
type gb_2 from groupbox within w_con_hoja_pallet
end type
type uo_cliente from u_em_campo_2 within w_con_hoja_pallet
end type
type gb_8 from groupbox within w_con_hoja_pallet
end type
type ncajas from singlelineedit within w_con_hoja_pallet
end type
type npiezas from singlelineedit within w_con_hoja_pallet
end type
type otra from singlelineedit within w_con_hoja_pallet
end type
type uo_formato from u_em_campo_2 within w_con_hoja_pallet
end type
type gb_10 from groupbox within w_con_hoja_pallet
end type
end forward

global type w_con_hoja_pallet from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 3634
integer height = 2128
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
string icon = "\bmp\RINO.ICO"
gb_4 gb_4
gb_3 gb_3
gb_9 gb_9
gb_7 gb_7
gb_6 gb_6
cb_1 cb_1
uo_articulo uo_articulo
gb_5 gb_5
pb_2 pb_2
pb_1 pb_1
uo_caja uo_caja
gb_1 gb_1
uo_tipo_pallet uo_tipo_pallet
dw_1 dw_1
gb_2 gb_2
uo_cliente uo_cliente
gb_8 gb_8
ncajas ncajas
npiezas npiezas
otra otra
uo_formato uo_formato
gb_10 gb_10
end type
global w_con_hoja_pallet w_con_hoja_pallet

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long   donde
string articulo,caja,palet,cliente,numcajas,piezas,cajas,pzcj,sel,formato,nombre_cliente
datastore datos

dw_1.Reset()

if uo_articulo.em_codigo.text<>'' then
	articulo=uo_articulo.em_codigo.text
else
	articulo='%'
end if
if uo_caja.em_codigo.text<>'' then
	caja=uo_caja.em_codigo.text
else
	caja='%'
end if
if uo_tipo_pallet.em_codigo.text<>'' then
	palet=uo_tipo_pallet.em_codigo.text
else
	palet='%'
end if
if uo_cliente.em_codigo.text<>'' then
	cliente=uo_cliente.em_codigo.text
else
	cliente='%'
end if
if ncajas.text<>'' then
	numcajas=ncajas.text
else
	messagebox("Atención","Debe introducir el número de cajas")
	ncajas.setfocus()
end if
if len(trim(otra.text))=0 then
	messagebox("Atención","Debe introducir la otra descripción del artículo")
	otra.setfocus()
end if
if npiezas.text<>'' then
	piezas=npiezas.text
	dw_1.modify("sueltas.visible = true")
else
	piezas = "0"
	dw_1.modify("sueltas.visible = false")
end if

if uo_cliente.em_codigo.text = "79" then
	cajas = "BOXES"
	pzcj  = "PZ/BX"
else
	cajas = "CAJAS A"
	pzcj  = "PZ/CJ"
end if

formato = uo_formato.em_campo.text
nombre_cliente = trim(f_nombre_genter(codigo_empresa,"C",cliente))

data.retrieve(codigo_empresa,articulo,caja,palet,cliente,numcajas,piezas,trim(otra.text),cajas,pzcj,formato)

sel = "select codigo,descripcion,formato "+&
		"from   articulos "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    codigo = '"+articulo+"' "
			
//datos = f_cargar_cursor(sel)		

f_cargar_cursor_nuevo(sel, datos)

donde = data.insertrow(0)
data.object.empresa[donde]   = codigo_empresa
data.object.codigo[donde]    = articulo
data.object.caja[donde]      = caja
data.object.palet[donde]     = palet
data.object.cliente[donde]   = cliente
data.object.nombre_cliente[donde] = nombre_cliente
data.object.ncajas[donde]    = numcajas
data.object.npiezas[donde]   = piezas
data.object.otra[donde]      = otra.text
data.object.cajas[donde]     = cajas
data.object.pzcj[donde]      = pzcj
data.object.formato[donde]   = formato

destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Hojas de Pallet"
This.title=istr_parametros.s_titulo_ventana

dw_1.Settransobject(SQLCA)
dw_1.ue_marca_linea=false
f_activar_campo(uo_cliente.em_campo)
end event

on w_con_hoja_pallet.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_9=create gb_9
this.gb_7=create gb_7
this.gb_6=create gb_6
this.cb_1=create cb_1
this.uo_articulo=create uo_articulo
this.gb_5=create gb_5
this.pb_2=create pb_2
this.pb_1=create pb_1
this.uo_caja=create uo_caja
this.gb_1=create gb_1
this.uo_tipo_pallet=create uo_tipo_pallet
this.dw_1=create dw_1
this.gb_2=create gb_2
this.uo_cliente=create uo_cliente
this.gb_8=create gb_8
this.ncajas=create ncajas
this.npiezas=create npiezas
this.otra=create otra
this.uo_formato=create uo_formato
this.gb_10=create gb_10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_9
this.Control[iCurrent+4]=this.gb_7
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_articulo
this.Control[iCurrent+8]=this.gb_5
this.Control[iCurrent+9]=this.pb_2
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.uo_caja
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.uo_tipo_pallet
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.uo_cliente
this.Control[iCurrent+17]=this.gb_8
this.Control[iCurrent+18]=this.ncajas
this.Control[iCurrent+19]=this.npiezas
this.Control[iCurrent+20]=this.otra
this.Control[iCurrent+21]=this.uo_formato
this.Control[iCurrent+22]=this.gb_10
end on

on w_con_hoja_pallet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_9)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.cb_1)
destroy(this.uo_articulo)
destroy(this.gb_5)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.uo_caja)
destroy(this.gb_1)
destroy(this.uo_tipo_pallet)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.uo_cliente)
destroy(this.gb_8)
destroy(this.ncajas)
destroy(this.npiezas)
destroy(this.otra)
destroy(this.uo_formato)
destroy(this.gb_10)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_hoja_pallet
integer x = 919
integer y = 904
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_hoja_pallet
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_hoja_pallet
integer width = 2656
integer height = 108
end type

type gb_4 from groupbox within w_con_hoja_pallet
integer x = 14
integer y = 480
integer width = 2405
integer height = 168
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Otra descripción del artículo"
end type

type gb_3 from groupbox within w_con_hoja_pallet
integer x = 2779
integer y = 664
integer width = 466
integer height = 168
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Piezas Sueltas"
end type

type gb_9 from groupbox within w_con_hoja_pallet
integer x = 2446
integer y = 664
integer width = 311
integer height = 168
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nº Cajas"
end type

type gb_7 from groupbox within w_con_hoja_pallet
integer x = 2757
integer y = 156
integer width = 160
integer height = 152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_6 from groupbox within w_con_hoja_pallet
integer x = 2450
integer y = 156
integer width = 302
integer height = 152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_1 from u_boton within w_con_hoja_pallet
integer x = 2464
integer y = 192
integer width = 274
integer height = 108
integer taborder = 80
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)
end event

type uo_articulo from u_em_campo_2 within w_con_hoja_pallet
event destroy ( )
integer x = 27
integer y = 368
integer width = 2368
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_descripcion_almcliartdesc(codigo_empresa,uo_cliente.em_codigo.text,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
   uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
END IF
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF
uo_formato.em_campo.text=f_nombre_formato(codigo_empresa,f_formato_articulo(codigo_empresa,uo_articulo.em_codigo.text))
otra.text = uo_articulo.em_campo.text





end event

event getfocus;ue_titulo     = "Ayuda seleccion de articulos"
//ue_datawindow = "dw_ayuda_articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""

end event

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type gb_5 from groupbox within w_con_hoja_pallet
integer x = 9
integer y = 308
integer width = 2409
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Articulo"
end type

type pb_2 from upb_imprimir within w_con_hoja_pallet
string tag = "Imprimir Hojas Palet"
integer x = 2770
integer y = 188
integer width = 133
integer height = 108
integer taborder = 90
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_1)	
dw_1.Reset()
uo_articulo.em_campo.setfocus()


end event

type pb_1 from upb_salir within w_con_hoja_pallet
integer x = 2706
integer y = 32
integer width = 128
integer height = 108
integer taborder = 0
alignment htextalign = right!
end type

type uo_caja from u_em_campo_2 within w_con_hoja_pallet
event destroy ( )
integer x = 37
integer y = 720
integer width = 992
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text=f_nombre_almartcaja(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text)

IF Trim(uo_caja.em_campo.text)=""  or IsNull(uo_caja.em_campo.text)THEN 
 IF Trim(uo_caja.em_codigo.text)<>"" Then 
   uo_caja.em_campo.SetFocus()
 END IF
 uo_caja.em_campo.text=""
 uo_caja.em_codigo.text=""
END IF

//f_peso_linea()	
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"
//campo_actual = "CAJA"



end event

type gb_1 from groupbox within w_con_hoja_pallet
integer x = 14
integer y = 664
integer width = 1061
integer height = 168
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de caja"
end type

type uo_tipo_pallet from u_em_campo_2 within w_con_hoja_pallet
event destroy ( )
integer x = 1161
integer y = 720
integer width = 1230
integer height = 88
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tipo_pallet.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_tipo_pallet.em_campo.text=f_nombre_palarticulocaja(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text)

IF Trim(uo_tipo_pallet.em_campo.text)=""  or IsNull(uo_tipo_pallet.em_campo.text)THEN 
 IF Trim(uo_tipo_pallet.em_codigo.text)<>"" Then 
   uo_tipo_pallet.em_campo.SetFocus()
 END IF
 uo_tipo_pallet.em_campo.text=""
 uo_tipo_pallet.em_codigo.text=""
END IF

//f_peso_linea()
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_palarticulo_abr"
ue_filtro     = "(palarticulo_articulo = '" + uo_articulo.em_codigo.text+ "') and "+&
                "(palarticulo_caja = '" + uo_caja.em_codigo.text + "')" 
//campo_actual = "TIPO_PALLET"



end event

type dw_1 from u_datawindow_consultas within w_con_hoja_pallet
integer x = 18
integer y = 848
integer width = 3579
integer height = 1096
integer taborder = 0
string dataobject = "dw_hoja_pallet"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_con_hoja_pallet
integer x = 1138
integer y = 664
integer width = 1280
integer height = 168
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de palet"
end type

type uo_cliente from u_em_campo_2 within w_con_hoja_pallet
event destroy ( )
integer x = 27
integer y = 200
integer width = 2363
integer taborder = 10
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

type gb_8 from groupbox within w_con_hoja_pallet
integer x = 9
integer y = 152
integer width = 2409
integer height = 156
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type ncajas from singlelineedit within w_con_hoja_pallet
integer x = 2473
integer y = 724
integer width = 247
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type npiezas from singlelineedit within w_con_hoja_pallet
integer x = 2816
integer y = 724
integer width = 398
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

type otra from singlelineedit within w_con_hoja_pallet
integer x = 32
integer y = 536
integer width = 2368
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type uo_formato from u_em_campo_2 within w_con_hoja_pallet
event destroy ( )
integer x = 2446
integer y = 368
integer width = 535
integer height = 88
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

type gb_10 from groupbox within w_con_hoja_pallet
integer x = 2432
integer y = 308
integer width = 571
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Formato"
end type

