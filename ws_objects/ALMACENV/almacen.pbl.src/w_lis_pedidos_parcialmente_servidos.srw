$PBExportHeader$w_lis_pedidos_parcialmente_servidos.srw
forward
global type w_lis_pedidos_parcialmente_servidos from w_int_con_empresa
end type
type st_anyo from statictext within w_lis_pedidos_parcialmente_servidos
end type
type cb_continuar from u_boton within w_lis_pedidos_parcialmente_servidos
end type
type st_fecha from statictext within w_lis_pedidos_parcialmente_servidos
end type
type dw_consulta from u_datawindow within w_lis_pedidos_parcialmente_servidos
end type
type em_fecha from u_em_campo within w_lis_pedidos_parcialmente_servidos
end type
type pb_2 from upb_imprimir within w_lis_pedidos_parcialmente_servidos
end type
type pb_1 from upb_salir within w_lis_pedidos_parcialmente_servidos
end type
end forward

global type w_lis_pedidos_parcialmente_servidos from w_int_con_empresa
integer x = 14
integer y = 4
integer width = 2962
integer height = 2204
st_anyo st_anyo
cb_continuar cb_continuar
st_fecha st_fecha
dw_consulta dw_consulta
em_fecha em_fecha
pb_2 pb_2
pb_1 pb_1
end type
global w_lis_pedidos_parcialmente_servidos w_lis_pedidos_parcialmente_servidos

type variables
String filtro,var_referencia,var_tipo_unidad,var_situacion
Integer registros,contado,suborden,anyo
String  var_articulo,var_formato,var_calidad,var_tipo_pallet,var_sector,codigo_almacen,codigo_zona,var_es_pico,var_tipo_pallet_entrada,var_conexion,var_tipo_pallet_preparacion
Dec{0}  var_tono,var_calibre,var_pedido,var_periodo,var_pallets,var_cajas,var_total_cajas,var_orden_preparacion,var_linea_pedido
Dec{0} total_piezas,var_linea,var_unidades,codigo_fila,codigo_altura,codigo_pico,var_numero_pico
Dec{2} var_cantidad,var_metros,var_cantidad_preparada,var_cantidad_prepa
String codigo_operario,procesando,bloqueado,var_operario_prepa,var_familia,var_modelo
Dec{0}  var_fila_ent,var_altura_ent,var_mov_ent,var_mov_sal
String v_almacen,v_zona,campo_anterior
Integer v_fila,v_altura,bien
Dec{2} v_cantidad,v_tot,ante_pallets,ante_cajas,ante_cantidad
end variables

forward prototypes
public subroutine f_proceso ()
end prototypes

public subroutine f_proceso ();String sel,cliente
Date  vfalbaran,vf1,vf2,vflistado
DateTime vflis
Dec r,f,vpedido,vanyo,numero
f = 0
vf1 = Date(em_fecha.text)
vfalbaran = vf1
vf2 = RelativeDate(Date(em_fecha.text) ,1)
DataStore dw
dw_consulta.Reset()
Sel = " Select  venlialb.anyo_pedido_origen,venlialb.pedido_origen From venlialb " + &
		" Where   venlialb.empresa = '" + codigo_empresa + "'" + &
		" And     venlialb.falta   Between '" + &
		STring(vf1,"mm-dd-yyyy")+"' and '"   + &
		STring(vf2,"mm-dd-yyyy")+"' Group BY anyo_pedido_origen,pedido_origen Order BY anyo_pedido_origen,pedido_origen"

//dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)


IF dw.RowCount() = 0 Then 
	destroy dw
	Return
