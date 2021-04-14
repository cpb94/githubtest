$PBExportHeader$w_con_pedidos_cliente.srw
forward
global type w_con_pedidos_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_cliente
end type
type pb_2 from upb_imprimir within w_con_pedidos_cliente
end type
type st_2 from statictext within w_con_pedidos_cliente
end type
type em_cliente from u_em_campo within w_con_pedidos_cliente
end type
type st_nombre_cliente from statictext within w_con_pedidos_cliente
end type
type dw_listado from datawindow within w_con_pedidos_cliente
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_cliente
end type
type em_pallets from u_em_campo within w_con_pedidos_cliente
end type
type em_cajas from u_em_campo within w_con_pedidos_cliente
end type
type em_metros from u_em_campo within w_con_pedidos_cliente
end type
type em_unidades from u_em_campo within w_con_pedidos_cliente
end type
type ss from statictext within w_con_pedidos_cliente
end type
type st-10 from statictext within w_con_pedidos_cliente
end type
type st-11 from statictext within w_con_pedidos_cliente
end type
type st-12 from statictext within w_con_pedidos_cliente
end type
type st-13 from statictext within w_con_pedidos_cliente
end type
type em_kilos from u_em_campo within w_con_pedidos_cliente
end type
type em_totalkilos from u_em_campo within w_con_pedidos_cliente
end type
type st-15 from statictext within w_con_pedidos_cliente
end type
type st-16 from statictext within w_con_pedidos_cliente
end type
type st-17 from statictext within w_con_pedidos_cliente
end type
type st-18 from statictext within w_con_pedidos_cliente
end type
type st-19 from statictext within w_con_pedidos_cliente
end type
type em_totalbruto from u_em_campo within w_con_pedidos_cliente
end type
type em_totaldto from u_em_campo within w_con_pedidos_cliente
end type
type em_totalbase from u_em_campo within w_con_pedidos_cliente
end type
type em_totaliva from u_em_campo within w_con_pedidos_cliente
end type
type em_totalgeneral from u_em_campo within w_con_pedidos_cliente
end type
type em_totalgeneral_bruto from u_em_campo within w_con_pedidos_cliente
end type
type st_1 from statictext within w_con_pedidos_cliente
end type
type em_totalgeneral_dto from u_em_campo within w_con_pedidos_cliente
end type
type em_totalgeneral_base from u_em_campo within w_con_pedidos_cliente
end type
type em_totalgeneral_iva from u_em_campo within w_con_pedidos_cliente
end type
type em_totalgeneral_neto from u_em_campo within w_con_pedidos_cliente
end type
type st_3 from statictext within w_con_pedidos_cliente
end type
type em_unidades_general from u_em_campo within w_con_pedidos_cliente
end type
type em_metros_general from u_em_campo within w_con_pedidos_cliente
end type
type em_cajas_general from u_em_campo within w_con_pedidos_cliente
end type
type em_pallets_general from u_em_campo within w_con_pedidos_cliente
end type
type dw_detalle from u_datawindow_consultas within w_con_pedidos_cliente
end type
end forward

global type w_con_pedidos_cliente from w_int_con_empresa
integer x = 142
integer y = 16
integer width = 3643
integer height = 2096
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_cliente em_cliente
st_nombre_cliente st_nombre_cliente
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
dw_detalle dw_detalle
end type
global w_con_pedidos_cliente w_con_pedidos_cliente

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_calculo (integer cod, integer linea)
public subroutine f_calcula_bruto_linea (integer cod, integer linea)
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,em_cliente.text)
dw_detalle.sort()
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

on open;call w_int_con_empresa::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido por cliente"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

