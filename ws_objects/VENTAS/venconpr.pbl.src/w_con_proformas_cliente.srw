$PBExportHeader$w_con_proformas_cliente.srw
forward
global type w_con_proformas_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_proformas_cliente
end type
type pb_2 from upb_imprimir within w_con_proformas_cliente
end type
type st_2 from statictext within w_con_proformas_cliente
end type
type dw_detalle from datawindow within w_con_proformas_cliente
end type
type dw_listado from datawindow within w_con_proformas_cliente
end type
type uo_manejo from u_manejo_datawindow within w_con_proformas_cliente
end type
type em_pallets from u_em_campo within w_con_proformas_cliente
end type
type em_cajas from u_em_campo within w_con_proformas_cliente
end type
type em_metros from u_em_campo within w_con_proformas_cliente
end type
type em_unidades from u_em_campo within w_con_proformas_cliente
end type
type ss from statictext within w_con_proformas_cliente
end type
type st-10 from statictext within w_con_proformas_cliente
end type
type st-11 from statictext within w_con_proformas_cliente
end type
type st-12 from statictext within w_con_proformas_cliente
end type
type st-13 from statictext within w_con_proformas_cliente
end type
type em_kilos from u_em_campo within w_con_proformas_cliente
end type
type em_totalkilos from u_em_campo within w_con_proformas_cliente
end type
type st-15 from statictext within w_con_proformas_cliente
end type
type st-16 from statictext within w_con_proformas_cliente
end type
type st-17 from statictext within w_con_proformas_cliente
end type
type st-18 from statictext within w_con_proformas_cliente
end type
type st-19 from statictext within w_con_proformas_cliente
end type
type em_totalbruto from u_em_campo within w_con_proformas_cliente
end type
type em_totaldto from u_em_campo within w_con_proformas_cliente
end type
type em_totalbase from u_em_campo within w_con_proformas_cliente
end type
type em_totaliva from u_em_campo within w_con_proformas_cliente
end type
type em_totalgeneral from u_em_campo within w_con_proformas_cliente
end type
type em_totalgeneral_bruto from u_em_campo within w_con_proformas_cliente
end type
type st_1 from statictext within w_con_proformas_cliente
end type
type em_totalgeneral_dto from u_em_campo within w_con_proformas_cliente
end type
type em_totalgeneral_base from u_em_campo within w_con_proformas_cliente
end type
type em_totalgeneral_iva from u_em_campo within w_con_proformas_cliente
end type
type em_totalgeneral_neto from u_em_campo within w_con_proformas_cliente
end type
type st_3 from statictext within w_con_proformas_cliente
end type
type em_unidades_general from u_em_campo within w_con_proformas_cliente
end type
type em_metros_general from u_em_campo within w_con_proformas_cliente
end type
type em_cajas_general from u_em_campo within w_con_proformas_cliente
end type
type em_pallets_general from u_em_campo within w_con_proformas_cliente
end type
type ddlb_1 from dropdownlistbox within w_con_proformas_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_proformas_cliente
end type
end forward

global type w_con_proformas_cliente from w_int_con_empresa
integer width = 3090
integer height = 2528
pb_1 pb_1
pb_2 pb_2
st_2 st_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
em_pallets em_pallets
em_cajas em_cajas
em_metros em_metros
em_unidades em_unidades
ss ss
st-10 st-10
st-11 st-11
st-12 st-12
st-13 st-13
em_kilos em_kilos
em_totalkilos em_totalkilos
st-15 st-15
st-16 st-16
st-17 st-17
st-18 st-18
st-19 st-19
em_totalbruto em_totalbruto
em_totaldto em_totaldto
em_totalbase em_totalbase
em_totaliva em_totaliva
em_totalgeneral em_totalgeneral
em_totalgeneral_bruto em_totalgeneral_bruto
st_1 st_1
em_totalgeneral_dto em_totalgeneral_dto
em_totalgeneral_base em_totalgeneral_base
em_totalgeneral_iva em_totalgeneral_iva
em_totalgeneral_neto em_totalgeneral_neto
st_3 st_3
em_unidades_general em_unidades_general
em_metros_general em_metros_general
em_cajas_general em_cajas_general
em_pallets_general em_pallets_general
ddlb_1 ddlb_1
uo_cliente uo_cliente
end type
global w_con_proformas_cliente w_con_proformas_cliente

type variables
string filtro, tipo_cli

end variables

