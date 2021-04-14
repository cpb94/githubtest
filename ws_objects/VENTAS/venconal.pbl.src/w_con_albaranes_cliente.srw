$PBExportHeader$w_con_albaranes_cliente.srw
forward
global type w_con_albaranes_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_albaranes_cliente
end type
type pb_2 from upb_imprimir within w_con_albaranes_cliente
end type
type st_2 from statictext within w_con_albaranes_cliente
end type
type dw_detalle from datawindow within w_con_albaranes_cliente
end type
type dw_listado from datawindow within w_con_albaranes_cliente
end type
type uo_manejo from u_manejo_datawindow within w_con_albaranes_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_albaranes_cliente
end type
type em_desde from u_em_campo within w_con_albaranes_cliente
end type
type em_hasta from u_em_campo within w_con_albaranes_cliente
end type
type st_3 from statictext within w_con_albaranes_cliente
end type
type st_4 from statictext within w_con_albaranes_cliente
end type
type gb_1 from groupbox within w_con_albaranes_cliente
end type
type cb_1 from commandbutton within w_con_albaranes_cliente
end type
end forward

global type w_con_albaranes_cliente from w_int_con_empresa
integer x = 14
integer y = 16
integer width = 3058
integer height = 2208
pb_1 pb_1
pb_2 pb_2
st_2 st_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
uo_cliente uo_cliente
em_desde em_desde
em_hasta em_hasta
st_3 st_3
st_4 st_4
gb_1 gb_1
cb_1 cb_1
end type
global w_con_albaranes_cliente w_con_albaranes_cliente

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_calculo (integer cod, integer linea)
public subroutine f_calcula_bruto_linea (integer cod, integer linea)
end prototypes

public subroutine f_control ();dw_detalle.Reset()

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_desde.Text)))
fecha2=Datetime(Date(String(em_hasta.Text)))

dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,fecha1,fecha2)

f_activar_campo(uo_cliente.em_campo)

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

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de albarán por cliente"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

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

on w_con_albaranes_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.uo_cliente=create uo_cliente
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_3=create st_3
this.st_4=create st_4
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.em_desde
this.Control[iCurrent+9]=this.em_hasta
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.cb_1
end on

on w_con_albaranes_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.uo_cliente)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_1)
destroy(this.cb_1)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_albaranes_cliente
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_albaranes_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_albaranes_cliente
integer x = 9
integer width = 2427
end type

type pb_1 from upb_salir within w_con_albaranes_cliente
integer x = 2720
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_albaranes_cliente
integer x = 2706
integer y = 212
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_albaranes_cliente
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

type dw_detalle from datawindow within w_con_albaranes_cliente
integer x = 5
integer y = 320
integer width = 2962
integer height = 1624
string dataobject = "dw_con_albaranes_cliente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;Integer linea
linea = row
IF linea = 0 Then Return
String controles

//controles =  This.GetItemString(linea,"usuario")
//IF controles = "MARCADO" Then
//  This.SetItem(linea,"usuario","NOMARCADO")
//  This.SelectRow(linea,FALSE)
//  f_calculo(2,linea)
//  f_calcula_bruto_linea(2,linea)
//Else
//  This.SetItem(linea,"usuario","MARCADO")
//  This.SelectRow(linea,TRUE)
//  f_calculo(1,linea)
//  f_calcula_bruto_linea(1,linea)
//End If
//
end event

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_int_venalb,lstr_param) 
End If
end event

type dw_listado from datawindow within w_con_albaranes_cliente
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_con_albaranes_cliente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_albaranes_cliente
integer x = 2231
integer y = 168
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type uo_cliente from u_em_campo_2 within w_con_albaranes_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 279
integer y = 120
integer width = 1435
integer taborder = 10
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

type em_desde from u_em_campo within w_con_albaranes_cliente
integer x = 425
integer y = 212
integer width = 297
integer height = 80
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_hasta from u_em_campo within w_con_albaranes_cliente
integer x = 987
integer y = 212
integer width = 297
integer height = 80
integer taborder = 40
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_3 from statictext within w_con_albaranes_cliente
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

type st_4 from statictext within w_con_albaranes_cliente
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

type gb_1 from groupbox within w_con_albaranes_cliente
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

type cb_1 from commandbutton within w_con_albaranes_cliente
integer x = 1335
integer y = 212
integer width = 379
integer height = 80
integer taborder = 60
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

