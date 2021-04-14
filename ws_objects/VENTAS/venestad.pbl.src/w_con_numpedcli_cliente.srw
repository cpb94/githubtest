$PBExportHeader$w_con_numpedcli_cliente.srw
forward
global type w_con_numpedcli_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_numpedcli_cliente
end type
type pb_2 from upb_imprimir within w_con_numpedcli_cliente
end type
type st_2 from statictext within w_con_numpedcli_cliente
end type
type dw_listado from datawindow within w_con_numpedcli_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_numpedcli_cliente
end type
type em_desde from u_em_campo within w_con_numpedcli_cliente
end type
type em_hasta from u_em_campo within w_con_numpedcli_cliente
end type
type st_3 from statictext within w_con_numpedcli_cliente
end type
type st_4 from statictext within w_con_numpedcli_cliente
end type
type gb_1 from groupbox within w_con_numpedcli_cliente
end type
type cb_1 from commandbutton within w_con_numpedcli_cliente
end type
type dw_2 from datawindow within w_con_numpedcli_cliente
end type
type dw_1 from u_datawindow_consultas within w_con_numpedcli_cliente
end type
end forward

global type w_con_numpedcli_cliente from w_int_con_empresa
integer width = 2939
integer height = 1680
pb_1 pb_1
pb_2 pb_2
st_2 st_2
dw_listado dw_listado
uo_cliente uo_cliente
em_desde em_desde
em_hasta em_hasta
st_3 st_3
st_4 st_4
gb_1 gb_1
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_con_numpedcli_cliente w_con_numpedcli_cliente

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_calculo (integer cod, integer linea)
public subroutine f_calcula_bruto_linea (integer cod, integer linea)
public subroutine f_control2 (datawindow data)
end prototypes

public subroutine f_control ();dw_1.Reset()
dw_2.Reset()
dw_1.SetRedraw(False)
Dec r,r1,rr
String ped
Datetime fecha1,fecha2

fecha1=Datetime(Date(String(em_desde.Text)))
fecha2=Datetime(Date(String(em_hasta.Text)))

dw_1.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,fecha1,fecha2)

DataStore cur
String Sel 
sel = " Select  numpedcli from venliped " +&
		" Where   empresa    = '" +codigo_empresa+"'"+&
		" And     cliente    = '" +uo_cliente.em_codigo.text+"'"     +&
		" And     fpedido    between '"+STring(date(fecha1),"dd/mm/yy")+"' and '"+STring(date(fecha2),"dd/mm/yy")+"'"    +&
		" And     numpedcli is not null Group by numpedcli"
//cur= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, cur)

r1 = cur.RowCOunt()
IF r1 <> 0 then
	FOr r = 1 To r1		
		ped = cur.GetItemString(r,"numpedcli")
		IF dw_1.find("numpedcli='"+Trim(ped)+"'",1,dw_1.RowCount()) = 0 Then 
			rr = dw_1.InsertRow(0)
			dw_1.SetItem(rr,"numpedcli",ped)
		END IF
	Next
END IF





sel = " Select  numpedcli ped from venlialb " +&
		" Where   empresa    = '" +codigo_empresa+"'"+&
		" And     cliente    = '" +uo_cliente.em_codigo.text+"'"     +&
		" And     falbaran    between '"+STring(date(fecha1),"dd/mm/yy")+"' and '"+STring(date(fecha2),"dd/mm/yy")+"'"    +&
		" And     numpedcli is not null Group by numpedcli"
//cur= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, cur)

r1 = cur.RowCOunt()
IF r1 <> 0 then
FOr r = 1 To r1		
	ped = cur.GetItemString(r,"ped")
	IF dw_1.find("numpedcli='"+Trim(ped)+"'",1,dw_1.RowCount()) = 0 Then 
		rr = dw_1.InsertRow(0)
		dw_1.SetItem(rr,"numpedcli",ped)
	END IF
Next
END IF
dw_1.SetSort("numpedcli")
dw_1.Sort()
dw_1.SetRedraw(True)

f_activar_campo(uo_cliente.em_campo)

destroy cur

end subroutine