end on

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa,em_cliente.text)
dw_report.sort()
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_pedidos_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_cliente=create em_cliente
this.st_nombre_cliente=create st_nombre_cliente
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
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_cliente
this.Control[iCurrent+5]=this.st_nombre_cliente
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.uo_manejo
this.Control[iCurrent+8]=this.em_pallets
this.Control[iCurrent+9]=this.em_cajas
this.Control[iCurrent+10]=this.em_metros
this.Control[iCurrent+11]=this.em_unidades
this.Control[iCurrent+12]=this.ss
this.Control[iCurrent+13]=this.st-10
this.Control[iCurrent+14]=this.st-11
this.Control[iCurrent+15]=this.st-12
this.Control[iCurrent+16]=this.st-13
this.Control[iCurrent+17]=this.em_kilos
this.Control[iCurrent+18]=this.em_totalkilos
this.Control[iCurrent+19]=this.st-15
this.Control[iCurrent+20]=this.st-16
this.Control[iCurrent+21]=this.st-17
this.Control[iCurrent+22]=this.st-18
this.Control[iCurrent+23]=this.st-19
this.Control[iCurrent+24]=this.em_totalbruto
this.Control[iCurrent+25]=this.em_totaldto
this.Control[iCurrent+26]=this.em_totalbase
this.Control[iCurrent+27]=this.em_totaliva
this.Control[iCurrent+28]=this.em_totalgeneral
this.Control[iCurrent+29]=this.em_totalgeneral_bruto
this.Control[iCurrent+30]=this.st_1
this.Control[iCurrent+31]=this.em_totalgeneral_dto
this.Control[iCurrent+32]=this.em_totalgeneral_base
this.Control[iCurrent+33]=this.em_totalgeneral_iva
this.Control[iCurrent+34]=this.em_totalgeneral_neto
this.Control[iCurrent+35]=this.st_3
this.Control[iCurrent+36]=this.em_unidades_general
this.Control[iCurrent+37]=this.em_metros_general
this.Control[iCurrent+38]=this.em_cajas_general
this.Control[iCurrent+39]=this.em_pallets_general
this.Control[iCurrent+40]=this.dw_detalle
end on

on w_con_pedidos_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_cliente)
destroy(this.st_nombre_cliente)
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
destroy(this.dw_detalle)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_cliente
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_cliente
integer x = 9
integer y = 8
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_con_pedidos_cliente
integer x = 3506
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_cliente
integer x = 3506
integer y = 136
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_pedidos_cliente
integer x = 41
integer y = 144
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

type em_cliente from u_em_campo within w_con_pedidos_cliente
integer x = 297
integer y = 140
integer width = 549
integer taborder = 10
long backcolor = 33551858
end type

event modificado;call super::modificado; st_nombre_cliente.text = f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
 if Trim(st_nombre_cliente.text)="" Then
      IF len( st_nombre_cliente.text) <> 0 Then f_activar_campo(em_cliente)
		em_cliente.text = ""
      return
 End If
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

    tipoiva  = f_tipoiva_venclientes(codigo_empresa,em_cliente.text)
    claveiva = f_iva_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,tipoiva)

    em_totalgeneral_iva.text  = string((dec(em_totalgeneral_base.text) * claveiva) /100)
    em_totalgeneral_neto.text = string(dec(em_totalgeneral_iva.text)+dec(em_totalgeneral_base.text))
end if







 



end event

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE CLIENTES"
		ue_datawindow = "dw_ayuda_clientes"
		ue_filtro     = ""
  


 
        
end on

type st_nombre_cliente from statictext within w_con_pedidos_cliente
integer x = 859
integer y = 144
integer width = 1367
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_pedidos_cliente
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 180
boolean bringtotop = true
string dataobject = "report_con_pedidos_cliente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_cliente
integer x = 3026
integer y = 92
integer width = 649
integer height = 144
end type