forward prototypes
public subroutine f_control ()
public subroutine f_calculo (integer cod, integer linea)
public subroutine f_calcula_bruto_linea (integer cod, integer linea)
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,tipo_cli)
em_pallets.text  = "0"  
em_cajas.text    =  "0"  
em_metros.text   =  "0"  
em_unidades.text =  "0"  
em_kilos.text    =  "0"  

end subroutine

public subroutine f_calculo (integer cod, integer linea);dec{2} pallets,cajas,metros,unidades,kilos
dec{2} total_pallets,total_cajas,total_metros,total_unidades,total_kilos
string tipo
 unidades = 0
 metros = 0
 pallets = dw_detalle.GetItemNumber(linea,"pallets")
 cajas    =dw_detalle.GetItemNumber(linea,"cajas")
 Kilos    =dw_detalle.GetItemNumber(linea,"peso")
 tipo  =dw_detalle.GetItemString(linea,"tipo_unidad")
 If tipo = "1" then
   metros  =dw_detalle.GetItemNumber(linea,"cantidad")
 Else
   unidades =dw_detalle.GetItemNumber(linea,"cantidad")
 End if

 total_pallets  = Dec(em_pallets.text)
 total_cajas    = Dec(em_cajas.text)
 total_metros   = Dec(em_metros.text)
 total_unidades = Dec(em_unidades.text)
 total_kilos = Dec(em_kilos.text)
 If IsNull(total_pallets) Then total_pallets =0
 If IsNull(total_cajas) Then total_cajas =0
 If IsNull(total_metros) Then total_metros =0
 If IsNull(total_unidades) Then total_unidades =0
 If IsNull(total_kilos) Then total_kilos =0

 If IsNull(pallets)  Then pallets =0
 If IsNull(cajas)    Then cajas =0
 If IsNull(metros)   Then metros =0
 If IsNull(unidades) Then unidades =0
 If IsNull(kilos)    Then kilos =0

 IF cod =1 Then
    total_pallets  = total_pallets + pallets   
    total_cajas    = total_cajas + cajas   
    total_metros   = total_metros + metros  
    total_unidades = total_unidades + unidades   
    total_kilos    = total_kilos + kilos   
  END IF
 IF cod =2 Then
    total_pallets  = total_pallets - pallets   
    total_cajas    = total_cajas - cajas   
    total_metros   = total_metros - metros  
    total_unidades = total_unidades - unidades   
    total_kilos    = total_kilos - kilos   
 END IF

em_pallets.text  = String(total_pallets)  
em_cajas.text    = String(total_cajas)
em_metros.text   = String(total_metros)
em_unidades.text = String(total_unidades)
em_kilos.text    = String(total_kilos)
end subroutine

public subroutine f_calcula_bruto_linea (integer cod, integer linea);integer claveiva,periodo
String tipoiva
dec{2} importedto,importe,bruto,total_iva
dec{2} total_bruto,total_base,total_dto

importe    = dw_detalle.GetItemNumber(linea,"importe")
importedto = dw_detalle.GetItemNumber(linea,"importedto")
tipoiva    = dw_detalle.GetItemString(linea,"tipoiva")

bruto = importe + importedto

periodo  = f_ejercicio_activo(codigo_empresa)
claveiva = f_iva_contaiva(periodo,codigo_empresa,tipoiva)

total_bruto = dec(em_totalbruto.text)
total_base  = dec(em_totalbase.text)
total_dto   = dec(em_totaldto.text)

If IsNull(total_bruto) Then total_bruto = 0
If IsNull(total_base) Then  total_base  = 0
If IsNull(total_dto) Then   total_dto   = 0

if cod=1 then
     total_bruto = total_bruto + (importe+importedto)
     total_base  = total_base  + importe
     total_dto   = total_dto   + importedto
 else
     total_bruto = total_bruto - (importe+importedto)
     total_base  = total_base  - importe
     total_dto   = total_dto   - importedto
end if

em_totalbruto.text  = String(total_bruto)  
em_totaldto.text    = String(total_dto)
em_totalbase.text   = String(total_base)

IF total_base=0 or claveiva=0 then 
   total_iva=0
 else
   total_iva = (total_base * claveiva) /100
End IF

em_totaliva.text     = string(total_iva)
em_totalgeneral.text = string(total_base+total_iva)

return
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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de proforma por cliente"
This.title=istr_parametros.s_titulo_ventana

