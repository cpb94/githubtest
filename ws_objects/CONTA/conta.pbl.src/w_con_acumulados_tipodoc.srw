$PBExportHeader$w_con_acumulados_tipodoc.srw
$PBExportComments$Proveedores/Clientes > 500.000
forward
global type w_con_acumulados_tipodoc from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_acumulados_tipodoc
end type
type pb_2 from upb_imprimir within w_con_acumulados_tipodoc
end type
type st_9 from statictext within w_con_acumulados_tipodoc
end type
type em_fechadesde from u_em_campo within w_con_acumulados_tipodoc
end type
type st_8 from statictext within w_con_acumulados_tipodoc
end type
type em_fechahasta from u_em_campo within w_con_acumulados_tipodoc
end type
type cb_1 from commandbutton within w_con_acumulados_tipodoc
end type
type dw_listado from datawindow within w_con_acumulados_tipodoc
end type
type ddlb_1 from dropdownlistbox within w_con_acumulados_tipodoc
end type
type dw_detalle from datawindow within w_con_acumulados_tipodoc
end type
type em_cantidad from editmask within w_con_acumulados_tipodoc
end type
type st_1 from statictext within w_con_acumulados_tipodoc
end type
type pb_3 from upb_imprimir within w_con_acumulados_tipodoc
end type
type uo_manejo from u_manejo_datawindow within w_con_acumulados_tipodoc
end type
type dw_cartas from datawindow within w_con_acumulados_tipodoc
end type
type st_2 from statictext within w_con_acumulados_tipodoc
end type
end forward

global type w_con_acumulados_tipodoc from w_int_con_empresa
integer width = 2921
integer height = 2196
pb_1 pb_1
pb_2 pb_2
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
cb_1 cb_1
dw_listado dw_listado
ddlb_1 ddlb_1
dw_detalle dw_detalle
em_cantidad em_cantidad
st_1 st_1
pb_3 pb_3
uo_manejo uo_manejo
dw_cartas dw_cartas
st_2 st_2
end type
global w_con_acumulados_tipodoc w_con_acumulados_tipodoc

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Integer r,c,ejercicio
DataStore d
String tipo,tip,sel1,tipoter
String clipro,nombre
dec base,iva,total,debe,haber

ejercicio = year(date(em_fechadesde.text))
tipo = "2"
if ddlb_1.text = "Clientes" then tipo = "1"




data.Reset()
data.SetRedraw(FALSE)
IF Trim(em_cantidad.text) = "" THEN
	em_cantidad.text = '0'
END IF
data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),DateTime(Date(em_fechahasta.text)),tipo,em_cantidad.text)
f_contador_procesos(0,100)

tip = f_tipo_cta_libro(ejercicio,codigo_empresa,tipo)

if ddlb_1.text = "Clientes" then 
	tipo = "1"
	Sel1 = " SELECT sum(debe) debe,sum(haber) haber,clipro,tipoter,sum(imponible) imponible" +&
			 " FROM   contaapun " +&
			 " WHERE  contaapun.empresa = '"+codigo_empresa+"'" +&
			 " And    contaapun.ejercicio = "+string(ejercicio)+&
			 " And    contaapun.tipoapu  = '"+tipo+"'" +&
			 " And    contaapun.fapunte between '"+STring(Date(em_fechadesde.text),"dd/mm/yyyy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yyyy")+"' "+&
			 " GROUP By tipoter,clipro"
else
	tipo = "2"
	Sel1 = " SELECT sum(debe) debe,sum(haber) haber,clipro,tipoter,sum(imponible) imponible" +&
			 " FROM   contaapun " +&
			 " WHERE  contaapun.empresa = '"+codigo_empresa+"'" +&
			 " And    contaapun.ejercicio = "+string(ejercicio)+&
			 " And    (contaapun.tipoapu  = '"+tipo+"' or  contaapun.tipoapu  = '7')" +&
			 " And    contaapun.fapunte between '"+STring(Date(em_fechadesde.text),"dd/mm/yyyy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yyyy")+"' "+&
			 " GROUP By tipoter,clipro"
end if		

messagebox ("",sel1)
		