on valores;call u_manejo_datawindow::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(em_cliente)
end on

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type em_pallets from u_em_campo within w_con_pedidos_cliente
integer x = 242
integer y = 1764
integer width = 101
integer taborder = 0
integer weight = 400
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type em_cajas from u_em_campo within w_con_pedidos_cliente
integer x = 352
integer y = 1764
integer width = 178
integer taborder = 0
boolean bringtotop = true
integer weight = 400
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type em_metros from u_em_campo within w_con_pedidos_cliente
integer x = 530
integer y = 1764
integer width = 261
integer taborder = 0
boolean bringtotop = true
integer weight = 400
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_unidades from u_em_campo within w_con_pedidos_cliente
integer x = 795
integer y = 1764
integer width = 210
integer taborder = 0
boolean bringtotop = true
integer weight = 400
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type ss from statictext within w_con_pedidos_cliente
integer x = 242
integer y = 1692
integer width = 105
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st-10 from statictext within w_con_pedidos_cliente
integer x = 352
integer y = 1692
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st-11 from statictext within w_con_pedidos_cliente
integer x = 539
integer y = 1692
integer width = 256
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Metros"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st-12 from statictext within w_con_pedidos_cliente
integer x = 805
integer y = 1692
integer width = 206
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Unid."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st-13 from statictext within w_con_pedidos_cliente
integer x = 1019
integer y = 1692
integer width = 251
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Kilos"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_kilos from u_em_campo within w_con_pedidos_cliente
integer x = 1010
integer y = 1764
integer width = 256
integer taborder = 0
boolean bringtotop = true
integer weight = 400
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0.##"
end type

type em_totalkilos from u_em_campo within w_con_pedidos_cliente
integer x = 1010
integer y = 1848
integer width = 256
integer taborder = 0
boolean bringtotop = true
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
end type

type st-15 from statictext within w_con_pedidos_cliente
integer x = 1280
integer y = 1692
integer width = 347
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Imp. bruto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st-16 from statictext within w_con_pedidos_cliente
integer x = 1637
integer y = 1692
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Dto."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st-17 from statictext within w_con_pedidos_cliente
integer x = 1920
integer y = 1692
integer width = 347
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Base Imp."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st-18 from statictext within w_con_pedidos_cliente
integer x = 2277
integer y = 1692
integer width = 251
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "I.v.a."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st-19 from statictext within w_con_pedidos_cliente
integer x = 2528
integer y = 1692
integer width = 366
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Total"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_totalbruto from u_em_campo within w_con_pedidos_cliente
integer x = 1271
integer y = 1764
integer width = 352
integer taborder = 40
boolean bringtotop = true
integer weight = 400
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totaldto from u_em_campo within w_con_pedidos_cliente
integer x = 1627
integer y = 1764
integer width = 279
integer taborder = 140
boolean bringtotop = true
integer weight = 400
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totalbase from u_em_campo within w_con_pedidos_cliente
integer x = 1911
integer y = 1764
integer width = 352
integer taborder = 110
boolean bringtotop = true
integer weight = 400
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totaliva from u_em_campo within w_con_pedidos_cliente
integer x = 2267
integer y = 1764
integer width = 256
integer taborder = 160
boolean bringtotop = true
integer weight = 400
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

type em_totalgeneral from u_em_campo within w_con_pedidos_cliente
integer x = 2528
integer y = 1764
integer width = 366
integer taborder = 130
boolean bringtotop = true
integer weight = 400
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totalgeneral_bruto from u_em_campo within w_con_pedidos_cliente
integer x = 1271
integer y = 1848
integer width = 352
integer taborder = 100
boolean bringtotop = true
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type st_1 from statictext within w_con_pedidos_cliente
integer x = 37
integer y = 1856
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
string text = "Gene."
boolean focusrectangle = false
end type

type em_totalgeneral_dto from u_em_campo within w_con_pedidos_cliente
integer x = 1627
integer y = 1848
integer width = 279
integer taborder = 90
boolean bringtotop = true
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totalgeneral_base from u_em_campo within w_con_pedidos_cliente
integer x = 1911
integer y = 1848
integer width = 352
integer taborder = 150
boolean bringtotop = true
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_totalgeneral_iva from u_em_campo within w_con_pedidos_cliente
integer x = 2267
integer y = 1848
integer width = 256
integer taborder = 120
boolean bringtotop = true
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

type em_totalgeneral_neto from u_em_campo within w_con_pedidos_cliente
integer x = 2528
integer y = 1848
integer width = 366
integer taborder = 170
boolean bringtotop = true
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type st_3 from statictext within w_con_pedidos_cliente
integer x = 37
integer y = 1772
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

