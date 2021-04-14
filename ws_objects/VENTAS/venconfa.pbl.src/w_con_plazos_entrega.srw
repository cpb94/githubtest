$PBExportHeader$w_con_plazos_entrega.srw
forward
global type w_con_plazos_entrega from w_int_con_empresa
end type
type gb_fecha from groupbox within w_con_plazos_entrega
end type
type pb_1 from upb_salir within w_con_plazos_entrega
end type
type pb_2 from upb_imprimir within w_con_plazos_entrega
end type
type dw_detalle from datawindow within w_con_plazos_entrega
end type
type uo_cliente from u_em_campo_2 within w_con_plazos_entrega
end type
type gb_cliente from groupbox within w_con_plazos_entrega
end type
type cb_1 from commandbutton within w_con_plazos_entrega
end type
type em_fechadesde from u_em_campo within w_con_plazos_entrega
end type
type em_fechahasta from u_em_campo within w_con_plazos_entrega
end type
type st_1 from statictext within w_con_plazos_entrega
end type
type uo_articulo from u_em_campo_2 within w_con_plazos_entrega
end type
type st_2 from statictext within w_con_plazos_entrega
end type
type st_3 from statictext within w_con_plazos_entrega
end type
type sle_plazo_inf from singlelineedit within w_con_plazos_entrega
end type
type sle_plazo_sup from singlelineedit within w_con_plazos_entrega
end type
type st_4 from statictext within w_con_plazos_entrega
end type
type st_5 from statictext within w_con_plazos_entrega
end type
type sle_variacion_inf from singlelineedit within w_con_plazos_entrega
end type
type sle_variacion_sup from singlelineedit within w_con_plazos_entrega
end type
type uo_g1 from u_em_campo_2 within w_con_plazos_entrega
end type
type uo_g2 from u_em_campo_2 within w_con_plazos_entrega
end type
type ddlb_n from dropdownlistbox within w_con_plazos_entrega
end type
type ddlb_nc from dropdownlistbox within w_con_plazos_entrega
end type
type uo_ct from u_em_campo_2 within w_con_plazos_entrega
end type
type uo_g4 from u_em_campo_2 within w_con_plazos_entrega
end type
type gb_1 from groupbox within w_con_plazos_entrega
end type
type gb_6 from groupbox within w_con_plazos_entrega
end type
type gb_7 from groupbox within w_con_plazos_entrega
end type
type gb_125 from groupbox within w_con_plazos_entrega
end type
type gb_13 from groupbox within w_con_plazos_entrega
end type
type gb_18 from groupbox within w_con_plazos_entrega
end type
type gb_10 from groupbox within w_con_plazos_entrega
end type
end forward

global type w_con_plazos_entrega from w_int_con_empresa
integer x = 59
integer y = 16
integer width = 4165
integer height = 3940
string title = "Plazos de entrega por cliente"
gb_fecha gb_fecha
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
uo_cliente uo_cliente
gb_cliente gb_cliente
cb_1 cb_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_1 st_1
uo_articulo uo_articulo
st_2 st_2
st_3 st_3
sle_plazo_inf sle_plazo_inf
sle_plazo_sup sle_plazo_sup
st_4 st_4
st_5 st_5
sle_variacion_inf sle_variacion_inf
sle_variacion_sup sle_variacion_sup
uo_g1 uo_g1
uo_g2 uo_g2
ddlb_n ddlb_n
ddlb_nc ddlb_nc
uo_ct uo_ct
uo_g4 uo_g4
gb_1 gb_1
gb_6 gb_6
gb_7 gb_7
gb_125 gb_125
gb_13 gb_13
gb_18 gb_18
gb_10 gb_10
end type
global w_con_plazos_entrega w_con_plazos_entrega

type variables
string filtro

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();String descli,hascli, articulo, restriccion_g2, restriccion_g4
string restriccion_g1, codestadistico, restriccion_nc, restriccion_n, restriccion_ct 


dw_detalle.Reset()

if uo_articulo.em_codigo.text = '' or isnull(uo_articulo.em_codigo.text) then
	articulo = '%'
else
	articulo = uo_articulo.em_codigo.text
end if

if Trim(uo_cliente.em_codigo.text) = "" then
	descli = "%"
 ELSE
	descli = uo_cliente.em_codigo.text
End if

if uo_g1.em_campo.text <> "" and not isnull(uo_g1.em_campo.text) then
	restriccion_g1 = "(art_codestadistico_g1 = '"+uo_g1.em_campo.text+"')"
	codestadistico = codestadistico + "   G1: "+uo_g1.em_campo.text
else
	restriccion_g1 = '1=1' // Codición que siempre se cumplirá
