$PBExportHeader$w_chequeo_integridad_articulos.srw
forward
global type w_chequeo_integridad_articulos from w_int_con_empresa
end type
type pb_2 from upb_imprimir within w_chequeo_integridad_articulos
end type
type uo_1 from u_manejo_datawindow within w_chequeo_integridad_articulos
end type
type dw_listado from datawindow within w_chequeo_integridad_articulos
end type
type cb_2 from u_boton within w_chequeo_integridad_articulos
end type
type dw_1 from datawindow within w_chequeo_integridad_articulos
end type
type pb_1 from upb_salir within w_chequeo_integridad_articulos
end type
end forward

global type w_chequeo_integridad_articulos from w_int_con_empresa
integer width = 2885
integer height = 1632
pb_2 pb_2
uo_1 uo_1
dw_listado dw_listado
cb_2 cb_2
dw_1 dw_1
pb_1 pb_1
end type
global w_chequeo_integridad_articulos w_chequeo_integridad_articulos

type variables
String filtro

end variables

forward prototypes
public subroutine f_proceso (datawindow data)
end prototypes

public subroutine f_proceso (datawindow data);String sel,articulo,codigo_aticulo,calidad,tipo_pallet,refe,&
	grabar,c_calidad,c_tono,c_calibre,c_tipo_pallet,formato,caja,tono
Dec{2} calibre,cantidad,cont,nu
STring t,c
DataStore d
Dec r ,r1

Sel = " Select  articulo,calidad,tonochar,calibre,tipo_pallet,caja,Sum(existencias) cantidad From almlinubica" + &
		" Where empresa   = '"+ codigo_empresa + "'" + &
		" Group  by articulo,calidad,tono,calibre,tipo_pallet,caja"+ &
		" Order by articulo,calidad,tono,calibre,tipo_pallet,caja"
data.Retrieve(codigo_empresa)		

//d= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)


r1 = d.rowCOunt()
f_contador_procesos(0,100)
cont = 0
For r = 1 To r1
	grabar        = "N"
	c_calidad     = "N"
	c_tono        = "N"
	c_calibre     = "N"
	c_calidad     = "N"
	c_tipo_pallet = "N"
	articulo  = d.getItemString(r,"articulo")
	IF f_sector_articulo(codigo_empresa,articulo) = "S" Then
			tono      = d.getItemString(r,"tonochar")
			calibre   = d.getItemNumber(r,"calibre")
			tipo_pallet = d.getItemString(r,"tipo_pallet")
			caja      = d.GetItemString(r,"caja")
			cantidad   = d.getItemNumber(r,"cantidad")
		
			Select formato,tono,calibre Into :formato,:t,:c from articulos
			Where  empresa   = :codigo_empresa
			ANd    codigo  = :articulo;
			calidad   = d.getItemString(r,"calidad")
			IF f_tono_calidad(codigo_empresa,calidad) = "N" Then t = "N"
			IF f_calibre_calidad(codigo_empresa,calidad) = "N" Then c = "N"
			
			IF t="S" and Trim(tono) = "" Then
				c_tono = "S"
				grabar = "S"
			END IF
			IF t="N" and Trim(tono) <> "" Then
				c_tono = "S"
				grabar = "S"
			END IF
			
			IF c="S" and calibre = 0 Then
				c_calibre = "S"
				grabar = "S"
			END IF
			IF c="N" and calibre<> 0 Then
				c_calibre = "S"
				grabar = "S"
			END IF
			
			
			Select count(*)  Into :nu  From almartcal
			Where  almartcal.empresa  = :codigo_empresa
			And    almartcal.articulo = :articulo
			And    almartcal.calidad  = :calidad;
			IF IsNull(nu) Then nu = 0
			IF nu = 0 Then
				grabar = "S"
				c_calidad = "S"
			END IF
			Select count(*)  Into :nu  From palarticulo
			Where  palarticulo.empresa  = :codigo_empresa
			And    palarticulo.articulo = :articulo
			And    palarticulo.codigo  = :tipo_pallet
			And    palarticulo.caja    = :caja;
			IF IsNull(nu) Then nu = 0
			IF nu = 0 Then
				grabar = "S"
				c_tipo_pallet = "S"
			END IF
			IF grabar = "S" Then
				cont = cont +1
				data.InsertRow(cont)
				data.SetItem(cont,"codigo_articulo",articulo)
				data.SetItem(cont,"cantidad",cantidad)
				data.SetItem(cont,"articulo",f_nombre_articulo(codigo_empresa,articulo))
				data.SetItem(cont,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
				data.SetItem(cont,"tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
				data.SetItem(cont,"caja",f_nombre_caja_abr(codigo_empresa,caja))
				data.SetItem(cont,"tonochar",tono)
				data.SetItem(cont,"calibre",calibre)
				data.SetItem(cont,"c_calidad",c_calidad)
				data.SetItem(cont,"c_tono",c_tono)
				data.SetItem(cont,"c_calibre",c_calibre)
				data.SetItem(cont,"c_tipo_pallet",c_tipo_pallet)
			END IF
	END IF
   	f_contador_procesos(r,r1)
		
Next

destroy d
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta diferencias almacen"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_listado.settransobject(SQLCA)

end event

on w_chequeo_integridad_articulos.create
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

on w_chequeo_integridad_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.dw_listado)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_chequeo_integridad_articulos
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_chequeo_integridad_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_chequeo_integridad_articulos
integer x = 5
end type

type pb_2 from upb_imprimir within w_chequeo_integridad_articulos
integer x = 1047
integer y = 132
integer width = 101
integer height = 84
boolean originalsize = false
end type

event clicked;call super::clicked;f_proceso(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type uo_1 from u_manejo_datawindow within w_chequeo_integridad_articulos
integer x = 571
integer y = 88
integer width = 599
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_chequeo_integridad_articulos
boolean visible = false
integer x = 1193
integer y = 100
integer width = 494
integer height = 164
integer taborder = 30
string dataobject = "report_checheo_integridad_articulos"
boolean livescroll = true
end type

type cb_2 from u_boton within w_chequeo_integridad_articulos
integer x = 18
integer y = 120
integer width = 553
integer height = 112
integer taborder = 10
string text = "&Consultar"
end type

event clicked;call super::clicked;f_proceso(dw_1)
end event

type dw_1 from datawindow within w_chequeo_integridad_articulos
event key pbm_dwnkey
integer y = 260
integer width = 2341
integer height = 1144
integer taborder = 20
string dataobject = "dw_checheo_integridad_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_salir within w_chequeo_integridad_articulos
integer x = 2706
integer y = 12
integer width = 137
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