c = 0
//d= f_cargar_cursor(sel1)
f_cargar_cursor_nuevo(sel1, d)

	For r = 1 To d.RowCount()
		clipro  = d.GetItemString(r,"clipro")
		tipoter = d.GetItemString(r,"tipoter")
		if tipo = "1" then
		    nombre  = f_nombre_cliente(codigo_empresa,tipoter,clipro)
		else
			 nombre  = f_nombre_proveedor(codigo_empresa,clipro)
		End if
		base    = d.GetItemNumber(r,"imponible")
		debe    = d.GetItemNumber(r,"debe")
      haber   = d.GetItemNumber(r,"haber")
				
		IF tip = "D" then 
			iva = debe - haber
		 else
			iva = haber - debe
		End if
		total   = base + iva
		
			if f_pais_genter(codigo_empresa,tipoter,clipro)="11" then
				if total >=dec(em_cantidad.text) then
					c = data.RowCount()+1
					data.InsertRow(c)
					data.SetItem(c,"clipro",clipro)
					data.SetItem(c,"tipoter",tipoter)
					data.SetItem(c,"nombre",nombre)
					data.SetItem(c,"base",base)
					data.SetItem(c,"total",total)
					data.SetItem(c,"iva",iva)
				End if
			End if

		f_mensaje_proceso("Leyendo apuntes",r,d.RowCount() )
	Next

data.SetSort("number(clipro)")
data.Sort()
f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
f_contador_procesos(1,1)

destroy d
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen ventas/compras"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())

dw_listado.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_cartas.SetTransObject(SQLCA)

ddlb_1.Text = "Clientes"

end event

on w_con_acumulados_tipodoc.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_9=create st_9
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.dw_listado=create dw_listado
this.ddlb_1=create ddlb_1
this.dw_detalle=create dw_detalle
this.em_cantidad=create em_cantidad
this.st_1=create st_1
this.pb_3=create pb_3
this.uo_manejo=create uo_manejo
this.dw_cartas=create dw_cartas
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_9
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.st_8
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_listado
this.Control[iCurrent+9]=this.ddlb_1
this.Control[iCurrent+10]=this.dw_detalle
this.Control[iCurrent+11]=this.em_cantidad
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.pb_3
this.Control[iCurrent+14]=this.uo_manejo
this.Control[iCurrent+15]=this.dw_cartas
this.Control[iCurrent+16]=this.st_2
end on

on w_con_acumulados_tipodoc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_9)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.dw_listado)
destroy(this.ddlb_1)
destroy(this.dw_detalle)
destroy(this.em_cantidad)
destroy(this.st_1)
destroy(this.pb_3)
destroy(this.uo_manejo)
destroy(this.dw_cartas)
destroy(this.st_2)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_acumulados_tipodoc
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_acumulados_tipodoc
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_acumulados_tipodoc
integer y = 4
integer width = 2071
integer height = 108
end type

type pb_1 from upb_salir within w_con_acumulados_tipodoc
integer x = 2720
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_acumulados_tipodoc
integer x = 2112
integer y = 176
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_cartas)
f_imprimir_datawindow(dw_cartas)


end event

type st_9 from statictext within w_con_acumulados_tipodoc
integer x = 14
integer y = 176
integer width = 187
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_acumulados_tipodoc
integer x = 201
integer y = 176
integer width = 283
integer height = 88
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_acumulados_tipodoc
integer x = 507
integer y = 180
integer width = 169
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
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_acumulados_tipodoc
integer x = 681
integer y = 176
integer width = 283
integer height = 88
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_acumulados_tipodoc
integer x = 1815
integer y = 176
integer width = 279
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;f_control(dw_detalle)

end event

type dw_listado from datawindow within w_con_acumulados_tipodoc
integer x = 2130
integer y = 12
integer width = 229
integer height = 76
string dataobject = "report_con_libros_iva_resumen"
boolean livescroll = true
end type

type ddlb_1 from dropdownlistbox within w_con_acumulados_tipodoc
integer x = 1001
integer y = 176
integer width = 407
integer height = 220
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean vscrollbar = true
string item[] = {"Clientes","Proveedores"}
end type

type dw_detalle from datawindow within w_con_acumulados_tipodoc
integer y = 284
integer width = 2862
integer height = 1692
string dataobject = "dw_con_acumulados_tipodoc"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type em_cantidad from editmask within w_con_acumulados_tipodoc
integer x = 1417
integer y = 176
integer width = 384
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "3005.06"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###,##0.00"
end type

type st_1 from statictext within w_con_acumulados_tipodoc
integer x = 1467
integer y = 112
integer width = 288
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Cantidad >"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_3 from upb_imprimir within w_con_acumulados_tipodoc
event clicked pbm_bnclicked
integer x = 2706
integer y = 180
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type uo_manejo from u_manejo_datawindow within w_con_acumulados_tipodoc
integer x = 2231
integer y = 132
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_cartas from datawindow within w_con_acumulados_tipodoc
integer x = 2368
integer y = 8
integer width = 233
integer height = 80
string dataobject = "report_cartas_iva_resumen"
boolean livescroll = true
end type

type st_2 from statictext within w_con_acumulados_tipodoc
integer x = 2075
integer y = 116
integer width = 169
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cartas"
alignment alignment = center!
boolean focusrectangle = false
end type