ddlb_1.text = "Si"
dw_detalle.SetTransObject(SQLCA)

f_activar_campo(uo_cliente.em_campo)
end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa,uo_cliente.em_codigo.text,tipo_cli)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_proformas_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.em_pallets=create em_pallets
this.em_cajas=create em_cajas
this.em_metros=create em_metros
this.em_unidades=create em_unidades
this.ss=create ss
this.st-10=create st-10
this.st-11=create st-11
this.st-12=create st-12
this.st-13=create st-13
this.em_kilos=create em_kilos
this.em_totalkilos=create em_totalkilos
this.st-15=create st-15
this.st-16=create st-16
this.st-17=create st-17
this.st-18=create st-18
this.st-19=create st-19
this.em_totalbruto=create em_totalbruto
this.em_totaldto=create em_totaldto
this.em_totalbase=create em_totalbase
this.em_totaliva=create em_totaliva
this.em_totalgeneral=create em_totalgeneral
this.em_totalgeneral_bruto=create em_totalgeneral_bruto
this.st_1=create st_1
this.em_totalgeneral_dto=create em_totalgeneral_dto
this.em_totalgeneral_base=create em_totalgeneral_base
this.em_totalgeneral_iva=create em_totalgeneral_iva
this.em_totalgeneral_neto=create em_totalgeneral_neto
this.st_3=create st_3
this.em_unidades_general=create em_unidades_general
this.em_metros_general=create em_metros_general
this.em_cajas_general=create em_cajas_general
this.em_pallets_general=create em_pallets_general
this.ddlb_1=create ddlb_1
this.uo_cliente=create uo_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.em_pallets
this.Control[iCurrent+8]=this.em_cajas
this.Control[iCurrent+9]=this.em_metros
this.Control[iCurrent+10]=this.em_unidades
this.Control[iCurrent+11]=this.ss
this.Control[iCurrent+12]=this.st-10
this.Control[iCurrent+13]=this.st-11
this.Control[iCurrent+14]=this.st-12
this.Control[iCurrent+15]=this.st-13
this.Control[iCurrent+16]=this.em_kilos
this.Control[iCurrent+17]=this.em_totalkilos
this.Control[iCurrent+18]=this.st-15
this.Control[iCurrent+19]=this.st-16
this.Control[iCurrent+20]=this.st-17
this.Control[iCurrent+21]=this.st-18
this.Control[iCurrent+22]=this.st-19
this.Control[iCurrent+23]=this.em_totalbruto
this.Control[iCurrent+24]=this.em_totaldto
this.Control[iCurrent+25]=this.em_totalbase
this.Control[iCurrent+26]=this.em_totaliva
this.Control[iCurrent+27]=this.em_totalgeneral
this.Control[iCurrent+28]=this.em_totalgeneral_bruto
this.Control[iCurrent+29]=this.st_1
this.Control[iCurrent+30]=this.em_totalgeneral_dto
this.Control[iCurrent+31]=this.em_totalgeneral_base
this.Control[iCurrent+32]=this.em_totalgeneral_iva
this.Control[iCurrent+33]=this.em_totalgeneral_neto
this.Control[iCurrent+34]=this.st_3
this.Control[iCurrent+35]=this.em_unidades_general
this.Control[iCurrent+36]=this.em_metros_general
this.Control[iCurrent+37]=this.em_cajas_general
this.Control[iCurrent+38]=this.em_pallets_general
this.Control[iCurrent+39]=this.ddlb_1
this.Control[iCurrent+40]=this.uo_cliente
end on

on w_con_proformas_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.em_pallets)
destroy(this.em_cajas)
destroy(this.em_metros)
destroy(this.em_unidades)
destroy(this.ss)
destroy(this.st-10)
destroy(this.st-11)
destroy(this.st-12)
destroy(this.st-13)
destroy(this.em_kilos)
destroy(this.em_totalkilos)
destroy(this.st-15)
destroy(this.st-16)
destroy(this.st-17)
destroy(this.st-18)
destroy(this.st-19)
destroy(this.em_totalbruto)
destroy(this.em_totaldto)
destroy(this.em_totalbase)
destroy(this.em_totaliva)
destroy(this.em_totalgeneral)
destroy(this.em_totalgeneral_bruto)
destroy(this.st_1)
destroy(this.em_totalgeneral_dto)
destroy(this.em_totalgeneral_base)
destroy(this.em_totalgeneral_iva)
destroy(this.em_totalgeneral_neto)
destroy(this.st_3)
destroy(this.em_unidades_general)
destroy(this.em_metros_general)
destroy(this.em_cajas_general)
destroy(this.em_pallets_general)
destroy(this.ddlb_1)
destroy(this.uo_cliente)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_proformas_cliente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_proformas_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_proformas_cliente
integer x = 9
integer y = 8
integer width = 3013
end type