end if

if uo_g2.em_campo.text <> "" and not isnull(uo_g2.em_campo.text) then
	restriccion_g2 = "(art_codestadistico_g2 = '"+uo_g2.em_campo.text+"')"
	codestadistico = codestadistico + "   G2: "+uo_g2.em_campo.text	
else
	restriccion_g2 = '1=1' // Codición que siempre se cumplirá
end if

if uo_g4.em_campo.text <> "" and not isnull(uo_g4.em_campo.text) then
	restriccion_g4 = "(art_codestadistico_g4 = '"+uo_g4.em_campo.text+"')"
	codestadistico = codestadistico + "   G4: "+uo_g4.em_campo.text
else
	restriccion_g4 = '1=1' // Codición que siempre se cumplirá
end if

if (ddlb_nc.text = "Todo" or ddlb_nc.text = "" ) then
	restriccion_nc = '1=1' // Codición que siempre se cumplirá
else
	restriccion_nc = "(art_codestadistico_nc = '"+ddlb_nc.text+"')"
	codestadistico = codestadistico + "   NC: "+ddlb_nc.text	
end if

if (ddlb_n.text = "Todo" or ddlb_n.text = "" ) then
	restriccion_n = '1=1' // Codición que siempre se cumplirá
else
	restriccion_n = "(art_codestadistico_n = '"+ddlb_n.text+"')"
	codestadistico = codestadistico + "   N: "+ddlb_n.text
end if

if uo_ct.em_campo.text <> "" and not isnull(uo_ct.em_campo.text) then
	restriccion_ct = "(art_codestadistico_ct = '"+uo_ct.em_campo.text+"')"
	codestadistico = codestadistico + "   CT: "+uo_ct.em_campo.text
else
	restriccion_ct = '1=1' // Codición que siempre se cumplirá
end if

filtro = ''
filtro = " plazo > "+sle_plazo_inf.text+ " and plazo < "+sle_plazo_sup.text+& 
							 " and dif_entrega_servido > "+sle_variacion_inf.text+" and dif_entrega_servido < "+sle_variacion_sup.text+" and "
filtro = filtro + &
			restriccion_g1+" and "+ &
			restriccion_g2+" and "+ &
			restriccion_g4+" and "+ &
			restriccion_nc+" and "+ &
			restriccion_ct+" and "+ &
			restriccion_n

			
dw_detalle.SetFilter(filtro)
dw_detalle.Filter()

dw_detalle.Retrieve(codigo_empresa,descli, datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)), articulo)

dw_detalle.object.t_cliente.text = uo_cliente.em_campo.text + "           Desde "+em_fechadesde.text+" Hasta "+em_fechahasta.text

f_activar_campo(uo_cliente.em_campo)

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

sle_plazo_inf.text = '0'
sle_plazo_sup.text = '9999'
sle_variacion_inf.text = '-100'
sle_variacion_sup.text = '100'

istr_parametros.s_titulo_ventana="Plazos de entrega"
This.title=istr_parametros.s_titulo_ventana
f_activar_campo(uo_cliente.em_campo)
end event

on w_con_plazos_entrega.create
int iCurrent
call super::create
this.gb_fecha=create gb_fecha
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.uo_cliente=create uo_cliente
this.gb_cliente=create gb_cliente
this.cb_1=create cb_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.uo_articulo=create uo_articulo
this.st_2=create st_2
this.st_3=create st_3
this.sle_plazo_inf=create sle_plazo_inf
this.sle_plazo_sup=create sle_plazo_sup
this.st_4=create st_4
this.st_5=create st_5
this.sle_variacion_inf=create sle_variacion_inf
this.sle_variacion_sup=create sle_variacion_sup
this.uo_g1=create uo_g1
this.uo_g2=create uo_g2
this.ddlb_n=create ddlb_n
this.ddlb_nc=create ddlb_nc
this.uo_ct=create uo_ct
this.uo_g4=create uo_g4
this.gb_1=create gb_1
this.gb_6=create gb_6
this.gb_7=create gb_7
this.gb_125=create gb_125
this.gb_13=create gb_13
this.gb_18=create gb_18
this.gb_10=create gb_10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_fecha
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.uo_cliente
this.Control[iCurrent+6]=this.gb_cliente
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.em_fechadesde
this.Control[iCurrent+9]=this.em_fechahasta
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.uo_articulo
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.sle_plazo_inf
this.Control[iCurrent+15]=this.sle_plazo_sup
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.sle_variacion_inf
this.Control[iCurrent+19]=this.sle_variacion_sup
this.Control[iCurrent+20]=this.uo_g1
this.Control[iCurrent+21]=this.uo_g2
this.Control[iCurrent+22]=this.ddlb_n
this.Control[iCurrent+23]=this.ddlb_nc
this.Control[iCurrent+24]=this.uo_ct
this.Control[iCurrent+25]=this.uo_g4
this.Control[iCurrent+26]=this.gb_1
this.Control[iCurrent+27]=this.gb_6
this.Control[iCurrent+28]=this.gb_7
this.Control[iCurrent+29]=this.gb_125
this.Control[iCurrent+30]=this.gb_13
this.Control[iCurrent+31]=this.gb_18
this.Control[iCurrent+32]=this.gb_10
end on

