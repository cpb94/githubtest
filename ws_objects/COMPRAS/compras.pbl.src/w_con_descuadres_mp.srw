$PBExportHeader$w_con_descuadres_mp.srw
forward
global type w_con_descuadres_mp from w_int_con_empresa
end type
type pb_2 from upb_imprimir within w_con_descuadres_mp
end type
type uo_1 from u_manejo_datawindow within w_con_descuadres_mp
end type
type dw_listado from datawindow within w_con_descuadres_mp
end type
type cb_2 from u_boton within w_con_descuadres_mp
end type
type dw_1 from datawindow within w_con_descuadres_mp
end type
type pb_1 from upb_salir within w_con_descuadres_mp
end type
end forward

global type w_con_descuadres_mp from w_int_con_empresa
integer width = 2894
integer height = 1608
string icon = "Application!"
pb_2 pb_2
uo_1 uo_1
dw_listado dw_listado
cb_2 cb_2
dw_1 dw_1
pb_1 pb_1
end type
global w_con_descuadres_mp w_con_descuadres_mp

type variables
String filtro

end variables

forward prototypes
public subroutine f_proceso (datawindow data)
end prototypes

public subroutine f_proceso (datawindow data);String sel,articulo,codigo_aticulo,calidad,tipo_pallet,refe,caja,tono
Dec{2} calibre,cantidad1,cantidad2,dif,cont
DataStore d
Dec r ,r1

Sel = " Select  mp,calidad,Sum(cantidade - cantidads) cantidad From commovhis" + &
		" Where empresa   = '"+ codigo_empresa + "'" + &
		" And   situacion <> 'A'" + &
		" Group  by mp,calidad"+ &
		" Order by mp,calidad"
data.Retrieve(codigo_empresa)		
//d= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)

r1 = d.rowCOunt()
f_contador_procesos(0,100)
cont = 0
For r = 1 To r1
	articulo    = d.getItemString(r,"mp")
	calidad     = d.getItemString(r,"calidad")
	cantidad1   = d.getItemNumber(r,"cantidad")
	//cantidad2   = f_existencias_ref_pallet_caja_deposito(codigo_empresa,refe,tipo_pallet,caja)
	
	cantidad2 = 0
	
	select sum(existencias)
	into   :cantidad2
	from   comlinubica
	where  empresa = :codigo_empresa
	and    mp      = :articulo
	and    calidad = :calidad;
	
	if isnull(cantidad2) then cantidad2 = 0
	
	dif = cantidad1 - cantidad2
	IF dif <> 0 Then
		cont = cont +1
		data.InsertRow(cont)
		data.SetItem(cont,"codigo_articulo",articulo)
		data.SetItem(cont,"articulo",f_nombre_mprima(codigo_empresa,articulo))
		data.SetItem(cont,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
		data.SetItem(cont,"cantidad1",cantidad1)
		data.SetItem(cont,"cantidad2",cantidad2)		
		data.SetItem(cont,"diferencia",dif)		
	END IF
	f_contador_procesos(r,r1)
Next

destroy d
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta diferencias almacen compras"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_listado.settransobject(SQLCA)

end event

on w_con_descuadres_mp.create
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

on w_con_descuadres_mp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.dw_listado)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_descuadres_mp
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_descuadres_mp
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_descuadres_mp
integer x = 5
end type

type pb_2 from upb_imprimir within w_con_descuadres_mp
integer x = 2011
integer y = 148
integer width = 101
integer height = 84
boolean originalsize = false
string picturename = "print!"
end type

event clicked;call super::clicked;f_proceso(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type uo_1 from u_manejo_datawindow within w_con_descuadres_mp
integer x = 1536
integer y = 100
integer width = 599
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_con_descuadres_mp
boolean visible = false
integer x = 622
integer y = 96
integer width = 494
integer height = 164
integer taborder = 30
string dataobject = "report_con_descuadres_mp"
boolean livescroll = true
end type

type cb_2 from u_boton within w_con_descuadres_mp
integer x = 41
integer y = 152
integer width = 526
integer height = 92
integer taborder = 10
string text = "&Consultar"
end type

event clicked;call super::clicked;f_proceso(dw_1)
end event

type dw_1 from datawindow within w_con_descuadres_mp
event key pbm_dwnkey
integer y = 260
integer width = 2848
integer height = 1144
integer taborder = 20
string dataobject = "dw_con_descuadres_mp"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_salir within w_con_descuadres_mp
integer x = 2670
integer y = 24
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