public subroutine f_calculo (integer cod, integer linea);//dec{2} pallets,cajas,metros,unidades,kilos
//dec{2} total_pallets,total_cajas,total_metros,total_unidades,total_kilos
//string tipo
// unidades = 0
// metros = 0
// pallets = dw_detalle.GetItemNumber(linea,"pallets")
// cajas    =dw_detalle.GetItemNumber(linea,"cajas")
// Kilos    =dw_detalle.GetItemNumber(linea,"peso")
// tipo  =dw_detalle.GetItemString(linea,"tipo_unidad")
// If tipo = "1" then
//   metros  =dw_detalle.GetItemNumber(linea,"cantidad")
// Else
//   unidades =dw_detalle.GetItemNumber(linea,"cantidad")
// End if
//
// total_pallets  = Dec(em_pallets.text)
// total_cajas    = Dec(em_cajas.text)
// total_metros   = Dec(em_metros.text)
// total_unidades = Dec(em_unidades.text)
// total_kilos = Dec(em_kilos.text)
// If IsNull(total_pallets) Then total_pallets =0
// If IsNull(total_cajas) Then total_cajas =0
// If IsNull(total_metros) Then total_metros =0
// If IsNull(total_unidades) Then total_unidades =0
// If IsNull(total_kilos) Then total_kilos =0
//
// If IsNull(pallets)  Then pallets =0
// If IsNull(cajas)    Then cajas =0
// If IsNull(metros)   Then metros =0
// If IsNull(unidades) Then unidades =0
// If IsNull(kilos)    Then kilos =0
//
// IF cod =1 Then
//    total_pallets  = total_pallets + pallets   
//    total_cajas    = total_cajas + cajas   
//    total_metros   = total_metros + metros  
//    total_unidades = total_unidades + unidades   
//    total_kilos    = total_kilos + kilos   
//  END IF
// IF cod =2 Then
//    total_pallets  = total_pallets - pallets   
//    total_cajas    = total_cajas - cajas   
//    total_metros   = total_metros - metros  
//    total_unidades = total_unidades - unidades   
//    total_kilos    = total_kilos - kilos   
// END IF
//
//em_pallets.text  = String(total_pallets)  
//em_cajas.text    = String(total_cajas)
//em_metros.text   = String(total_metros)
//em_unidades.text = String(total_unidades)
//em_kilos.text    = String(total_kilos)
end subroutine

public subroutine f_calcula_bruto_linea (integer cod, integer linea);//integer claveiva,periodo
//String tipoiva
//dec{2} importedto,importe,bruto,total_iva
//dec{2} total_bruto,total_base,total_dto
//
//importe    = dw_detalle.GetItemNumber(linea,"importe")
//importedto = dw_detalle.GetItemNumber(linea,"importedto")
//tipoiva    = dw_detalle.GetItemString(linea,"tipoiva")
//
//bruto = importe + importedto
//
//periodo  = f_ejercicio_activo(codigo_empresa)
//claveiva = f_iva_contaiva(periodo,codigo_empresa,tipoiva)
//
//total_bruto = dec(em_totalbruto.text)
//total_base  = dec(em_totalbase.text)
//total_dto   = dec(em_totaldto.text)
//
//If IsNull(total_bruto) Then total_bruto = 0
//If IsNull(total_base) Then  total_base  = 0
//If IsNull(total_dto) Then   total_dto   = 0
//
//if cod=1 then
//     total_bruto = total_bruto + (importe+importedto)
//     total_base  = total_base  + importe
//     total_dto   = total_dto   + importedto
// else
//     total_bruto = total_bruto - (importe+importedto)
//     total_base  = total_base  - importe
//     total_dto   = total_dto   - importedto
//end if
//
//em_totalbruto.text  = String(total_bruto)  
//em_totaldto.text    = String(total_dto)
//em_totalbase.text   = String(total_base)
//
//IF total_base=0 or claveiva=0 then 
//   total_iva=0
// else
//   total_iva = (total_base * claveiva) /100
//End IF
//
//em_totaliva.text     = string(total_iva)
//em_totalgeneral.text = string(total_base+total_iva)
//
//return
end subroutine