on w_con_plazos_entrega.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_fecha)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.uo_cliente)
destroy(this.gb_cliente)
destroy(this.cb_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.uo_articulo)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_plazo_inf)
destroy(this.sle_plazo_sup)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_variacion_inf)
destroy(this.sle_variacion_sup)
destroy(this.uo_g1)
destroy(this.uo_g2)
destroy(this.ddlb_n)
destroy(this.ddlb_nc)
destroy(this.uo_ct)
destroy(this.uo_g4)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.gb_7)
destroy(this.gb_125)
destroy(this.gb_13)
destroy(this.gb_18)
destroy(this.gb_10)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_plazos_entrega
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_plazos_entrega
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_plazos_entrega
integer x = 55
integer y = 4
integer width = 3890
long textcolor = 20590053
long backcolor = 553648127
end type

type gb_fecha from groupbox within w_con_plazos_entrega
integer x = 1211
integer y = 108
integer width = 617
integer height = 152
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Albarán"
end type

type pb_1 from upb_salir within w_con_plazos_entrega
integer x = 4000
integer y = 28
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_plazos_entrega
integer x = 3995
integer y = 152
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

//dw_listado.Retrieve(codigo_empresa,descli,hascli)
f_imprimir_datawindow(dw_detalle)


end event

type dw_detalle from datawindow within w_con_plazos_entrega
integer x = 27
integer y = 456
integer width = 4064
integer height = 3312
string dataobject = "dw_con_plazos_entrega"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_int_almalb,lstr_param) 
End If
end event

event clicked;IF dwo.name= "t_fpedido" Then
	this.SetSort("venlifac_fecha_linped A")
	this.Sort()
END IF
IF dwo.name= "t_falbaran" Then
	this.SetSort("venlifac_falbaran A")
	this.Sort()
END IF

IF dwo.name= "t_dias1" Then
	this.SetSort("plazo D")
	this.Sort()
END IF

IF dwo.name= "t_dias2" Then
	this.SetSort("dif_entrega_servido A")
	this.Sort()
END IF

end event

type uo_cliente from u_em_campo_2 within w_con_plazos_entrega
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 91
integer y = 160
integer width = 969
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

type gb_cliente from groupbox within w_con_plazos_entrega
integer x = 73
integer y = 108
integer width = 1006
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

type cb_1 from commandbutton within w_con_plazos_entrega
integer x = 3639
integer y = 148
integer width = 347
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;if isnull(sle_plazo_inf.text ) or sle_plazo_inf.text = '' then
	sle_plazo_inf.text = '0'
end if

if isnull(sle_plazo_sup.text ) or sle_plazo_sup.text = '' then
	sle_plazo_sup.text = '9999'
end if

if isnull(sle_variacion_inf.text ) or sle_variacion_inf.text = '' then
	sle_variacion_inf.text = '-100'
end if

if isnull(sle_variacion_sup.text ) or sle_variacion_sup.text = '' then
	sle_variacion_sup.text = '100'
end if




f_control()
end event

type em_fechadesde from u_em_campo within w_con_plazos_entrega
integer x = 1225
integer y = 168
integer width = 265
integer height = 76
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fechahasta from u_em_campo within w_con_plazos_entrega
integer x = 1541
integer y = 168
integer width = 270
integer height = 76
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_1 from statictext within w_con_plazos_entrega
integer x = 1490
integer y = 168
integer width = 50
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
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

type uo_articulo from u_em_campo_2 within w_con_plazos_entrega
event destroy ( )
boolean visible = false
integer x = 50
integer y = 280
integer width = 978
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

