$PBExportHeader$w_chequeo_integridad_cajas.srw
forward
global type w_chequeo_integridad_cajas from w_int_con_empresa
end type
type pb_2 from upb_imprimir within w_chequeo_integridad_cajas
end type
type uo_1 from u_manejo_datawindow within w_chequeo_integridad_cajas
end type
type dw_listado from datawindow within w_chequeo_integridad_cajas
end type
type cb_2 from u_boton within w_chequeo_integridad_cajas
end type
type dw_1 from datawindow within w_chequeo_integridad_cajas
end type
type pb_1 from upb_salir within w_chequeo_integridad_cajas
end type
end forward

global type w_chequeo_integridad_cajas from w_int_con_empresa
integer width = 2885
integer height = 1648
pb_2 pb_2
uo_1 uo_1
dw_listado dw_listado
cb_2 cb_2
dw_1 dw_1
pb_1 pb_1
end type
global w_chequeo_integridad_cajas w_chequeo_integridad_cajas

type variables
String filtro

end variables

forward prototypes
public subroutine f_proceso (datawindow data)
end prototypes

public subroutine f_proceso (datawindow data);String sel,articulo,codigo_aticulo,calidad,tipo_pallet,caja,tono
Dec{2} calibre,cantidad,cont,nu,metros,t_cajas
STring t,c,almacen,zona
integer fila,altura,e_cajas
DataStore d
Dec r ,r1

data.SetRedraw(FALSE)
Sel = " Select  almacen,zona,fila,altura,articulo,calidad,tonochar,calibre,tipo_pallet,caja,existencias cantidad From almlinubica" + &
		" Where empresa   = '"+ codigo_empresa + "'" +&
		" and   tipo_unidad = '1' "
		
data.Retrieve(codigo_empresa)		

//d= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)

r1 = d.rowCOunt()
f_contador_procesos(0,100)
cont = 0
For r = 1 To r1
	articulo    = d.getItemString(r,"articulo")
	tono        = d.getItemString(r,"tonochar")
	calibre     = d.getItemNumber(r,"calibre")
	tipo_pallet = d.getItemString(r,"tipo_pallet")
	caja        = d.GetItemString(r,"caja")
	calidad     = d.getItemString(r,"calidad")
	cantidad    = d.getItemNumber(r,"cantidad")
	metros      = f_metroscaja_articulo(codigo_empresa,articulo,caja)
	almacen     = d.getItemString(r,"almacen")
	fila        = d.getItemNumber(r,"fila")
	zona        = d.getItemString(r,"zona")
	altura      = d.getItemNumber(r,"altura")
	
	t_cajas = dec(string(cantidad,'###,###,###.##'))/dec(string(metros,'###,###.##'))
	e_cajas = int(t_cajas)
	
	if t_cajas<>e_cajas then
				cont = cont +1
				data.InsertRow(cont)
				data.SetItem(cont,"codigo_articulo",articulo)
				data.SetItem(cont,"cantidad",cantidad)
				data.SetItem(cont,"articulo",f_nombre_articulo(codigo_empresa,articulo))
				data.SetItem(cont,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
				data.SetItem(cont,"tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
				data.SetItem(cont,"tonochar",tono)
				data.SetItem(cont,"calibre",calibre)
				data.SetItem(cont,"metros",metros)
				data.SetItem(cont,"almacen",almacen)
				data.SetItem(cont,"zona",zona)
				data.SetItem(cont,"altura",altura)
				data.SetItem(cont,"fila",fila)
				data.SetItem(cont,"cajas",t_cajas)
	End if
  	f_contador_procesos(r,r1)
		
Next
destroy d
data.SetRedraw(True)
data.Setfocus()
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta diferencias almacen"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_listado.settransobject(SQLCA)

end event

on w_chequeo_integridad_cajas.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.dw_listado=create dw_listado
this.cb_2=create cb_2
this.dw_1=create dw_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.pb_1
end on

on w_chequeo_integridad_cajas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.dw_listado)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_chequeo_integridad_cajas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_chequeo_integridad_cajas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_chequeo_integridad_cajas
integer x = 5
end type

type pb_2 from upb_imprimir within w_chequeo_integridad_cajas
integer x = 2638
integer y = 164
integer width = 101
integer height = 84
boolean originalsize = false
end type

event clicked;call super::clicked;f_proceso(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type uo_1 from u_manejo_datawindow within w_chequeo_integridad_cajas
integer x = 2162
integer y = 116
integer width = 599
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_chequeo_integridad_cajas
boolean visible = false
integer x = 1193
integer y = 100
integer width = 494
integer height = 164
integer taborder = 30
string dataobject = "report_chequeo_integridad_cajas"
boolean livescroll = true
end type

type cb_2 from u_boton within w_chequeo_integridad_cajas
integer x = 46
integer y = 176
integer height = 92
integer taborder = 10
string text = "&Consultar"
end type

event clicked;call super::clicked;f_proceso(dw_1)
end event

type dw_1 from datawindow within w_chequeo_integridad_cajas
event key pbm_dwnkey
integer x = 18
integer y = 276
integer width = 2779
integer height = 1144
integer taborder = 20
string dataobject = "dw_chequeo_integridad_cajas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_salir within w_chequeo_integridad_cajas
integer x = 2679
integer y = 4
integer width = 114
integer height = 104
integer taborder = 0
boolean bringtotop = true
end type

