$PBExportHeader$w_con_descuadres_articulos_deposito.srw
forward
global type w_con_descuadres_articulos_deposito from w_int_con_empresa
end type
type pb_2 from upb_imprimir within w_con_descuadres_articulos_deposito
end type
type uo_1 from u_manejo_datawindow within w_con_descuadres_articulos_deposito
end type
type dw_listado from datawindow within w_con_descuadres_articulos_deposito
end type
type cb_2 from u_boton within w_con_descuadres_articulos_deposito
end type
type dw_1 from datawindow within w_con_descuadres_articulos_deposito
end type
type cb_1 from commandbutton within w_con_descuadres_articulos_deposito
end type
type pb_1 from upb_salir within w_con_descuadres_articulos_deposito
end type
end forward

global type w_con_descuadres_articulos_deposito from w_int_con_empresa
integer width = 2917
integer height = 1636
pb_2 pb_2
uo_1 uo_1
dw_listado dw_listado
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
pb_1 pb_1
end type
global w_con_descuadres_articulos_deposito w_con_descuadres_articulos_deposito

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

Sel = " Select  articulo,calidad,tonochar,calibre,tipo_pallet,caja,Sum(cantidade - cantidads) cantidad From depmovhis" + &
		" Where empresa   = '"+ codigo_empresa + "'" + &
		" And   situacion <> 'A'" + &
		" Group  by articulo,calidad,tonochar,calibre,tipo_pallet,caja"+ &
		" Order by articulo,calidad,tonochar,calibre,tipo_pallet,caja"
data.Retrieve(codigo_empresa)		
//d= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)

r1 = d.rowCOunt()
f_contador_procesos(0,100)
cont = 0
For r = 1 To r1
	articulo    = d.getItemString(r,"articulo")
	calidad     = d.getItemString(r,"calidad")
	tono        = d.getItemString(r,"tonochar")
	calibre     = d.getItemNumber(r,"calibre")
	tipo_pallet = d.getItemString(r,"tipo_pallet")
	caja        = d.GetItemString (r,"caja")
 
	cantidad1   = d.getItemNumber(r,"cantidad")
	refe	 = f_componer_ref(articulo,calidad,tono,calibre)
	cantidad2   = f_existencias_ref_pallet_caja_deposito(codigo_empresa,refe,tipo_pallet,caja)
	//cantidad2   = f_existencias_ref_pallet_deposito(codigo_empresa,refe,tipo_pallet,caja)
	dif = cantidad1 - cantidad2
	IF dif <> 0 Then
		cont = cont +1
		data.InsertRow(cont)
		data.SetItem(cont,"codigo_articulo",articulo)
		//data.SetItem(cont,"codigo_articulo",refe)
		data.SetItem(cont,"articulo",f_nombre_articulo(codigo_empresa,articulo))
		data.SetItem(cont,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
		data.SetItem(cont,"tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
		data.SetItem(cont,"caja",f_nombre_caja_abr(codigo_empresa,caja))
		data.SetItem(cont,"tonochar",tono)
		data.SetItem(cont,"calibre",calibre)
		data.SetItem(cont,"cantidad1",cantidad1)
		data.SetItem(cont,"cantidad2",cantidad2)		
		data.SetItem(cont,"diferencia",dif)		
	END IF
	f_contador_procesos(r,r1)
Next

destroy d
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta diferencias almacen deposito"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_listado.settransobject(SQLCA)

end event

on w_con_descuadres_articulos_deposito.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.dw_listado=create dw_listado
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.pb_1
end on

on w_con_descuadres_articulos_deposito.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.dw_listado)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_descuadres_articulos_deposito
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_descuadres_articulos_deposito
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_descuadres_articulos_deposito
integer x = 5
end type

type pb_2 from upb_imprimir within w_con_descuadres_articulos_deposito
integer x = 2011
integer y = 148
integer width = 101
integer height = 84
integer taborder = 20
boolean originalsize = false
end type

event clicked;call super::clicked;f_proceso(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type uo_1 from u_manejo_datawindow within w_con_descuadres_articulos_deposito
integer x = 1536
integer y = 100
integer width = 599
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_con_descuadres_articulos_deposito
boolean visible = false
integer x = 622
integer y = 96
integer width = 494
integer height = 164
integer taborder = 50
string dataobject = "report_descuadres_articulos"
boolean livescroll = true
end type

type cb_2 from u_boton within w_con_descuadres_articulos_deposito
integer x = 41
integer y = 152
integer width = 526
integer height = 92
integer taborder = 30
string text = "&Consultar"
end type

event clicked;call super::clicked;f_proceso(dw_1)
end event

type dw_1 from datawindow within w_con_descuadres_articulos_deposito
event key pbm_dwnkey
integer y = 260
integer width = 2848
integer height = 1144
integer taborder = 40
string dataobject = "dw_con_descuadres_articulos1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within w_con_descuadres_articulos_deposito
boolean visible = false
integer x = 910
integer y = 164
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "none"
end type

event clicked;string sel,articulo,tipo_pallet,caja
long   indice,total,cajas_pallet,total2,indice2
dec    cantidad,existencias,cantidad_his
datastore errores,soluciones

sel = "select articulo,tipo_pallet,sum(cantidade - cantidads) cantidad "+&
		"from   depmovhis "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and   (caja = '' or caja is null) "+&
		"and   situacion <> 'A' "+&
		"group by articulo,tipo_pallet"
		
//errores = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, errores)

total = errores.rowcount()

for indice = 1 to total
	f_mensaje_proceso('',indice,total)
	
	articulo    = errores.object.articulo[indice]
	tipo_pallet = errores.object.tipo_pallet[indice]
	cantidad    = errores.object.cantidad[indice]
	
	sel = "select caja,sum(cantidade - cantidads) cantidad "+&
			"from   depmovhis "+&
			"where  empresa = '"+codigo_empresa+"' "+&
			"and    articulo = '"+articulo+"' "+&
			"and    tipo_pallet = '"+tipo_pallet+"' "+&
			"and   (caja <> '' and caja is not null) "+&
			"and   situacion <> 'A' "+&
			"group by caja"
			
	//soluciones = f_cargar_cursor(sel)
	f_cargar_cursor_nuevo(sel, soluciones)
	
	total2 = soluciones.rowcount()
	
	for indice2 = 1 to total2
		cantidad_his = soluciones.object.cantidad[indice2]
		caja         = soluciones.object.caja[indice2]
		
		existencias = 0
		
		select sum(existencias)
		into   :existencias
		from   deplinubica
		where  empresa     = :codigo_empresa
		and    articulo    = :articulo
		and    tipo_pallet = :tipo_pallet
		and    caja        = :caja;
		
		if isnull(existencias) then existencias = 0
		
		if abs(cantidad) = abs(cantidad_his - existencias) then
			update depmovhis
			set    caja = :caja
			where  empresa     = :codigo_empresa
			and    articulo    = :articulo
			and    tipo_pallet = :tipo_pallet
			and    (caja = '' or caja is null);
	
			if sqlca.sqlcode = 0 then
				commit;
			else
				rollback;
			end if					
		end if
	next
	destroy soluciones
next

destroy errores

end event

type pb_1 from upb_salir within w_con_descuadres_articulos_deposito
integer x = 2729
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