type pb_1 from upb_salir within w_con_proformas_cliente
integer x = 2880
integer y = 132
integer width = 110
integer height = 104
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_proformas_cliente
integer x = 2702
integer y = 144
integer taborder = 0
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_proformas_cliente
integer x = 23
integer y = 148
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

type dw_detalle from datawindow within w_con_proformas_cliente
integer x = 27
integer y = 256
integer width = 3003
integer height = 1772
string dataobject = "dw_con_proformas_cliente"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;Integer linea
linea = row
IF linea = 0 Then Return
String controles

controles =  This.GetItemString(linea,"usuario")
IF controles = "MARCADO" Then
  This.SetItem(linea,"usuario","NOMARCADO")
  This.SelectRow(linea,FALSE)
  f_calculo(2,linea)
  f_calcula_bruto_linea(2,linea)
Else
  This.SetItem(linea,"usuario","MARCADO")
  This.SelectRow(linea,TRUE)
  f_calculo(1,linea)
  f_calcula_bruto_linea(1,linea)
End If

end event

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"proforma"))
  OpenWithParm(w_int_venproformas,lstr_param) 
End If
end event

type dw_listado from datawindow within w_con_proformas_cliente
boolean visible = false
integer y = 4
integer width = 160
integer height = 252
boolean bringtotop = true
string dataobject = "report_con_proformas_cliente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_proformas_cliente
integer x = 2222
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

type em_pallets from u_em_campo within w_con_proformas_cliente
integer x = 197
integer y = 2136
integer width = 101
integer taborder = 0
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type em_cajas from u_em_campo within w_con_proformas_cliente
integer x = 302
integer y = 2136
integer width = 178
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type em_metros from u_em_campo within w_con_proformas_cliente
integer x = 485
integer y = 2136
integer width = 261
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_unidades from u_em_campo within w_con_proformas_cliente
integer x = 750
integer y = 2136
integer width = 210
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type ss from statictext within w_con_proformas_cliente
integer x = 197
integer y = 2064
integer width = 105
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "Pl"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st-10 from statictext within w_con_proformas_cliente
integer x = 306
integer y = 2064
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st-11 from statictext within w_con_proformas_cliente
integer x = 494
integer y = 2064
integer width = 256
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "Metros"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st-12 from statictext within w_con_proformas_cliente
integer x = 759
integer y = 2064
integer width = 206
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "Unid."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st-13 from statictext within w_con_proformas_cliente
integer x = 974
integer y = 2064
integer width = 251
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "Kilos"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_kilos from u_em_campo within w_con_proformas_cliente
integer x = 965
integer y = 2136
integer width = 256
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
end type

type em_totalkilos from u_em_campo within w_con_proformas_cliente
integer x = 965
integer y = 2220
integer width = 256
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
end type

type st-15 from statictext within w_con_proformas_cliente
integer x = 1234
integer y = 2064
integer width = 347
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "Imp. bruto"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st-16 from statictext within w_con_proformas_cliente
integer x = 1591
integer y = 2064
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "Dto."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st-17 from statictext within w_con_proformas_cliente
integer x = 1874
integer y = 2064
integer width = 347
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "Base Imp."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st-18 from statictext within w_con_proformas_cliente
integer x = 2231
integer y = 2064
integer width = 251
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "I.v.a."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st-19 from statictext within w_con_proformas_cliente
integer x = 2491
integer y = 2064
integer width = 370
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 23245055
boolean enabled = false
string text = "Total"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_totalbruto from u_em_campo within w_con_proformas_cliente
integer x = 1225
integer y = 2136
integer width = 352
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totaldto from u_em_campo within w_con_proformas_cliente
integer x = 1582
integer y = 2136
integer width = 279
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totalbase from u_em_campo within w_con_proformas_cliente
integer x = 1865
integer y = 2136
integer width = 352
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totaliva from u_em_campo within w_con_proformas_cliente
integer x = 2222
integer y = 2136
integer width = 256
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