type em_unidades_general from u_em_campo within w_con_pedidos_cliente
integer x = 795
integer y = 1848
integer width = 210
integer taborder = 80
boolean bringtotop = true
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type em_metros_general from u_em_campo within w_con_pedidos_cliente
integer x = 530
integer y = 1848
integer width = 261
integer taborder = 70
boolean bringtotop = true
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type em_cajas_general from u_em_campo within w_con_pedidos_cliente
integer x = 347
integer y = 1848
integer width = 178
integer taborder = 60
boolean bringtotop = true
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type em_pallets_general from u_em_campo within w_con_pedidos_cliente
integer x = 242
integer y = 1848
integer width = 101
integer taborder = 50
integer weight = 400
long backcolor = 16773367
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type dw_detalle from u_datawindow_consultas within w_con_pedidos_cliente
integer x = 5
integer y = 248
integer width = 3625
integer height = 1432
integer taborder = 30
string dataobject = "dw_con_pedidos_cliente"
boolean vscrollbar = true
end type

event clicked;dec kilos,totalbase,totaldto,totalbruto,metros
long pallets,cajas,unidades
string tipoiva
integer claveiva


If row=0 Then Return
IF ue_marca_linea = TRUE Then
	This.SelectRow(row,not isselected(row))  
	SetRow(row)

	kilos         = dec(dw_detalle.GetItemNumber(row,"peso"))
	totalbase  = dec(dw_detalle.GetItemNumber(row,"importe"))
	totaldto   = dec(dw_detalle.GetItemNumber(row,"importedto"))
	totalbruto = totalbase + totaldto
	pallets    = dw_detalle.GetItemNumber(row,"pallets")
	cajas      = dw_detalle.GetItemNumber(row,"cajas")	
	if dw_detalle.GetItemString(row,"tipo_unidad")='1' then
		unidades   = 0
		metros     = dec(dw_detalle.GetItemNumber(row,"cantidad"))
	else 
		if dw_detalle.GetItemString(row,"tipo_unidad")='0' then
			unidades   = dw_detalle.GetItemNumber(row,"cantidad")
			metros     = 0
		end if
	end if


	if isselected(row) then	
		em_kilos.text         = string(dec(em_kilos.text)+kilos)
		em_totalbase.text  = string(dec(em_totalbase.text)+totalbase)
		em_totaldto.text   = string(dec(em_totaldto.text)+totaldto)
		em_totalbruto.text = string(dec(em_totalbruto.text)+totalbruto)
		em_pallets.text    = string(long(em_pallets.text)+pallets)
		em_cajas.text      = string(long(em_cajas.text)+cajas)
		em_metros.text     = String(dec(em_metros.text)+metros)
		em_unidades.text   = String(dec(em_unidades.text)+unidades)
		
		tipoiva  = f_tipoiva_venclientes(codigo_empresa,em_cliente.text)
		claveiva = f_iva_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,tipoiva)
		
		em_totaliva.text  = string((dec(em_totalbase.text) * claveiva) /100)
		em_totalgeneral.text = string(dec(em_totaliva.text)+dec(em_totalbase.text))
	else
		em_kilos.text         = string(dec(em_kilos.text)-kilos)
		em_totalbase.text  = string(dec(em_totalbase.text)-totalbase)
		em_totaldto.text   = string(dec(em_totaldto.text)-totaldto)
		em_totalbruto.text = string(dec(em_totalbruto.text)-totalbruto)
		em_pallets.text    = string(long(em_pallets.text)-pallets)
		em_cajas.text      = string(long(em_cajas.text)-cajas)
		em_metros.text     = String(dec(em_metros.text)-metros)
		em_unidades.text   = String(dec(em_unidades.text)-unidades)
		
		tipoiva  = f_tipoiva_venclientes(codigo_empresa,em_cliente.text)
		claveiva = f_iva_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,tipoiva)
		
		em_totaliva.text  = string((dec(em_totalbase.text) * claveiva) /100)
		em_totalgeneral.text = string(dec(em_totaliva.text)+dec(em_totalbase.text))		
	end if
  
END IF


end event

event rowfocuschanged;//
end event

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