public subroutine f_control2 (datawindow data);data.Reset()
IF dw_1.GetRow() = 0 Then Return
data.SetRedraw(False)
Dec r,r1,rr
String ped,calidad
Datetime fecha1,fecha2
ped = dw_1.GetItemSTring(dw_1.GetRow(),"numpedcli")
fecha1=Datetime(Date(String(em_desde.Text)))
fecha2=Datetime(Date(String(em_hasta.Text)))

data.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,fecha1,fecha2,ped)

DataStore cur
String Sel 
sel = " Select  pedido,fpedido,descripcion,calidad,tono,calibre,tipo_pallet,divisa,tipo_unidad,pallets,cajas,cantidad,precio from venliped " +&
		" Where   empresa    = '" +codigo_empresa+"'"+&
		" And     cliente    = '" +uo_cliente.em_codigo.text+"'"     +&
		" And     fpedido    between '"+STring(date(fecha1),"dd/mm/yy")+"' and '"+STring(date(fecha2),"dd/mm/yy")+"'"    +&
		" And     numpedcli  = '"+Trim(ped)+"'"
//cur= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, cur)

r1 = cur.RowCOunt()
IF r1 <> 0 Then
FOr r = 1 To r1		
rr = data.InsertRow(0)
data.SetItem(rr,"venlifac_ffactura",cur.GetItemDateTime(r,"fpedido"))
data.SetItem(rr,"venlifac_factura",cur.GetItemNumber(r,"pedido"))
data.SetItem(rr,"venlifac_descripcion",cur.GetItemString(r,"descripcion"))
data.SetItem(rr,"calidad",cur.GetItemString(r,"calidad"))
data.SetItem(rr,"venlifac_tono",cur.GetItemNumber(r,"tono"))
data.SetItem(rr,"venlifac_calibre",cur.GetItemNumber(r,"calibre"))
data.SetItem(rr,"tipo_pallet",cur.GetItemString(r,"tipo_pallet"))
data.SetItem(rr,"venlifac_tipo_unidad",cur.GetItemString(r,"tipo_unidad"))
data.SetItem(rr,"venlifac_divisa",cur.GetItemString(r,"divisa"))
data.SetItem(rr,"venlifac_precio",cur.GetItemNumber(r,"precio"))
data.SetItem(rr,"venlifac_cantidad",cur.GetItemNumber(r,"cantidad"))
data.SetItem(rr,"venlifac_pallets",cur.GetItemNumber(r,"pallets"))
data.SetItem(rr,"venlifac_cajas",cur.GetItemNumber(r,"cajas"))
data.SetItem(rr,"tipo","P-")

Next
END IF


sel = " Select  albaran,falbaran,descripcion,calidad,tono,calibre,tipo_pallet,divisa,tipo_unidad,pallets,cajas,cantidad,precio from venlialb " +&
		" Where   empresa    = '" +codigo_empresa+"'"+&
		" And     cliente    = '" +uo_cliente.em_codigo.text+"'"     +&
		" And     falbaran    between '"+STring(date(fecha1),"dd/mm/yy")+"' and '"+STring(date(fecha2),"dd/mm/yy")+"'"    +&
		" And     numpedcli  = '"+Trim(ped)+"'"
//cur= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, cur)

r1 = cur.RowCOunt()
IF r1 <> 0 Then
FOr r = 1 To r1		
rr = data.InsertRow(0)
data.SetItem(rr,"venlifac_ffactura",cur.GetItemDateTime(r,"falbaran"))
data.SetItem(rr,"venlifac_factura",cur.GetItemNumber(r,"albaran"))
data.SetItem(rr,"venlifac_descripcion",cur.GetItemString(r,"descripcion"))
data.SetItem(rr,"calidad",cur.GetItemString(r,"calidad"))
data.SetItem(rr,"venlifac_tono",cur.GetItemNumber(r,"tono"))
data.SetItem(rr,"venlifac_calibre",cur.GetItemNumber(r,"calibre"))
data.SetItem(rr,"tipo_pallet",cur.GetItemString(r,"tipo_pallet"))
data.SetItem(rr,"venlifac_tipo_unidad",cur.GetItemString(r,"tipo_unidad"))
data.SetItem(rr,"venlifac_divisa",cur.GetItemString(r,"divisa"))
data.SetItem(rr,"venlifac_precio",cur.GetItemNumber(r,"precio"))
data.SetItem(rr,"venlifac_cantidad",cur.GetItemNumber(r,"cantidad"))
data.SetItem(rr,"venlifac_pallets",cur.GetItemNumber(r,"pallets"))
data.SetItem(rr,"venlifac_cajas",cur.GetItemNumber(r,"cajas"))
data.SetItem(rr,"tipo","A-")

