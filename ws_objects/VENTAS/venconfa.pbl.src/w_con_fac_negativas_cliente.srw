$PBExportHeader$w_con_fac_negativas_cliente.srw
forward
global type w_con_fac_negativas_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_fac_negativas_cliente
end type
type pb_2 from upb_imprimir within w_con_fac_negativas_cliente
end type
type dw_detalle from datawindow within w_con_fac_negativas_cliente
end type
type dw_listado from datawindow within w_con_fac_negativas_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_fac_negativas_cliente
end type
type gb_cliente from groupbox within w_con_fac_negativas_cliente
end type
type gb_fecha from groupbox within w_con_fac_negativas_cliente
end type
type cb_1 from commandbutton within w_con_fac_negativas_cliente
end type
type em_fechadesde from u_em_campo within w_con_fac_negativas_cliente
end type
type em_fechahasta from u_em_campo within w_con_fac_negativas_cliente
end type
type st_1 from statictext within w_con_fac_negativas_cliente
end type
type uo_articulo from u_em_campo_2 within w_con_fac_negativas_cliente
end type
type gb_1 from groupbox within w_con_fac_negativas_cliente
end type
end forward

global type w_con_fac_negativas_cliente from w_int_con_empresa
integer x = 59
integer y = 16
integer width = 3561
integer height = 2632
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_cliente uo_cliente
gb_cliente gb_cliente
gb_fecha gb_fecha
cb_1 cb_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_1 st_1
uo_articulo uo_articulo
gb_1 gb_1
end type
global w_con_fac_negativas_cliente w_con_fac_negativas_cliente

type variables
string filtro

end variables

forward prototypes
public subroutine f_control ()
public subroutine f_calculo (integer cod, integer linea)
public subroutine f_calcula_bruto_linea (integer cod, integer linea)
end prototypes

public subroutine f_control ();String descli,hascli, articulo
dw_detalle.Reset()

if uo_articulo.em_codigo.text = '' or isnull(uo_articulo.em_codigo.text) then
	articulo = '%'
else
	articulo = uo_articulo.em_codigo.text
end if

if Trim(uo_cliente.em_codigo.text) = "" then
	descli = "."
	hascli = "ZZZZZ"
 ELSE
	descli = uo_cliente.em_codigo.text
	hascli = uo_cliente.em_codigo.text
End if

dw_detalle.Retrieve(codigo_empresa,descli,hascli, datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)), articulo)

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
  OpenWithParm(w_int_venfac,lstr_param) 
END IF
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.TriggerEvent("pagina_abajo")
end event

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

em_fechadesde.text = '01-01-01'
em_fechahasta.text = string(today(), 'dd-mm-yy')

istr_parametros.s_titulo_ventana="Consulta lineas de Factura (Negativas) por cliente"
This.title=istr_parametros.s_titulo_ventana
f_activar_campo(uo_cliente.em_campo)
end event

on w_con_fac_negativas_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_cliente=create uo_cliente
this.gb_cliente=create gb_cliente
this.gb_fecha=create gb_fecha
this.cb_1=create cb_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.uo_articulo=create uo_articulo
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_cliente
this.Control[iCurrent+6]=this.gb_cliente
this.Control[iCurrent+7]=this.gb_fecha
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.em_fechadesde
this.Control[iCurrent+10]=this.em_fechahasta
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.uo_articulo
this.Control[iCurrent+13]=this.gb_1
end on

on w_con_fac_negativas_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_cliente)
destroy(this.gb_cliente)
destroy(this.gb_fecha)
destroy(this.cb_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.uo_articulo)
destroy(this.gb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_fac_negativas_cliente
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_fac_negativas_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_fac_negativas_cliente
integer x = 9
integer width = 3291
integer height = 88
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_con_fac_negativas_cliente
integer x = 3333
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_fac_negativas_cliente
integer x = 3328
integer y = 128
integer taborder = 0
end type

event clicked;String descli,hascli
if Trim(uo_cliente.em_codigo.text) = "" then
	descli = "."
	hascli = "ZZZZZ"
 ELSE
	descli = uo_cliente.em_codigo.text
	hascli = uo_cliente.em_codigo.text
End if

dw_listado.Retrieve(codigo_empresa,descli,hascli)
f_imprimir_datawindow(dw_detalle)


end event

type dw_detalle from datawindow within w_con_fac_negativas_cliente
integer x = 23
integer y = 252
integer width = 3442
integer height = 2148
string dataobject = "dw_con_fac_negativas_cliente"
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

type dw_listado from datawindow within w_con_fac_negativas_cliente
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_almalb_cliente"
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_con_fac_negativas_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 50
integer y = 136
integer width = 1234
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

type gb_cliente from groupbox within w_con_fac_negativas_cliente
integer x = 32
integer y = 84
integer width = 1271
integer height = 152
integer taborder = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type gb_fecha from groupbox within w_con_fac_negativas_cliente
integer x = 2254
integer y = 80
integer width = 631
integer height = 152
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type cb_1 from commandbutton within w_con_fac_negativas_cliente
integer x = 2917
integer y = 124
integer width = 379
integer height = 104
integer taborder = 90
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

type em_fechadesde from u_em_campo within w_con_fac_negativas_cliente
integer x = 2267
integer y = 132
integer width = 265
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fechahasta from u_em_campo within w_con_fac_negativas_cliente
integer x = 2601
integer y = 132
integer width = 270
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_1 from statictext within w_con_fac_negativas_cliente
integer x = 2537
integer y = 124
integer width = 64
integer height = 68
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_con_fac_negativas_cliente
event destroy ( )
integer x = 1330
integer y = 136
integer width = 901
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_articulo.em_campo.text = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Artículos"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

type gb_1 from groupbox within w_con_fac_negativas_cliente
integer x = 1312
integer y = 84
integer width = 937
integer height = 152
integer taborder = 100
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Artículo"
end type