type em_totalgeneral from u_em_campo within w_con_proformas_cliente
integer x = 2482
integer y = 2136
integer width = 375
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totalgeneral_bruto from u_em_campo within w_con_proformas_cliente
integer x = 1225
integer y = 2220
integer width = 352
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type st_1 from statictext within w_con_proformas_cliente
integer y = 2228
integer width = 201
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
string text = "Gene."
boolean focusrectangle = false
end type

type em_totalgeneral_dto from u_em_campo within w_con_proformas_cliente
integer x = 1582
integer y = 2220
integer width = 279
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totalgeneral_base from u_em_campo within w_con_proformas_cliente
integer x = 1865
integer y = 2220
integer width = 352
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totalgeneral_iva from u_em_campo within w_con_proformas_cliente
integer x = 2222
integer y = 2220
integer width = 256
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

type em_totalgeneral_neto from u_em_campo within w_con_proformas_cliente
integer x = 2482
integer y = 2220
integer width = 375
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type st_3 from statictext within w_con_proformas_cliente
integer y = 2144
integer width = 192
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
string text = "Linea"
boolean focusrectangle = false
end type

type em_unidades_general from u_em_campo within w_con_proformas_cliente
integer x = 750
integer y = 2220
integer width = 210
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type em_metros_general from u_em_campo within w_con_proformas_cliente
integer x = 485
integer y = 2220
integer width = 261
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_cajas_general from u_em_campo within w_con_proformas_cliente
integer x = 302
integer y = 2220
integer width = 178
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type em_pallets_general from u_em_campo within w_con_proformas_cliente
integer x = 197
integer y = 2220
integer width = 101
integer taborder = 0
integer weight = 400
long textcolor = 16777215
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type ddlb_1 from dropdownlistbox within w_con_proformas_cliente
integer x = 279
integer y = 140
integer width = 210
integer height = 260
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551093
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type uo_cliente from u_em_campo_2 within w_con_proformas_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 498
integer y = 144
integer width = 1303
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;if ddlb_1.text = "Si" then
	   uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
	else
      uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)		
End if

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

tipo_cli = "N"
if ddlb_1.text="Si" then tipo_cli="S"

dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,tipo_cli)

 f_control()
 em_totalbase.text    = ""
 em_totalbruto.text   = ""
 em_totaldto.text     = "" 
 em_totalgeneral.text = ""
 em_totaliva.text     = ""
 em_totalkilos.text   = ""

 em_totalgeneral_base.text    = ""
 em_totalgeneral_bruto.text   = ""
 em_totalgeneral_dto.text     = "" 
 em_totalgeneral_iva.text     = "" 
 em_totalgeneral_neto.text    = ""
 em_totaliva.text             = ""
 em_pallets_general.text      = ""
 em_cajas_general.text        = ""
 em_unidades_general.text     = ""
 em_metros_general.text       = ""

IF dw_detalle.Rowcount()<>0 then
    string tipoiva
    integer claveiva
    em_totalkilos.text         = String(dw_detalle.GetItemNumber(1,"total_peso"))
	 em_totalgeneral_base.text  = String(dw_detalle.GetItemNumber(1,"totalgeneral_importe"))
	 em_totalgeneral_dto.text   = String(dw_detalle.GetItemNumber(1,"totalgeneral_importedto"))
    em_totalgeneral_bruto.text = String(Dec(em_totalgeneral_base.text) + Dec(em_totalgeneral_dto.text))
    em_pallets_general.text    = String(dw_detalle.GetItemNumber(1,"total_general_pallets"))
    em_cajas_general.text      = String(dw_detalle.GetItemNumber(1,"total_general_cajas"))
    em_metros_general.text     = String(dw_detalle.GetItemNumber(1,"total_general_metros"))
    em_unidades_general.text   = String(dw_detalle.GetItemNumber(1,"total_general_unidades"))

    tipoiva  = f_tipoiva_venclientes(codigo_empresa,uo_cliente.em_codigo.text)
    claveiva = f_iva_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,tipoiva)

    em_totalgeneral_iva.text  = string((dec(em_totalgeneral_base.text) * claveiva) /100)
    em_totalgeneral_neto.text = string(dec(em_totalgeneral_iva.text)+dec(em_totalgeneral_base.text))
end if

end event

event getfocus;call super::getfocus;IF ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""
Else
	ue_titulo = "Selección de no cliente"
	ue_datawindow ="dw_ayuda_vencliproforma"
	ue_filtro = ""
End if
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