Next
END IF


data.SetSort("venlifac_ffactura")
data.Sort()

data.SetRedraw(True)
r1 = data.RowCOunt()
IF r1 = 0 Then
	destroy cur
	Return
end if
For r = 1 To r1
	calidad = data.GetItemSTring(r,"calidad")
	data.SetItem(r,"nombre_calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
	data.SetItem(r,"nombre_unidad",f_nombre_unidad_abr(data.GetItemSTring(r,"venlifac_tipo_unidad")))
	data.SetItem(r,"nombre_tipo_pallet",f_nombre_pallet_abr(codigo_empresa,data.GetItemSTring(r,"tipo_pallet")))
	data.SetItem(r,"nombre_moneda",f_nombre_moneda_abr(data.GetItemSTring(r,"venlifac_divisa")))
NEXT


f_activar_campo(uo_cliente.em_campo)
destroy cur


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta referencia por cliente"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

em_desde.text = String(MDY(01,01,Year(Today())))
em_hasta.text = String(Today())

f_activar_campo(uo_cliente.em_campo)
end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_desde.Text)))
fecha2=Datetime(Date(String(em_hasta.Text)))

dw_report.retrieve(codigo_empresa,uo_cliente.em_codigo.text,fecha1,fecha2)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar

f_activar_campo(uo_cliente.em_campo)
end event

on w_con_numpedcli_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.dw_listado=create dw_listado
this.uo_cliente=create uo_cliente
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_3=create st_3
this.st_4=create st_4
this.gb_1=create gb_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_cliente
this.Control[iCurrent+6]=this.em_desde
this.Control[iCurrent+7]=this.em_hasta
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.dw_2
this.Control[iCurrent+13]=this.dw_1
end on

on w_con_numpedcli_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.dw_listado)
destroy(this.uo_cliente)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_numpedcli_cliente
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_numpedcli_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_numpedcli_cliente
integer x = 9
integer width = 2427
end type

type pb_1 from upb_salir within w_con_numpedcli_cliente
integer x = 2720
integer y = 4
integer width = 114
integer height = 104
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_numpedcli_cliente
integer x = 1751
integer y = 212
integer width = 101
integer height = 80
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control2(dw_listado)
f_imprimir_datawindow(dw_listado)

end event

type st_2 from statictext within w_con_numpedcli_cliente
integer x = 18
integer y = 120
integer width = 238
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_numpedcli_cliente
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_numpedcli_cliente"
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_con_numpedcli_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 279
integer y = 120
integer width = 1435
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

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

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type em_desde from u_em_campo within w_con_numpedcli_cliente
integer x = 425
integer y = 212
integer width = 297
integer height = 80
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_hasta from u_em_campo within w_con_numpedcli_cliente
integer x = 987
integer y = 212
integer width = 297
integer height = 80
integer taborder = 50
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_3 from statictext within w_con_numpedcli_cliente
integer x = 23
integer y = 212
integer width = 370
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_numpedcli_cliente
integer x = 745
integer y = 212
integer width = 183
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_numpedcli_cliente
integer x = 9
integer y = 76
integer width = 1723
integer height = 236
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_1 from commandbutton within w_con_numpedcli_cliente
integer x = 1335
integer y = 212
integer width = 379
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;f_control()
end event

type dw_2 from datawindow within w_con_numpedcli_cliente
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
integer x = 704
integer y = 328
integer width = 2153
integer height = 1104
string dataobject = "dw_con_numpedcli_cliente2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_1 from u_datawindow_consultas within w_con_numpedcli_cliente
integer y = 324
integer width = 699
integer height = 1108
integer taborder = 10
string dataobject = "dw_con_numpedcli_cliente1"
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;f_control2(dw_2)
end event