type st_2 from statictext within w_con_plazos_entrega
integer x = 2011
integer y = 136
integer width = 265
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Plazo Inf."
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_plazos_entrega
integer x = 2011
integer y = 208
integer width = 265
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Plazo Sup."
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_plazo_inf from singlelineedit within w_con_plazos_entrega
integer x = 2304
integer y = 128
integer width = 219
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type sle_plazo_sup from singlelineedit within w_con_plazos_entrega
integer x = 2304
integer y = 208
integer width = 219
integer height = 72
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_con_plazos_entrega
integer x = 2807
integer y = 128
integer width = 334
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Variación Inf."
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_plazos_entrega
integer x = 2775
integer y = 200
integer width = 366
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Variación Sup."
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_variacion_inf from singlelineedit within w_con_plazos_entrega
integer x = 3168
integer y = 120
integer width = 219
integer height = 72
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type sle_variacion_sup from singlelineedit within w_con_plazos_entrega
integer x = 3168
integer y = 200
integer width = 219
integer height = 72
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type uo_g1 from u_em_campo_2 within w_con_plazos_entrega
event destroy ( )
integer x = 78
integer y = 308
integer width = 142
integer height = 68
integer taborder = 110
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g1.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g1.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo1
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g1.em_campo.text = descripcion
IF Trim(uo_g1.em_campo.text)="" THEN 
 IF Trim(uo_g1.em_codigo.text)<>"" Then uo_g1.em_campo.SetFocus()
 uo_g1.em_campo.text=""
 uo_g1.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G1"
ue_datawindow = "dw_ayuda_art_grupo1"
ue_filtro     = ""

end event

type uo_g2 from u_em_campo_2 within w_con_plazos_entrega
event destroy ( )
integer x = 242
integer y = 308
integer width = 169
integer height = 68
integer taborder = 120
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g2.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g2.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo2
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g2.em_campo.text = descripcion
IF Trim(uo_g2.em_campo.text)="" THEN 
 IF Trim(uo_g2.em_codigo.text)<>"" Then uo_g2.em_campo.SetFocus()
 uo_g2.em_campo.text=""
 uo_g2.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G2"
ue_datawindow = "dw_ayuda_art_grupo2"
ue_filtro     = ""

end event

type ddlb_n from dropdownlistbox within w_con_plazos_entrega
integer x = 1051
integer y = 308
integer width = 279
integer height = 332
integer taborder = 140
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","S","N"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_nc from dropdownlistbox within w_con_plazos_entrega
integer x = 791
integer y = 304
integer width = 224
integer height = 484
integer taborder = 30
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","0","1","2","3","4","5"}
borderstyle borderstyle = stylelowered!
end type

type uo_ct from u_em_campo_2 within w_con_plazos_entrega
event destroy ( )
integer x = 608
integer y = 308
integer width = 142
integer height = 68
integer taborder = 140
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_ct.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_ct.em_codigo.text

select descripcion_abr
into :descripcion
from art_cortes
where empresa = :codigo_empresa
and codigo = :codigo;

uo_ct.em_campo.text = descripcion
IF Trim(uo_ct.em_campo.text)="" THEN 
 IF Trim(uo_ct.em_codigo.text)<>"" Then uo_ct.em_campo.SetFocus()
 uo_ct.em_campo.text=""
 uo_ct.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Cortes"
ue_datawindow = "dw_ayuda_art_cortes"
ue_filtro     = ""

end event

type uo_g4 from u_em_campo_2 within w_con_plazos_entrega
event destroy ( )
integer x = 434
integer y = 308
integer width = 142
integer height = 68
integer taborder = 140
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g4.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g4.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo4
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g4.em_campo.text = descripcion
IF Trim(uo_g4.em_campo.text)="" THEN 
 IF Trim(uo_g4.em_codigo.text)<>"" Then uo_g4.em_campo.SetFocus()
 uo_g4.em_campo.text=""
 uo_g4.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G4"
ue_datawindow = "dw_ayuda_art_grupo4"
ue_filtro     = ""

end event

type gb_1 from groupbox within w_con_plazos_entrega
boolean visible = false
integer x = 32
integer y = 228
integer width = 1015
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

type gb_6 from groupbox within w_con_plazos_entrega
integer x = 64
integer y = 260
integer width = 169
integer height = 140
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G1"
end type

type gb_7 from groupbox within w_con_plazos_entrega
integer x = 224
integer y = 260
integer width = 197
integer height = 140
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G2"
end type

type gb_125 from groupbox within w_con_plazos_entrega
integer x = 1038
integer y = 260
integer width = 302
integer height = 140
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "B. Cliente"
end type

type gb_13 from groupbox within w_con_plazos_entrega
integer x = 777
integer y = 260
integer width = 256
integer height = 140
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "NC"
end type

type gb_18 from groupbox within w_con_plazos_entrega
integer x = 594
integer y = 260
integer width = 174
integer height = 140
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "CT"
end type

type gb_10 from groupbox within w_con_plazos_entrega
integer x = 421
integer y = 260
integer width = 174
integer height = 140
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G4"
end type

