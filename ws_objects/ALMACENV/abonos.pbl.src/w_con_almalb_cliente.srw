$PBExportHeader$w_con_almalb_cliente.srw
forward
global type w_con_almalb_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_almalb_cliente
end type
type pb_2 from upb_imprimir within w_con_almalb_cliente
end type
type st_2 from statictext within w_con_almalb_cliente
end type
type dw_detalle from datawindow within w_con_almalb_cliente
end type
type dw_listado from datawindow within w_con_almalb_cliente
end type
type uo_manejo from u_manejo_datawindow within w_con_almalb_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_almalb_cliente
end type
type gb_1 from groupbox within w_con_almalb_cliente
end type
type cb_1 from commandbutton within w_con_almalb_cliente
end type
end forward

global type w_con_almalb_cliente from w_int_con_empresa
integer x = 59
integer y = 16
integer width = 2921
integer height = 2256
string title = "Consulta lineas de albarán (Abonos) por cliente"
pb_1 pb_1
pb_2 pb_2
st_2 st_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
uo_cliente uo_cliente
gb_1 gb_1
cb_1 cb_1
end type
global w_con_almalb_cliente w_con_almalb_cliente

type variables
string filtro

end variables

forward prototypes
public subroutine f_control ()
public subroutine f_calculo (integer cod, integer linea)
public subroutine f_calcula_bruto_linea (integer cod, integer linea)
end prototypes

public subroutine f_control ();String descli,hascli
dw_detalle.Reset()

if Trim(uo_cliente.em_codigo.text) = "" then
	descli = "."
	hascli = "ZZZZZ"
 ELSE
	descli = uo_cliente.em_codigo.text
	hascli = uo_cliente.em_codigo.text
End if

dw_detalle.Retrieve(codigo_empresa,descli,hascli)

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

event close;call super::close;str_parametros lstr_param
IF istr_parametros.s_argumentos[3] = "S" Then
  OpenWithParm(w_int_almalb,lstr_param) 
END IF
end event

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
istr_parametros.s_argumentos[3] = "N"
istr_parametros = Message.PowerObjectParm
IF istr_parametros.i_nargumentos>1 THEN
     uo_cliente.em_codigo.text=String(istr_parametros.s_argumentos[2])
	  uo_cliente.em_campo.text = f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
     f_control()
     istr_parametros.i_nargumentos=0
END IF
istr_parametros.s_titulo_ventana="Consulta lineas de albarán (Abonos) por cliente"
This.title=istr_parametros.s_titulo_ventana
f_activar_campo(uo_cliente.em_campo)
end event

on w_con_almalb_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.uo_cliente=create uo_cliente
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
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.cb_1
end on

on w_con_almalb_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.cb_1)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_almalb_cliente
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_almalb_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_almalb_cliente
integer x = 9
integer width = 2427
end type

type pb_1 from upb_salir within w_con_almalb_cliente
integer x = 2720
integer y = 4
integer width = 114
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type pb_2 from upb_imprimir within w_con_almalb_cliente
integer x = 2711
integer y = 144
integer width = 101
integer height = 80
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;String descli,hascli
if Trim(uo_cliente.em_codigo.text) = "" then
	descli = "."
	hascli = "ZZZZZ"
 ELSE
	descli = uo_cliente.em_codigo.text
	hascli = uo_cliente.em_codigo.text
End if

dw_listado.Retrieve(codigo_empresa,descli,hascli)
f_imprimir_datawindow(dw_listado)


end event

type st_2 from statictext within w_con_almalb_cliente
integer x = 18
integer y = 140
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

type dw_detalle from datawindow within w_con_almalb_cliente
integer x = 14
integer y = 248
integer width = 2830
integer height = 1772
string dataobject = "dw_con_almalb_cliente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_int_almalb,lstr_param) 
End If
end event

type dw_listado from datawindow within w_con_almalb_cliente
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_almalb_cliente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_almalb_cliente
integer x = 2231
integer y = 96
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

type uo_cliente from u_em_campo_2 within w_con_almalb_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 279
integer y = 140
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

type gb_1 from groupbox within w_con_almalb_cliente
integer x = 9
integer y = 92
integer width = 2130
integer height = 144
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_1 from commandbutton within w_con_almalb_cliente
integer x = 1737
integer y = 140
integer width = 379
integer height = 80
integer taborder = 50
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