end if
For r = 1 To dw.RowCount()
	vanyo     = dw.GetItemnumber(r,"anyo_pedido_origen")
	vpedido   = dw.GetItemnumber(r,"pedido_origen")
   Select venped.flistado,venped.cliente Into :vflis,:cliente From venped
	Where  venped.empresa   = :codigo_empresa
	And    venped.anyo      = :vanyo
	And    venped.pedido    = :vpedido;
	vflistado = Date(vflis)
   Select count(*) Into :numero From venliped
	Where  venliped.empresa   = :codigo_empresa
	And    venliped.anyo      = :vanyo
	And    venliped.pedido    = :vpedido;
	iF IsNull(numero) Then numero =0
	
	IF numero <> 0 and vflistado < vfalbaran or STring(vflistado,"dd-mm-yyyy")= "00-00-0000" Then
			f = f +1
			dw_consulta.InsertRow(f)
			dw_consulta.SetItem(f,"anyo",vanyo)
			dw_consulta.SetItem(f,"pedido",vpedido)
			dw_consulta.SetItem(f,"flistado",String(vflistado,"dd-mm-yy"))
			dw_consulta.SetItem(f,"cliente",f_razon_genter(codigo_empresa,"C",cliente))
			dw_consulta.SetItem(f,"cmarca","S")
	END IF
	f_mensaje_proceso("Espere Por favor....",r,dw.RowCount())
Next

destroy dw
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Listado pedidos pracialmente servidos"
This.title=istr_parametros.s_titulo_ventana
titulo = This.title
dw_consulta.SetTransObject(SQLCA)
em_fecha.text = STring(Today(),"dd-mm-yy")
f_activar_campo(em_fecha)
end event

on w_lis_pedidos_parcialmente_servidos.create
int iCurrent
call super::create
this.st_anyo=create st_anyo
this.cb_continuar=create cb_continuar
this.st_fecha=create st_fecha
this.dw_consulta=create dw_consulta
this.em_fecha=create em_fecha
this.pb_2=create pb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_anyo
this.Control[iCurrent+2]=this.cb_continuar
this.Control[iCurrent+3]=this.st_fecha
this.Control[iCurrent+4]=this.dw_consulta
this.Control[iCurrent+5]=this.em_fecha
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.pb_1
end on

on w_lis_pedidos_parcialmente_servidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_anyo)
destroy(this.cb_continuar)
destroy(this.st_fecha)
destroy(this.dw_consulta)
destroy(this.em_fecha)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_consulta)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_consulta)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_consulta)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_cursor_arriba(dw_consulta)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_pedidos_parcialmente_servidos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_pedidos_parcialmente_servidos
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_fecha)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_pedidos_parcialmente_servidos
end type

type st_anyo from statictext within w_lis_pedidos_parcialmente_servidos
integer x = 101
integer y = 192
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_continuar from u_boton within w_lis_pedidos_parcialmente_servidos
integer x = 745
integer y = 180
integer width = 421
integer height = 96
integer taborder = 0
string text = "&Continuar"
end type

event clicked;call super::clicked;f_proceso()
end event

type st_fecha from statictext within w_lis_pedidos_parcialmente_servidos
integer x = 2505
integer y = 156
integer width = 297
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_consulta from u_datawindow within w_lis_pedidos_parcialmente_servidos
integer y = 316
integer width = 2875
integer height = 1652
integer taborder = 0
string dataobject = "dw_list_pedidos_parcialmente_sevidos"
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type em_fecha from u_em_campo within w_lis_pedidos_parcialmente_servidos
integer x = 375
integer y = 188
integer width = 347
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type pb_2 from upb_imprimir within w_lis_pedidos_parcialmente_servidos
integer x = 1170
integer y = 180
end type

event clicked;call super::clicked;str_parametros lstr_param
Dec vpedido,vanyo,r
IF dw_consulta.RowCount() = 0 Then Return
For r = 1 To dw_consulta.RowCount()
	vanyo = dw_consulta.GetItemNumber(r,"anyo")
	vpedido = dw_consulta.GetItemNumber(r,"pedido")

 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=String(vanyo,"####")
 lstr_param.s_argumentos[3]=String(vpedido,"########")
 OpenWithParm(w_list_preparacion_pedido,lstr_param)
 f_mensaje_proceso("Procesando...",r,dw_consulta.RowCount())
Next
dw_consulta.Reset()
end event

type pb_1 from upb_salir within w_lis_pedidos_parcialmente_servidos
integer x = 2793
integer y = 16
integer width = 123
integer height = 108
integer taborder = 0
boolean bringtotop = true
end type

